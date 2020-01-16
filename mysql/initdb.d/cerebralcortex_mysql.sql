SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `cerebralcortex`
--
CREATE DATABASE IF NOT EXISTS `cerebralcortex` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `cerebralcortex`;

-- --------------------------------------------------------

--
-- Table structure for table `cc_cache`
--

DROP TABLE IF EXISTS `cc_cache`;
CREATE TABLE `cc_cache` (
  `cache_key` varchar(255) NOT NULL,
  `cache_value` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `corrected_metadata`
--

DROP TABLE IF EXISTS `corrected_metadata`;
CREATE TABLE `corrected_metadata` (
  `row_id` int(3) NOT NULL,
  `stream_name` varchar(255) NOT NULL,
  `metadata` json NOT NULL,
  `status` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ingestion_logs`
--

DROP TABLE IF EXISTS `ingestion_logs`;
CREATE TABLE `ingestion_logs` (
  `row_id` int(4) NOT NULL,
  `user_id` varchar(40) NOT NULL,
  `stream_name` varchar(255) NOT NULL,
  `metadata` json NOT NULL,
  `platform_metadata` json NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `fault_type` varchar(100) NOT NULL,
  `fault_description` text NOT NULL,
  `success` tinyint(1) NOT NULL,
  `added_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `kafka_offsets`
--

DROP TABLE IF EXISTS `kafka_offsets`;
CREATE TABLE `kafka_offsets` (
  `id` int(5) NOT NULL,
  `topic` varchar(255) NOT NULL,
  `topic_partition` varchar(15) NOT NULL,
  `offset_start` varchar(20) NOT NULL,
  `offset_until` varchar(20) NOT NULL,
  `offset_update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stream`
--

DROP TABLE IF EXISTS `stream`;
CREATE TABLE `stream` (
  `row_id` int(5) NOT NULL,
  `name` varchar(255) NOT NULL,
  `version` varchar(20) NOT NULL,
  `metadata_hash` varchar(45) NOT NULL,
  `metadata` json NOT NULL,
  `creation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `row_id` int(5) NOT NULL,
  `user_id` varchar(40) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `study_name` varchar(250) NOT NULL,
  `token` text,
  `token_issued` datetime DEFAULT CURRENT_TIMESTAMP,
  `token_expiry` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_role` varchar(255) DEFAULT NULL,
  `user_metadata` json DEFAULT NULL,
  `user_settings` json NOT NULL,
  `active` tinyint(1) DEFAULT '0',
  `confirmed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cc_cache`
--
ALTER TABLE `cc_cache`
  ADD PRIMARY KEY (`cache_key`);

--
-- Indexes for table `corrected_metadata`
--
ALTER TABLE `corrected_metadata`
  ADD PRIMARY KEY (`row_id`),
  ADD UNIQUE KEY `no_repeat` (`stream_name`);

--
-- Indexes for table `ingestion_logs`
--
ALTER TABLE `ingestion_logs`
  ADD PRIMARY KEY (`row_id`),
  ADD UNIQUE KEY `file_path_2` (`file_path`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `stream_name` (`stream_name`),
  ADD KEY `file_path` (`file_path`),
  ADD KEY `fault_type` (`fault_type`),
  ADD KEY `success` (`success`);

--
-- Indexes for table `kafka_offsets`
--
ALTER TABLE `kafka_offsets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_topic` (`topic`,`topic_partition`),
  ADD KEY `topic` (`topic`);

--
-- Indexes for table `stream`
--
ALTER TABLE `stream`
  ADD PRIMARY KEY (`row_id`),
  ADD UNIQUE KEY `metadata_hash` (`metadata_hash`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`row_id`),
  ADD UNIQUE KEY `user_name` (`username`),
  ADD KEY `identifier` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `corrected_metadata`
--
ALTER TABLE `corrected_metadata`
  MODIFY `row_id` int(3) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `ingestion_logs`
--
ALTER TABLE `ingestion_logs`
  MODIFY `row_id` int(4) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `kafka_offsets`
--
ALTER TABLE `kafka_offsets`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `stream`
--
ALTER TABLE `stream`
  MODIFY `row_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `row_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;