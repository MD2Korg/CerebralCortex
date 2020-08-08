
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `cerebralcortex`
--

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `row_id` int NOT NULL,
  `user_id` varchar(100) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `study_name` varchar(100) DEFAULT NULL,
  `token` text,
  `token_issued` date DEFAULT NULL,
  `token_expiry` date DEFAULT NULL,
  `user_role` varchar(56) DEFAULT NULL,
  `user_metadata` json DEFAULT NULL,
  `user_settings` json DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `has_data` tinyint(1) DEFAULT NULL,
  `creation_date` date DEFAULT NULL
) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`row_id`),
  ADD UNIQUE KEY `ix_user_username` (`username`),
  ADD UNIQUE KEY `ix_user_user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `row_id` int NOT NULL AUTO_INCREMENT;
COMMIT;
