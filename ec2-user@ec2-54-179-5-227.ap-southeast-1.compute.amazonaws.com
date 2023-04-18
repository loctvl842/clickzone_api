-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 18, 2023 at 10:52 PM
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
-- Table structure for table `cart_item`
--

CREATE TABLE `cart_item` (
  `id` int(11) NOT NULL,
  `session_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cart_item`
--

INSERT INTO `cart_item` (`id`, `session_id`, `product_id`, `quantity`, `created_at`, `modified_at`) VALUES
(29, 3, 87, 1, '2023-04-16 13:44:24', '2023-04-16 13:44:24'),
(30, 3, 90, 1, '2023-04-16 17:53:08', '2023-04-16 17:53:08'),
(31, 3, 88, 1, '2023-04-16 17:53:16', '2023-04-18 14:41:41'),
(33, 3, 89, 2, '2023-04-16 19:09:01', '2023-04-18 13:14:40'),
(34, 3, 85, 1, '2023-04-18 14:36:55', '2023-04-18 14:36:55'),
(39, 5, 88, 3, '2023-04-18 15:27:55', '2023-04-18 15:29:05');

--
-- Triggers `cart_item`
--
DELIMITER $$
CREATE TRIGGER `update_total_shopping_session_on_delete` AFTER DELETE ON `cart_item` FOR EACH ROW UPDATE shopping_session AS s
CROSS JOIN (SELECT price, id FROM product WHERE product.id = OLD.product_id) AS p
SET s.total = s.total - OLD.quantity * p.price
WHERE OLD.session_id = s.id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_total_shopping_session_on_insert` AFTER INSERT ON `cart_item` FOR EACH ROW UPDATE shopping_session AS s
CROSS JOIN (SELECT price, id FROM product WHERE product.id = NEW.product_id) AS p
SET s.total = s.total + p.price * NEW.quantity
WHERE NEW.session_id = s.id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_total_shopping_session_on_update` AFTER UPDATE ON `cart_item` FOR EACH ROW UPDATE shopping_session AS s
CROSS JOIN (SELECT price, id FROM product WHERE product.id = NEW.product_id) AS p
SET s.total = s.total + p.price * (NEW.quantity - OLD.quantity)
WHERE NEW.session_id = s.id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `price` decimal(11,0) NOT NULL DEFAULT 0,
  `old_price` decimal(11,0) DEFAULT 0,
  `description` varchar(1000) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `image_url`, `price`, `old_price`, `description`, `created_at`, `modified_at`) VALUES
