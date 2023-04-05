-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 21, 2023 at 09:12 PM
-- Server version: 10.11.2-MariaDB
-- PHP Version: 8.2.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `click_zone`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`) VALUES
(16, 'ON NO', 'loclepnvx@gmail.com', '$2y$10$bGHW757d.rs.btM3ueqIu.txoKGpoUMciAxolMmCVOoNX7FJnE5Iy');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

INSERT INTO products(name, image_url, price, old_price, description)
              VALUES ("Bàn phím cơ RK918 White - Kèm kê tay", "https://zpro.vn/images/product/500x500/ban-phim-co-rk918-white-kem-ke-tay.1666326022.jpg", 1090000, 1500000, "<h3>- Phiên bản 2022 mới nhất: Stab xịn hơn, êm và chắc chắn; font chữ đẹp hơn; có sách HD đa ngôn ngữ, tùy đợt hàng có tặng kèm keypuller thép.</h3><h3>- Sử dụng switch RK được cải tiến, cảm giác bấm mềm hơn, độ bền 50 triệu lần bấm.</h3><h3>- Led RGB 16,8 triệu màu nhiều hiệu ứng.</h3><h3>- Phần mềm tùy chỉnh giao diện tiếng Anh dễ sử dụng (chỉ hỗ trợ HĐH Window).</h3><h3>- Tích hợp led gầm RGB siêu sang, siêu sáng.</h3><h3>- Keycap ABS double shot ko mờ chữ.</h3><h3>- Plate hợp kim cắt CNC cao cấp.</h3><h3>- Bảo hành 2 năm (1 đổi 1 trong 10 ngày đầu nếu lỗi).</h3>")
