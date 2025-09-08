-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 08, 2025 at 02:33 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `click_build_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `ID` int(11) NOT NULL,
  `Product` varchar(100) DEFAULT NULL,
  `C_Date` date DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Dis_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`ID`, `Product`, `C_Date`, `Quantity`, `Dis_ID`) VALUES
(1, 'AMD RX 7900 XTX', '2025-08-31', 1, NULL),
(6, 'AMD Ryzen 9 7900X', '2025-09-05', 1, NULL),
(7, 'AMD RX 7800 XT', '2025-09-05', 1, NULL),
(8, 'G.Skill Trident Z5 32GB DDR5', '2025-09-05', 1, NULL),
(9, 'Seagate Barracuda 2TB HDD', '2025-09-05', 1, NULL),
(10, 'be quiet! Pure Base 500DX', '2025-09-05', 1, NULL),
(11, 'Corsair RM850x 850W', '2025-09-05', 1, NULL),
(12, 'ASRock B550M Pro4', '2025-09-05', 1, NULL),
(14, 'AMD Ryzen 5 7600X', '2025-09-07', 1, NULL),
(15, 'NVIDIA RTX 4080', '2025-09-07', 1, NULL),
(16, 'Corsair Vengeance LPX 32GB DDR4', '2025-09-07', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `Cat_ID` int(11) NOT NULL,
  `Description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`Cat_ID`, `Description`) VALUES
(1, 'Central Processing Units for computing'),
(2, 'Graphics Processing Units for gaming and rendering'),
(3, 'System memory modules'),
(4, 'Storage devices for data'),
(5, 'Computer cases and enclosures'),
(6, 'Power supply units'),
(7, 'Motherboards and mainboards');

-- --------------------------------------------------------

--
-- Table structure for table `category_name`
--

