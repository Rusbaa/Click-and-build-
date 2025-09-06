from flask import Flask, render_template, request, redirect, url_for, flash, session, jsonify
import mysql.connector
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime, date
import os

app = Flask(__name__)
app.secret_key = '123456'

# Database configuration for XAMPP
def get_db_connection():
    return mysql.connector.connect(
        host='localhost',
        user='root',
        password='',  # Default XAMPP password is empty
        database='click_build_db'
    )

# Home page
@app.route('/')
def index():
    return render_template('index.html')



# Browse Components
@app.route('/components')
def components():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # Get filter parameters
        category = request.args.get('category', '')
        sort_by = request.args.get('sort', 'name')
        search = request.args.get('search', '')
        
        # Base query
        query = """
            SELECT c.C_ID, c.Name, c.Price, c.Brand, s.Stock,
                   COALESCE(d.Amount, 0) as Discount, c.type, c.supports
            FROM Components c
            LEFT JOIN Stocks s ON c.C_ID = s.C_ID
            LEFT JOIN Discount d ON c.C_ID = d.C_ID 
                AND CURDATE() BETWEEN d.Start AND d.End
            WHERE 1=1
        """
        params = []
        
        # Add category filter
        if category:
            query += " AND c.type = %s"
            params.append(category)

        # Add search filter
        if search:
            query += " AND c.Name LIKE %s"
            params.append(f"%{search}%")
        
        # Add sorting, but always keep category ordering
        query += " ORDER BY FIELD(c.type, 'CPU', 'MOBO', 'GPU', 'RAM', 'STORAGE', 'PSU', 'CASE')"
        
        if sort_by == 'price_low':
            query += ", c.Price ASC"
        elif sort_by == 'price_high':
            query += ", c.Price DESC"
        elif sort_by == 'brand':
            query += ", c.Brand ASC"
        else:
            query += ", c.Name ASC"
        
        cursor.execute(query, params)
        components_list = cursor.fetchall()
        
        return render_template('components.html', components=components_list)
        
    except mysql.connector.Error as e:
        flash(f'Error loading components: {str(e)}', 'error')
        return render_template('components.html', components=[])
    finally:
        cursor.close()
        conn.close()
  


# PC Builder
@app.route('/build_pc', methods=['GET', 'POST'])
def build_pc():
    if 'user_id' not in session:
        return redirect(url_for('login'))
    
    if request.method == 'POST':
        build_name = request.form['build_name']
        selected_components = request.form.getlist('components')
        
        try:
            conn = get_db_connection()
            cursor = conn.cursor()
            
            # Validate component compatibility and category restrictions
            cursor.execute("""
                SELECT C_ID, type, Brand, COALESCE(supports, 'N/A') as supports
                FROM Components 
                WHERE C_ID IN (%s)
            """ % ','.join(['%s'] * len(selected_components)), selected_components)
            components = cursor.fetchall()
            
            # Check category restrictions
            component_types = {}
            for comp in components:
                if comp[1] not in ['RAM', 'STORAGE']:
                    if comp[1] in component_types:
                        flash(f'Only one {comp[1]} can be added to a build!', 'error')
                        return redirect(url_for('build_pc'))
                component_types[comp[1]] = comp
            
            # Check CPU and Motherboard compatibility
            if 'CPU' in component_types and 'MOBO' in component_types:
                cpu = component_types['CPU']
                mobo = component_types['MOBO']
                # Get CPU brand (index 2) and motherboard supports (index 3)
                cpu_brand = cpu[2]  # Brand field
                mobo_supports = mobo[3]  # supports field
                
                if mobo_supports == 'N/A':
                    flash('Motherboard compatibility information is missing!', 'error')
                    return redirect(url_for('build_pc'))
                
                # Check if CPU brand matches what motherboard supports
                if cpu_brand.upper() not in mobo_supports.upper():
                    flash(f'CPU brand ({cpu_brand}) is not compatible with this motherboard which supports ({mobo_supports})!', 'error')
                    return redirect(url_for('build_pc'))
            
            # Create PC build
            cursor.execute("""
                INSERT INTO PC_BUILD (Name, C_Date, U_ID) 
                VALUES (%s, %s, %s)
            """, (build_name, date.today(), session['user_id']))
            
            build_id = cursor.lastrowid
            
            # Link components to build
            for comp_id in selected_components:
                cursor.execute("""
                    UPDATE Components 
                    SET B_ID = %s 
                    WHERE C_ID = %s
                """, (build_id, comp_id))
            
            conn.commit()
            flash('PC build created successfully!', 'success')
            return redirect(url_for('dashboard'))
            
        except mysql.connector.Error as e:
            flash(f'Error creating build: {str(e)}', 'error')
        finally:
            cursor.close()
            conn.close()
    
    # GET request - show available components
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        cursor.execute("""
            SELECT C_ID, Name, Price, Brand, type, supports
            FROM Components 
            WHERE B_ID IS NULL AND Cart_ID IS NULL
            ORDER BY FIELD(type, 'CPU', 'MOBO', 'GPU', 'RAM', 'STORAGE', 'PSU', 'CASE'), Brand, Name
        """)
        available_components = cursor.fetchall()
        
        return render_template('build_pc.html', components=available_components)
        
    except mysql.connector.Error as e:
        flash(f'Error loading components: {str(e)}', 'error')
        return render_template('build_pc.html', components=[])
    finally:
        cursor.close()
        conn.close()

# Checkout
@app.route('/checkout', methods=['GET', 'POST'])
def checkout():
    if 'user_id' not in session:
        return redirect(url_for('login'))
    
    if request.method == 'POST':
        payment_method = request.form['payment_method']
        
        try:
            conn = get_db_connection()
            cursor = conn.cursor()
            
            # Create payment record
            payment_data = {
                'COD': payment_method == 'cod',
                'offlineFlag': payment_method in ['cod'],
                'Baksh': payment_method == 'bkash',
                'Visa': payment_method == 'visa',
                'Nogod': payment_method == 'nogod',
                'onlineFlag': payment_method in ['bkash', 'visa', 'nogod']
            }
            
            cursor.execute("""
                INSERT INTO Payment (COD, offlineFlag, Baksh, Visa, Nogod, onlineFlag)
                VALUES (%s, %s, %s, %s, %s, %s)
            """, tuple(payment_data.values()))
            
            payment_id = cursor.lastrowid
            
            # Get cart items for this user
            cursor.execute("""
                SELECT cart.ID 
                FROM Cart cart
                JOIN Components c ON cart.ID = c.Cart_ID
                WHERE c.U_ID = %s
            """, (session['user_id'],))
            
            cart_ids = cursor.fetchall()
            
            # Create orders
            for (cart_id,) in cart_ids:
                cursor.execute("""
                    INSERT INTO Orders (U_ID, P_ID, Cart_ID)
                    VALUES (%s, %s, %s)
                """, (session['user_id'], payment_id, cart_id))
            
            # Clear cart associations
            cursor.execute("""
                UPDATE Components 
                SET Cart_ID = NULL 
                WHERE U_ID = %s AND Cart_ID IS NOT NULL
            """, (session['user_id'],))
            
            conn.commit()
            flash('Order placed successfully!', 'success')
            return redirect(url_for('order_confirmation'))
            
        except mysql.connector.Error as e:
            flash(f'Error processing order: {str(e)}', 'error')
        finally:
            cursor.close()
            conn.close()
    
    return render_template('checkout.html')

