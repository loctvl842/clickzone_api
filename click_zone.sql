-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 12, 2023 at 01:43 PM
-- Server version: 10.11.2-MariaDB
-- PHP Version: 8.2.4

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
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `old_price` int(11) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `image_url`, `price`, `old_price`, `description`) VALUES
(31, 'Chuột Gaming Durgod V90 Pro - 10.000 DPI', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/eab11f9e-3448-4101-854b-5838cd662f9e', 245000, 490000, '<h3>- Mắt đọc cảm biến PMW3325 đem lại độ chính xác gần như tuyệt đối, thường được dùng ở các dòng chuột trung cấp.</h3><h3>- Hệ thống led RGB 16,8 triệu màu.</h3><h3>- Phần mềm hỗ trợ tùy chỉnh giao diện tiếng Anh dễ sử dụng.</h3><h3>- Thiết kế Ergonomic (công thái học) giúp bạn sử dụng lâu mà vẫn thoải mái.</h3><h3>- Switch Huano cho cảm giác bấm tốt, độ bền 20 triệu lần.</h3><h3>- Dây cáp bọc vải dù chắc chắn.</h3><h3>- DPI max 10.000.</h3><h3>- Bảo hành chính hãng Ninza 2 năm (1 đổi 1 trong 10 ngày đầu nếu lỗi kỹ thuật).</h3><h3><br></h3>'),
(35, 'Bàn phím cơ Dareu EK87 V2 (Multi-Led)', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/34dfbd45-cb95-405e-909c-3d46a9980e05', 495000, 595000, '<h3>- Bản nâng cấp của EK87 cũ với màu sắc đẹp hơn, nhiều hiệu ứng hơn, keycap được làm lại, giá ko đổi.</h3><h3>- Led Rainbow Area 6 hiệu ứng, hỗ trợ thêm 5 profile gaming tự setup.</h3><h3>- Switch D công nghệ độc quyền của hãng với độ bền 60 triệu lần.</h3><h3>- Dây cáp cao su, dài 1,5m.</h3><h3>- Sử dụng stab kiểu Cherry giúp bạn dễ thay keycap.</h3><h3>- Bảo hành chính hãng 2 năm + 1 năm tại shop (1 đổi 1 trong 10 ngày đầu nếu lỗi kỹ thuật).</h3>'),
(52, 'Switch TTC ACE v2', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/e734a5c7-d907-48f6-9fa3-78ce2d0e4511', 15000, NULL, '<h3>- Bản v2: Lá đồng được mạ bạc chống oxi hóa, tăng thẩm mĩ và tối ưu tín hiệu.</h3><h3>- Linear, 60g.</h3><h3>- 5 Pin.</h3><h3>- Độ bền 100 triệu lần bấm.</h3><h3>- Factory light prelubed.</h3><h3>- Lò xo mạ vàng 2 tầng cho lực bấm đều hơn.</h3>'),
(55, 'KIT Bàn phím cơ MXRSKEY CK820 (Nhôm CNC, 3 Modes, Mạch Xuôi)', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/c4df53b0-0ba4-47b4-9161-8e4b859179d7', 3200000, NULL, '<h3>*** Tuyệt đối&nbsp;<strong>KHÔNG SẠC</strong>&nbsp;trực tiếp qua củ sạc.</h3><h3>*** Khi cắm switch cần chú ý 2 chân đồng phải thẳng, tránh trường hợp bị bung socket hotswap.</h3><h3>- Chất liệu: Case nhôm CNC, plate PC.</h3><h3>- Kết nối 3 Modes: USB Type-C, Bluetooth 5.0 và Wireless 2.4G.</h3><h3>- Thiết kế Gasket Mount cho âm đều hơn.</h3><h3>- Mạch xuôi, hotswap 5 pin.</h3><h3>- Tích hợp foam đáy và foam PCB.</h3><h3>- Trọng lượng: 0.95kg.</h3><h3>- Tương thích: Windows, MacOs, iOS, Android.</h3><h3>- Bảo hành 1 năm.</h3><h3><br></h3>'),
(57, 'Keycap Ice Crystal 131 Keys (ABS trong suốt)', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/bdc51a24-d970-4d74-a8c8-31ca0cd681dd.jpeg', 390000, NULL, '<h3>- Chất liệu: ABS trong suốt.</h3><h3>- Số lượng: 131 phím.</h3><h3>- Hỗ trợ các layout: 60,64,68, 71,84,96,98,104.</h3><h3>- Profile: CBSA.</h3>'),
(68, 'Switch Gateron Modern Grey', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/84d1e26e-b133-4fc5-bd09-8f5256d98e85.jpeg', 11000, NULL, '<h3>- Produced by Gateron X Swagkey.</h3><h3>- Spring 62g (2 stage).</h3><h3>- POM linear long stem, long spring.</h3><h3>- Polycarbonate &amp; Nylon Mix housing.</h3><h3>- Factory lubed.</h3><h3>- 5-pin PCB mount.</h3><h3><br></h3>'),
(69, 'Bộ Keycap PBT Retro 9009 (158 Keys)', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/153c43c6-0102-49b2-a31c-cf110e6f277a.jpeg', 390000, NULL, '<h3>- Profile: Cherry.</h3><h3>- Chất liệu: PBT.</h3><h3>- Số phím: 158.</h3>');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `is_admin`) VALUES
(24, 'admin', 'loclepnvx@gmail.com', '$2y$10$6SfjfzgbANbbtOl1qMHGYOJ0KGiY9tQRC8LqTb2JfIJzc0ugYUaZe', 1),
(25, 'ON NO', 'loc@gmail.com', '$2y$10$l.bmW3AW/pzmgU1z/WzfwOyga/tzcBWjIpiJ6sdWizriAmH6Ylmk2', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

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
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