CREATE TABLE `category_name` (
  `Cat_ID` int(11) NOT NULL,
  `Cat_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category_name`
--

INSERT INTO `category_name` (`Cat_ID`, `Cat_name`) VALUES
(1, 'CPU'),
(2, 'GPU'),
(3, 'RAM'),
(4, 'Storage'),
(5, 'Cases'),
(6, 'PSU'),
(7, 'Motherboard');

-- --------------------------------------------------------

--
-- Table structure for table `chooses`
--

CREATE TABLE `chooses` (
  `U_ID` int(11) NOT NULL,
  `Cat_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `components`
--

CREATE TABLE `components` (
  `C_ID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Brand` varchar(100) DEFAULT NULL,
  `U_ID` int(11) DEFAULT NULL,
  `B_ID` int(11) DEFAULT NULL,
  `Cart_ID` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `supports` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `components`
--

INSERT INTO `components` (`C_ID`, `Name`, `Price`, `Brand`, `U_ID`, `B_ID`, `Cart_ID`, `type`, `supports`) VALUES
(1, 'Intel Core i9-13900K', 589.99, 'Intel', 2, NULL, NULL, 'CPU', NULL),
(2, 'AMD Ryzen 9 7900X', 549.99, 'AMD', 2, NULL, NULL, 'CPU', NULL),
(3, 'Intel Core i7-13700K', 409.99, 'Intel', NULL, NULL, NULL, 'CPU', NULL),
(4, 'AMD Ryzen 7 7700X', 399.99, 'AMD', NULL, 2, NULL, 'CPU', NULL),
(5, 'Intel Core i5-13600K', 319.99, 'Intel', NULL, NULL, NULL, 'CPU', NULL),
(6, 'AMD Ryzen 5 7600X', 299.99, 'AMD', 2, 2, NULL, 'CPU', NULL),
(7, 'NVIDIA RTX 4090', 1599.99, 'NVIDIA', NULL, NULL, NULL, 'GPU', NULL),
(8, 'NVIDIA RTX 4080', 1199.99, 'NVIDIA', 2, NULL, NULL, 'GPU', NULL),
(9, 'AMD RX 7900 XTX', 999.99, 'AMD', 2, 2, NULL, 'GPU', NULL),
(10, 'NVIDIA RTX 4070', 599.99, 'NVIDIA', NULL, NULL, NULL, 'GPU', NULL),
(11, 'AMD RX 7800 XT', 499.99, 'AMD', 2, NULL, NULL, 'GPU', NULL),
(12, 'NVIDIA RTX 4060', 299.99, 'NVIDIA', NULL, NULL, NULL, 'GPU', NULL),
(13, 'Corsair Vengeance LPX 32GB DDR4', 129.99, 'Corsair', 2, NULL, NULL, 'RAM', NULL),
(14, 'G.Skill Trident Z5 32GB DDR5', 179.99, 'G.Skill', 2, NULL, NULL, 'RAM', NULL),
(15, 'Kingston Fury Beast 16GB DDR4', 64.99, 'Kingston', NULL, NULL, NULL, 'RAM', NULL),
(16, 'Crucial Ballistix 16GB DDR4', 59.99, 'Crucial', 2, NULL, NULL, 'RAM', NULL),
(17, 'Samsung 980 Pro 1TB NVMe', 119.99, 'Samsung', NULL, NULL, NULL, 'STORAGE', NULL),
(18, 'WD Black SN850 2TB NVMe', 199.99, 'Western Digital', NULL, NULL, NULL, 'STORAGE', NULL),
(19, 'Crucial MX4 1TB SSD', 89.99, 'Crucial', NULL, NULL, NULL, 'STORAGE', NULL),
(20, 'Seagate Barracuda 2TB HDD', 54.99, 'Seagate', 2, NULL, NULL, 'STORAGE', NULL),
(21, 'NZXT H7 Flow', 139.99, 'NZXT', NULL, NULL, NULL, 'COOLER', NULL),
(22, 'Fractal Design Define 7', 169.99, 'Fractal Design', NULL, NULL, NULL, 'CASE', NULL),
(23, 'Corsair 4000D Airflow', 104.99, 'Corsair', NULL, NULL, NULL, 'COOLER', NULL),
(24, 'be quiet! Pure Base 500DX', 99.99, 'be quiet!', 2, NULL, NULL, 'CASE', NULL),
(25, 'Corsair RM850x 850W', 139.99, 'Corsair', 2, NULL, NULL, 'PSU', NULL),
(26, 'EVGA SuperNOVA 750W', 119.99, 'EVGA', NULL, NULL, NULL, 'PSU', NULL),
(27, 'Seasonic Focus GX-650', 99.99, 'Seasonic', NULL, NULL, NULL, 'PSU', NULL),
(28, 'ASUS ROG Strix Z790-E', 399.99, 'ASUS', NULL, NULL, NULL, 'MOBO', 'Intel'),
(29, 'MSI MAG B650 Tomahawk', 249.99, 'MSI', NULL, NULL, NULL, 'MOBO', 'AMD'),
(30, 'Gigabyte Z790 Aorus Elite', 299.99, 'Gigabyte', NULL, NULL, NULL, 'MOBO', 'Intel'),
(31, 'ASRock B550M Pro4', 79.99, 'ASRock', 2, NULL, NULL, 'MOBO', 'AMD');

-- --------------------------------------------------------

--
-- Table structure for table `discount`
--

CREATE TABLE `discount` (
  `Dis_ID` int(11) NOT NULL,
  `Type` varchar(50) DEFAULT NULL,
  `Start` date DEFAULT NULL,
  `End` date DEFAULT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `C_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `discount`
--

INSERT INTO `discount` (`Dis_ID`, `Type`, `Start`, `End`, `Amount`, `C_ID`) VALUES
(1, 'Percentage', '2025-08-01', '2025-09-30', 50.00, 7),
(2, 'Percentage', '2025-08-01', '2025-09-30', 30.00, 13),
(3, 'Percentage', '2025-08-01', '2025-09-30', 20.00, 17),
(4, 'Percentage', '2025-08-01', '2025-09-30', 25.00, 21),
(5, 'Percentage', '2025-08-01', '2025-09-30', 15.00, 25);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `U_ID` int(11) NOT NULL,
  `P_ID` int(11) NOT NULL,
  `Cart_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`U_ID`, `P_ID`, `Cart_ID`) VALUES
(2, 1, 1),
(2, 2, 6),
(2, 2, 7),
(2, 2, 8),
(2, 2, 9),
(2, 2, 10),
(2, 2, 11),
(2, 2, 12),
(2, 3, 14),
(2, 4, 15),
(2, 4, 16);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `P_ID` int(11) NOT NULL,
  `COD` tinyint(1) DEFAULT 0,
  `offlineFlag` tinyint(1) DEFAULT 0,
  `Baksh` tinyint(1) DEFAULT 0,
  `Visa` tinyint(1) DEFAULT 0,
  `Nogod` tinyint(1) DEFAULT 0,
  `onlineFlag` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`P_ID`, `COD`, `offlineFlag`, `Baksh`, `Visa`, `Nogod`, `onlineFlag`) VALUES
(1, 1, 1, 0, 0, 0, 0),
(2, 1, 1, 0, 0, 0, 0),
(3, 1, 1, 0, 0, 0, 0),
(4, 0, 0, 1, 0, 0, 1),
(5, 1, 1, 0, 0, 0, 0),
(6, 0, 0, 0, 1, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `pc_build`
--

CREATE TABLE `pc_build` (
  `B_ID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `C_Date` date DEFAULT NULL,
  `U_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pc_build`
--

INSERT INTO `pc_build` (`B_ID`, `Name`, `C_Date`, `U_ID`) VALUES
(2, 'fd', '2025-08-31', 2),
(3, 'pc', '2025-09-05', 2),
(4, 'as', '2025-09-07', 2);

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `Rev_ID` int(11) NOT NULL,
  `Comment` text DEFAULT NULL,
  `Rating` int(11) DEFAULT NULL CHECK (`Rating` >= 1 and `Rating` <= 5),
  `U_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `review`
--

INSERT INTO `review` (`Rev_ID`, `Comment`, `Rating`, `U_ID`) VALUES
(1, 'Great selection of components and fast delivery!', 5, 1),
(2, 'The PC builder tool is very intuitive and helpful.', 4, 1),
(3, 'Competitive prices and good customer service.', 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `stocks`
--

CREATE TABLE `stocks` (
  `C_ID` int(11) NOT NULL,
  `Stock` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stocks`
--

INSERT INTO `stocks` (`C_ID`, `Stock`) VALUES
(1, 15),
(2, 20),
(3, 25),
(4, 18),
(5, 30),
(6, 22),
(7, 8),
(8, 12),
(9, 15),
(10, 25),
(11, 18),
(12, 35),
(13, 50),
(14, 40),
(15, 30),
(16, 25),
(17, 20),
(18, 15),
(19, 12),
(20, 8),
(21, 10),
(22, 15),
(23, 20),
(24, 18),
(25, 12),
(26, 15),
(27, 25),
(28, 8),
(29, 12),
(30, 10),
(31, 20);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `U_ID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`U_ID`, `Name`, `Email`, `Password`, `Address`) VALUES
(1, 'John Doe', 'john@example.com', 'scrypt:32768:8:1$VqT8x5KwmG2lQjR9$64f1e4f3c8b5a2d9e6f7a8b1c2d3e4f5g6h7i8j9k0l1m2n3o4p5q6r7s8t9u0v1w2x3y4z5a6b7c8d9e0f1g2h3i4j5k6l7m8n9o0p1q2r3s4t5u6v7w8x9y0z1', 'Dhaka, Bangladesh'),
(2, 'Debopriyo Karmaker', 'deb@gmail.com', 'pbkdf2:sha256:600000$uB3o5bjQHCcZkXbb$997736286eca050ea66f4e7b5a2ab53ac9d1236f543a4063a96dbba1707a31bf', 'abc');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Dis_ID` (`Dis_ID`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`Cat_ID`);

--
-- Indexes for table `category_name`
--
ALTER TABLE `category_name`
  ADD PRIMARY KEY (`Cat_ID`);

--
-- Indexes for table `chooses`
--
ALTER TABLE `chooses`
  ADD PRIMARY KEY (`U_ID`,`Cat_ID`),
  ADD KEY `Cat_ID` (`Cat_ID`);

--
-- Indexes for table `components`
--
ALTER TABLE `components`
  ADD PRIMARY KEY (`C_ID`),
  ADD KEY `U_ID` (`U_ID`),
  ADD KEY `B_ID` (`B_ID`),
  ADD KEY `Cart_ID` (`Cart_ID`);

--
-- Indexes for table `discount`
--
ALTER TABLE `discount`
  ADD PRIMARY KEY (`Dis_ID`),
  ADD KEY `C_ID` (`C_ID`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`U_ID`,`P_ID`,`Cart_ID`),
  ADD KEY `P_ID` (`P_ID`),
  ADD KEY `Cart_ID` (`Cart_ID`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`P_ID`);

--
-- Indexes for table `pc_build`
--
ALTER TABLE `pc_build`
  ADD PRIMARY KEY (`B_ID`),
  ADD KEY `U_ID` (`U_ID`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`Rev_ID`),
  ADD KEY `U_ID` (`U_ID`);

--
-- Indexes for table `stocks`
--
ALTER TABLE `stocks`
  ADD PRIMARY KEY (`C_ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`U_ID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `Cat_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `components`
--
ALTER TABLE `components`
  MODIFY `C_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `discount`
--
ALTER TABLE `discount`
  MODIFY `Dis_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `P_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `pc_build`
--
ALTER TABLE `pc_build`
  MODIFY `B_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `Rev_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `U_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`Dis_ID`) REFERENCES `discount` (`Dis_ID`);

--
-- Constraints for table `category_name`
--
ALTER TABLE `category_name`
  ADD CONSTRAINT `category_name_ibfk_1` FOREIGN KEY (`Cat_ID`) REFERENCES `category` (`Cat_ID`);

--
-- Constraints for table `chooses`
--
ALTER TABLE `chooses`
  ADD CONSTRAINT `chooses_ibfk_1` FOREIGN KEY (`U_ID`) REFERENCES `users` (`U_ID`),
  ADD CONSTRAINT `chooses_ibfk_2` FOREIGN KEY (`Cat_ID`) REFERENCES `category` (`Cat_ID`);

--
-- Constraints for table `components`
--
ALTER TABLE `components`
  ADD CONSTRAINT `components_ibfk_1` FOREIGN KEY (`U_ID`) REFERENCES `users` (`U_ID`),
  ADD CONSTRAINT `components_ibfk_2` FOREIGN KEY (`B_ID`) REFERENCES `pc_build` (`B_ID`),
  ADD CONSTRAINT `components_ibfk_3` FOREIGN KEY (`Cart_ID`) REFERENCES `cart` (`ID`);

--
-- Constraints for table `discount`
--
ALTER TABLE `discount`
  ADD CONSTRAINT `discount_ibfk_1` FOREIGN KEY (`C_ID`) REFERENCES `components` (`C_ID`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`U_ID`) REFERENCES `users` (`U_ID`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`P_ID`) REFERENCES `payment` (`P_ID`),
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`Cart_ID`) REFERENCES `cart` (`ID`);

--
-- Constraints for table `pc_build`
--
ALTER TABLE `pc_build`
  ADD CONSTRAINT `pc_build_ibfk_1` FOREIGN KEY (`U_ID`) REFERENCES `users` (`U_ID`);

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`U_ID`) REFERENCES `users` (`U_ID`);

--
-- Constraints for table `stocks`
--
ALTER TABLE `stocks`
  ADD CONSTRAINT `stocks_ibfk_1` FOREIGN KEY (`C_ID`) REFERENCES `components` (`C_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
