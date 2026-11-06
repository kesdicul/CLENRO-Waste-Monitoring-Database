-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 06, 2026 at 09:33 AM
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
-- Database: `clenro_waste_monitoring`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `activity_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `module` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `barangays`
--

CREATE TABLE `barangays` (
  `barangay_id` int(10) UNSIGNED NOT NULL,
  `barangay_name` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL DEFAULT 'Cagayan de Oro City',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `barangays`
--

INSERT INTO `barangays` (`barangay_id`, `barangay_name`, `city`, `created_at`) VALUES
(1, 'Cugman', 'Cagayan de Oro City', '2026-11-05 08:37:50'),
(2, 'Macasandig', 'Cagayan de Oro City', '2026-11-05 08:37:50'),
(3, 'Macanhan', 'Cagayan de Oro City', '2026-11-05 08:37:50');

-- --------------------------------------------------------

--
-- Table structure for table `collection_areas`
--

CREATE TABLE `collection_areas` (
  `area_id` int(10) UNSIGNED NOT NULL,
  `barangay_id` int(10) UNSIGNED NOT NULL,
  `area_name` varchar(120) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `collection_records`
--

CREATE TABLE `collection_records` (
  `record_id` int(10) UNSIGNED NOT NULL,
  `schedule_id` int(10) UNSIGNED NOT NULL,
  `route_stop_id` int(10) UNSIGNED NOT NULL,
  `status_id` int(10) UNSIGNED NOT NULL,
  `recorded_by` int(10) UNSIGNED NOT NULL,
  `collection_datetime` datetime DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `collection_routes`
--

CREATE TABLE `collection_routes` (
  `route_id` int(10) UNSIGNED NOT NULL,
  `route_name` varchar(120) NOT NULL,
  `description` text DEFAULT NULL,
  `route_status` enum('Active','Inactive','Archived') NOT NULL DEFAULT 'Active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `collection_schedules`
--

CREATE TABLE `collection_schedules` (
  `schedule_id` int(10) UNSIGNED NOT NULL,
  `route_id` int(10) UNSIGNED NOT NULL,
  `vehicle_id` int(10) UNSIGNED NOT NULL,
  `driver_user_id` int(10) UNSIGNED NOT NULL,
  `supervisor_user_id` int(10) UNSIGNED DEFAULT NULL,
  `scheduled_date` date NOT NULL,
  `scheduled_start_time` time NOT NULL,
  `schedule_status` enum('Scheduled','In Progress','Completed','Delayed','Missed','Cancelled') NOT NULL DEFAULT 'Scheduled',
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `collection_statuses`
--

CREATE TABLE `collection_statuses` (
  `status_id` int(10) UNSIGNED NOT NULL,
  `status_name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `collection_statuses`
--

INSERT INTO `collection_statuses` (`status_id`, `status_name`, `description`) VALUES
(1, 'Scheduled', 'Collection stop is planned but has not started'),
(2, 'In Progress', 'Collection at the stop is ongoing'),
(3, 'Completed', 'Collection at the stop has been completed'),
(4, 'Delayed', 'Collection is delayed'),
(5, 'Missed', 'Scheduled collection was not carried out'),
(6, 'Cancelled', 'Collection at the stop was cancelled');

-- --------------------------------------------------------

--
-- Table structure for table `gps_tracking`
--