(85, 'Chuột Gaming Durgod V90 Pro - 10.000 DPI', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/2037c32f-d59c-4abd-9e68-2cfdd904aee9.jpeg', 245000, 490000, '<h3>- Mắt đọc cảm biến PMW3325 đem lại độ chính xác gần như tuyệt đối, thường được dùng ở các dòng chuột trung cấp.</h3><h3>- Hệ thống led RGB 16,8 triệu màu.</h3><h3>- Phần mềm hỗ trợ tùy chỉnh giao diện tiếng Anh dễ sử dụng.</h3><h3>- Thiết kế Ergonomic (công thái học) giúp bạn sử dụng lâu mà vẫn thoải mái.</h3><h3>- Switch Huano cho cảm giác bấm tốt, độ bền 20 triệu lần.</h3><h3>- Dây cáp bọc vải dù chắc chắn.</h3><h3>- DPI max 10.000.</h3><h3>- Bảo hành chính hãng Ninza 2 năm (1 đổi 1 trong 10 ngày đầu nếu lỗi kỹ thuật).</h3>', '2023-04-15 00:37:25', '2023-04-15 00:37:25'),
(86, 'Bàn phím cơ Dareu EK87 V2 (Multi-Led)', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/50c63f68-ddf4-4107-a03e-587dc1c02f96.jpeg', 495000, 595000, '<h3>- Bản nâng cấp của EK87 cũ với màu sắc đẹp hơn, nhiều hiệu ứng hơn, keycap được làm lại, giá ko đổi.</h3><h3>- Led Rainbow Area 6 hiệu ứng, hỗ trợ thêm 5 profile gaming tự setup.</h3><h3>- Switch D công nghệ độc quyền của hãng với độ bền 60 triệu lần.</h3><h3>- Dây cáp cao su, dài 1,5m.</h3><h3>- Sử dụng stab kiểu Cherry giúp bạn dễ thay keycap.</h3><h3>- Bảo hành chính hãng 2 năm + 1 năm tại shop (1 đổi 1 trong 10 ngày đầu nếu lỗi kỹ thuật).</h3>', '2023-04-15 00:38:12', '2023-04-15 00:38:12'),
(87, 'Bàn phím cơ RK918 White - Kèm kê tay', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/92fe9ef4-06aa-46d3-a5ed-c6443286ea19.jpeg', 1090000, NULL, '<h3>- Phiên bản 2022 mới nhất: Stab xịn hơn, êm và chắc chắn; font chữ đẹp hơn; có sách HD đa ngôn ngữ, tùy đợt hàng có tặng kèm keypuller thép.</h3><h3>- Sử dụng switch RK được cải tiến, cảm giác bấm mềm hơn, độ bền 50 triệu lần bấm.</h3><h3>- Led RGB 16,8 triệu màu nhiều hiệu ứng.</h3><h3>- Phần mềm tùy chỉnh giao diện tiếng Anh dễ sử dụng (chỉ hỗ trợ HĐH Window).</h3><h3>- Tích hợp led gầm RGB siêu sang, siêu sáng.</h3><h3>- Keycap ABS double shot ko mờ chữ.</h3><h3>- Plate hợp kim cắt CNC cao cấp.</h3><h3>- Bảo hành 2 năm (1 đổi 1 trong 10 ngày đầu nếu lỗi).</h3>', '2023-04-15 00:39:22', '2023-04-15 00:39:22'),
(88, 'Bàn phím cơ Dareu EK807G - Wireless 2.4ghz', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/89135cbd-a31b-4ac7-a426-5d848a92ea18.jpeg', 545000, 645000, '<h3>- Kết nối không dây wireless 2.4ghz, dùng 2 pin AAA cho thời gian sử dụng ~ 6 tháng.</h3><h3>- Switch D (Dareu) chính hãng độ bền cao.</h3><h3>- Keycap ABS double shot.</h3><h3>- KO có led.</h3><h3>- Layout 87 (TKL) nhỏ gọn.</h3><h3>- Bảo hành chính hãng 2 năm (1 đổi 1 trong 10 ngày đầu với lỗi kỹ thuật).</h3>', '2023-04-15 00:40:14', '2023-04-15 00:40:14'),
(89, 'Bàn phím cơ Keycool GZ68 - Pudding (3 Modes, Hotswap)', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/07f16826-3110-41eb-b512-a9d9045afc06.jpeg', 1390000, NULL, '<h3>- Kết nối 3 chế độ: Bluetooth 5.0, wireless 2.4ghz + cáp.</h3><h3>- Keycap PBT pudding độc đáo, OEM profile.</h3><h3>- HUANO switch, mạch hotswap giúp thay đổi switch dễ dàng.</h3><h3>- Led RGB đa hiệu ứng.</h3><h3>- Có phần mềm tùy chỉnh giao diện tiếng Anh.</h3><h3>- Hỗ trợ layout MacOs.</h3><h3>- Tích hợp sẵn foam PCB (tiêu âm).</h3><h3>- Pin 2700 mAh cho thời gian sử dụng khoảng 70 tiếng (KO led).</h3><h3>- Phụ kiện: Cáp, switch puller, keypuller, sách.</h3><h3>- Bảo hành 2 năm (1 đổi 1 trong 10 ngày đầu cho lỗi kỹ thuật).</h3>', '2023-04-15 00:41:15', '2023-04-15 00:41:15'),
(90, 'Bộ Keycap Son Goku - Super Saiyan Blue (PBT, Cherry Profile)', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/8c6e7253-61be-4e5f-aa3f-742bef01797e.jpeg', 195000, 0, '<h3>- Chất liệu: PBT.</h3><h3>- Công nghệ in: Dye-sub 5 mặt.</h3><h3>- Profile: Cherry, dày 1.3mm.</h3><h3>- Số phím: 15.</h3>', '2023-04-15 00:42:02', '2023-04-15 00:42:02'),
(94, 'Dây cáp sạc nhanh cho iPhone (Type-C to Lightning)', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/2e41b164-5f19-49e2-aa84-63197a09d58b.jpeg', 110000, NULL, '<h3>- Chất liệu: Dây silicone lỏng chất lượng cao, 2 đầu bọc hợp kim kẽm chắc chắn.</h3><h3>- Độ dài 1m.</h3><h3>- Hỗ trợ sạc nhanh + truyền dữ liệu.</h3><h3>- Bảo hành 1 đổi 1 trong 6 tháng.</h3>', '2023-04-18 15:30:21', '2023-04-18 15:30:21');

-- --------------------------------------------------------

--
-- Table structure for table `shopping_session`
--

CREATE TABLE `shopping_session` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total` decimal(11,0) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `modified_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shopping_session`
--

INSERT INTO `shopping_session` (`id`, `user_id`, `total`, `created_at`, `modified_at`) VALUES
(1, 31, 0, '2023-04-15 11:29:47', '2023-04-15 11:29:47'),
(2, 28, 0, '2023-04-15 12:01:44', '2023-04-15 12:01:44'),
(3, 29, 4855000, '2023-04-15 12:39:26', '2023-04-18 14:43:29'),
(5, 33, 1635000, '2023-04-18 15:26:35', '2023-04-18 15:29:05');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `telephone` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `refresh_token` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password`, `telephone`, `created_at`, `modified_at`, `is_admin`, `refresh_token`) VALUES
(28, 'ON NO', 'loclepnvx@gmail.com', 'NULL', '0341234567', '2023-04-15 07:09:05', '2023-04-17 15:03:12', 0, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2ODE3Mzk4ODQsImlzcyI6ImxvY2FsaG9zdCIsIm5iZiI6MTY4MTczOTg4NCwiZXhwIjoxNjgxNzQzNDg0LCJ1c2VySWQiOjI4fQ.Y0nYBoNbMcQDZqWPOKDqvmu8YhGNPjH0qPkjXaAEWk0'),
(29, 'admin', 'admin@gmail.com', '$2y$10$XcemZzOs/r4rhUyAcYnQruh6YDXQ.FiF/oeOtIVpDXnojq53JD4Wq', '0967123456', '2023-04-15 07:23:55', '2023-04-18 15:42:15', 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2ODE4MzI1MzUsImlzcyI6ImxvY2FsaG9zdCIsIm5iZiI6MTY4MTgzMjUzNSwiZXhwIjoxNjgxODM2MTM1LCJ1c2VySWQiOjI5fQ.pt3eMGAN6dZ2-LeOm8xlhJ-mqwqfzg1MtOJWZg7d4P4'),
(31, 'van', 'van@gmail.com', '$2y$10$vYYp0w6QoKieRqKN3m2u1uO.qos41dLX7a7fYyM64HspQiFzRXROO', '0341234567', '2023-04-15 11:29:47', '2023-04-15 11:29:47', 0, NULL),
(33, 'dung', 'dung@gmail.com', '$2y$10$hgD4E5hfBXCJnskM77WzIO1ZbXcE9yWb/avd6O.bb5PJKhoGts2x6', '0341234567', '2023-04-18 15:26:35', '2023-04-18 15:26:45', 0, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2ODE4MzE2MDUsImlzcyI6ImxvY2FsaG9zdCIsIm5iZiI6MTY4MTgzMTYwNSwiZXhwIjoxNjgxODM1MjA1LCJ1c2VySWQiOjMzfQ.Q_wuR78qwDDjmXMWh3SXTuuIYjRIDnBXjELULCnUOkw');

--
-- Triggers `user`
--
DELIMITER $$
CREATE TRIGGER `create_session` AFTER INSERT ON `user` FOR EACH ROW INSERT INTO shopping_session(user_id) VALUES (NEW.id)
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart_item`
--
ALTER TABLE `cart_item`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_product_session` (`session_id`,`product_id`) USING BTREE,
  ADD KEY `fk_product` (`product_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `shopping_session`
--
ALTER TABLE `shopping_session`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `session_index` (`user_id`) USING BTREE;

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart_item`
--
ALTER TABLE `cart_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

--
-- AUTO_INCREMENT for table `shopping_session`
--
ALTER TABLE `shopping_session`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart_item`
--
ALTER TABLE `cart_item`
  ADD CONSTRAINT `fk_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_session` FOREIGN KEY (`session_id`) REFERENCES `shopping_session` (`id`);

--
-- Constraints for table `shopping_session`
--
ALTER TABLE `shopping_session`
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
