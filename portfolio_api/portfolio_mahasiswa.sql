-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 13, 2026 at 06:54 PM
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
-- Database: `portfolio_mahasiswa`
--

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `category` varchar(50) NOT NULL,
  `year` varchar(4) NOT NULL,
  `tech` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `color` bigint(20) NOT NULL DEFAULT 1818423295,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `title`, `category`, `year`, `tech`, `description`, `color`, `image`, `created_at`) VALUES
(1, 'Aplikasi Djawara Dawet', 'React', '2025', 'Flutter, Dart, PHP, MySQL', 'Aplikasi pemesanan dawet digital untuk pelanggan dan manajemen toko.', 4278223759, 'assets/appdjawara.jpg', '2026-10-08 15:22:31'),
(3, 'Web Supplier Toko El-Fath', 'Laravel', '2024', 'Laravel, PHP, MySQL, Bootstrap', 'Sistem informasi pengelolaan pasokan dan supplier.', 4279592384, 'assets/websiteel-fath.jpg', '2026-10-08 15:22:31'),
(6, 'Web informasi Seventeen', 'PHP', '2025', 'html,CSS', 'website tentang grup kpop seventeen beserta perjalan karirnya', 4282722208, 'uploads/project_1791870234_6acdc51a875c7.jpg', '2026-10-13 05:43:54'),
(7, 'Desain Figma Aplikasi Djawara Dawet', 'Figma', '2026', 'Figma, Flutter, PHP', 'Desain rancangan aplikasi Djawara Dawet', 4285143962, 'uploads/project_1791890771_6ace1553ebf36.png', '2026-10-13 11:26:12'),
(9, 'Kariera (Aplikasi Pencarian Kerja)', 'Figma', '2026', 'Flutter,  Dart, Figma', 'Kariera adalah aplikasi mobile pencarian lowongan kerja modern yang memudahkan pengguna menemukan pekerjaan impian, memfilter tipe pekerjaan (Full-time, Remote), serta mengelola profil kandidat digital', 4285143962, 'uploads/project_1791904290_6ace4a226ddb6.jpg', '2026-10-13 15:11:30');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
