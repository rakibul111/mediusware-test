-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 26, 2021 at 06:57 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `medius`
--

-- --------------------------------------------------------

--
-- Table structure for table `blogs`
--

CREATE TABLE `blogs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `blog_post` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `blog_category_id` bigint(20) UNSIGNED NOT NULL,
  `tags` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_categories`
--

CREATE TABLE `blog_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_tags`
--

CREATE TABLE `blog_tags` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `blog_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(6, '2020_08_28_072131_create_blog_categories_table', 3),
(7, '2020_08_28_072234_create_blogs_table', 3),
(8, '2020_08_28_103502_create_variants_table', 3),
(10, '2020_08_28_104103_create_blog_tags_table', 3),
(14, '2020_08_28_063029_create_products_table', 4),
(15, '2020_08_28_103644_create_product_images_table', 4),
(16, '2020_08_31_065549_create_product_variants_table', 4),
(19, '2020_08_31_073704_create_product_variant_prices_table', 5),
(20, '2020_08_31_081510_create_product_variant_price_relation_table', 5);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sku` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `title`, `sku`, `description`, `created_at`, `updated_at`) VALUES
(28, 'prod1', 'sku1', 'llkjk desc', '2021-10-24 02:02:10', '2021-10-24 02:02:10'),
(29, 'prod2222', 'sku2', 'kljlkj', '2021-10-23 03:16:42', '2021-10-26 10:53:17'),
(32, 'hkj', 'kjh465', 'kjhk', '2021-10-24 03:29:25', '2021-10-24 03:29:25'),
(33, 'prod3', 'sku3', 'lkj', '2021-10-24 03:34:53', '2021-10-24 03:34:53'),
(34, 'jkj', 'ljl', NULL, '2021-10-24 03:53:25', '2021-10-24 03:53:25'),
(36, 'khk', 'jhkjh687', NULL, '2021-10-24 03:59:11', '2021-10-26 10:06:31'),
(40, 'prod110', 'sku110', 'lkjlkj', '2021-10-26 10:07:31', '2021-10-26 10:07:31'),
(41, 'prod 112', 'sku112', 'klj', '2021-10-26 10:50:05', '2021-10-26 10:50:05');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `thumbnail` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `file_path`, `thumbnail`, `created_at`, `updated_at`) VALUES
(8, 28, '1635062530-61751302f0a90.jpg', NULL, '2021-10-24 02:02:10', '2021-10-24 02:02:10'),
(9, 28, '1635062531-6175130327db4.jpg', NULL, '2021-10-24 02:02:11', '2021-10-24 02:02:11'),
(10, 29, '1635067002-6175247a8a59c.jpg', NULL, '2021-10-24 03:16:42', '2021-10-24 03:16:42'),
(11, 29, '1635067002-6175247a9b6ad.jpg', NULL, '2021-10-24 03:16:42', '2021-10-24 03:16:42'),
(12, 33, '1635068093-617528bd6e411.jpg', NULL, '2021-10-24 03:34:53', '2021-10-24 03:34:53'),
(13, 33, '1635068093-617528bd7d03b.jpg', NULL, '2021-10-24 03:34:53', '2021-10-24 03:34:53'),
(28, 40, '1635264451-617827c3841eb.jpg', NULL, '2021-10-26 10:07:31', '2021-10-26 10:07:31'),
(29, 41, '1635267006-617831beb676b.jpg', NULL, '2021-10-26 10:50:06', '2021-10-26 10:50:06');

-- --------------------------------------------------------

--
-- Table structure for table `product_variants`
--

CREATE TABLE `product_variants` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `variant` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `variant_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_variants`
--

INSERT INTO `product_variants` (`id`, `variant`, `variant_id`, `product_id`, `created_at`, `updated_at`) VALUES
(127, 'black', 1, 28, '2021-10-24 02:02:11', '2021-10-24 02:02:11'),
(128, 'l', 2, 28, '2021-10-24 02:02:11', '2021-10-24 02:02:11'),
(130, 'pink', 1, 29, '2021-10-24 03:16:43', '2021-10-24 03:16:43'),
(131, 'm', 2, 29, '2021-10-24 03:16:43', '2021-10-24 03:16:43'),
(132, 'jkh', 1, 32, '2021-10-24 03:29:26', '2021-10-24 03:29:26'),
(133, 'k', 1, 32, '2021-10-24 03:29:26', '2021-10-24 03:29:26'),
(134, 'd', 2, 32, '2021-10-24 03:29:27', '2021-10-24 03:29:27'),
(135, 'black', 1, 33, '2021-10-24 03:34:53', '2021-10-24 03:34:53'),
(136, 'white', 1, 33, '2021-10-24 03:34:53', '2021-10-24 03:34:53'),
(137, 'slim', 6, 33, '2021-10-24 03:34:53', '2021-10-24 03:34:53'),
(138, 'r', 1, 34, '2021-10-24 03:53:25', '2021-10-24 03:53:25'),
(139, 'r', 1, 36, '2021-10-24 03:59:11', '2021-10-24 03:59:11'),
(140, 'u', 1, 36, '2021-10-24 03:59:11', '2021-10-24 03:59:11'),
(155, 'm', 2, 36, '2021-10-26 10:06:03', '2021-10-26 10:06:03'),
(156, 'blue', 1, 40, '2021-10-26 10:07:31', '2021-10-26 10:07:31'),
(157, 'm', 2, 40, '2021-10-26 10:07:31', '2021-10-26 10:07:31'),
(158, 'l', 2, 40, '2021-10-26 10:07:31', '2021-10-26 10:07:31'),
(159, 'black', 1, 41, '2021-10-26 10:50:06', '2021-10-26 10:50:06'),
(160, 'm', 2, 41, '2021-10-26 10:50:06', '2021-10-26 10:50:06');

