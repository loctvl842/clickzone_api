-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 27, 2023 at 08:20 PM
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
(39, 5, 88, 3, '2023-04-18 15:27:55', '2023-04-18 15:29:05'),
(72, 3, 94, 2, '2023-04-21 14:10:48', '2023-04-21 14:10:48'),
(73, 3, 97, 1, '2023-04-21 14:10:54', '2023-04-21 14:10:54');

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
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`) VALUES
(1, 'Mechanical Keyboard'),
(2, 'Gaming Mouse'),
(3, 'Switch'),
(4, 'Mouse Pad'),
(5, 'Keycap'),
(6, 'Gadgets'),
(7, 'Repair, Mod tools'),
(9, 'AKKO Keyboard'),
(10, 'Dareu Keyboard'),
(11, 'Anne Pro 2 Keyboard'),
(12, 'iKBC Keyboard'),
(13, 'Keydous Keyboard'),
(14, 'Ajazz Keyboard'),
(15, 'Keywalker Keyboard'),
(16, 'Royal Kludge Keyboard'),
(17, 'Fuhlen Keyboard'),
(18, 'AKKO Mouse'),
(19, 'Fuhlen Mouse'),
(20, 'Dareu Mouse'),
(21, 'Ajazz Mouse'),
(22, 'Wireless Mouse'),
(23, 'Logitech Mouse'),
(24, 'Edra Mouse'),
(25, 'Doraemon Mouse pad'),
(26, 'Once Piece Mouse pad'),
(27, 'Dota 2 Mouse pad'),
(28, 'LOL Mouse pad'),
(29, 'Dragon Ball'),
(30, 'Naruto Mouse pad'),
(31, 'Led RGB Mouse pad'),
(32, 'Earphone'),
(33, 'Figure'),
(34, 'Laptop screen'),
(35, 'Gaming chair'),
(36, 'Other Gaming Mouse'),
(37, 'KIT Custom Keyboard'),
(38, 'Other Gadgets'),
(39, 'Keycool Keyboard');

-- --------------------------------------------------------

--
-- Table structure for table `category_relationship`
--

CREATE TABLE `category_relationship` (
  `parent_id` int(11) NOT NULL,
  `child_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `category_relationship`
--

