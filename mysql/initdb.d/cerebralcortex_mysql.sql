-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 22, 2019 at 10:42 AM
-- Server version: 5.7.24-0ubuntu0.18.04.1
-- PHP Version: 7.0.33-1+ubuntu18.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

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
  `token` text,
  `token_issued` datetime DEFAULT CURRENT_TIMESTAMP,
  `token_expiry` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_role` varchar(255) DEFAULT NULL,
  `user_metadata` json DEFAULT NULL,
  `active` tinyint(1) DEFAULT '0',
  `confirmed_at` datetime DEFAULT CURRENT_TIMESTAMP
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
-- Indexes for table `data_replay`
--
ALTER TABLE `data_replay`
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
  ADD PRIMARY KEY (`row_id`);

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
-- AUTO_INCREMENT for table `data_replay`
--
ALTER TABLE `data_replay`
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
  MODIFY `row_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `row_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
