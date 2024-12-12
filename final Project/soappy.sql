-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 12, 2024 at 10:38 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `soappy`
--

-- --------------------------------------------------------

--
-- Table structure for table `low_inventory_alert`
--

CREATE TABLE `low_inventory_alert` (
  `soap_id` int(11) NOT NULL,
  `alert_id` int(11) NOT NULL,
  `alert_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_general_ci;

--
-- Dumping data for table `low_inventory_alert`
--

INSERT INTO `low_inventory_alert` (`soap_id`, `alert_id`, `alert_date`) VALUES
(8, 1, '2024-12-07 14:51:07'),
(7, 2, '2024-12-11 19:06:53');

-- --------------------------------------------------------

--
-- Table structure for table `sale`
--

CREATE TABLE `sale` (
  `sale_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `soap_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_general_ci;

--
-- Dumping data for table `sale`
--

INSERT INTO `sale` (`sale_id`, `user_id`, `soap_id`) VALUES
(1, 4, 1),
(6, 8, 7),
(7, 2, 8),
(8, 5, 9),
(9, 2, 7),
(13, 3, 7);

--
-- Triggers `sale`
--
DELIMITER $$
CREATE TRIGGER `after_sale_insert` AFTER INSERT ON `sale` FOR EACH ROW BEGIN 
    UPDATE soap 
    SET inventory = inventory - 1 
    WHERE soap_id = NEW.soap_id; 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `soap`
--

CREATE TABLE `soap` (
  `soap_id` int(11) NOT NULL,
  `weight_grams` decimal(10,2) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `season` enum('Fall','Winter','Spring','Summer') NOT NULL,
  `produce_date` date NOT NULL,
  `inventory` int(111) NOT NULL,
  `expire_date` date DEFAULT NULL,
  `soap_recipe_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_general_ci;

--
-- Dumping data for table `soap`
--

INSERT INTO `soap` (`soap_id`, `weight_grams`, `price`, `cost`, `season`, `produce_date`, `inventory`, `expire_date`, `soap_recipe_id`, `name`) VALUES
(1, 120.50, 9.99, 3.20, 'Fall', '2023-07-03', 50, '2025-07-03', 2, 'Breast Milk'),
(2, 60.50, 6.99, 2.20, 'Fall', '2023-07-14', 60, '2025-07-14', 4, 'SunSet'),
(4, 113.20, 9.99, 3.60, 'Winter', '2023-09-02', 40, '2025-09-02', 3, 'Forest'),
(5, 62.50, 6.99, 2.10, 'Winter', '2024-01-14', 23, '2026-01-14', 1, 'Cherry Blossom'),
(6, 122.70, 9.99, 3.20, 'Spring', '2024-01-17', 20, '2026-01-17', 6, 'Maple'),
(7, 62.50, 6.99, 2.10, 'Spring', '2024-01-25', 9, '2026-01-25', 7, 'Staring Night'),
(8, 62.50, 6.99, 2.10, 'Summer', '2024-03-20', 9, '2026-03-20', 5, 'Apple Cider'),
(9, 112.70, 9.99, 3.20, 'Fall', '2024-03-27', 10, '2026-03-27', 8, 'Wood Note');

--
-- Triggers `soap`
--
DELIMITER $$
CREATE TRIGGER `low_inventory_alert` AFTER UPDATE ON `soap` FOR EACH ROW BEGIN
    -- Check if the inventory is lower than 10 after the update
    IF NEW.inventory < 10 THEN
        -- Insert a new record into low_inventory_alerts table
        INSERT INTO low_inventory_alert (soap_id, alert_date)
        VALUES (NEW.soap_id, NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `soap_recipe`
--

CREATE TABLE `soap_recipe` (
  `soap_recipe_id` int(11) NOT NULL,
  `colour` varchar(100) NOT NULL,
  `main_oil` varchar(100) NOT NULL,
  `scent` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_general_ci;

--
-- Dumping data for table `soap_recipe`
--

INSERT INTO `soap_recipe` (`soap_recipe_id`, `colour`, `main_oil`, `scent`) VALUES
(1, 'Pink', 'Palm Oil', 'Floral'),
(2, 'None', 'Olive Oil', 'None'),
(3, 'Green', 'Grape Seed Oil', 'Teatree'),
(4, 'Yellow', 'Olive Oil', 'Ginger'),
(5, 'Red', 'Sunflower Oil', 'Apple Cinnamon'),
(6, 'Orange', 'Olive Oil', 'Maple'),
(7, 'Blue', 'Palm Oil', 'Ocean'),
(8, 'Brown', 'Palm Oil', 'Ceder');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `skin_types` enum('Oily','Dry','Normal','Combination','Sensitive') NOT NULL,
  `location` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `first_name`, `email`, `last_name`, `skin_types`, `location`) VALUES
(1, 'Judy', 'judy.chen@gmail.com', 'Chan', 'Oily', 'Toronto'),
(2, 'Miwand', 'miwand.khan@gmail.com', 'Khan', 'Normal', 'Richmond Hill'),
(3, 'Agustin', 'agustin.marquz@gmail.com', 'Marquz', 'Dry', 'Markhamn'),
(4, 'Santiago', 'santiago.leris@gmail.com', 'Leris', 'Combination', 'Mississauga'),
(5, 'Rachel', 'rachel.zegler@gmail.com', 'Zegler', 'Normal', 'Oakville'),
(6, 'Jennifer ', 'jennifer.lawrence@gmail.com\r\n\r\n', 'Lawrence', 'Combination', 'Newmarket'),
(8, 'Emma', 'emma.watson@gmail.com', 'Watson', 'Dry', 'London'),
(9, 'Leo', 'leo.messie@gmail.com', 'Messie', 'Combination', 'Toronto');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `low_inventory_alert`
--
ALTER TABLE `low_inventory_alert`
  ADD PRIMARY KEY (`alert_id`),
  ADD KEY `fk_soap_id` (`soap_id`);

--
-- Indexes for table `sale`
--
ALTER TABLE `sale`
  ADD PRIMARY KEY (`sale_id`),
  ADD KEY `fk_sale_soap_id` (`soap_id`),
  ADD KEY `fk_sale_user_id` (`user_id`);

--
-- Indexes for table `soap`
--
ALTER TABLE `soap`
  ADD PRIMARY KEY (`soap_id`),
  ADD KEY `fk_soap_recipe_id` (`soap_recipe_id`);

--
-- Indexes for table `soap_recipe`
--
ALTER TABLE `soap_recipe`
  ADD PRIMARY KEY (`soap_recipe_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `unique_email_index` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `low_inventory_alert`
--
ALTER TABLE `low_inventory_alert`
  MODIFY `alert_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sale`
--
ALTER TABLE `sale`
  MODIFY `sale_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `soap`
--
ALTER TABLE `soap`
  MODIFY `soap_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `soap_recipe`
--
ALTER TABLE `soap_recipe`
  MODIFY `soap_recipe_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `low_inventory_alert`
--
ALTER TABLE `low_inventory_alert`
  ADD CONSTRAINT `fk_soap_id` FOREIGN KEY (`soap_id`) REFERENCES `soap` (`soap_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sale`
--
ALTER TABLE `sale`
  ADD CONSTRAINT `fk_sale_soap_id` FOREIGN KEY (`soap_id`) REFERENCES `soap` (`soap_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sale_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `soap`
--
ALTER TABLE `soap`
  ADD CONSTRAINT `fk_soap_recipe_id` FOREIGN KEY (`soap_recipe_id`) REFERENCES `soap_recipe` (`soap_recipe_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
