-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 11, 2022 at 12:35 PM
-- Server version: 8.0.28
-- PHP Version: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `salamonb_python-login`
--
CREATE DATABASE IF NOT EXISTS `project` DEFAULT CHARACTER SET utf8 COLLATE utf8_hungarian_ci;
USE `project`;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int NOT NULL,
  `category` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `category`) VALUES
(1, 'Tanulás'),
(2, 'Munka'),
(3, 'Bevásárlás'),
(4, 'Család'),
(5, 'Számlák');

-- --------------------------------------------------------

--
-- Table structure for table `mission`
--

CREATE TABLE `mission` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `misson` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `end_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- Dumping data for table `mission`
--

INSERT INTO `mission` (`id`, `user_id`, `misson`, `creation_date`, `end_date`) VALUES
(1, 2, 'Meg kell csinálni a projektet', '2022-02-08 12:44:00', '2022-05-01 12:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `reminder`
--

CREATE TABLE `reminder` (
  `id` int NOT NULL,
  `reminder` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- Dumping data for table `reminder`
--

INSERT INTO `reminder` (`id`, `reminder`) VALUES
(1, 'Melyik városban született?'),
(2, 'Mi volt az első háziállata neve?'),
(3, 'Mi volt a középiskolájának a neve?'),
(4, 'Mi a kedvenc könyvének neve?');

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

CREATE TABLE `session` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `token_hash` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- Dumping data for table `session`
--

INSERT INTO `session` (`id`, `user_id`, `token_hash`) VALUES
(3, 2, '8c07c2c4b2b3bbd8fc01e360ccb36d4ba559d8d1bfee4bbd6d772cf9ce05519f'),
(4, 2, '66a0b840c010389c08b6388c3db37fb7e7bbfd8c52624b66bd171ea09987edc9'),
(5, 2, 'ad40f291c12f63c67ce0e208708f24fce7e757a07973e6ce61051f5a7f321055'),
(10, 2, '5b0123b3b35e881cbf113c41ccc7d632ebe100283eb12178533a7d10629ad007'),
(13, 4, '8ee7269bb596fcca0f5e749f0ba7b9713cc3dade5ed28cf0c3587cbe81f11f8d'),
(16, 5, '0afbba3155cfe3224d94ab4ef9e472ea2ac26cd32f5d4eb0f7b660ec5fd039e8'),
(19, 6, 'd5738fe1feaaa8082215150a5a4659050241e8b9d50c7d2095bd4a2ce6d50155'),
(23, 7, '940cf564514f5774bc599259e5b1cd37436413f4a368278c11944454a6d72d68'),
(24, 8, '8005fe04c290dc280a40fbae70f6890869ee0a6f759c2becf46e398a07c26c79'),
(26, 2, 'c1e69cbbd47acc4b3b76ef409c34b709af42f72997a8f2b47a4f98c4a64a3907'),
(27, 2, 'db6773fbfef05524400265e67a83c1c89af607b993a336257c6ac2f165330e77'),
(28, 2, 'fcb259134a6837101980181d73808a268ed087c3b675c83f072c7edea5194093'),
(29, 2, 'ee47d6f092d8a03f15e23e6156bead885bedc78aa70727973bbb46ba4941da39'),
(30, 2, 'fc6093f13d8f31ca7d073a75c54ec5686558fbd6ef3056e3034566b9ec8e8b29'),
(31, 2, '56046f8020b6ce2eb0a6ab4007dc18f0640de959628f5d39eff63cf2c2988c33'),
(32, 2, '0de12481424d3e34ec547de9680c398af4c86a36b67b3c1cb3f0c9dab1c6739f'),
(33, 2, '51411e0e6d3807a2f7c2c5dc666e8060420f5a16efaffad9ceafb9f571dad252'),
(37, 2, '51014fc88774b51c7c4d0c06c9aaf40b089c9397f4d4ea92d3f3f904f8c3afda'),
(40, 13, 'f337535e841cfe64e5590716a41e15116b3c9a73c0183d4ffa985bc8d8874090'),
(41, 13, 'f93ef86c512ef5616057585816e5ef54441b7fd97b9f87d1ebe4ab25655cad79'),
(44, 14, '6b0bffde8482462dce2349cbb51815518541982495283331d04235dca973b9cf');

-- --------------------------------------------------------

--
-- Table structure for table `todo`
--

CREATE TABLE `todo` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `todo` varchar(256) COLLATE utf8_hungarian_ci NOT NULL,
  `category_id` int NOT NULL,
  `creation_date` int NOT NULL,
  `done` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_hungarian_ci;

--
-- Dumping data for table `todo`
--

INSERT INTO `todo` (`id`, `user_id`, `todo`, `category_id`, `creation_date`, `done`) VALUES
(1, 2, 'Feladat szövege.', 1, 1644353737, 0),
(2, 2, 'Feladat szövege 2.', 1, 1644353753, 0),
(10, 13, 'Csinálni egy Jészön éjpiájt.', 1, 1644526411, 0),
(11, 14, 'valamit csinálni', 2, 1644578638, 0),
(12, 15, 'valamit csinálni 2', 1, 1644579212, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int NOT NULL,
  `username` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `password_hash` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `password_salt` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `first_name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `last_name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `gender` int NOT NULL,
  `register_date` bigint NOT NULL,
  `password_reset_token` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  `email_verification_token` char(64) COLLATE utf8mb4_hungarian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password_hash`, `password_salt`, `email`, `first_name`, `last_name`, `gender`, `register_date`, `password_reset_token`, `email_verification_token`) VALUES