CREATE TABLE `gps_tracking` (
  `gps_id` bigint(20) UNSIGNED NOT NULL,
  `vehicle_id` int(10) UNSIGNED NOT NULL,
  `schedule_id` int(10) UNSIGNED DEFAULT NULL,
  `latitude` decimal(10,7) NOT NULL,
  `longitude` decimal(10,7) NOT NULL,
  `accuracy` decimal(8,2) DEFAULT NULL,
  `recorded_at` datetime NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `residents`
--

CREATE TABLE `residents` (
  `resident_id` int(10) UNSIGNED NOT NULL,
  `barangay_id` int(10) UNSIGNED NOT NULL,
  `full_name` varchar(150) NOT NULL,
  `mobile_number` varchar(30) NOT NULL,
  `address` varchar(255) NOT NULL,
  `subscription_status` enum('Subscribed','Unsubscribed') NOT NULL DEFAULT 'Subscribed',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `role_name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`, `description`) VALUES
(1, 'System Administrator', 'Manages system configuration and authorized accounts'),
(2, 'CLENRO Head / Authorized Officer', 'Oversees CLENRO operations and system reports'),
(3, 'CLENRO Personnel', 'Manages collection operations and records'),
(4, 'Barangay Officials / Staff', 'Views and coordinates barangay collection information'),
(5, 'Waste Collection Supervisors', 'Supervises assigned collection schedules'),
(6, 'Garbage Truck Drivers', 'Operates assigned collection vehicles'),
(7, 'Waste Collectors', 'Performs assigned waste collection activities');

-- --------------------------------------------------------

--
-- Table structure for table `route_stops`
--

CREATE TABLE `route_stops` (
  `route_stop_id` int(10) UNSIGNED NOT NULL,
  `route_id` int(10) UNSIGNED NOT NULL,
  `area_id` int(10) UNSIGNED NOT NULL,
  `stop_sequence` smallint(5) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `schedule_collectors`
--

CREATE TABLE `schedule_collectors` (
  `schedule_collector_id` int(10) UNSIGNED NOT NULL,
  `schedule_id` int(10) UNSIGNED NOT NULL,
  `collector_user_id` int(10) UNSIGNED NOT NULL,
  `assigned_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sms_notifications`
--

CREATE TABLE `sms_notifications` (
  `sms_id` bigint(20) UNSIGNED NOT NULL,
  `resident_id` int(10) UNSIGNED NOT NULL,
  `schedule_id` int(10) UNSIGNED DEFAULT NULL,
  `notification_type` enum('Collection Schedule','Schedule Change','Collection Delay') NOT NULL,
  `message_content` text NOT NULL,
  `gateway_reference` varchar(150) DEFAULT NULL,
  `delivery_status` enum('Pending','Sent','Delivered','Failed') NOT NULL DEFAULT 'Pending',
  `sent_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `barangay_id` int(10) UNSIGNED DEFAULT NULL,
  `full_name` varchar(150) NOT NULL,
  `username` varchar(80) NOT NULL,
  `email` varchar(190) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `contact_number` varchar(30) DEFAULT NULL,
  `account_status` enum('Active','Inactive','Suspended') NOT NULL DEFAULT 'Active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `vehicle_id` int(10) UNSIGNED NOT NULL,
  `vehicle_code` varchar(50) NOT NULL,
  `plate_number` varchar(30) NOT NULL,
  `vehicle_type` varchar(80) NOT NULL,
  `capacity` decimal(10,2) DEFAULT NULL,
  `vehicle_status` enum('Active','Inactive','Under Maintenance','Retired') NOT NULL DEFAULT 'Active',
  `gps_device_identifier` varchar(120) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`activity_id`),
  ADD KEY `idx_activity_user_created` (`user_id`,`created_at`),
  ADD KEY `idx_activity_module_created` (`module`,`created_at`),
  ADD KEY `idx_activity_created` (`created_at`);

--
-- Indexes for table `barangays`
--
ALTER TABLE `barangays`
  ADD PRIMARY KEY (`barangay_id`),
  ADD UNIQUE KEY `uq_barangay_city_name` (`city`,`barangay_name`);

--
-- Indexes for table `collection_areas`
--
ALTER TABLE `collection_areas`
  ADD PRIMARY KEY (`area_id`),
  ADD UNIQUE KEY `uq_collection_area_per_barangay` (`barangay_id`,`area_name`),
  ADD KEY `idx_areas_name` (`area_name`);

--
-- Indexes for table `collection_records`
--
ALTER TABLE `collection_records`
  ADD PRIMARY KEY (`record_id`),
  ADD UNIQUE KEY `uq_collection_record_stop` (`schedule_id`,`route_stop_id`),
  ADD KEY `fk_collection_records_user` (`recorded_by`),
  ADD KEY `idx_collection_records_schedule` (`schedule_id`),
  ADD KEY `idx_collection_records_stop` (`route_stop_id`),
  ADD KEY `idx_collection_records_status` (`status_id`),
  ADD KEY `idx_collection_records_datetime` (`collection_datetime`);

--
-- Indexes for table `collection_routes`
--
ALTER TABLE `collection_routes`
  ADD PRIMARY KEY (`route_id`),
  ADD UNIQUE KEY `uq_routes_name` (`route_name`),
  ADD KEY `idx_routes_status` (`route_status`);

--
-- Indexes for table `collection_schedules`
--
ALTER TABLE `collection_schedules`
  ADD PRIMARY KEY (`schedule_id`),
  ADD KEY `fk_schedules_creator` (`created_by`),
  ADD KEY `idx_schedules_date_status` (`scheduled_date`,`schedule_status`),
  ADD KEY `idx_schedules_vehicle_date` (`vehicle_id`,`scheduled_date`),
  ADD KEY `idx_schedules_driver_date` (`driver_user_id`,`scheduled_date`),
  ADD KEY `idx_schedules_supervisor` (`supervisor_user_id`),
  ADD KEY `idx_schedules_route_date` (`route_id`,`scheduled_date`);

--
-- Indexes for table `collection_statuses`
--
ALTER TABLE `collection_statuses`
  ADD PRIMARY KEY (`status_id`),
  ADD UNIQUE KEY `uq_collection_statuses_name` (`status_name`);

--
-- Indexes for table `gps_tracking`
--
ALTER TABLE `gps_tracking`
  ADD PRIMARY KEY (`gps_id`),
  ADD KEY `idx_gps_vehicle_recorded` (`vehicle_id`,`recorded_at`),
  ADD KEY `idx_gps_schedule_recorded` (`schedule_id`,`recorded_at`),
  ADD KEY `idx_gps_recorded_at` (`recorded_at`);

--
-- Indexes for table `residents`
--
ALTER TABLE `residents`
  ADD PRIMARY KEY (`resident_id`),
  ADD KEY `idx_residents_barangay` (`barangay_id`),
  ADD KEY `idx_residents_mobile` (`mobile_number`),
  ADD KEY `idx_residents_subscription` (`subscription_status`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `uq_roles_role_name` (`role_name`);

--
-- Indexes for table `route_stops`
--
ALTER TABLE `route_stops`
  ADD PRIMARY KEY (`route_stop_id`),
  ADD UNIQUE KEY `uq_route_stop_sequence` (`route_id`,`stop_sequence`),
  ADD KEY `idx_route_stops_area` (`area_id`);

--
-- Indexes for table `schedule_collectors`
--
ALTER TABLE `schedule_collectors`
  ADD PRIMARY KEY (`schedule_collector_id`),
  ADD UNIQUE KEY `uq_schedule_collector` (`schedule_id`,`collector_user_id`),
  ADD KEY `idx_schedule_collectors_user` (`collector_user_id`);

--
-- Indexes for table `sms_notifications`
--
ALTER TABLE `sms_notifications`
  ADD PRIMARY KEY (`sms_id`),
  ADD KEY `idx_sms_resident_created` (`resident_id`,`created_at`),
  ADD KEY `idx_sms_schedule` (`schedule_id`),
  ADD KEY `idx_sms_status_created` (`delivery_status`,`created_at`),
  ADD KEY `idx_sms_gateway_reference` (`gateway_reference`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `uq_users_username` (`username`),
  ADD UNIQUE KEY `uq_users_email` (`email`),
  ADD KEY `idx_users_role_status` (`role_id`,`account_status`),
  ADD KEY `idx_users_barangay` (`barangay_id`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`vehicle_id`),
  ADD UNIQUE KEY `uq_vehicles_code` (`vehicle_code`),
  ADD UNIQUE KEY `uq_vehicles_plate` (`plate_number`),
  ADD UNIQUE KEY `uq_vehicles_gps_device` (`gps_device_identifier`),
  ADD KEY `idx_vehicles_status` (`vehicle_status`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `activity_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `barangays`
--
ALTER TABLE `barangays`
  MODIFY `barangay_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `collection_areas`
--
ALTER TABLE `collection_areas`
  MODIFY `area_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `collection_records`
--
ALTER TABLE `collection_records`
  MODIFY `record_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `collection_routes`
--
ALTER TABLE `collection_routes`
  MODIFY `route_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `collection_schedules`
--
ALTER TABLE `collection_schedules`
  MODIFY `schedule_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `collection_statuses`
--
ALTER TABLE `collection_statuses`
  MODIFY `status_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `gps_tracking`
--
ALTER TABLE `gps_tracking`
  MODIFY `gps_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `residents`
--
ALTER TABLE `residents`
  MODIFY `resident_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `route_stops`
--
ALTER TABLE `route_stops`
  MODIFY `route_stop_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `schedule_collectors`
--
ALTER TABLE `schedule_collectors`
  MODIFY `schedule_collector_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sms_notifications`
--
ALTER TABLE `sms_notifications`
  MODIFY `sms_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `vehicle_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `fk_activity_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `collection_areas`
--
ALTER TABLE `collection_areas`
  ADD CONSTRAINT `fk_areas_barangay` FOREIGN KEY (`barangay_id`) REFERENCES `barangays` (`barangay_id`) ON UPDATE CASCADE;

--
-- Constraints for table `collection_records`
--
ALTER TABLE `collection_records`
  ADD CONSTRAINT `fk_collection_records_schedule` FOREIGN KEY (`schedule_id`) REFERENCES `collection_schedules` (`schedule_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_collection_records_status` FOREIGN KEY (`status_id`) REFERENCES `collection_statuses` (`status_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_collection_records_stop` FOREIGN KEY (`route_stop_id`) REFERENCES `route_stops` (`route_stop_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_collection_records_user` FOREIGN KEY (`recorded_by`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `collection_schedules`
--
ALTER TABLE `collection_schedules`
  ADD CONSTRAINT `fk_schedules_creator` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_schedules_driver` FOREIGN KEY (`driver_user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_schedules_route` FOREIGN KEY (`route_id`) REFERENCES `collection_routes` (`route_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_schedules_supervisor` FOREIGN KEY (`supervisor_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_schedules_vehicle` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`) ON UPDATE CASCADE;

--
-- Constraints for table `gps_tracking`
--
ALTER TABLE `gps_tracking`
  ADD CONSTRAINT `fk_gps_schedule` FOREIGN KEY (`schedule_id`) REFERENCES `collection_schedules` (`schedule_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_gps_vehicle` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`) ON UPDATE CASCADE;

--
-- Constraints for table `residents`
--
ALTER TABLE `residents`
  ADD CONSTRAINT `fk_residents_barangay` FOREIGN KEY (`barangay_id`) REFERENCES `barangays` (`barangay_id`) ON UPDATE CASCADE;

--
-- Constraints for table `route_stops`
--
ALTER TABLE `route_stops`
  ADD CONSTRAINT `fk_route_stops_area` FOREIGN KEY (`area_id`) REFERENCES `collection_areas` (`area_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_route_stops_route` FOREIGN KEY (`route_id`) REFERENCES `collection_routes` (`route_id`) ON UPDATE CASCADE;

--
-- Constraints for table `schedule_collectors`
--
ALTER TABLE `schedule_collectors`
  ADD CONSTRAINT `fk_schedule_collectors_schedule` FOREIGN KEY (`schedule_id`) REFERENCES `collection_schedules` (`schedule_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_schedule_collectors_user` FOREIGN KEY (`collector_user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `sms_notifications`
--
ALTER TABLE `sms_notifications`
  ADD CONSTRAINT `fk_sms_resident` FOREIGN KEY (`resident_id`) REFERENCES `residents` (`resident_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sms_schedule` FOREIGN KEY (`schedule_id`) REFERENCES `collection_schedules` (`schedule_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_barangay` FOREIGN KEY (`barangay_id`) REFERENCES `barangays` (`barangay_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_users_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
