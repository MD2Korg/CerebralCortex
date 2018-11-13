-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 12, 2018 at 12:41 PM
-- Server version: 5.7.21-0ubuntu0.17.10.1
-- PHP Version: 7.1.15-0ubuntu0.17.10.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `cerebralcortex`
--
CREATE DATABASE IF NOT EXISTS `cerebralcortex` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `cerebralcortex`;

-- --------------------------------------------------------

--
-- Table structure for table `data_replay`
--

DROP TABLE IF EXISTS `data_replay`;
CREATE TABLE `data_replay` (
  `id` int(20) NOT NULL,
  `owner_id` varchar(40) NOT NULL,
  `stream_id` varchar(256) NOT NULL,
  `stream_name` varchar(255) NOT NULL,
  `day` varchar(12) NOT NULL,
  `files_list` json NOT NULL,
  `dir_size` int(10) NOT NULL,
  `metadata` json NOT NULL,
  `processed` int(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `data_replay_md2k2`
--

DROP TABLE IF EXISTS `data_replay_md2k2`;
CREATE TABLE `data_replay_md2k2` (
  `id` int(20) NOT NULL,
  `owner_id` varchar(40) NOT NULL,
  `stream_id` varchar(256) NOT NULL,
  `stream_name` varchar(255) NOT NULL,
  `day` varchar(12) NOT NULL,
  `files_list` json NOT NULL,
  `dir_size` int(10) NOT NULL,
  `metadata` json NOT NULL,
  `processed` int(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `identifier` varchar(36) NOT NULL,
  `owner` varchar(36) NOT NULL,
  `name` varchar(150) NOT NULL,
  `data_descriptor` json NOT NULL,
  `execution_context` json NOT NULL,
  `annotations` json NOT NULL,
  `type` varchar(45) NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `tmp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `identifier` varchar(40) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `token` text,
  `token_issued` datetime DEFAULT CURRENT_TIMESTAMP,
  `token_expiry` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_role` varchar(255) DEFAULT NULL,
  `user_metadata` json DEFAULT NULL,
  `active` tinyint(1) DEFAULT '0',
  `confirmed_at` datetime DEFAULT NULL,
  `tmp_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `cc_cache`
--

DROP TABLE IF EXISTS `cc_cache`;
CREATE TABLE `cc_cache` (
      `cache_key` varchar(255) NOT NULL,
      `cache_value` text,
      PRIMARY KEY (`cache_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`identifier`, `username`, `password`, `token`, `token_issued`, `token_expiry`, `user_role`, `user_metadata`, `active`, `confirmed_at`, `tmp_id`) VALUES
('636fcc1f-8966-4e63-a9df-0cbaa6e9296c', 'string', '473287f8298dba7163a897908958f7c0eae733e25d2e027992ea2edc9bed2fa8', NULL, '2017-09-28 23:08:29', '2017-09-28 23:08:29', 'demo', '{"study_name": "demo"}', 1, NULL, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `data_replay`
--
ALTER TABLE `data_replay`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `owner_id` (`owner_id`,`stream_id`,`day`);

--
-- Indexes for table `data_replay_md2k2`
--
ALTER TABLE `data_replay_md2k2`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `owner_id` (`owner_id`,`stream_id`,`day`);

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
  ADD PRIMARY KEY (`tmp`),
  ADD KEY `UUID` (`identifier`),
  ADD KEY `name` (`name`),
  ADD KEY `owner` (`owner`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`tmp_id`),
  ADD UNIQUE KEY `user_name` (`username`),
  ADD KEY `identifier` (`identifier`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `data_replay`
--
ALTER TABLE `data_replay`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `data_replay_md2k2`
--
ALTER TABLE `data_replay_md2k2`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `kafka_offsets`
--
ALTER TABLE `kafka_offsets`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `stream`
--
ALTER TABLE `stream`
  MODIFY `tmp` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `tmp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