INSERT INTO `category_relationship` (`parent_id`, `child_id`) VALUES
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14),
(1, 15),
(1, 16),
(1, 17),
(1, 37),
(1, 39),
(2, 18),
(2, 19),
(2, 20),
(2, 21),
(2, 22),
(2, 23),
(2, 24),
(2, 36),
(4, 25),
(4, 26),
(4, 27),
(4, 28),
(4, 29),
(4, 30),
(4, 31),
(6, 32),
(6, 33),
(6, 34),
(6, 35),
(6, 38);

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total` decimal(10,0) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `modified_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id`, `user_id`, `total`, `created_at`, `modified_at`) VALUES
(27, 29, 1100000, '2023-04-21 12:29:41', '2023-04-21 12:29:41'),
(28, 29, 2380000, '2023-04-21 12:30:35', '2023-04-21 12:30:35'),
(29, 29, 1660000, '2023-04-21 12:32:24', '2023-04-21 12:32:24'),
(30, 29, 985000, '2023-04-21 12:33:39', '2023-04-21 12:33:39'),
(31, 29, 4155000, '2023-04-21 12:35:04', '2023-04-21 12:35:04'),
(32, 29, 0, '2023-04-21 13:34:36', '2023-04-21 13:34:36'),
(33, 29, 0, '2023-04-21 13:39:34', '2023-04-21 13:39:34'),
(34, 29, 2380000, '2023-04-21 14:07:08', '2023-04-21 14:07:08'),
(35, 29, 390000, '2023-04-21 14:07:29', '2023-04-21 14:07:29'),
(36, 34, 1770000, '2023-04-22 09:52:04', '2023-04-22 09:52:04');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `created_at`, `modified_at`) VALUES
(70, 28, 96, 1, '2023-04-21 12:30:35', '2023-04-21 12:30:35'),
(71, 28, 97, 2, '2023-04-21 12:30:35', '2023-04-21 12:30:35'),
(73, 30, 85, 2, '2023-04-21 12:33:39', '2023-04-21 12:33:39'),
(74, 30, 86, 1, '2023-04-21 12:33:39', '2023-04-21 12:33:39'),
(76, 31, 88, 4, '2023-04-21 12:35:04', '2023-04-21 12:35:04'),
(77, 31, 89, 1, '2023-04-21 12:35:04', '2023-04-21 12:35:04'),
(78, 31, 90, 3, '2023-04-21 12:35:04', '2023-04-21 12:35:04'),
(79, 34, 96, 1, '2023-04-21 14:07:08', '2023-04-21 14:07:08'),
(80, 34, 97, 2, '2023-04-21 14:07:08', '2023-04-21 14:07:08'),
(82, 35, 95, 1, '2023-04-21 14:07:29', '2023-04-21 14:07:29'),
(83, 36, 95, 2, '2023-04-22 09:52:04', '2023-04-22 09:52:04'),
(84, 36, 96, 1, '2023-04-22 09:52:04', '2023-04-22 09:52:04');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `category_id` int(11) NOT NULL DEFAULT 0,
  `price` decimal(11,0) NOT NULL DEFAULT 0,
  `old_price` decimal(11,0) DEFAULT 0,
  `description` varchar(1000) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `image_url`, `category_id`, `price`, `old_price`, `description`, `created_at`, `modified_at`) VALUES
(85, 'Chuột Gaming Durgod V90 Pro - 10.000 DPI', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/2037c32f-d59c-4abd-9e68-2cfdd904aee9.jpeg', 36, 245000, 490000, '<h3>- Mắt đọc cảm biến PMW3325 đem lại độ chính xác gần như tuyệt đối, thường được dùng ở các dòng chuột trung cấp.</h3><h3>- Hệ thống led RGB 16,8 triệu màu.</h3><h3>- Phần mềm hỗ trợ tùy chỉnh giao diện tiếng Anh dễ sử dụng.</h3><h3>- Thiết kế Ergonomic (công thái học) giúp bạn sử dụng lâu mà vẫn thoải mái.</h3><h3>- Switch Huano cho cảm giác bấm tốt, độ bền 20 triệu lần.</h3><h3>- Dây cáp bọc vải dù chắc chắn.</h3><h3>- DPI max 10.000.</h3><h3>- Bảo hành chính hãng Ninza 2 năm (1 đổi 1 trong 10 ngày đầu nếu lỗi kỹ thuật).</h3>', '2023-04-15 00:37:25', '2023-04-15 00:37:25'),
(86, 'Bàn phím cơ Dareu EK87 V2 (Multi-Led)', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/50c63f68-ddf4-4107-a03e-587dc1c02f96.jpeg', 10, 495000, 595000, '<h3>- Bản nâng cấp của EK87 cũ với màu sắc đẹp hơn, nhiều hiệu ứng hơn, keycap được làm lại, giá ko đổi.</h3><h3>- Led Rainbow Area 6 hiệu ứng, hỗ trợ thêm 5 profile gaming tự setup.</h3><h3>- Switch D công nghệ độc quyền của hãng với độ bền 60 triệu lần.</h3><h3>- Dây cáp cao su, dài 1,5m.</h3><h3>- Sử dụng stab kiểu Cherry giúp bạn dễ thay keycap.</h3><h3>- Bảo hành chính hãng 2 năm + 1 năm tại shop (1 đổi 1 trong 10 ngày đầu nếu lỗi kỹ thuật).</h3>', '2023-04-15 00:38:12', '2023-04-15 00:38:12'),
(87, 'Bàn phím cơ RK918 White - Kèm kê tay', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/92fe9ef4-06aa-46d3-a5ed-c6443286ea19.jpeg', 16, 1090000, 0, '<h3>- Phiên bản 2022 mới nhất: Stab xịn hơn, êm và chắc chắn; font chữ đẹp hơn; có sách HD đa ngôn ngữ, tùy đợt hàng có tặng kèm keypuller thép.</h3><h3>- Sử dụng switch RK được cải tiến, cảm giác bấm mềm hơn, độ bền 50 triệu lần bấm.</h3><h3>- Led RGB 16,8 triệu màu nhiều hiệu ứng.</h3><h3>- Phần mềm tùy chỉnh giao diện tiếng Anh dễ sử dụng (chỉ hỗ trợ HĐH Window).</h3><h3>- Tích hợp led gầm RGB siêu sang, siêu sáng.</h3><h3>- Keycap ABS double shot ko mờ chữ.</h3><h3>- Plate hợp kim cắt CNC cao cấp.</h3><h3>- Bảo hành 2 năm (1 đổi 1 trong 10 ngày đầu nếu lỗi).</h3>', '2023-04-15 00:39:22', '2023-04-15 00:39:22'),
(88, 'Bàn phím cơ Dareu EK807G - Wireless 2.4ghz', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/89135cbd-a31b-4ac7-a426-5d848a92ea18.jpeg', 10, 545000, 645000, '<h3>- Kết nối không dây wireless 2.4ghz, dùng 2 pin AAA cho thời gian sử dụng ~ 6 tháng.</h3><h3>- Switch D (Dareu) chính hãng độ bền cao.</h3><h3>- Keycap ABS double shot.</h3><h3>- KO có led.</h3><h3>- Layout 87 (TKL) nhỏ gọn.</h3><h3>- Bảo hành chính hãng 2 năm (1 đổi 1 trong 10 ngày đầu với lỗi kỹ thuật).</h3>', '2023-04-15 00:40:14', '2023-04-15 00:40:14'),
(89, 'Bàn phím cơ Keycool GZ68 - Pudding (3 Modes, Hotswap)', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/07f16826-3110-41eb-b512-a9d9045afc06.jpeg', 39, 1390000, 0, '<h3>- Kết nối 3 chế độ: Bluetooth 5.0, wireless 2.4ghz + cáp.</h3><h3>- Keycap PBT pudding độc đáo, OEM profile.</h3><h3>- HUANO switch, mạch hotswap giúp thay đổi switch dễ dàng.</h3><h3>- Led RGB đa hiệu ứng.</h3><h3>- Có phần mềm tùy chỉnh giao diện tiếng Anh.</h3><h3>- Hỗ trợ layout MacOs.</h3><h3>- Tích hợp sẵn foam PCB (tiêu âm).</h3><h3>- Pin 2700 mAh cho thời gian sử dụng khoảng 70 tiếng (KO led).</h3><h3>- Phụ kiện: Cáp, switch puller, keypuller, sách.</h3><h3>- Bảo hành 2 năm (1 đổi 1 trong 10 ngày đầu cho lỗi kỹ thuật).</h3>', '2023-04-15 00:41:15', '2023-04-15 00:41:15'),
(90, 'Bộ Keycap Son Goku - Super Saiyan Blue (PBT, Cherry Profile)', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/8c6e7253-61be-4e5f-aa3f-742bef01797e.jpeg', 5, 195000, 0, '<h3>- Chất liệu: PBT.</h3><h3>- Công nghệ in: Dye-sub 5 mặt.</h3><h3>- Profile: Cherry, dày 1.3mm.</h3><h3>- Số phím: 15.</h3>', '2023-04-15 00:42:02', '2023-04-15 00:42:02'),
(94, 'Dây cáp sạc nhanh cho iPhone (Type-C to Lightning)', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/2e41b164-5f19-49e2-aa84-63197a09d58b.jpeg', 38, 110000, 0, '<h3>- Chất liệu: Dây silicone lỏng chất lượng cao, 2 đầu bọc hợp kim kẽm chắc chắn.</h3><h3>- Độ dài 1m.</h3><h3>- Hỗ trợ sạc nhanh + truyền dữ liệu.</h3><h3>- Bảo hành 1 đổi 1 trong 6 tháng.</h3>', '2023-04-18 15:30:21', '2023-04-18 15:30:21'),
(95, 'Keycap Fuhlen PANDA - 151 Phím (Profile CSA, PBT 2shot)', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/06266709-b6ed-440b-854f-115efa2ac7bc.jpeg', 5, 390000, 0, '<p><br></p>', '2023-04-19 19:48:16', '2023-04-19 19:48:16'),
(96, 'KIT Bàn phím cơ GMK67', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/3bf2bc6b-e0e8-438d-9c5a-251680322ac6.jpeg', 37, 990000, 0, '<h3><strong>*** LƯU Ý</strong>:&nbsp;KO sạc bằng củ sạc điện thoại, máy tính bảng...</h3><p>- Chất liệu case: Nhựa.</p><p>- Chất liệu plate: PC.</p><p>- Kết nối: 3 Modes: Type C, Bluetooth và receiver</p><p>- Thiết kế Gasket mount.</p><p>- Pin 3000 mAh.</p><p>- PCB: Hotswap, mạch xuôi, led RGB.</p><p>- Foam: Foam PCB poron, switch pad poron, foam case bọt biển.</p><p>- Layout: 65% có núm xoay.</p><p>- Stab: Plate mount, có lube sẵn.</p><p>- Bảo hành 6 tháng (1 đổi 1 trong 10 ngày đầu nếu lỗi kỹ thuật).</p>', '2023-04-19 19:50:33', '2023-04-19 19:50:33'),
(97, 'Bộ Keycap AKKO Cream (MDA Profile - 282 Nút)', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/018fc90d-8dfc-45db-9644-49a35bd55c67.jpeg', 5, 695000, 0, '<h3>- Chất liệu: PBT Double shot.</h3><h3>- Profile: MDA.</h3><h3>- Số nút: 282.</h3><h3>- Thương hiệu: AKKO.</h3>', '2023-04-19 19:51:23', '2023-04-19 19:51:23'),
(101, 'Bàn phím cơ AKKO 3087 RF - Ocean Star (2.4Ghz / AKKO sw v3)', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/d690d1d8-fe8a-4faa-95f8-c5786cebdc54.jpeg', 9, 1390000, NULL, '<p>- Model: 3087 (TKL, 87 keys).</p><p>- Kết nối: Không dây (2.4ghz, pin AAA) hoặc USB Type-C to Type-A (dây có thể tháo rời).</p><p>- Kích thước: 360 x 140 x 40mm | Trọng lượng ~ 0.95 kg</p><p>- Tích hợp sẵn foam tiêu âm PCB.</p><p>- Không có LED, không có Hotswap.</p><p>- Hỗ trợ NKRO / Multimedia / Macro / Khóa phím Window.</p><p>- Keycap: PBT Double-Shot, ASA profile.</p><p>- Loại switch: Akko switch v3 (Cream Blue / Cream Yellow).</p><p>- Phụ kiện: 1 sách HDSD + 1 keypuller + 1 cover che bụi + 1 dây cáp USB C to A + 2 pin AAA.</p><p>- Bảo hành chính hãng 12 tháng + 6 tháng tại shop (1 đổi 1 trong 10 ngày đầu nếu lỗi kỹ thuật).</p><p><strong>***&nbsp;Giảm giá 50% cho dịch vụ mod phím (rã hàn, lube sw, mod stab).</strong></p>', '2023-04-25 07:46:20', '2023-04-25 07:46:20'),
(102, 'Chuột Gaming AKKO AG325 One Piece', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/4084fce5-e520-4092-a260-0c03a08b6d75.jpeg', 18, 595000, NULL, '<h3>- Thiết kế đối xứng cho cả 2 tay.</h3><h3>- Mắt đọc Pixart PMW3325 cao cấp.</h3><h3>- Con lăn làm bằng hợp kim CNC.</h3><h3>- DPI: 400/800/1500/2000/3000/5000 (Có thể lên đến 10.000 thông qua driver)</h3><h3>- Switch Omron 50 triệu lần bấm.</h3><h3>- Phần mềm tùy chỉnh dễ sử dụng.</h3><h3>- Kích thước: 125mm x 67mm x 43mm. Trọng lượng ~ 126g.</h3><h3>- Bảo hành 2 năm (1 đổi 1 trong tháng đầu nếu lỗi).</h3>', '2023-04-25 09:27:08', '2023-04-25 09:27:08'),
(103, 'Chuột Gaming AKKO RG325 DragonBall Z - Vegeta', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/93d7ef4a-462a-4d4a-ae16-f212300d0794.jpeg', 9, 590000, NULL, '<h3>- Thiết kế công thái học (Ergonomic) giúp bạn sử dụng thoải mái.</h3><h3>- Mắt đọc Pixart PMW3325 cao cấp.</h3><h3>- Con lăn làm bằng hợp kim CNC.</h3><h3>- DPI: 400/800/1500/2000/3000/5000.</h3><h3>- Switch Omron 50 triệu lần bấm.</h3><h3>- Kích thước: 125mm x 67mm x 43mm. Trọng lượng ~ 126g.</h3><h3>- Bảo hành 2 năm (1 đổi 1 trong 10 này đầu nếu lỗi).</h3>', '2023-04-25 09:38:14', '2023-04-25 09:38:14'),
(104, 'Switch TTC ACE v2', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/f5a500a7-9450-4e5b-900a-3be050d39553.jpeg', 3, 15000, 0, '<h3>- Bản v2: Lá đồng được mạ bạc chống oxi hóa, tăng thẩm mĩ và tối ưu tín hiệu.</h3><h3>- Linear, 60g.</h3><h3>- 5 Pin.</h3><h3>- Độ bền 100 triệu lần bấm.</h3><h3>- Factory light prelubed.</h3><h3>- Lò xo mạ vàng 2 tầng cho lực bấm đều hơn.</h3><p><img src=\"https://clickzone.s3.ap-southeast-2.amazonaws.com/8ea5a210-a2db-4358-95c8-b676f8f55953.png\"><img src=\"https://clickzone.s3.ap-southeast-2.amazonaws.com/d56abd66-0e50-4133-8d7f-d4d8091e2843.png\"><img src=\"https://clickzone.s3.ap-southeast-2.amazonaws.com/b4ad14f3-ba3b-4958-98a0-8ffdbe11ecab.png\"><img src=\"https://clickzone.s3.ap-southeast-2.amazonaws.com/f4f1844d-8740-42f5-8ff6-db5edce80b7b.png\"><img src=\"https://clickzone.s3.ap-southeast-2.amazonaws.com/fce19c11-16f7-421f-9cd7-f5721cb333f8.png\"></p>', '2023-04-25 09:50:01', '2023-04-25 09:50:01'),
(105, 'Switch Gateron Pro Yellow v2', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/318867f7-33ec-4572-9882-efdfb9898bd0.jpeg', 3, 5000, 0, '<h3>- Housing được cải tiến chắc chắn hơn, giảm rung lắc, trong suốt và tỏa led tốt hơn.</h3><h3>- Linear, 50g.</h3><h3>- Pre-travel: 2mm.</h3><h3>- Total travel: 4mm.</h3><h3>- Factory prelubed.</h3><h3><span style=\"color: rgb(0, 0, 0);\">- 1 pack 35sw:&nbsp;</span>160k.</h3><p><img src=\"https://clickzone.s3.ap-southeast-2.amazonaws.com/ce98e31a-c114-482a-a734-f1098a9b98ab.png\"><img src=\"https://clickzone.s3.ap-southeast-2.amazonaws.com/a4d57e50-d51b-47e8-9da8-cd03e7d48327.png\"><img src=\"https://clickzone.s3.ap-southeast-2.amazonaws.com/ca20fe67-4102-453b-862c-9f8ec0a4417b.png\"><img src=\"https://clickzone.s3.ap-southeast-2.amazonaws.com/4216e578-371a-41cf-a2a8-f42bf38eeafb.png\"></p>', '2023-04-25 09:55:22', '2023-04-25 09:55:22'),
(106, 'Nhíp gắp loại tốt, sơn chống tĩnh điện', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/20fb677c-7b83-4438-8fd9-6c8cc33351e7.jpeg', 38, 60000, NULL, '<h3>Chất liệu: Hợp kim cao cấp, được sơn chống tĩnh điện.</h3>', '2023-04-25 09:58:21', '2023-04-25 09:58:21'),
(110, 'USB Dongle Bluetooth 5.1', 'https://clickzone.s3.ap-southeast-2.amazonaws.com/df347468-ce27-450e-a416-f4414ff23d28.jpeg', 38, 80000, NULL, '<h3>- Dùng để cắm vào pc để kết với các thiết bị bluetooth: Bàn phím, tai nghe, chuột, . . .</h3><h3>- Khoảng cách hoạt động ~ 10m.</h3><h3>- Hỗ trợ ngược cho các thiết bị có chuẩn bluetooth 2.0, 3.0, 4.0, 5.0.</h3><h3>- Truyền tải dữ liệu 3Mbps.</h3><h3>- Hỗ trợ các HĐH: Win 7 đến Win 11.</h3><h3>- Bảo hành 1 đổi 1 trong 6 tháng.</h3>', '2023-04-25 10:06:15', '2023-04-25 10:06:15');

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
(3, 29, 915000, '2023-04-15 12:39:26', '2023-04-21 14:10:54'),
(5, 33, 1635000, '2023-04-18 15:26:35', '2023-04-18 15:29:05'),
(6, 34, 0, '2023-04-22 09:45:48', '2023-04-22 09:52:04'),
(7, 35, 0, '2023-04-22 10:27:04', '2023-04-22 10:27:04'),
(8, 36, 0, '2023-04-22 13:00:08', '2023-04-22 13:00:08');

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
(29, 'admin', 'admin@gmail.com', '$2y$10$XcemZzOs/r4rhUyAcYnQruh6YDXQ.FiF/oeOtIVpDXnojq53JD4Wq', '0967123456', '2023-04-15 07:23:55', '2023-04-27 12:46:32', 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2ODI1OTk1OTIsImlzcyI6ImxvY2FsaG9zdCIsIm5iZiI6MTY4MjU5OTU5MiwiZXhwIjoxNjgyNjAzMTkyLCJ1c2VySWQiOjI5fQ.iJpuZPBhc7EdlMr-2I0Huyt3tQuPYBKakR6LZNOwiaM'),
(31, 'van', 'van@gmail.com', '$2y$10$vYYp0w6QoKieRqKN3m2u1uO.qos41dLX7a7fYyM64HspQiFzRXROO', '0341234567', '2023-04-15 11:29:47', '2023-04-15 11:29:47', 0, NULL),
(33, 'dung', 'dung@gmail.com', '$2y$10$hgD4E5hfBXCJnskM77WzIO1ZbXcE9yWb/avd6O.bb5PJKhoGts2x6', '0341234567', '2023-04-18 15:26:35', '2023-04-18 15:26:45', 0, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2ODE4MzE2MDUsImlzcyI6ImxvY2FsaG9zdCIsIm5iZiI6MTY4MTgzMTYwNSwiZXhwIjoxNjgxODM1MjA1LCJ1c2VySWQiOjMzfQ.Q_wuR78qwDDjmXMWh3SXTuuIYjRIDnBXjELULCnUOkw'),
(34, 'ON NO', 'loclepnvx@gmail.com', '$2y$10$9kRp87L3dNIk.DiSNDTbIORM0DWz/cDEghoa06zxlTs6IW8KVmpRW', '0345567449', '2023-04-22 09:45:48', '2023-04-25 11:10:55', 0, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2ODI0MjEwNTUsImlzcyI6ImxvY2FsaG9zdCIsIm5iZiI6MTY4MjQyMTA1NSwiZXhwIjoxNjgyNDI0NjU1LCJ1c2VySWQiOjM0fQ.ZaZ9uI7xpsGKbksZeV8QipO5mMDIu9KjqeK9xgXPVfU'),
(35, 'duc', 'duc@gmail.com', '$2y$10$zj0L.sUqwbv40lI2L3ukHueVePChYQdgEDPIRWLbQQi8XH3py9zLC', '0967123456', '2023-04-22 10:27:04', '2023-04-22 10:27:30', 0, NULL),
(36, 'rpt pro', 'rpt.plpro@gmail.com', '$2y$10$qTKH1r5P.kiGq5uyYO7azeyLf/zocjuIUyoY/NEPaYhEXWqxvNroi', '0341234567', '2023-04-22 13:00:08', '2023-04-22 13:07:12', 0, NULL);

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
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category_relationship`
--
ALTER TABLE `category_relationship`
  ADD PRIMARY KEY (`parent_id`,`child_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_order_details_user` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_order_product` (`product_id`),
  ADD KEY `fk_order_order_details` (`order_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT for table `shopping_session`
--
ALTER TABLE `shopping_session`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

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
-- Constraints for table `category_relationship`
--
ALTER TABLE `category_relationship`
  ADD CONSTRAINT `fk_child_category` FOREIGN KEY (`child_id`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `fk_parent_category` FOREIGN KEY (`parent_id`) REFERENCES `category` (`id`);

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `fk_order_details_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `fk_order_order_details` FOREIGN KEY (`order_id`) REFERENCES `order_details` (`id`),
  ADD CONSTRAINT `fk_order_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

--
-- Constraints for table `shopping_session`
--
ALTER TABLE `shopping_session`
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
