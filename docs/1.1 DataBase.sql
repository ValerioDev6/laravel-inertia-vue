-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.7.19 - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para laravelvue
CREATE DATABASE IF NOT EXISTS `laravelvue` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `laravelvue`;

-- Volcando estructura para tabla laravelvue.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categories_created_by_index` (`created_by`),
  KEY `categories_updated_by_index` (`updated_by`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla laravelvue.categories: ~2 rows (aproximadamente)
DELETE FROM `categories`;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`id`, `name`, `description`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
	(1, 'Frutas', 'Descripción de Prueba', 21, 21, '2020-05-22 17:50:25', '2020-05-22 21:15:59'),
	(2, 'Carnes', 'Todo tipo de Carnes', 21, 21, '2020-05-22 22:03:21', '2020-05-22 22:03:21'),
	(3, 'Verduras', 'Todo tipo de Verduras', 21, 21, '2020-05-22 22:03:32', '2020-05-22 22:03:32'),
	(4, 'Embutidos', '', 21, 21, '2020-05-30 20:42:14', '2020-05-30 20:42:14');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

-- Volcando estructura para tabla laravelvue.customers
CREATE TABLE IF NOT EXISTS `customers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `document` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customers_lastname_index` (`lastname`),
  KEY `customers_document_index` (`document`),
  KEY `customers_email_index` (`email`),
  KEY `customers_created_by_index` (`created_by`),
  KEY `customers_updated_by_index` (`updated_by`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla laravelvue.customers: ~7 rows (aproximadamente)
DELETE FROM `customers`;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` (`id`, `name`, `lastname`, `document`, `phone`, `email`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
	(1, 'Diego', 'Ramirez', '02502415', '', 'diego@gmail.com', 21, 21, '2020-05-28 01:00:01', '2020-05-28 01:00:01'),
	(2, 'Daniel', 'Tello', '02603252', '', 'daniel@gmail.com', 21, 21, '2020-05-29 14:28:14', '2020-05-29 14:28:14'),
	(3, 'Andres', 'Ramirez', '05263574', '', '', 21, 21, '2020-05-29 14:29:19', '2020-05-29 14:29:19'),
	(4, 'Alejandro', 'Mendoza', '1245352', '', '', 21, 21, '2020-05-29 14:53:41', '2020-05-29 14:53:41'),
	(5, 'Diana', 'Avellaneda', '36252145', '', '', 21, 21, '2020-05-29 14:58:27', '2020-05-29 14:58:27'),
	(6, 'Francis', 'Bustamante', '36524152', '', '', 21, 21, '2020-05-29 16:41:53', '2020-05-29 16:41:53'),
	(7, 'Alonso', 'Sancho', '74858585', '', 'alonso@gmail.com', 21, 21, '2020-05-31 17:24:24', '2020-05-31 20:21:22'),
	(8, 'Rosa', 'Moya', '03625241', '', 'rosa@gmail.com', 21, 21, '2020-06-01 10:57:40', '2020-06-01 10:57:40');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;

-- Volcando estructura para tabla laravelvue.details_orders
CREATE TABLE IF NOT EXISTS `details_orders` (
  `order_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `quantity` smallint(6) DEFAULT '12',
  `price` double DEFAULT '12',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `details_orders_order_id_foreign` (`order_id`),
  KEY `details_orders_product_id_foreign` (`product_id`),
  CONSTRAINT `details_orders_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `details_orders_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla laravelvue.details_orders: ~45 rows (aproximadamente)
DELETE FROM `details_orders`;
/*!40000 ALTER TABLE `details_orders` DISABLE KEYS */;
INSERT INTO `details_orders` (`order_id`, `product_id`, `quantity`, `price`, `created_at`, `updated_at`) VALUES
	(1, 2, 2, 2, NULL, NULL),
	(1, 1, 1, 4, NULL, NULL),
	(2, 2, 2, 4, NULL, NULL),
	(2, 1, 1, 4, NULL, NULL),
	(3, 2, 1, 2, NULL, NULL),
	(3, 1, 3, 10.5, NULL, NULL),
	(4, 1, 1, 3.5, NULL, NULL),
	(5, 2, 3, 6, NULL, NULL),
	(6, 2, 2, 4, NULL, NULL),
	(7, 3, 1, 5, NULL, NULL),
	(8, 3, 2, 10, NULL, NULL),
	(9, 2, 1, 2, NULL, NULL),
	(10, 3, 2, 10, NULL, NULL),
	(11, 3, 2, 5, NULL, NULL),
	(11, 2, 1, 2, NULL, NULL),
	(12, 6, 1, 3, NULL, NULL),
	(12, 5, 1, 1, NULL, NULL),
	(12, 4, 2, 2, NULL, NULL),
	(12, 3, 3, 5, NULL, NULL),
	(12, 2, 1, 2, NULL, NULL),
	(12, 1, 3, 3.5, NULL, NULL),
	(13, 6, 1, 3, NULL, NULL),
	(13, 5, 1, 1, NULL, NULL),
	(14, 6, 1, 3, NULL, NULL),
	(14, 5, 1, 1, NULL, NULL),
	(14, 4, 1, 2, NULL, NULL),
	(15, 6, 1, 3, NULL, NULL),
	(15, 5, 1, 1, NULL, NULL),
	(16, 6, 2, 3, NULL, NULL),
	(17, 1, 1, 3.5, NULL, NULL),
	(18, 5, 2, 1, NULL, NULL),
	(18, 4, 1, 2, NULL, NULL),
	(19, 4, 1, 2, NULL, NULL),
	(20, 1, 1, 3.5, NULL, NULL),
	(21, 3, 1, 5, NULL, NULL),
	(22, 6, 2, 3, NULL, NULL),
	(22, 5, 1, 1, NULL, NULL),
	(23, 6, 1, 3, NULL, NULL),
	(23, 5, 2, 1, NULL, NULL),
	(24, 4, 1, 2, NULL, NULL),
	(25, 6, 1, 3, NULL, NULL),
	(26, 1, 2, 3.5, NULL, NULL),
	(27, 4, 1, 2, NULL, NULL),
	(27, 3, 1, 5, NULL, NULL),
	(28, 1, 2, 3.5, NULL, NULL),
	(29, 6, 1, 3, NULL, NULL),
	(30, 4, 1, 2, NULL, NULL),
	(31, 4, 2, 2, NULL, NULL),
	(32, 5, 1, 1, NULL, NULL),
	(34, 6, 1, 3, NULL, NULL);
/*!40000 ALTER TABLE `details_orders` ENABLE KEYS */;

-- Volcando estructura para tabla laravelvue.files
CREATE TABLE IF NOT EXISTS `files` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `files_created_by_index` (`created_by`),
  KEY `files_updated_by_index` (`updated_by`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla laravelvue.files: ~19 rows (aproximadamente)
DELETE FROM `files`;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
INSERT INTO `files` (`id`, `path`, `filename`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
	(1, 'http://laravelvue.test/storage/users/uiSlFySZVu_logo.png', 'logo.png', 1, 1, '2020-05-04 17:03:35', '2020-05-04 17:03:35'),
	(2, 'http://laravelvue.test/storage/users/R7lCrnCd6B_logo.png', 'logo.png', 1, 1, '2020-05-04 17:04:02', '2020-05-04 17:04:02'),
	(3, 'http://laravelvue.test/storage/users/Cro5vbebyn_logo.png', 'logo.png', 1, 1, '2020-05-04 18:37:57', '2020-05-04 18:37:57'),
	(4, 'http://laravelvue.test/storage/users/k6xGflzQaB_logo.png', 'logo.png', 1, 1, '2020-05-04 18:38:32', '2020-05-04 18:38:32'),
	(5, 'http://laravelvue.test/storage/users/P8ihl6r0DU_logo.png', 'logo.png', 1, 1, '2020-05-04 18:40:53', '2020-05-04 18:40:53'),
	(6, 'http://laravelvue.test/storage/users/FLAUCpx1fB_logo.png', 'logo.png', 1, 1, '2020-05-04 18:41:51', '2020-05-04 18:41:51'),
	(7, 'http://laravelvue.test/storage/users/Vd2wugMQoO_logo.png', 'logo.png', 1, 1, '2020-05-04 18:52:52', '2020-05-04 18:52:52'),
	(8, 'http://laravelvue.test/storage/users/aI8koIP8n8_image.png', 'image.png', 1, 1, '2020-05-07 19:53:08', '2020-05-07 19:53:08'),
	(9, 'http://laravelvue.test/storage/users/24ECyAiOfz_image.png', 'image.png', 1, 1, '2020-05-14 21:24:17', '2020-05-14 21:24:17'),
	(10, 'http://laravelvue.test/storage/users/fAeFPRZUBT_image.png', 'image.png', 1, 1, '2020-05-15 19:39:40', '2020-05-15 19:39:40'),
	(11, 'http://laravelvue.test/storage/users/jgOwoT21SL_image.png', 'image.png', 1, 1, '2020-05-15 20:27:26', '2020-05-15 20:27:26'),
	(12, 'http://laravelvue.test/storage/users/9fTJddBfRm_image.png', 'image.png', 1, 1, '2020-05-15 20:32:40', '2020-05-15 20:32:40'),
	(13, 'http://laravelvue.test/storage/users/VIyFwcZRZx_image.png', 'image.png', 1, 1, '2020-05-16 11:52:30', '2020-05-16 11:52:30'),
	(14, 'http://laravelvue.test/storage/users/tHhC1DAnYw_image.png', 'image.png', 1, 1, '2020-05-16 11:56:42', '2020-05-16 11:56:42'),
	(15, 'http://laravelvue.test/storage/users/KuI2Q3qEZA_image.png', 'image.png', 1, 1, '2020-05-16 12:05:32', '2020-05-16 12:05:32'),
	(16, 'http://laravelvue.test/storage/users/Z14rchytUJ_image.png', 'image.png', 1, 1, '2020-05-16 12:11:21', '2020-05-16 12:11:21'),
	(17, 'http://laravelvue.test/storage/users/ZOrHmkDEMC_image.png', 'image.png', 1, 1, '2020-05-20 21:14:36', '2020-05-20 21:14:36'),
	(18, 'http://laravelvue.test/storage/users/ifZHSqvea3_image.png', 'image.png', 1, 1, '2020-05-20 21:26:46', '2020-05-20 21:26:46'),
	(19, 'http://laravelvue.test/storage/users/kPrsdPeHq8_image.png', 'image.png', 1, 1, '2020-05-20 21:29:01', '2020-05-20 21:29:01'),
	(20, 'http://laravelvue.test/storage/users/qBT0ZLwidj_image.png', 'image.png', 1, 1, '2020-05-20 21:30:04', '2020-05-20 21:30:04');
/*!40000 ALTER TABLE `files` ENABLE KEYS */;

-- Volcando estructura para tabla laravelvue.messages
CREATE TABLE IF NOT EXISTS `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from` int(10) unsigned NOT NULL,
  `to` int(10) unsigned NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT '0',
  `text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla laravelvue.messages: ~34 rows (aproximadamente)
DELETE FROM `messages`;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` (`id`, `from`, `to`, `read`, `text`, `created_at`, `updated_at`) VALUES
	(1, 21, 24, 1, 'Hola', '2020-06-04 15:29:07', '2020-06-05 16:31:27'),
	(2, 21, 24, 1, 'Como estas?', '2020-06-04 15:29:11', '2020-06-05 16:31:27'),
	(3, 24, 21, 1, 'Bien y tu?', '2020-06-04 15:29:12', '2020-06-08 20:12:17'),
	(4, 21, 24, 1, 'Hola', '2020-06-04 17:29:05', '2020-06-05 16:31:27'),
	(5, 21, 24, 1, 'Como estas?', '2020-06-04 17:37:13', '2020-06-05 16:31:27'),
	(6, 21, 24, 1, 'Todo bien?', '2020-06-04 17:37:18', '2020-06-05 16:31:27'),
	(64, 21, 24, 1, 'Hola', '2020-06-04 23:11:33', '2020-06-05 16:31:27'),
	(65, 21, 24, 1, 'Mensaje de Prueba', '2020-06-04 23:13:11', '2020-06-05 16:31:27'),
	(66, 24, 21, 1, 'Respuesta de Prueba', '2020-06-04 23:13:29', '2020-06-08 20:12:17'),
	(67, 21, 24, 1, 'Hola', '2020-06-05 00:11:11', '2020-06-05 16:31:27'),
	(68, 24, 21, 1, 'Como estas?', '2020-06-05 00:11:16', '2020-06-08 20:12:17'),
	(69, 24, 20, 0, 'Hola?', '2020-06-05 00:15:19', '2020-06-05 00:15:19'),
	(70, 24, 22, 0, 'Hola', '2020-06-05 00:15:42', '2020-06-05 00:15:42'),
	(71, 24, 21, 1, 'Hola', '2020-06-05 00:18:27', '2020-06-08 20:12:17'),
	(72, 24, 21, 1, 'Hola mundo', '2020-06-05 00:34:27', '2020-06-08 20:12:17'),
	(73, 24, 21, 1, 'Hola de prueba', '2020-06-05 00:34:57', '2020-06-08 20:12:17'),
	(74, 24, 21, 1, 'Hola de prueba 2', '2020-06-05 00:35:10', '2020-06-08 20:12:17'),
	(75, 24, 21, 1, 'Hola Juan', '2020-06-05 11:26:17', '2020-06-08 20:12:17'),
	(76, 24, 21, 1, 'Hola Anton', '2020-06-05 11:27:14', '2020-06-08 20:12:17'),
	(77, 24, 21, 1, 'Otro mensaje de Prueba', '2020-06-05 11:55:50', '2020-06-08 20:12:17'),
	(78, 24, 21, 1, 'Hola', '2020-06-05 13:48:05', '2020-06-08 20:12:17'),
	(79, 24, 21, 1, 'EScribiendo', '2020-06-05 13:54:16', '2020-06-08 20:12:17'),
	(80, 24, 21, 1, 'Hola', '2020-06-05 15:26:31', '2020-06-08 20:12:17'),
	(81, 24, 21, 1, 'Prueba', '2020-06-05 15:26:45', '2020-06-08 20:12:17'),
	(82, 24, 21, 1, 'Hola', '2020-06-05 16:08:02', '2020-06-08 20:12:17'),
	(97, 21, 1, 0, 'Hola', '2020-06-05 22:30:24', '2020-06-05 22:30:24'),
	(98, 25, 21, 1, 'Hola', '2020-06-05 22:56:07', '2020-06-08 03:10:27'),
	(99, 25, 21, 1, 'Hola como estas', '2020-06-05 22:56:29', '2020-06-08 03:10:27'),
	(100, 25, 21, 1, 'Prueba', '2020-06-05 22:56:45', '2020-06-08 03:10:27'),
	(101, 25, 21, 1, 'Prueba 3', '2020-06-05 22:56:54', '2020-06-08 03:10:27'),
	(102, 25, 21, 1, 'Prueba 4', '2020-06-05 22:56:58', '2020-06-08 03:10:27'),
	(103, 21, 25, 1, 'Respuesta', '2020-06-05 22:57:13', '2020-06-08 03:10:56'),
	(104, 25, 21, 1, 'Prueba', '2020-06-05 22:57:46', '2020-06-08 03:10:27'),
	(105, 25, 21, 1, 'Bueno podemos agregar otra validaciòn, que pasa si escribimos un mensaje con varios caracteres, como estamos escribiendo ahora', '2020-06-05 23:06:12', '2020-06-08 03:10:27'),
	(106, 25, 21, 1, 'Mensaje de Prueba', '2020-06-06 22:51:03', '2020-06-08 03:10:27'),
	(107, 25, 21, 1, 'Mensaje de Prueba', '2020-06-06 22:51:21', '2020-06-08 03:10:27'),
	(108, 25, 21, 1, 'HOla pieritos', '2020-06-08 03:10:12', '2020-06-08 03:10:27'),
	(109, 21, 25, 1, 'que paso', '2020-06-08 03:10:29', '2020-06-08 03:10:56');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;

-- Volcando estructura para tabla laravelvue.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla laravelvue.migrations: ~12 rows (aproximadamente)
DELETE FROM `migrations`;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_04_25_204732_create_files_table', 1),
	(2, '2014_10_12_000000_create_users_table', 1),
	(3, '2014_10_12_100000_create_password_resets_table', 1),
	(4, '2020_04_25_205358_create_permissions_table', 1),
	(5, '2020_04_25_205514_create_roles_table', 1),
	(6, '2020_04_25_205543_create_users_permissions_table', 1),
	(7, '2020_04_25_205727_create_users_roles_table', 1),
	(8, '2020_04_25_205815_create_roles_permissions_table', 1),
	(9, '2020_04_25_205935_create_messages_table', 1),
	(10, '2020_04_25_210043_create_categories_table', 1),
	(11, '2020_04_25_210147_create_products_table', 1),
	(12, '2020_04_25_210503_create_customers_table', 1),
	(13, '2020_04_25_210710_create_orders_table', 1),
	(14, '2020_04_25_211021_create_details_orders_table', 1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Volcando estructura para tabla laravelvue.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comments` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `total` double(4,2) NOT NULL DEFAULT '10.50',
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `state` enum('A','I') COLLATE utf8mb4_unicode_ci DEFAULT 'A',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_customer_id_foreign` (`customer_id`),
  KEY `orders_user_id_foreign` (`user_id`),
  KEY `orders_created_by_index` (`created_by`),
  KEY `orders_updated_by_index` (`updated_by`),
  CONSTRAINT `orders_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla laravelvue.orders: ~26 rows (aproximadamente)
DELETE FROM `orders`;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` (`id`, `order_number`, `comments`, `customer_id`, `user_id`, `total`, `created_by`, `updated_by`, `state`, `created_at`, `updated_at`) VALUES
	(1, '20205291', '', 3, 21, 7.50, 21, 21, 'A', '2020-05-29 14:29:19', '2020-05-29 14:29:19'),
	(2, '20205292', 'Comentario de prueba', 4, 21, 7.50, 21, 21, 'A', '2020-05-29 14:53:42', '2020-05-29 14:53:42'),
	(3, '20205293', '', 5, 21, 12.50, 21, 21, 'A', '2020-05-29 14:58:27', '2020-05-29 14:58:27'),
	(4, '20205294', '', 6, 21, 3.50, 21, 21, 'A', '2020-05-29 16:41:53', '2020-05-29 16:41:53'),
	(5, '20205295', '', 5, 21, 6.00, 21, 21, 'A', '2020-05-29 16:49:42', '2020-05-29 16:49:42'),
	(6, '20205306', 'Mensaje de Prueba', 1, 21, 4.00, 21, 21, 'A', '2020-05-30 20:28:14', '2020-05-30 20:28:14'),
	(7, '20205307', '', 1, 21, 5.00, 21, 21, 'A', '2020-05-30 20:43:43', '2020-05-30 20:43:43'),
	(8, '20205308', '', 1, 21, 10.00, 21, 21, 'A', '2020-05-30 20:53:44', '2020-05-30 20:53:44'),
	(9, '20205309', '', 1, 21, 2.00, 21, 21, 'I', '2020-05-30 20:54:25', '2020-05-30 21:51:46'),
	(10, '202053010', '', 1, 21, 10.00, 21, 21, 'A', '2020-05-30 20:55:39', '2020-05-30 20:55:39'),
	(11, '202053011', '', 2, 21, 12.00, 21, 21, 'A', '2020-05-30 21:05:00', '2020-05-30 21:05:00'),
	(12, '202053112', 'Delivery Calle #1234', 5, 21, 35.50, 21, 21, 'I', '2020-05-31 00:17:41', '2020-05-31 01:58:39'),
	(13, '20206113', 'Comentario de Prueba', 7, 21, 4.00, 21, 21, 'A', '2020-06-01 00:02:36', '2020-06-01 00:02:36'),
	(14, '20206114', 'Comentario de Prueba', 7, 21, 6.00, 21, 21, 'A', '2020-06-01 00:05:15', '2020-06-01 00:05:15'),
	(15, '20206115', 'Comentario de Prueba', 7, 21, 4.00, 21, 21, 'A', '2020-06-01 00:08:18', '2020-06-01 00:08:18'),
	(16, '20206116', '', 7, 21, 6.00, 21, 21, 'A', '2020-06-01 00:09:27', '2020-06-01 00:09:27'),
	(17, '20206117', '', 7, 21, 3.50, 21, 21, 'A', '2020-06-01 00:17:30', '2020-06-01 00:17:30'),
	(18, '20206118', 'Comentario de Prueba', 7, 21, 4.00, 21, 21, 'A', '2020-06-01 00:21:05', '2020-06-01 00:21:05'),
	(19, '20206119', '', 6, 21, 2.00, 21, 21, 'A', '2020-06-01 00:32:12', '2020-06-01 00:32:12'),
	(20, '20206120', '', 3, 21, 3.50, 21, 21, 'A', '2020-06-01 00:33:35', '2020-06-01 00:33:35'),
	(21, '20206121', '', 7, 21, 5.00, 21, 21, 'A', '2020-06-01 00:34:07', '2020-06-01 00:34:07'),
	(22, '20206122', '', 7, 21, 7.00, 21, 21, 'A', '2020-06-01 00:39:39', '2020-06-01 00:39:39'),
	(23, '20206123', 'Mensaje de Prueba', 8, 21, 5.00, 21, 21, 'A', '2020-06-01 10:57:40', '2020-06-01 10:57:40'),
	(24, '20206124', 'Comentario de Prueba', 6, 28, 2.00, 28, 28, 'A', '2020-06-01 19:25:26', '2020-06-01 19:25:26'),
	(25, '20206125', '', 2, 28, 3.00, 28, 28, 'A', '2020-06-01 19:25:43', '2020-06-01 19:25:43'),
	(26, '20206126', '', 3, 24, 7.00, 24, 24, 'A', '2020-06-01 19:29:42', '2020-06-01 19:29:42'),
	(27, '20206127', '', 7, 24, 7.00, 24, 24, 'A', '2020-06-01 19:30:04', '2020-06-01 19:30:04'),
	(28, '20206128', '', 8, 21, 7.00, 21, 21, 'A', '2020-06-01 22:00:26', '2020-06-01 22:00:26'),
	(29, '20206229', '', 7, 21, 3.00, 21, 21, 'A', '2020-06-02 00:45:19', '2020-06-02 00:45:19'),
	(30, '20206230', '', 5, 21, 2.00, 21, 21, 'A', '2020-06-02 19:51:31', '2020-06-02 19:51:31'),
	(31, '20206331', '', 7, 21, 4.00, 21, 21, 'A', '2020-06-03 13:07:00', '2020-06-03 13:07:00'),
	(32, '20206532', '', 8, 21, 1.00, 21, 21, 'A', '2020-06-05 16:46:24', '2020-06-05 16:46:24'),
	(34, '20206834', 'comentario de prueba', 8, 21, 3.00, 21, 21, 'A', '2020-06-08 03:08:08', '2020-06-08 03:08:08');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;

-- Volcando estructura para tabla laravelvue.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla laravelvue.password_resets: ~0 rows (aproximadamente)
DELETE FROM `password_resets`;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Volcando estructura para tabla laravelvue.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla laravelvue.permissions: ~29 rows (aproximadamente)
DELETE FROM `permissions`;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` (`id`, `slug`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'usuario.index', 'Navegar Usuarios', '2020-05-11 16:57:10', '2020-05-11 16:57:10'),
	(2, 'usuario.crear', 'Crear Usuario', '2020-05-11 16:57:10', '2020-05-16 20:17:10'),
	(3, 'usuario.editar', 'Editar Usuario', '2020-05-11 16:57:10', '2020-05-16 20:17:19'),
	(4, 'usuario.ver', 'Ver Usuario', '2020-05-11 16:57:10', '2020-05-16 20:17:31'),
	(5, 'usuario.activar', 'Activar Usuario', '2020-05-11 16:57:10', '2020-05-16 20:18:20'),
	(6, 'usuario.desactivar', 'Desactivar Usuario', '2020-05-11 16:57:10', '2020-05-16 20:18:08'),
	(7, 'rol.index', 'Navegar Roles', '2020-05-11 16:57:10', '2020-05-11 16:57:10'),
	(8, 'permiso.crear', 'Crear Permiso', '2020-05-14 13:08:05', '2020-05-16 20:17:50'),
	(9, 'usuario.permiso', 'Permiso Usuario', '2020-05-15 12:22:59', '2020-05-15 12:22:59'),
	(10, 'rol.crear', 'Crear Rol', '2020-05-15 12:24:39', '2020-05-15 12:24:39'),
	(11, 'rol.editar', 'Editar Rol', '2020-05-15 12:25:00', '2020-05-15 12:25:00'),
	(12, 'rol.ver', 'Ver Rol', '2020-05-16 20:11:48', '2020-05-16 20:12:05'),
	(13, 'permiso.index', 'Navegar Permiso', '2020-05-16 20:13:19', '2020-05-16 20:13:19'),
	(14, 'permiso.editar', 'Editar Permiso', '2020-05-16 20:13:34', '2020-05-16 20:13:34'),
	(15, 'dashboard.index', 'Navegar Dashboard', '2020-05-16 20:15:04', '2020-05-16 20:15:04'),
	(16, 'pedido.index', 'Navegar Pedidos', '2020-05-16 20:15:31', '2020-05-16 20:19:29'),
	(17, 'cliente.index', 'Navegar Clientes', '2020-05-16 20:15:50', '2020-05-16 20:19:19'),
	(18, 'categoria.index', 'Navegar Categorias', '2020-05-16 20:16:16', '2020-05-16 20:19:07'),
	(19, 'producto.index', 'Navegar Productos', '2020-05-16 20:16:26', '2020-05-16 20:18:59'),
	(20, 'reporte.pedido.index', 'Navegar Reporte Pedido', '2020-05-16 20:20:19', '2020-05-16 20:20:19'),
	(21, 'categoria.crear', 'Crear Categoria', '2020-05-22 17:31:16', '2020-05-22 17:31:16'),
	(22, 'categoria.editar', 'Editar Categoria', '2020-05-22 17:57:29', '2020-05-22 17:57:29'),
	(23, 'producto.crear', 'Crear Producto', '2020-05-23 22:39:54', '2020-05-23 22:39:54'),
	(24, 'producto.editar', 'Editar Producto', '2020-05-23 22:40:02', '2020-05-23 22:40:02'),
	(26, 'pedido.crear', 'Crear Pedido', '2020-05-25 20:32:47', '2020-05-25 20:32:47'),
	(27, 'pedido.ver', 'Ver Pedido', '2020-05-25 20:33:51', '2020-05-25 20:33:51'),
	(28, 'pedido.rechazar', 'Rechazar Pedido', '2020-05-25 20:34:09', '2020-05-25 20:34:09'),
	(30, 'cliente.crear', 'Crear Cliente', '2020-05-31 13:16:52', '2020-05-31 13:16:52'),
	(31, 'cliente.editar', 'Editar Cliente', '2020-05-31 13:17:00', '2020-05-31 13:17:00'),
	(32, 'productos.mas.vendidos', 'Productos mas vendidos', '2020-06-02 01:12:42', '2020-06-02 01:30:19'),
	(33, 'ventas.por.dia', 'Ventas por dia', '2020-06-02 01:13:16', '2020-06-02 01:30:11');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;

-- Volcando estructura para tabla laravelvue.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `stock` smallint(6) NOT NULL DEFAULT '1',
  `price` double(4,2) NOT NULL DEFAULT '10.50',
  `categorie_id` bigint(20) unsigned DEFAULT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_categorie_id_foreign` (`categorie_id`),
  KEY `products_created_by_index` (`created_by`),
  KEY `products_updated_by_index` (`updated_by`),
  CONSTRAINT `products_categorie_id_foreign` FOREIGN KEY (`categorie_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla laravelvue.products: ~6 rows (aproximadamente)
DELETE FROM `products`;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` (`id`, `name`, `description`, `stock`, `price`, `categorie_id`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
	(1, 'Tomate', '', 8, 3.50, 3, 21, 21, '2020-05-23 23:15:05', '2020-05-31 00:16:19'),
	(2, 'Lechuga', 'Descripción de Lechuga', 1, 2.00, 3, 21, 21, '2020-05-23 23:25:14', '2020-05-24 13:04:59'),
	(3, 'HotDog', '', 13, 5.00, 4, 21, 21, '2020-05-30 20:42:35', '2020-05-30 20:42:35'),
	(4, 'Tocino', '', 2, 2.00, 4, 21, 21, '2020-05-31 00:15:26', '2020-05-31 00:15:26'),
	(5, 'Salchicha', '', 4, 1.00, 4, 21, 21, '2020-05-31 00:15:44', '2020-05-31 00:15:44'),
	(6, 'Alberja', '', 18, 3.00, 3, 21, 21, '2020-05-31 00:16:04', '2020-05-31 00:16:04');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;

-- Volcando estructura para tabla laravelvue.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla laravelvue.roles: ~0 rows (aproximadamente)
DELETE FROM `roles`;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `slug`, `name`, `created_at`, `updated_at`) VALUES
	(2, 'rol.administrador', 'Administrador', '2020-05-11 15:45:15', '2020-06-08 03:13:14'),
	(3, 'vendedor', 'Vendedor', '2020-06-01 19:23:31', '2020-06-05 17:56:52');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Volcando estructura para tabla laravelvue.roles_permissions
CREATE TABLE IF NOT EXISTS `roles_permissions` (
  `role_id` bigint(20) unsigned NOT NULL,
  `permission_id` bigint(20) unsigned NOT NULL,
  KEY `roles_permissions_role_id_foreign` (`role_id`),
  KEY `roles_permissions_permission_id_foreign` (`permission_id`),
  CONSTRAINT `roles_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`),
  CONSTRAINT `roles_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla laravelvue.roles_permissions: ~41 rows (aproximadamente)
DELETE FROM `roles_permissions`;
/*!40000 ALTER TABLE `roles_permissions` DISABLE KEYS */;
INSERT INTO `roles_permissions` (`role_id`, `permission_id`) VALUES
	(3, 15),
	(3, 16),
	(3, 17),
	(3, 26),
	(3, 27),
	(3, 28),
	(3, 30),
	(3, 31),
	(3, 32),
	(3, 33),
	(2, 1),
	(2, 2),
	(2, 3),
	(2, 4),
	(2, 5),
	(2, 6),
	(2, 7),
	(2, 8),
	(2, 9),
	(2, 10),
	(2, 11),
	(2, 12),
	(2, 13),
	(2, 14),
	(2, 15),
	(2, 16),
	(2, 17),
	(2, 18),
	(2, 19),
	(2, 20),
	(2, 21),
	(2, 22),
	(2, 23),
	(2, 24),
	(2, 26),
	(2, 27),
	(2, 28),
	(2, 30),
	(2, 31),
	(2, 32),
	(2, 33);
/*!40000 ALTER TABLE `roles_permissions` ENABLE KEYS */;

-- Volcando estructura para procedimiento laravelvue.sp_Archivo_setRegistrarArchivo
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Archivo_setRegistrarArchivo`(
	IN `cpath` VARCHAR(255),
	IN `cfilename` VARCHAR(50)




,
	IN `nidauthuser` INT
)
BEGIN
	INSERT INTO files (path, filename, created_by, updated_by, created_at, updated_at)
				VALUES	(cpath, cfilename, nidauthuser, nidauthuser, NOW(), NOW());

	/*OBTENER EL ULTIMO ID REGISTRADO*/
	SET @nIdFile := (SELECT	((IFNULL(MAX(image.id), 1)))
	FROM		files image);

	/*RETORNAMOS*/
	SELECT	@nIdFile	AS	nIdFile;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Categoria_getListarCategorias
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Categoria_getListarCategorias`(
	IN `nidcategoria` INT,
	IN `cnombre` VARCHAR(50),
	IN `cdescripcion` TEXT


)
BEGIN
	SELECT	categoria.id,
				categoria.name,
				categoria.description
	FROM		categories categoria
	WHERE		CONCAT_WS(' ', categoria.name)	LIKE	CONCAT('%', cnombre, '%')
				AND	CONCAT_WS(' ', categoria.description)	LIKE	CONCAT('%', cdescripcion, '%')
				AND	(categoria.id	=	nidcategoria	OR	nidcategoria	=	0)
	ORDER BY categoria.id DESC;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Categoria_setEditarCategoria
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Categoria_setEditarCategoria`(
	IN `nidcategoria` INT,
	IN `cnombre` VARCHAR(50),
	IN `cdescripcion` TEXT,
	IN `nidauthuser` INT
)
BEGIN
	UPDATE	categories
	SET		name			=	cnombre,
				description	=	cdescripcion,
				updated_by	=	nidauthuser,
				updated_at	=	NOW()
	WHERE		id				=	nidcategoria;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Categoria_setRegistrarCategoria
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Categoria_setRegistrarCategoria`(
	IN `cnombre` VARCHAR(50),
	IN `cdescripcion` TEXT,
	IN `nidauthuser` INT
)
BEGIN
	INSERT	INTO	categories	(name, description, created_by, updated_by, created_at, updated_at)
							VALUES	(cnombre, cdescripcion, nidauthuser, nidauthuser, NOW(), NOW());
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Chat_getListarContactos
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Chat_getListarContactos`(
	IN `nidauthuser` INT


)
BEGIN
	SELECT	usuario.id,
				CONCAT_WS(' ', usuario.firstname, usuario.lastname)	AS	fullname,
				IFNULL(imagen.path, '')	AS	profile_imagen,
				(
					SELECT	COUNT(mensaje.id)
					FROM		messages	mensaje
					WHERE		mensaje.`to`	=	nidauthuser
								AND	mensaje.`from`	=	usuario.id
								AND	mensaje.`read`	=	0
				)	AS	nNumeroMensajeNoLeidos,
				(
					SELECT	mensaje.text
					FROM		messages	mensaje
					WHERE		mensaje.`to`	=	nidauthuser
								AND	mensaje.`from`	=	usuario.id
								AND	mensaje.`read`	=	0
					ORDER	BY	mensaje.id	DESC
					LIMIT	1
				)	AS	cUltimoMensajeNoLeido
	FROM		users	usuario
				LEFT OUTER JOIN	files	imagen	ON	usuario.file_id	=	imagen.id
	WHERE		usuario.id	NOT	IN	(nidauthuser);
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Chat_getListarConversaciones
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Chat_getListarConversaciones`(
	IN `nidcontacto` INT,
	IN `nidauthuser` INT

)
BEGIN
	UPDATE	messages
	SET		`read`			=	1,
				`updated_at`	=	NOW()
	WHERE		`from`			=	nidcontacto
				AND	`to`		=	nidauthuser;

	SELECT	mensaje.`*`,
				CONCAT_WS(' ', usu_from.firstname, usu_from.lastname)	AS	usu_from_fullname,
				IFNULL(usu_from_image.path, '')	AS	usu_from_profile_image,
				CONCAT_WS(' ', usu_to.firstname, usu_to.lastname)	AS	usu_to_fullname,
				IFNULL(usu_to_image.path, '')	AS	usu_to_profile_image

	FROM		messages	mensaje
				INNER	JOIN	users	usu_to					ON	mensaje.`to`		=	usu_to.id
				INNER	JOIN	users	usu_from					ON	mensaje.`from`		=	usu_from.id
				LEFT OUTER JOIN	files	usu_to_image	ON	usu_to.file_id		=	usu_to_image.id
				LEFT OUTER JOIN	files	usu_from_image	ON	usu_from.file_id	=	usu_from_image.id
	WHERE		(mensaje.`from`	=	nidauthuser		AND	mensaje.`to`	=	nidcontacto)
				OR	(mensaje.`from`	=	nidcontacto	AND	mensaje.`to`	=	nidauthuser);
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Chat_setRegistrarMensaje
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Chat_setRegistrarMensaje`(
	IN `from` INT,
	IN `to` INT,
	IN `text` TEXT


)
BEGIN
	INSERT	INTO	messages	(`from`, `to`, `text`, created_at, updated_at)
						VALUES	(`from`, `to`, text, NOW(), NOW());

	/*OBTENER EL ULTIMO ID REGISTRADO*/
	SET @nIdMensaje := (SELECT	((IFNULL(MAX(mensaje.id), 1)))
	FROM		messages mensaje);

	SELECT	mensaje.`*`,
				CONCAT_WS(' ', usu_from.firstname, usu_from.lastname)	AS	usu_from_fullname,
				IFNULL(usu_from_image.path, '')	AS	usu_from_profile_image,
				CONCAT_WS(' ', usu_to.firstname, usu_to.lastname)	AS	usu_to_fullname,
				IFNULL(usu_to_image.path, '')	AS	usu_to_profile_image

	FROM		messages	mensaje
				INNER	JOIN	users	usu_to					ON	mensaje.`to`		=	usu_to.id
				INNER	JOIN	users	usu_from					ON	mensaje.`from`		=	usu_from.id
				LEFT OUTER JOIN	files	usu_to_image	ON	usu_to.file_id		=	usu_to_image.id
				LEFT OUTER JOIN	files	usu_from_image	ON	usu_from.file_id	=	usu_from_image.id
	WHERE		mensaje.id	=	@nIdMensaje;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Cliente_getListarClientes
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Cliente_getListarClientes`(
	IN `nidcliente` INT,
	IN `cnombre` VARCHAR(50),
	IN `cdocumento` VARCHAR(50)

)
BEGIN
	SELECT	cliente.id,
				CONCAT_WS(' ', cliente.name, cliente.lastname)	AS	fullname,
				cliente.name,
				cliente.lastname,
				cliente.document,
				cliente.email,
				cliente.phone
	FROM		customers	cliente
	WHERE		CONCAT_WS(' ', cliente.name, cliente.lastname)	LIKE	CONCAT('%', cnombre, '%')
				AND	cliente.document	LIKE	CONCAT('%', cdocumento, '%')
				AND	(cliente.id	=	nidcliente	OR	nidcliente = 0)
	ORDER	BY	cliente.id DESC;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Cliente_setEditarCliente
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Cliente_setEditarCliente`(
	IN `nidcliente` INT,
	IN `cdocumento` VARCHAR(50),
	IN `cnombre` VARCHAR(50),
	IN `capellido` VARCHAR(50),
	IN `cemail` VARCHAR(50),
	IN `ctelefono` VARCHAR(50),
	IN `nidauthuser` INT

)
BEGIN
	UPDATE	customers
	SET		document		=	cdocumento,
				name			=	cnombre,
				lastname		=	capellido,
				email			=	cemail,
				phone			=	ctelefono,
				updated_by	=	nidauthuser,
				updated_at	=	NOW()
	WHERE		id				=	nidcliente;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Cliente_setRegistrarCliente
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Cliente_setRegistrarCliente`(
	IN `cdocumento` VARCHAR(50),
	IN `cnombre` VARCHAR(50),
	IN `capellido` VARCHAR(50),
	IN `cemail` VARCHAR(50),
	IN `ctelefono` VARCHAR(50),
	IN `nidauthuser` INT

)
BEGIN
	INSERT	INTO	customers	(document, name, lastname, email, phone, created_by, updated_by, created_at, updated_at)
							VALUES	(cdocumento, cnombre, capellido, cemail, ctelefono, nidauthuser, nidauthuser, NOW(), NOW());

	/*OBTENER EL ULTIMO ID REGISTRADO*/
	SET @nIdCliente := (SELECT	((IFNULL(MAX(cliente.id), 1)))
	FROM		customers cliente);

	/*RETORNAMOS*/
	SELECT	@nIdCliente	AS	nIdCliente;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Dashboard_getProductosMasVendidos
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Dashboard_getProductosMasVendidos`()
BEGIN
	SELECT	producto.id,
				producto.name,
				(
					SELECT	SUM(detalle.quantity)
					FROM		details_orders	detalle
					WHERE		detalle.product_id	=	producto.id
				)	AS	cantidad
	FROM		products	producto
	ORDER	BY	cantidad DESC
	LIMIT	5;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Dashboard_getVentasPorDia
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Dashboard_getVentasPorDia`()
BEGIN
	SELECT	SUM(pedido.total)	AS	total,
				DAY(pedido.created_at)	AS	dia
	FROM		orders	pedido
	WHERE		MONTH(pedido.created_at)	=	MONTH(NOW())
	GROUP	BY	dia;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Pedido_getDetallePedido
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Pedido_getDetallePedido`(
	IN `nidpedido` INT
)
BEGIN
	SELECT	producto.id,
				producto.name				AS	cProducto,
				detalle_pedido.quantity	AS	nCantidad,
				detalle_pedido.price		AS	fPrecio,
				(detalle_pedido.quantity * detalle_pedido.price)	AS	fSubTotal
	FROM		orders	pedido
				INNER	JOIN	details_orders	detalle_pedido	ON	pedido.id	=	detalle_pedido.order_id
				INNER	JOIN	products			producto			ON	detalle_pedido.product_id	=	producto.id
	WHERE		pedido.id	=	nidpedido;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Pedido_getListarPedidos
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Pedido_getListarPedidos`(
	IN `cNombre` VARCHAR(50),
	IN `cDocumento` VARCHAR(50),
	IN `cPedido` VARCHAR(50),
	IN `cEstado` CHAR(1)
)
BEGIN
	SELECT	pedido.id,
				pedido.order_number	AS	pedido,
				cliente.document		AS	documento,
				CONCAT_WS(' ', cliente.name, cliente.lastname)	AS	cliente,
				(
					SELECT	SUM(detalle_venta.price)
					FROM		details_orders	detalle_venta
					WHERE		detalle_venta.order_id		=	pedido.id
				)	AS	total,
				CASE	IFNULL(pedido.state, '')	WHEN	'A'	THEN	'ACTIVO'
																			ELSE	'RECHAZADO'
																			END	estado,
				IFNULL(pedido.state, '')	AS	state,
				CONCAT_WS(' ', vendedor.firstname, vendedor.lastname)	AS	vendedor
	FROM		orders	pedido
				INNER	JOIN	customers	cliente	ON	pedido.customer_id	=	cliente.id
				INNER	JOIN	users			vendedor	ON	pedido.user_id			=	vendedor.id
	WHERE		CONCAT_WS(' ', cliente.name, cliente.lastname)	LIKE	CONCAT('%', cNombre, '%')
				AND	cliente.document	LIKE	CONCAT('%', cDocumento, '%')
				AND	pedido.order_number	LIKE	CONCAT('%', cPedido, '%')
				AND	(pedido.state	=	cEstado	OR	cEstado	=	'')
	ORDER	BY	pedido.order_number	DESC;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Pedido_getPedido
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Pedido_getPedido`(
	IN `nidpedido` INT



)
BEGIN
	SELECT	pedido.id,
				pedido.order_number		AS	nNumeroPedido,
				pedido.created_at			AS	dFechaPedido,
				CASE	IFNULL(pedido.state, '')	WHEN	'A'	THEN	'GENERADO'
																			ELSE	'RECHAZADO'
																			END	cEstadoPedido,
				CONCAT_WS(' ', vendedor.firstname, vendedor.lastname)	AS	cVendedor,
				vendedor.email	AS	cVendedorCorreo,
				CONCAT_WS(' ', cliente.name, cliente.lastname)	AS	cCliente,
				cliente.document					AS	cDocumento,
				IFNULL(cliente.phone, '')		AS	cTelefono,
				IFNULL(cliente.email, '')		AS	cCorreo,
				pedido.total						AS	fTotalPedido,
				IFNULL(pedido.comments, '')	AS	cComentario
	FROM		orders	pedido
				INNER	JOIN	customers	cliente	ON	pedido.customer_id	=	cliente.id
				INNER	JOIN	users			vendedor	ON	pedido.user_id			=	vendedor.id
	WHERE		pedido.id	=	nidpedido;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Pedido_setCambiarEstadoPedido
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Pedido_setCambiarEstadoPedido`(
	IN `nidpedido` INT,
	IN `cestado` CHAR(1),
	IN `nidauthuser` INT

)
BEGIN
	UPDATE	orders
	SET		state			=	cestado,
				updated_by	=	nidauthuser,
				updated_at	=	NOW()
	WHERE		id				=	nidpedido;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Pedido_setRegistrarDetallePedido
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Pedido_setRegistrarDetallePedido`(
	IN `nidpedido` INT,
	IN `nidproducto` INT,
	IN `nstock` INT,
	IN `fsubtotal` DOUBLE

)
BEGIN
	INSERT	INTO	details_orders	(order_id, product_id, quantity, price)
								VALUES	(nidpedido, nidproducto, nstock, fsubtotal);
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Pedido_setRegistrarPedido
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Pedido_setRegistrarPedido`(
	IN `nidcliente` INT,
	IN `ccomentario` TEXT,
	IN `ftotalpedido` DOUBLE,
	IN `nidauthuser` INT

)
BEGIN
	/*Generar el número del pedido*/
	SET @nOrderName := (SELECT	CONCAT_WS('', YEAR(NOW()), MONTH(NOW()), DAY(NOW())));

	INSERT	INTO	orders	(comments, customer_id, user_id, total, created_by, updated_by, created_at, updated_at)
						VALUES	(ccomentario, nidcliente, nidauthuser, ftotalpedido, nidauthuser, nidauthuser, NOW(), NOW());

	/*OBTENER EL ULTIMO ID REGISTRADO*/
	SET @nIdPedido := (SELECT	((IFNULL(MAX(pedido.id), 1)))
	FROM		orders pedido);

	/*ACTUALIZAR EL NUMERO DEL PEDIDO*/
	UPDATE	orders
	SET		order_number	=	CONCAT_WS('', @nOrderName, @nIdPedido)
	WHERE		id					=	@nIdPedido;

	/*RETORNAMOS*/
	SELECT	@nIdPedido	AS	nIdPedido;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Permiso_getListarPermisos
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Permiso_getListarPermisos`(
	IN `nidpermiso` INT,
	IN `cnombre` VARCHAR(50),
	IN `cslug` VARCHAR(50)

)
BEGIN
	SELECT	permiso.id,
				permiso.slug,
				permiso.name
	FROM		permissions permiso
	WHERE		CONCAT_WS(' ', permiso.name)	LIKE	CONCAT('%', cnombre, '%')
				AND	CONCAT_WS(' ', permiso.slug)	LIKE	CONCAT('%', cslug, '%')
				AND	(permiso.id	=	nidpermiso	OR	nidpermiso = 0)
	ORDER BY permiso.id DESC;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Permiso_setEditarPermiso
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Permiso_setEditarPermiso`(
	IN `nidpermiso` INT,
	IN `cnombre` VARCHAR(50),
	IN `cslug` VARCHAR(50)
)
BEGIN
	UPDATE	permissions
	SET		name			=	cnombre,
				slug			=	cslug,
				updated_at	=	NOW()
	WHERE		id				=	nidpermiso;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Permiso_setRegistrarPermiso
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Permiso_setRegistrarPermiso`(
	IN `cnombre` VARCHAR(50),
	IN `cslug` VARCHAR(50)
)
BEGIN
	INSERT	INTO	permissions	(name, slug, created_at, updated_at)
							VALUES	(cnombre, cslug, NOW(), NOW());
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Producto_getListarProductos
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Producto_getListarProductos`(
	IN `nidproducto` INT,
	IN `cnombre` VARCHAR(50),
	IN `cdescripcion` TEXT,
	IN `nidcategoria` INT


)
BEGIN
	SELECT	producto.id,
				producto.name,
				producto.description,
				producto.stock,
				producto.price,
				categoria.id	AS	nidcategoria,
				categoria.name	AS	categoria
	FROM		products producto
				INNER JOIN categories categoria	ON	producto.categorie_id = categoria.id
	WHERE		CONCAT_WS(' ', producto.name)	LIKE	CONCAT('%', cnombre, '%')
				AND	CONCAT_WS(' ', producto.description)	LIKE	CONCAT('%', cdescripcion, '%')
				AND	(producto.id	=	nidproducto	OR	nidproducto	=	0)
				AND	(categoria.id	=	nidcategoria	OR	nidcategoria	=	0)
	ORDER BY producto.id DESC;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Producto_setEditarProducto
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Producto_setEditarProducto`(
	IN `nidproducto` INT,
	IN `cnombre` VARCHAR(50),
	IN `cdescripcion` TEXT,
	IN `nstock` INT,
	IN `fprecio` DOUBLE,
	IN `nidcategoria` INT,
	IN `nidauthuser` INT
)
BEGIN
	UPDATE	products
	SET		name				=	cnombre,
				description		=	cdescripcion,
				stock				=	nstock,
				price				=	fprecio,
				categorie_id	=	nidcategoria,
				updated_by		=	nidauthuser,
				updated_at		=	NOW()
	WHERE		id					=	nidproducto;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Producto_setRegistrarProducto
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Producto_setRegistrarProducto`(
	IN `cnombre` VARCHAR(50),
	IN `cdescripcion` TEXT,
	IN `nstock` INT,
	IN `fprecio` DOUBLE,
	IN `nidcategoria` INT,
	IN `nidauthuser` INT
)
BEGIN
	INSERT	INTO	products	(name, description, stock, price, categorie_id, created_by, updated_by, created_at, updated_at)
						VALUES	(cnombre, cdescripcion, nstock, fprecio, nidcategoria, nidauthuser, nidauthuser, NOW(), NOW());
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Reporte_getListarPedidos
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Reporte_getListarPedidos`(
	IN `cNombre` VARCHAR(50),
	IN `cDocumento` VARCHAR(50),
	IN `cPedido` VARCHAR(50),
	IN `cEstado` CHAR(1),
	IN `dFechaInicio` VARCHAR(50),
	IN `dFechaFin` VARCHAR(50)

)
BEGIN
	SELECT	pedido.id,
				pedido.order_number	AS	pedido,
				cliente.document		AS	documento,
				CONCAT_WS(' ', cliente.name, cliente.lastname)	AS	cliente,
				(
					SELECT	SUM(detalle_venta.price)
					FROM		details_orders	detalle_venta
					WHERE		detalle_venta.order_id		=	pedido.id
				)	AS	total,
				CASE	IFNULL(pedido.state, '')	WHEN	'A'	THEN	'ACTIVO'
																			ELSE	'RECHAZADO'
																			END	estado,
				IFNULL(pedido.state, '')	AS	state,
				CONCAT_WS(' ', vendedor.firstname, vendedor.lastname)	AS	vendedor
	FROM		orders	pedido
				INNER	JOIN	customers	cliente	ON	pedido.customer_id	=	cliente.id
				INNER	JOIN	users			vendedor	ON	pedido.user_id			=	vendedor.id
	WHERE		CONCAT_WS(' ', cliente.name, cliente.lastname)	LIKE	CONCAT('%', cNombre, '%')
				AND	cliente.document	LIKE	CONCAT('%', cDocumento, '%')
				AND	pedido.order_number	LIKE	CONCAT('%', cPedido, '%')
				AND	(pedido.state	=	cEstado	OR	cEstado	=	'')
				AND	(DATE(pedido.created_at)	BETWEEN	dFechaInicio	AND	dFechaFin)	OR	(dFechaInicio	=	''	AND	dFechaFin = '')
	ORDER	BY	pedido.order_number	DESC;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Rol_getListarPermisosByRol
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Rol_getListarPermisosByRol`(
	IN `nidrol` INT

)
BEGIN
	SELECT	permiso.id,
				permiso.slug,
				permiso.name,
				CASE	IFNULL(rol_permiso.role_id, '')	WHEN	''	THEN	0
																				ELSE	1
																				END	checked
	FROM		permissions	permiso
				LEFT OUTER JOIN	roles_permissions	rol_permiso	ON	permiso.id	=	rol_permiso.permission_id
																					AND	rol_permiso.role_id	=	nidrol;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Rol_getListarRoles
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Rol_getListarRoles`(
	IN `nidrol` INT,
	IN `cnombre` VARCHAR(50),
	IN `cslug` VARCHAR(50)

)
BEGIN
	SELECT	rol.id,
				rol.slug,
				rol.name
	FROM		roles rol
	WHERE		CONCAT_WS(' ', rol.name)	LIKE	CONCAT('%', cnombre, '%')
				AND	CONCAT_WS(' ', rol.slug)	LIKE	CONCAT('%', cslug, '%')
				AND	(rol.id	=	nidrol	OR	nidrol = 0)
	ORDER BY rol.id DESC;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Rol_setEditarRol
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Rol_setEditarRol`(
	IN `nidrol` INT,
	IN `cnombre` VARCHAR(50),
	IN `cslug` VARCHAR(50)



)
BEGIN
	UPDATE	roles
	SET		name			=	cnombre,
				slug			=	cslug,
				updated_at	=	NOW()
	WHERE		id				=	nidrol;


	DELETE
	FROM		roles_permissions
	WHERE		role_id	=	nidrol;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Rol_setRegistrarRol
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Rol_setRegistrarRol`(
	IN `cnombre` VARCHAR(50),
	IN `cslug` VARCHAR(50)

)
BEGIN
	INSERT	INTO	roles	(name, slug, created_at, updated_at)
					VALUES	(cnombre, cslug, NOW(), NOW());

	/*OBTENER EL ULTIMO ID REGISTRADO*/
	SET @nIdRol := (SELECT	((IFNULL(MAX(rol.id), 1)))
	FROM		roles rol);

	/*RETORNAMOS*/
	SELECT	@nIdRol	AS	nIdRol;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Rol_setRegistrarRolPermiso
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Rol_setRegistrarRolPermiso`(
	IN `nidrol` INT,
	IN `nidpermiso` INT
)
BEGIN
	INSERT INTO roles_permissions	(role_id, permission_id)
								VALUES	(nidrol, nidpermiso);
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Usuario_getListarPermisosByRolAsignado
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Usuario_getListarPermisosByRolAsignado`(
	IN `nidusario` INT

)
BEGIN
	SELECT	p.id,
				p.name,
				p.slug
	FROM		users_roles	ur
				INNER	JOIN	roles_permissions	rp	ON	ur.role_id			=	rp.role_id
				INNER	JOIN	permissions		p		ON	rp.permission_id	=	p.id
	WHERE		ur.user_id	=	nidusario;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Usuario_getListarPermisosByUsuario
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Usuario_getListarPermisosByUsuario`(
	IN `nidusuario` INT


)
BEGIN
	SELECT	permiso.id,
				permiso.slug,
				permiso.name,
				CASE	IFNULL(user_permiso.user_id, '')	WHEN	''	THEN	0
																				ELSE	1
																				END	checked
	FROM		permissions	permiso
				LEFT OUTER JOIN	users_permissions	user_permiso	ON	permiso.id	=	user_permiso.permission_id
																					AND	user_permiso.user_id	=	nidusuario;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Usuario_getListarRolPermisosByUsuario
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Usuario_getListarRolPermisosByUsuario`(
	IN `nidusuario` INT



)
BEGIN
	SELECT	permiso.id,
				permiso.name,
				permiso.slug
	FROM		permissions	permiso
				INNER JOIN	users_permissions	user_permiso	ON	permiso.id	=	user_permiso.permission_id
																					AND	user_permiso.user_id	=	nidusuario

	UNION

	SELECT	p.id,
				p.name,
				p.slug
	FROM		users_roles	ur
				INNER	JOIN	roles_permissions	rp	ON	ur.role_id			=	rp.role_id
				INNER	JOIN	permissions		p		ON	rp.permission_id	=	p.id
	WHERE		ur.user_id	=	nidusuario;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Usuario_getListarUsuarios
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Usuario_getListarUsuarios`(
	IN `nidusuario` INT,
	IN `cnombre` VARCHAR(50),
	IN `cusuario` VARCHAR(50),
	IN `ccorreo` VARCHAR(50),
	IN `cestado` CHAR(1)


)
BEGIN
	SELECT	usuario.id,
				CONCAT_WS(' ', usuario.firstname, usuario.secondname, usuario.lastname)	AS	fullname,
				usuario.firstname,
				usuario.secondname,
				usuario.lastname,
				usuario.username,
				IFNULL(usuario.email, '')	AS	email,
				CASE	IFNULL(usuario.state, '')	WHEN	'A'	THEN	'ACTIVO'
																			ELSE	'INACTIVO'
																			END	state_alias,
				IFNULL(usuario.state, '')	AS	state,
				IFNULL(image.path, '')		AS	profile_image
	FROM		users	usuario
				LEFT OUTER JOIN files image ON usuario.file_id	=	image.id
	WHERE		CONCAT_WS(' ', usuario.firstname, usuario.secondname, usuario.lastname)	LIKE	CONCAT('%', cnombre, '%')
				AND	CONCAT_WS(' ', usuario.username)	LIKE	CONCAT('%', cusuario, '%')
				AND	CONCAT_WS(' ', usuario.email)		LIKE	CONCAT('%', ccorreo, '%')
				AND	(usuario.state	=	cestado	OR	cestado	=	'')
				AND	(usuario.id		=	nidusuario	OR	nidusuario	=	0)
	ORDER	BY	usuario.id	DESC;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Usuario_getRolByUsuario
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Usuario_getRolByUsuario`(
	IN `nidusuario` INT

)
BEGIN
	SELECT	ur.role_id	AS	nIdRol,
				rol.name
	FROM		users_roles	ur
				INNER	JOIN	roles	rol	ON	ur.role_id	=	rol.id
	WHERE		user_id		=	nidusuario;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Usuario_setCambiarEstadoUsuario
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Usuario_setCambiarEstadoUsuario`(
	IN `nidusuario` INT,
	IN `cestado` CHAR(1)
,
	IN `nidauthuser` INT
)
BEGIN
	UPDATE	users
	SET		state			=	cestado,
				updated_by	=	nidauthuser,
				updated_at	=	NOW()
	WHERE		id				=	nidusuario;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Usuario_setEditarRolByUsuario
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Usuario_setEditarRolByUsuario`(
	IN `nidusuario` INT,
	IN `nidrol` INT

)
BEGIN
	SELECT	@nCantidadRoles :=	COUNT(role_id)
	FROM		users_roles
	WHERE		user_id		=	nidusuario;

	IF(@nCantidadRoles > 0)
		THEN
			/* ACTUALIZAR EL ROL POR USUARIO*/
			UPDATE	users_roles
			SET		role_id		=	nidrol
			WHERE		user_id		=	nidusuario;
	ELSE
		INSERT	INTO	users_roles	(user_id, role_id)
								VALUES	(nidusuario, nidrol);
	END IF;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Usuario_setEditarUsuario
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Usuario_setEditarUsuario`(
	IN `nidusuario` INT,
	IN `cprimernombre` VARCHAR(50),
	IN `csegundonombre` VARCHAR(50),
	IN `capellido` VARCHAR(50),
	IN `cusuario` VARCHAR(50),
	IN `ccorreo` VARCHAR(50),
	IN `ccontrasena` VARCHAR(150),
	IN `ofotografia` INT

,
	IN `nidauthuser` INT
)
BEGIN
	IF(csegundonombre = '' AND ccontrasena = '' AND ofotografia = 0)
		THEN
			UPDATE	users
			SET		firstname	=	cprimernombre,
						lastname		=	capellido,
						username		=	cusuario,
						email			=	ccorreo,
						updated_by	=	nidauthuser,
						updated_at	=	NOW()
			WHERE		id				=	nidusuario;
	ELSE
		IF(csegundonombre	= ''	AND	ccontrasena = '')
			THEN
				UPDATE	users
				SET		firstname	=	cprimernombre,
							lastname		=	capellido,
							username		=	cusuario,
							email			=	ccorreo,
							file_id		=	ofotografia,
							updated_by	=	nidauthuser,
							updated_at	=	NOW()
				WHERE		id				=	nidusuario;
		ELSE
			IF(csegundonombre	=	''	AND	ofotografia = 0)
				THEN
					UPDATE	users
					SET		firstname	=	cprimernombre,
								lastname		=	capellido,
								password		=	ccontrasena,
								username		=	cusuario,
								email			=	ccorreo,
								updated_by	=	nidauthuser,
								updated_at	=	NOW()
					WHERE		id				=	nidusuario;
			ELSE
				IF(ccontrasena	=	''	AND	ofotografia = 0)
					THEN
						UPDATE	users
						SET		firstname	=	cprimernombre,
									secondname	=	csegundonombre,
									lastname		=	capellido,
									username		=	cusuario,
									email			=	ccorreo,
									updated_by	=	nidauthuser,
									updated_at	=	NOW()
						WHERE		id				=	nidusuario;
				ELSE
					IF	(csegundonombre = '')
						THEN
							UPDATE	users
							SET		firstname	=	cprimernombre,
										lastname		=	capellido,
										password		=	ccontrasena,
										file_id		=	ofotografia,
										username		=	cusuario,
										email			=	ccorreo,
										updated_by	=	nidauthuser,
										updated_at	=	NOW()
							WHERE		id				=	nidusuario;
					ELSE
						IF(ccontrasena	=	'')
							THEN
								UPDATE	users
								SET		firstname	=	cprimernombre,
											secondname	=	csegundonombre,
											lastname		=	capellido,
											file_id		=	ofotografia,
											username		=	cusuario,
											email			=	ccorreo,
											updated_by	=	nidauthuser,
											updated_at	=	NOW()
								WHERE		id				=	nidusuario;
						ELSE
							IF(ofotografia = 0)
								THEN
									UPDATE	users
									SET		firstname	=	cprimernombre,
												secondname	=	csegundonombre,
												lastname		=	capellido,
												password		=	ccontrasena,
												username		=	cusuario,
												email			=	ccorreo,
												updated_by	=	nidauthuser,
												updated_at	=	NOW()
									WHERE		id				=	nidusuario;
							ELSE
								UPDATE	users
								SET		firstname	=	cprimernombre,
											secondname	=	csegundonombre,
											lastname		=	capellido,
											password		=	ccontrasena,
											username		=	cusuario,
											email			=	ccorreo,
											file_id		=	ofotografia,
											updated_by	=	nidauthuser,
											updated_at	=	NOW()
								WHERE		id				=	nidusuario;
							END IF;
						END IF;
					END IF;
				END IF;
			END IF;
		END IF;
	END IF;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Usuario_setEliminarPermisosByUsuario
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Usuario_setEliminarPermisosByUsuario`(
	IN `nidusuario` INT
)
BEGIN
	DELETE
	FROM		users_permissions
	WHERE		user_id	=	nidusuario;
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Usuario_setRegistrarPermisosByUsuario
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Usuario_setRegistrarPermisosByUsuario`(
	IN `nidusuario` INT,
	IN `nidpermiso` INT

)
BEGIN
	INSERT	INTO	users_permissions	(user_id, permission_id)
									VALUES	(nidusuario, nidpermiso);
END//
DELIMITER ;

-- Volcando estructura para procedimiento laravelvue.sp_Usuario_setRegistrarUsuario
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Usuario_setRegistrarUsuario`(
	IN `cprimernombre` VARCHAR(50),
	IN `csegundonombre` VARCHAR(50),
	IN `capellido` VARCHAR(50),
	IN `cusuario` VARCHAR(50),
	IN `ccorreo` VARCHAR(50),
	IN `ccontrasena` VARCHAR(150),
	IN `ofotografia` VARCHAR(50)


,
	IN `nidauthuser` INT
)
BEGIN
	insert into	users	(firstname, secondname, lastname, username, email, password, file_id, state, created_by, updated_by, created_at)
				VALUES	(cprimernombre, csegundonombre, capellido, cusuario, ccorreo, ccontrasena, ofotografia, 'A', nidauthuser, nidauthuser, NOW());

	/*OBTENER EL ULTIMO ID REGISTRADO*/
	SET @nIdUsuario := (SELECT	((IFNULL(MAX(usuario.id), 1)))
	FROM		users usuario);

	/*RETORNAMOS*/
	SELECT	@nIdUsuario	AS	nIdUsuario;
END//
DELIMITER ;

-- Volcando estructura para tabla laravelvue.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secondname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_id` bigint(20) unsigned DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `state` enum('A','I') COLLATE utf8mb4_unicode_ci DEFAULT 'A',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_file_id_foreign` (`file_id`),
  KEY `users_username_index` (`username`),
  KEY `users_created_by_index` (`created_by`),
  KEY `users_updated_by_index` (`updated_by`),
  CONSTRAINT `users_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla laravelvue.users: ~28 rows (aproximadamente)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `firstname`, `secondname`, `lastname`, `username`, `email`, `email_verified_at`, `password`, `file_id`, `remember_token`, `created_by`, `updated_by`, `state`, `created_at`, `updated_at`) VALUES
	(1, 'Alexandra', 'Bailee', 'Kunde', 'sint', 'marisol15@example.org', '2020-05-01 19:22:53', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'SOZPOomamy', 1, 1, 'A', '2020-05-01 19:22:53', '2020-05-01 19:22:53'),
	(2, 'Oscar', 'Avery', 'Mosciski', 'facere', 'camylle.oreilly@example.net', '2020-05-01 19:22:53', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'ZlHMYVnUl3', 1, 1, 'I', '2020-05-01 19:22:53', '2020-05-08 20:06:47'),
	(3, 'Lloyd', 'Aubree', 'West', 'quis', 'ernser.gerson@example.org', '2020-05-01 19:22:53', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '9xpVbVXpYo', 1, 1, 'A', '2020-05-01 19:22:54', '2020-05-01 19:22:54'),
	(4, 'Hipolito', 'Amalia', 'Gutmann', 'exercitationem', 'hharber@example.net', '2020-05-01 19:22:53', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'cmMpKMFOJQ', 1, 1, 'A', '2020-05-01 19:22:54', '2020-05-01 19:22:54'),
	(5, 'Hiram', 'Robert', 'Darex', 'suzxi', 'daugherty.cleveland@example.com', '2020-05-01 19:22:53', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '3D9V6CviIv', 1, 1, 'A', '2020-05-01 19:22:54', '2020-05-06 20:49:56'),
	(6, 'Thader', 'Leon', 'Nicolas', 'sequi', 'turner.wilderman@example.com', '2020-05-01 19:22:53', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'ePLjvkkQnz', 1, 1, 'I', '2020-05-01 19:22:54', '2020-05-08 01:16:04'),
	(7, 'Rhianna', 'Evan', 'Mosciski', 'dolores', 'cormier.creola@example.org', '2020-05-01 19:22:53', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'Uzrf5iVSba', 1, 1, 'A', '2020-05-01 19:22:54', '2020-05-01 19:22:54'),
	(8, 'Nellie', 'Emerson', 'Corwin', 'accusamus', 'ekoepp@example.com', '2020-05-01 19:22:53', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'hX8eDKY3Is', 1, 1, 'A', '2020-05-01 19:22:54', '2020-05-01 19:22:54'),
	(9, 'Saul', 'Sammy', 'Stark', 'laboriosam', 'prohaska.katelin@example.org', '2020-05-01 19:22:53', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'gY37rdUVUu', 1, 1, 'A', '2020-05-01 19:22:54', '2020-05-01 19:22:54'),
	(10, 'Charlene', 'Heath', 'Pacocha', 'labore', 'pjones@example.com', '2020-05-01 19:22:53', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'f5PZlzff5M', 1, 1, 'A', '2020-05-01 19:22:54', '2020-05-01 19:22:54'),
	(11, 'Jamarcus', 'Virgil', 'Larson', 'nobis', 'riley46@example.net', '2020-05-01 19:22:53', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'BpXPyHT4Jl', 1, 1, 'A', '2020-05-01 19:22:54', '2020-05-01 19:22:54'),
	(12, 'Jazlyn', 'Dean', 'Larkin', 'aut', 'walker.annabell@example.net', '2020-05-01 19:22:53', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '89UV7tz0z3', 1, 1, 'A', '2020-05-01 19:22:54', '2020-05-08 20:07:20'),
	(13, 'Diego', 'Antonio', 'Auer', 'atque', 'fgleason@example.net', '2020-05-01 19:22:53', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'gyY0k1uLVx', 1, 1, 'A', '2020-05-01 19:22:54', '2020-05-01 19:22:54'),
	(14, 'Jamaal', 'Ransom', 'Schumm', 'dolore', 'vada86@example.org', '2020-05-01 19:22:53', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'godyliXqif', 1, 1, 'A', '2020-05-01 19:22:54', '2020-05-01 19:22:54'),
	(15, 'Johathan', 'Karson', 'Kozey', 'et', 'griffin59@example.net', '2020-05-01 19:22:53', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '1SLRiMxJLy', 1, 1, 'A', '2020-05-01 19:22:54', '2020-05-01 19:22:54'),
	(16, 'Keshawn', 'Alejandra', 'Parker', 'eos', 'norma.dickinson@example.org', '2020-05-01 19:22:53', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, '9Ls3Ojg0CP', 1, 1, 'A', '2020-05-01 19:22:54', '2020-05-01 19:22:54'),
	(17, 'Bernita', 'Constance', 'Jaskolski', 'commodi', 'blanda.linwood@example.org', '2020-05-01 19:22:53', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'kiSq87idHz', 1, 1, 'A', '2020-05-01 19:22:55', '2020-05-01 19:22:55'),
	(18, 'Ardella', 'Christine', 'Gusikowski', 'voluptatem', 'thaddeus.beier@example.com', '2020-05-01 19:22:53', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'h2NmzJn7LY', 1, 1, 'A', '2020-05-01 19:22:55', '2020-05-01 19:22:55'),
	(19, 'Erin', 'Gerda', 'Jerde', 'ea', 'jakayla.wolf@example.com', '2020-05-01 19:22:53', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'DaT0tnHLVL', 1, 1, 'A', '2020-05-01 19:22:55', '2020-05-01 19:22:55'),
	(20, 'Sydni', 'Willard', 'Schumm', 'iste', 'chelsea.grimes@example.com', '2020-05-01 19:22:53', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'E9kDgLaVAg', 1, 1, 'A', '2020-05-01 19:22:55', '2020-05-01 19:22:55'),
	(21, 'Jose', 'Manuel', 'Anton Bernal', 'juan123456', 'juan123@gmail.com', NULL, '$2y$10$dDV27MGBlEwJRBrZeLG8memVVgpKlzp7fNIugSayDmBT/ba4q38Uq', 20, NULL, 1, 1, 'A', '2020-05-04 18:38:32', '2020-05-20 21:30:04'),
	(22, 'Jose', '', 'Rodriguez', 'jose123', 'jose123@gmail.com', NULL, '$2y$10$VwNlVLdS5gzbeeDnzoeEae4Ws4v2fK8uYi3d05JhkstU4326cbjdS', 5, NULL, 1, 1, 'A', '2020-05-04 18:40:54', '2020-05-07 13:10:52'),
	(23, 'Maria', '', 'Dominguez', 'maria123', 'maria123@gmail.com', NULL, '$2y$10$kVkjxsg6IZT/tnJFaB2bluuiHk6GDqiSrKAM2axWEe9Im40SEW3h6', 6, NULL, 1, 1, 'A', '2020-05-04 18:41:51', NULL),
	(24, 'Graciela', '', 'Chonate', 'gracie123', 'gracie123@gmail.com', NULL, '$2y$10$GWnlF.nUBWy//yI6cUExaur0bJa2wIYLwk57A/Px5hb0iZnHedSk.', NULL, NULL, 1, 21, 'A', '2020-05-04 18:52:52', '2020-06-01 19:24:52'),
	(25, 'Leslie', 'Elizabeth', 'Bernal', 'leslie1234', 'leslie123@gmail.com', NULL, '$2y$10$oWCBoXuwKX3TTRjJ.mIEuuco3yP8uN8AoKBTpqDaH0OzJHO7HsCli', NULL, NULL, 1, 21, 'I', '2020-05-04 18:53:38', '2020-06-08 03:11:27'),
	(26, 'Tatiana', '', 'Rodriguez', 'tati123', 'tati123@gmail.com', NULL, '$2y$10$rhOpT.5BcjL7xZ2cO2JLYuJP2OTHGBydzbmLMx8HYwcSBfPvU/gv.', NULL, NULL, 1, 21, 'A', '2020-05-14 21:24:18', '2020-06-01 19:24:40'),
	(27, 'Leonardo', '', 'Mendoza', 'leo1234', 'leo1234@gmail.com', NULL, '$2y$10$k/.XHh4QSemZDuyKVTJImum7ScXdB8FRfL7E.ljifbpXOia/2zbX2', NULL, NULL, 1, 21, 'I', '2020-05-14 21:26:02', '2020-06-06 22:45:13'),
	(28, 'Alonso', 'Vilchez', 'Bustamante', 'alonso123', 'alonso123@gmail.com', NULL, '$2y$10$D4Negl566vJcYJCDGK9N7OwKaPjb9qDGgkNWaYdBa/6tcbkOJknK6', NULL, NULL, 1, 21, 'A', '2020-05-14 21:26:52', '2020-06-01 19:24:19');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Volcando estructura para tabla laravelvue.users_permissions
CREATE TABLE IF NOT EXISTS `users_permissions` (
  `user_id` bigint(20) unsigned NOT NULL,
  `permission_id` bigint(20) unsigned NOT NULL,
  KEY `users_permissions_user_id_foreign` (`user_id`),
  KEY `users_permissions_permission_id_foreign` (`permission_id`),
  CONSTRAINT `users_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`),
  CONSTRAINT `users_permissions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla laravelvue.users_permissions: ~4 rows (aproximadamente)
DELETE FROM `users_permissions`;
/*!40000 ALTER TABLE `users_permissions` DISABLE KEYS */;
INSERT INTO `users_permissions` (`user_id`, `permission_id`) VALUES
	(28, 8),
	(21, 1),
	(21, 4),
	(21, 7);
/*!40000 ALTER TABLE `users_permissions` ENABLE KEYS */;

-- Volcando estructura para tabla laravelvue.users_roles
CREATE TABLE IF NOT EXISTS `users_roles` (
  `user_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  KEY `users_roles_user_id_foreign` (`user_id`),
  KEY `users_roles_role_id_foreign` (`role_id`),
  CONSTRAINT `users_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `users_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla laravelvue.users_roles: ~5 rows (aproximadamente)
DELETE FROM `users_roles`;
/*!40000 ALTER TABLE `users_roles` DISABLE KEYS */;
INSERT INTO `users_roles` (`user_id`, `role_id`) VALUES
	(28, 3),
	(26, 3),
	(24, 3),
	(21, 2),
	(27, 3),
	(25, 3);
/*!40000 ALTER TABLE `users_roles` ENABLE KEYS */;

-- Volcando estructura para disparador laravelvue.tr_Pedido_setActualizarStock
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `tr_Pedido_setActualizarStock` AFTER INSERT ON `details_orders` FOR EACH ROW BEGIN
	UPDATE	products
	SET		stock		=	stock - NEW.quantity
	WHERE		id			=	NEW.product_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