(2, 'admin', '87016ea764ce80079e4200a2139042f028a402a1103b200ca2810ab02ea7b18f', '9416cadebf073942fa5101db184583e31ae256464c056ce892f446267700a951', 'admin@example.com', 'Admin', 'Project', 0, 1643831501, '1b4d7dfd9f11ee84f549b565c1ae324d4957f75649346c180c1b6bd29e1c77db', NULL),
(3, 'szotaksoma', 'd091efb883a8aadd40a6332374a27f02a910ea293f836a1200e2e488d5c85fc4', '990425b6adf2dd8c9f2e334da8d8dfa9227582879fa91af8948d2c4b005565a7', 'szotaksoma@gmail.com', 'Soma', 'Szoták', 0, 1644351144, '956a0b71bafd2fe4b5c5686cb57f78c2f3d0cf7acb9843fdc99b9d7b8c11345d', NULL),
(4, 'szotaksimon', '0b383c3b6ad9cdbd435def6491760978a11e05e5aa9f7e685f9b22d49f527b83', '341654c7338157a7fad87387d2d03838ed6537e666348df2684b5acdba3793bc', 'szotak.simon16@gmail.com', 'Simon', 'Szoták', 0, 1644354697, NULL, NULL),
(5, 'valami', '998c19b80f7bf723b6e1e01d8dcdd68d022226b3052f89cfe1826608716fa0b5', '03032c66c7c922e95bed7d8fcd929451e6657c268ef3051d1f050f163cba12f3', 'asdasdasd@gmail.com', 'Valaki', 'Valami', 0, 1644355855, '2b93fd53cabbf481ea879522fed4d5676cb62915134856a4e3e2c01a75319fa5', NULL),
(6, 'kiralydavidvagyok', '5ff0a9a83e811fac7bcf26a99c205c3d9458ba6ee75588836be256ca715ba7c1', '380de80c9b8335451795dc0452dc3f853d36667b45feb80e5af2ab8c4178d8cc', 'kiralydavid@gmail.com', 'Dávid', 'Király', 0, 1644403895, 'ca70fcc7602c9906933a3d291fe31056717330ed9d868184637398483d1d6f4e', NULL),
(7, 'domokosvagyok', '9f86e326fdeae7f054b225be3e88154108ea65cfea4f459770faecf3f98e51fb', '6420356bfd17b1c5373fbde9f7a9a35b3a79fb15db98a7cf8046d5312e695b0e', 'domokos@gmail.com', 'Dávid', 'Domokos', 0, 1644405977, '75e71c44b385f45c7fcd860074f1a9dde304b3c14cd6392ae779f14081a8af4e', NULL),
(8, 'asdasd', 'cfa44190110d97ad875e6378f9377712fb4653cf398a23c0371e86618af0a761', 'ed5aa40ed8b8fbcbe69bbebb8e1de3640c20ff28be9959280a45876b304c2c20', 'dsa@dsa.com', 'asd', 'asdasd', 0, 1644420547, NULL, NULL),
(9, 'valakik', '87016ea764ce80079e4200a2139042f028a402a1103b200ca2810ab02ea7b18f', '9416cadebf073942fa5101db184583e31ae256464c056ce892f446267700a951', 'valamivalaki@gmail.com', 'asd', 'asd', 0, 1644421191, NULL, NULL),
(13, 'test', '0325a0e681025dcdeb00f199dd1e69dbc655e1c26cbfdccaa0ce9b41cda1825a', '23a50a876c1f8155c1f66b29ee3086732f813316435519a751ba63553f33d6ce', 'test@example.com', 'János', 'Teszt', 0, 1644526354, NULL, NULL),
(14, 'testuser', '071854c139cbbe1dea825cb7e6bfde36e27e7a03f12420e6009dd6351d8b00e9', 'af492d1ed57ebf62c3188c47a080ed4a5e982103bca0af3293f3f08e77d0f039', 'testelek@gmail.com', 'Test', 'elek', 0, 1644577955, NULL, NULL),
(15, 'fasirt', 'f71f107a2f81cc9f7b3e87c3f9f725e9ec157a3a669a1d15e4deb5ddc99874f1', 'ea83674f970a58024cb7de9ce2d05544eaafb0c533f90628b2809e7480b83ed3', 'fasirt@gmail.com', 'fasirt_first', 'fasirt_last', 0, 1644579120, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mission`
--
ALTER TABLE `mission`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reminder`
--
ALTER TABLE `reminder`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `todo`
--
ALTER TABLE `todo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ibfk_1_todo` (`category_id`),
  ADD KEY `ibfk_2_todo` (`user_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_name` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `mission`
--
ALTER TABLE `mission`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `reminder`
--
ALTER TABLE `reminder`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `session`
--
ALTER TABLE `session`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `todo`
--
ALTER TABLE `todo`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `todo`
--
ALTER TABLE `todo`
  ADD CONSTRAINT `ibfk_1_todo` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ibfk_2_todo` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