-- --------------------------------------------------------

--
-- Table structure for table `product_variant_prices`
--

CREATE TABLE `product_variant_prices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_variant_1` bigint(20) UNSIGNED DEFAULT NULL,
  `product_variant_2` bigint(20) UNSIGNED DEFAULT NULL,
  `product_variant_3` bigint(20) UNSIGNED DEFAULT NULL,
  `price` double NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_variant_prices`
--

INSERT INTO `product_variant_prices` (`id`, `product_variant_1`, `product_variant_2`, `product_variant_3`, `price`, `stock`, `product_id`, `created_at`, `updated_at`) VALUES
(10, 127, 128, NULL, 50000, 50, 28, '2021-10-24 02:02:11', '2021-10-24 02:02:11'),
(11, 130, 160, NULL, 501, 50, 29, '2021-10-24 03:16:43', '2021-10-26 10:53:18'),
(12, 132, 134, NULL, 200, 0, 32, '2021-10-24 03:29:27', '2021-10-24 03:29:27'),
(13, 133, 134, NULL, 150, 0, 32, '2021-10-24 03:29:27', '2021-10-24 03:29:27'),
(14, 135, 137, NULL, 5000, 0, 33, '2021-10-24 03:34:54', '2021-10-24 03:34:54'),
(15, 136, 137, NULL, 5000, 0, 33, '2021-10-24 03:34:54', '2021-10-24 03:34:54'),
(16, 138, NULL, NULL, 0, 0, 34, '2021-10-24 03:53:25', '2021-10-24 03:53:25'),
(17, 139, 155, NULL, 500, 0, 36, '2021-10-24 03:59:12', '2021-10-26 10:06:31'),
(18, 140, 155, NULL, 56, 0, 36, '2021-10-24 03:59:12', '2021-10-26 10:06:31'),
(23, 156, 157, NULL, 400, 0, 40, '2021-10-26 10:07:32', '2021-10-26 10:07:32'),
(24, 156, 158, NULL, 200, 0, 40, '2021-10-26 10:07:32', '2021-10-26 10:07:32'),
(25, 159, 160, NULL, 500, 100, 41, '2021-10-26 10:50:07', '2021-10-26 10:50:07');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin@gmail.com', NULL, '$2y$10$UJ715JKZNPqiChkHZUHxce5gzNcm47dYPaRE.T68hHwe/KWnSqvCu', NULL, '2020-08-28 00:03:42', '2020-08-28 00:03:42');

-- --------------------------------------------------------

--
-- Table structure for table `variants`
--

CREATE TABLE `variants` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `variants`
--

INSERT INTO `variants` (`id`, `title`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Color', 'asdfadsf', NULL, '2020-08-31 08:53:32'),
(2, 'Size', 'adfsasdf', NULL, '2020-08-31 08:54:28'),
(6, 'Style', 'Description', '2020-08-31 09:46:24', '2020-08-31 09:46:24');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blogs`
--
ALTER TABLE `blogs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blogs_blog_category_id_foreign` (`blog_category_id`);

--
-- Indexes for table `blog_categories`
--
ALTER TABLE `blog_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `blog_categories_slug_unique` (`slug`);

--
-- Indexes for table `blog_tags`
--
ALTER TABLE `blog_tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_tags_blog_id_foreign` (`blog_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_sku_unique` (`sku`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_images_product_id_foreign` (`product_id`);

--
-- Indexes for table `product_variants`
--
ALTER TABLE `product_variants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_variants_variant_id_foreign` (`variant_id`),
  ADD KEY `product_variants_product_id_foreign` (`product_id`);

--
-- Indexes for table `product_variant_prices`
--
ALTER TABLE `product_variant_prices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_variant_prices_product_id_foreign` (`product_id`),
  ADD KEY `product_variant_prices_product_variant_1_foreign` (`product_variant_1`),
  ADD KEY `product_variant_prices_product_variant_2_foreign` (`product_variant_2`),
  ADD KEY `product_variant_prices_product_variant_3_foreign` (`product_variant_3`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `variants`
--
ALTER TABLE `variants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `variants_title_unique` (`title`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `blogs`
--
ALTER TABLE `blogs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blog_categories`
--
ALTER TABLE `blog_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blog_tags`
--
ALTER TABLE `blog_tags`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `product_variants`
--
ALTER TABLE `product_variants`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=161;

--
-- AUTO_INCREMENT for table `product_variant_prices`
--
ALTER TABLE `product_variant_prices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `variants`
--
ALTER TABLE `variants`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `blogs`
--
ALTER TABLE `blogs`
  ADD CONSTRAINT `blogs_blog_category_id_foreign` FOREIGN KEY (`blog_category_id`) REFERENCES `blog_categories` (`id`);

--
-- Constraints for table `blog_tags`
--
ALTER TABLE `blog_tags`
  ADD CONSTRAINT `blog_tags_blog_id_foreign` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`);

--
-- Constraints for table `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `product_images_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `product_variants`
--
ALTER TABLE `product_variants`
  ADD CONSTRAINT `product_variants_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_variants_variant_id_foreign` FOREIGN KEY (`variant_id`) REFERENCES `variants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_variant_prices`
--
ALTER TABLE `product_variant_prices`
  ADD CONSTRAINT `product_variant_prices_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_variant_prices_product_variant_1_foreign` FOREIGN KEY (`product_variant_1`) REFERENCES `product_variants` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_variant_prices_product_variant_2_foreign` FOREIGN KEY (`product_variant_2`) REFERENCES `product_variants` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_variant_prices_product_variant_3_foreign` FOREIGN KEY (`product_variant_3`) REFERENCES `product_variants` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
