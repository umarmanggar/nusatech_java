-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 15, 2025 at 02:33 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nusatech`
--

-- --------------------------------------------------------

--
-- Table structure for table `balance_history`
--

CREATE TABLE `balance_history` (
  `history_id` int NOT NULL,
  `user_id` int NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `type` enum('CREDIT','DEBIT') NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `reference_id` int DEFAULT NULL,
  `reference_type` varchar(50) DEFAULT NULL,
  `balance_before` decimal(15,2) DEFAULT NULL,
  `balance_after` decimal(15,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `cart_id` int NOT NULL,
  `user_id` int NOT NULL,
  `course_id` int NOT NULL,
  `added_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` text,
  `icon` varchar(50) DEFAULT NULL,
  `color` varchar(7) DEFAULT '#8B1538',
  `is_active` tinyint(1) DEFAULT '1',
  `display_order` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `name`, `slug`, `description`, `icon`, `color`, `is_active`, `display_order`, `created_at`) VALUES
(1, 'Web Development', 'web-development', 'Pelajari cara membangun website dari nol hingga mahir', 'fa-globe', '#3498db', 1, 1, '2025-12-10 10:22:05'),
(2, 'Mobile Development', 'mobile-development', 'Bangun aplikasi mobile untuk Android dan iOS', 'fa-mobile-alt', '#9b59b6', 1, 2, '2025-12-10 10:22:05'),
(3, 'Data Science', 'data-science', 'Analisis data dan machine learning untuk pemula hingga expert', 'fa-chart-bar', '#27ae60', 1, 3, '2025-12-10 10:22:05'),
(4, 'Artificial Intelligence', 'artificial-intelligence', 'Pelajari AI, deep learning, dan neural networks', 'fa-robot', '#e74c3c', 1, 4, '2025-12-10 10:22:05'),
(5, 'Cloud Computing', 'cloud-computing', 'AWS, GCP, Azure dan teknologi cloud lainnya', 'fa-cloud', '#f39c12', 1, 5, '2025-12-10 10:22:05'),
(6, 'Cyber Security', 'cyber-security', 'Keamanan sistem dan ethical hacking', 'fa-shield-alt', '#1abc9c', 1, 6, '2025-12-10 10:22:05'),
(7, 'DevOps', 'devops', 'CI/CD, Docker, Kubernetes dan automation', 'fa-cogs', '#e67e22', 1, 7, '2025-12-10 10:22:05'),
(8, 'UI/UX Design', 'ui-ux-design', 'Desain antarmuka dan pengalaman pengguna', 'fa-paint-brush', '#8e44ad', 1, 8, '2025-12-10 10:22:05');

-- --------------------------------------------------------

--
-- Table structure for table `certificates`
--

CREATE TABLE `certificates` (
  `certificate_id` int NOT NULL,
  `enrollment_id` int NOT NULL,
  `certificate_number` varchar(50) NOT NULL,
  `issued_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `pdf_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `coupon_id` int NOT NULL,
  `code` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `discount_type` enum('PERCENTAGE','FIXED') NOT NULL,
  `discount_value` decimal(12,2) NOT NULL,
  `min_purchase` decimal(12,2) DEFAULT '0.00',
  `max_discount` decimal(12,2) DEFAULT NULL,
  `usage_limit` int DEFAULT '-1',
  `used_count` int DEFAULT '0',
  `valid_from` date NOT NULL,
  `valid_until` date NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `course_id` int NOT NULL,
  `lecturer_id` int NOT NULL,
  `category_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text,
  `short_description` varchar(500) DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT 'default-course.png',
  `preview_video` varchar(255) DEFAULT NULL,
  `price` decimal(12,2) DEFAULT '0.00',
  `discount_price` decimal(12,2) DEFAULT NULL,
  `level` enum('BEGINNER','INTERMEDIATE','ADVANCED','ALL_LEVELS') DEFAULT 'ALL_LEVELS',
  `language` varchar(50) DEFAULT 'Indonesia',
  `duration_hours` int DEFAULT '0',
  `total_sections` int DEFAULT '0',
  `total_materials` int DEFAULT '0',
  `total_students` int DEFAULT '0',
  `avg_rating` decimal(3,2) DEFAULT '0.00',
  `total_reviews` int DEFAULT '0',
  `requirements` text,
  `objectives` text,
  `target_audience` text,
  `status` enum('DRAFT','PENDING','PUBLISHED','ARCHIVED') DEFAULT 'DRAFT',
  `is_featured` tinyint(1) DEFAULT '0',
  `is_free` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `published_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `enrollments`
--

CREATE TABLE `enrollments` (
  `enrollment_id` int NOT NULL,
  `student_id` int NOT NULL,
  `course_id` int NOT NULL,
  `enrolled_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `progress_percentage` decimal(5,2) DEFAULT '0.00',
  `last_accessed_at` timestamp NULL DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `certificate_issued` tinyint(1) DEFAULT '0',
  `certificate_url` varchar(255) DEFAULT NULL,
  `status` enum('ACTIVE','COMPLETED','EXPIRED','CANCELLED') DEFAULT 'ACTIVE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Triggers `enrollments`
--
DELIMITER $$
CREATE TRIGGER `after_enrollment_insert` AFTER INSERT ON `enrollments` FOR EACH ROW BEGIN
    UPDATE courses SET total_students = total_students + 1 WHERE course_id = NEW.course_id;
    UPDATE student_profiles SET total_courses_enrolled = total_courses_enrolled + 1 WHERE student_id = NEW.student_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `forums`
--

CREATE TABLE `forums` (
  `forum_id` int NOT NULL,
  `course_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `forum_posts`
--

CREATE TABLE `forum_posts` (
  `post_id` int NOT NULL,
  `forum_id` int NOT NULL,
  `user_id` int NOT NULL,
  `parent_id` int DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` text NOT NULL,
  `upvotes` int DEFAULT '0',
  `is_pinned` tinyint(1) DEFAULT '0',
  `is_answered` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lecturer_profiles`
--

CREATE TABLE `lecturer_profiles` (
  `lecturer_id` int NOT NULL,
  `bio` text,
  `expertise` varchar(255) DEFAULT NULL,
  `linkedin_url` varchar(255) DEFAULT NULL,
  `website_url` varchar(255) DEFAULT NULL,
  `total_students` int DEFAULT '0',
  `total_courses` int DEFAULT '0',
  `avg_rating` decimal(3,2) DEFAULT '0.00',
  `is_verified` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `materials`
--

CREATE TABLE `materials` (
  `material_id` int NOT NULL,
  `section_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `content_type` enum('VIDEO','TEXT','PDF','QUIZ','PROJECT','DOWNLOAD') NOT NULL,
  `content` longtext,
  `video_url` varchar(500) DEFAULT NULL,
  `video_duration` int DEFAULT '0',
  `attachment_url` varchar(255) DEFAULT NULL,
  `display_order` int DEFAULT '0',
  `is_preview` tinyint(1) DEFAULT '0',
  `is_mandatory` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `material_progress`
--

CREATE TABLE `material_progress` (
  `progress_id` int NOT NULL,
  `enrollment_id` int NOT NULL,
  `material_id` int NOT NULL,
  `is_completed` tinyint(1) DEFAULT '0',
  `completed_at` timestamp NULL DEFAULT NULL,
  `time_spent_seconds` int DEFAULT '0',
  `last_position` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int NOT NULL,
  `user_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text,
  `type` enum('INFO','SUCCESS','WARNING','ERROR','COURSE','PAYMENT','FORUM') DEFAULT 'INFO',
  `link` varchar(255) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post_votes`
--

CREATE TABLE `post_votes` (
  `vote_id` int NOT NULL,
  `post_id` int NOT NULL,
  `user_id` int NOT NULL,
  `vote_type` enum('UP','DOWN') NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `project_id` int NOT NULL,
  `material_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `instructions` text,
  `deadline_days` int DEFAULT '7',
  `max_score` int DEFAULT '100',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_submissions`
--

CREATE TABLE `project_submissions` (
  `submission_id` int NOT NULL,
  `project_id` int NOT NULL,
  `student_id` int NOT NULL,
  `submission_url` varchar(255) DEFAULT NULL,
  `submission_text` text,
  `score` int DEFAULT NULL,
  `feedback` text,
  `status` enum('SUBMITTED','REVIEWING','GRADED','REVISION_NEEDED') DEFAULT 'SUBMITTED',
  `submitted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `graded_at` timestamp NULL DEFAULT NULL,
  `graded_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `question_id` int NOT NULL,
  `quiz_id` int NOT NULL,
  `question_text` text NOT NULL,
  `question_type` enum('MULTIPLE_CHOICE','TRUE_FALSE','ESSAY') DEFAULT 'MULTIPLE_CHOICE',
  `points` int DEFAULT '1',
  `display_order` int DEFAULT '0',
  `explanation` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `question_options`
--

CREATE TABLE `question_options` (
  `option_id` int NOT NULL,
  `question_id` int NOT NULL,
  `option_text` text NOT NULL,
  `is_correct` tinyint(1) DEFAULT '0',
  `display_order` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quizzes`
--

CREATE TABLE `quizzes` (
  `quiz_id` int NOT NULL,
  `material_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `passing_score` int DEFAULT '70',
  `time_limit_minutes` int DEFAULT '0',
  `max_attempts` int DEFAULT '3',
  `shuffle_questions` tinyint(1) DEFAULT '1',
  `show_correct_answers` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quiz_answers`
--

CREATE TABLE `quiz_answers` (
  `answer_id` int NOT NULL,
  `attempt_id` int NOT NULL,
  `question_id` int NOT NULL,
  `selected_option_id` int DEFAULT NULL,
  `essay_answer` text,
  `is_correct` tinyint(1) DEFAULT '0',
  `points_earned` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quiz_attempts`
--

CREATE TABLE `quiz_attempts` (
  `attempt_id` int NOT NULL,
  `student_id` int NOT NULL,
  `quiz_id` int NOT NULL,
  `score` decimal(5,2) DEFAULT '0.00',
  `is_passed` tinyint(1) DEFAULT '0',
  `started_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `completed_at` timestamp NULL DEFAULT NULL,
  `time_taken_seconds` int DEFAULT '0',
  `attempt_number` int DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `review_id` int NOT NULL,
  `course_id` int NOT NULL,
  `student_id` int NOT NULL,
  `rating` int NOT NULL,
  `review_text` text,
  `is_approved` tinyint(1) DEFAULT '1',
  `helpful_count` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;

--
-- Triggers `reviews`
--
DELIMITER $$
CREATE TRIGGER `after_review_insert` AFTER INSERT ON `reviews` FOR EACH ROW BEGIN
    UPDATE courses 
    SET avg_rating = (SELECT AVG(rating) FROM reviews WHERE course_id = NEW.course_id),
        total_reviews = (SELECT COUNT(*) FROM reviews WHERE course_id = NEW.course_id)
    WHERE course_id = NEW.course_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `section_id` int NOT NULL,
  `course_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `display_order` int DEFAULT '0',
  `is_preview` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `setting_id` int NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text,
  `setting_type` enum('STRING','NUMBER','BOOLEAN','JSON') DEFAULT 'STRING',
  `description` varchar(255) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`setting_id`, `setting_key`, `setting_value`, `setting_type`, `description`, `updated_at`) VALUES
(1, 'site_name', 'Dikoding Muda Nusantara', 'STRING', 'Nama website', '2025-12-10 10:22:05'),
(2, 'site_description', 'Platform Pembelajaran Coding untuk Indonesia Emas 2045', 'STRING', 'Deskripsi website', '2025-12-10 10:22:05'),
(3, 'commission_rate', '20', 'NUMBER', 'Persentase komisi platform (%)', '2025-12-10 10:22:05'),
(4, 'min_withdrawal', '100000', 'NUMBER', 'Minimal penarikan saldo', '2025-12-10 10:22:05'),
(5, 'contact_email', 'support@nusatech.id', 'STRING', 'Email kontak', '2025-12-10 10:22:05'),
(6, 'contact_phone', '+62 812 3456 7890', 'STRING', 'Nomor telepon kontak', '2025-12-10 10:22:05');

-- --------------------------------------------------------

--
-- Table structure for table `student_profiles`
--

CREATE TABLE `student_profiles` (
  `student_id` int NOT NULL,
  `institution` varchar(255) DEFAULT NULL,
  `level` enum('BEGINNER','INTERMEDIATE','ADVANCED') DEFAULT 'BEGINNER',
  `total_courses_enrolled` int DEFAULT '0',
  `total_courses_completed` int DEFAULT '0',
  `total_certificates` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscription_plans`
--

CREATE TABLE `subscription_plans` (
  `plan_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `price` decimal(12,2) NOT NULL,
  `duration_days` int NOT NULL,
  `features` text,
  `max_courses` int DEFAULT '-1',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `subscription_plans`
--

INSERT INTO `subscription_plans` (`plan_id`, `name`, `description`, `price`, `duration_days`, `features`, `max_courses`, `is_active`, `created_at`) VALUES
(1, 'Basic', 'Akses ke kursus-kursus dasar', '99000.00', 30, '[\"Akses 5 kursus per bulan\", \"Sertifikat digital\", \"Forum diskusi\"]', 5, 1, '2025-12-10 10:22:05'),
(2, 'Pro', 'Akses penuh ke semua kursus', '199000.00', 30, '[\"Akses semua kursus\", \"Sertifikat digital\", \"Forum diskusi\", \"Project review\", \"Konsultasi mingguan\"]', -1, 1, '2025-12-10 10:22:05'),
(3, 'Enterprise', 'Untuk tim dan perusahaan', '499000.00', 30, '[\"Akses semua kursus\", \"Sertifikat digital\", \"Forum diskusi\", \"Project review\", \"Dedicated mentor\", \"Custom learning path\"]', -1, 1, '2025-12-10 10:22:05');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `transaction_id` int NOT NULL,
  `user_id` int NOT NULL,
  `transaction_code` varchar(50) NOT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  `payment_method` enum('BANK_TRANSFER','E_WALLET','CREDIT_CARD','BALANCE') NOT NULL,
  `payment_status` enum('PENDING','PAID','FAILED','REFUNDED','EXPIRED') DEFAULT 'PENDING',
  `payment_proof` varchar(255) DEFAULT NULL,
  `paid_at` timestamp NULL DEFAULT NULL,
  `expired_at` timestamp NULL DEFAULT NULL,
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Triggers `transactions`
--
DELIMITER $$
CREATE TRIGGER `after_transaction_paid` AFTER UPDATE ON `transactions` FOR EACH ROW BEGIN
    DECLARE lecturer_share DECIMAL(12,2);
    DECLARE commission DECIMAL(5,2);
    DECLARE v_course_id INT;
    DECLARE v_lecturer_id INT;
    DECLARE v_price DECIMAL(12,2);
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR 
        SELECT ti.course_id, c.lecturer_id, ti.price 
        FROM transaction_items ti 
        JOIN courses c ON ti.course_id = c.course_id 
        WHERE ti.transaction_id = NEW.transaction_id AND ti.item_type = 'COURSE';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    IF NEW.payment_status = 'PAID' AND OLD.payment_status = 'PENDING' THEN
        SELECT CAST(setting_value AS DECIMAL(5,2)) INTO commission FROM settings WHERE setting_key = 'commission_rate';
        
        OPEN cur;
        read_loop: LOOP
            FETCH cur INTO v_course_id, v_lecturer_id, v_price;
            IF done THEN
                LEAVE read_loop;
            END IF;
            
            SET lecturer_share = v_price * (100 - commission) / 100;
            UPDATE users SET balance = balance + lecturer_share WHERE user_id = v_lecturer_id;
            
            INSERT INTO balance_history (user_id, amount, type, description, reference_id, reference_type, balance_before, balance_after)
            SELECT v_lecturer_id, lecturer_share, 'CREDIT', CONCAT('Penjualan kursus #', v_course_id), NEW.transaction_id, 'TRANSACTION',
                   balance - lecturer_share, balance
            FROM users WHERE user_id = v_lecturer_id;
        END LOOP;
        CLOSE cur;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_items`
--

CREATE TABLE `transaction_items` (
  `item_id` int NOT NULL,
  `transaction_id` int NOT NULL,
  `course_id` int DEFAULT NULL,
  `plan_id` int DEFAULT NULL,
  `item_type` enum('COURSE','SUBSCRIPTION') NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `discount` decimal(12,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT 'default-avatar.png',
  `role` enum('ADMIN','LECTURER','STUDENT') NOT NULL,
  `balance` decimal(15,2) DEFAULT '0.00',
  `is_active` tinyint(1) DEFAULT '1',
  `email_verified` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_login` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `email`, `password`, `name`, `phone`, `profile_picture`, `role`, `balance`, `is_active`, `email_verified`, `created_at`, `updated_at`, `last_login`) VALUES
(1, 'admin@nusatech.id', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZRGdjGj/n3.k0YKPB1g3qmZ4qhVaC', 'Administrator', NULL, 'default-avatar.png', 'ADMIN', '0.00', 1, 1, '2025-12-10 10:22:05', '2025-12-10 10:22:05', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_subscriptions`
--

CREATE TABLE `user_subscriptions` (
  `subscription_id` int NOT NULL,
  `user_id` int NOT NULL,
  `plan_id` int NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` enum('ACTIVE','EXPIRED','CANCELLED') DEFAULT 'ACTIVE',
  `auto_renew` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_admin_stats`
-- (See below for the actual view)
--
CREATE TABLE `v_admin_stats` (
`total_courses` bigint
,`total_enrollments` bigint
,`total_lecturers` bigint
,`total_revenue` decimal(34,2)
,`total_students` bigint
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_course_details`
-- (See below for the actual view)
--
CREATE TABLE `v_course_details` (
`avg_rating` decimal(3,2)
,`category_id` int
,`category_name` varchar(100)
,`category_slug` varchar(100)
,`course_id` int
,`created_at` timestamp
,`description` text
,`discount_price` decimal(12,2)
,`duration_hours` int
,`is_featured` tinyint(1)
,`is_free` tinyint(1)
,`language` varchar(50)
,`lecturer_avatar` varchar(255)
,`lecturer_bio` text
,`lecturer_id` int
,`lecturer_name` varchar(100)
,`lecturer_rating` decimal(3,2)
,`level` enum('BEGINNER','INTERMEDIATE','ADVANCED','ALL_LEVELS')
,`objectives` text
,`preview_video` varchar(255)
,`price` decimal(12,2)
,`published_at` timestamp
,`requirements` text
,`short_description` varchar(500)
,`slug` varchar(255)
,`status` enum('DRAFT','PENDING','PUBLISHED','ARCHIVED')
,`target_audience` text
,`thumbnail` varchar(255)
,`title` varchar(255)
,`total_materials` int
,`total_reviews` int
,`total_sections` int
,`total_students` int
,`updated_at` timestamp
);

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `wishlist_id` int NOT NULL,
  `user_id` int NOT NULL,
  `course_id` int NOT NULL,
  `added_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure for view `v_admin_stats`
--
DROP TABLE IF EXISTS `v_admin_stats`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_admin_stats`  AS SELECT (select count(0) from `users` where (`users`.`role` = 'STUDENT')) AS `total_students`, (select count(0) from `users` where (`users`.`role` = 'LECTURER')) AS `total_lecturers`, (select count(0) from `courses` where (`courses`.`status` = 'PUBLISHED')) AS `total_courses`, (select count(0) from `enrollments`) AS `total_enrollments`, (select coalesce(sum(`transactions`.`total_amount`),0) from `transactions` where (`transactions`.`payment_status` = 'PAID')) AS `total_revenue``total_revenue`  ;

-- --------------------------------------------------------

--
-- Structure for view `v_course_details`
--
DROP TABLE IF EXISTS `v_course_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_course_details`  AS SELECT `c`.`course_id` AS `course_id`, `c`.`lecturer_id` AS `lecturer_id`, `c`.`category_id` AS `category_id`, `c`.`title` AS `title`, `c`.`slug` AS `slug`, `c`.`description` AS `description`, `c`.`short_description` AS `short_description`, `c`.`thumbnail` AS `thumbnail`, `c`.`preview_video` AS `preview_video`, `c`.`price` AS `price`, `c`.`discount_price` AS `discount_price`, `c`.`level` AS `level`, `c`.`language` AS `language`, `c`.`duration_hours` AS `duration_hours`, `c`.`total_sections` AS `total_sections`, `c`.`total_materials` AS `total_materials`, `c`.`total_students` AS `total_students`, `c`.`avg_rating` AS `avg_rating`, `c`.`total_reviews` AS `total_reviews`, `c`.`requirements` AS `requirements`, `c`.`objectives` AS `objectives`, `c`.`target_audience` AS `target_audience`, `c`.`status` AS `status`, `c`.`is_featured` AS `is_featured`, `c`.`is_free` AS `is_free`, `c`.`created_at` AS `created_at`, `c`.`updated_at` AS `updated_at`, `c`.`published_at` AS `published_at`, `u`.`name` AS `lecturer_name`, `u`.`profile_picture` AS `lecturer_avatar`, `lp`.`bio` AS `lecturer_bio`, `lp`.`avg_rating` AS `lecturer_rating`, `cat`.`name` AS `category_name`, `cat`.`slug` AS `category_slug` FROM (((`courses` `c` join `users` `u` on((`c`.`lecturer_id` = `u`.`user_id`))) left join `lecturer_profiles` `lp` on((`c`.`lecturer_id` = `lp`.`lecturer_id`))) join `categories` `cat` on((`c`.`category_id` = `cat`.`category_id`)))  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `balance_history`
--
ALTER TABLE `balance_history`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `idx_user` (`user_id`);

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`cart_id`),
  ADD UNIQUE KEY `unique_cart_item` (`user_id`,`course_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `certificates`
--
ALTER TABLE `certificates`
  ADD PRIMARY KEY (`certificate_id`),
  ADD UNIQUE KEY `certificate_number` (`certificate_number`),
  ADD KEY `enrollment_id` (`enrollment_id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`coupon_id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`course_id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_category` (`category_id`),
  ADD KEY `idx_lecturer` (`lecturer_id`);
ALTER TABLE `courses` ADD FULLTEXT KEY `ft_search` (`title`,`description`,`short_description`);

--
-- Indexes for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`enrollment_id`),
  ADD UNIQUE KEY `unique_enrollment` (`student_id`,`course_id`),
  ADD KEY `idx_student` (`student_id`),
  ADD KEY `idx_course` (`course_id`);

--
-- Indexes for table `forums`
--
ALTER TABLE `forums`
  ADD PRIMARY KEY (`forum_id`),
  ADD UNIQUE KEY `unique_forum` (`course_id`);

--
-- Indexes for table `forum_posts`
--
ALTER TABLE `forum_posts`
  ADD PRIMARY KEY (`post_id`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `idx_forum` (`forum_id`),
  ADD KEY `idx_user` (`user_id`);

--
-- Indexes for table `lecturer_profiles`
--
ALTER TABLE `lecturer_profiles`
  ADD PRIMARY KEY (`lecturer_id`);

--
-- Indexes for table `materials`
--
ALTER TABLE `materials`
  ADD PRIMARY KEY (`material_id`),
  ADD KEY `idx_section` (`section_id`);

--
-- Indexes for table `material_progress`
--
ALTER TABLE `material_progress`
  ADD PRIMARY KEY (`progress_id`),
  ADD UNIQUE KEY `unique_progress` (`enrollment_id`,`material_id`),
  ADD KEY `material_id` (`material_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_read` (`is_read`);

--
-- Indexes for table `post_votes`
--
ALTER TABLE `post_votes`
  ADD PRIMARY KEY (`vote_id`),
  ADD UNIQUE KEY `unique_vote` (`post_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`project_id`),
  ADD KEY `material_id` (`material_id`);

--
-- Indexes for table `project_submissions`
--
ALTER TABLE `project_submissions`
  ADD PRIMARY KEY (`submission_id`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `graded_by` (`graded_by`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`question_id`),
  ADD KEY `idx_quiz` (`quiz_id`);

--
-- Indexes for table `question_options`
--
ALTER TABLE `question_options`
  ADD PRIMARY KEY (`option_id`),
  ADD KEY `idx_question` (`question_id`);

--
-- Indexes for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD PRIMARY KEY (`quiz_id`),
  ADD KEY `material_id` (`material_id`);

--
-- Indexes for table `quiz_answers`
--
ALTER TABLE `quiz_answers`
  ADD PRIMARY KEY (`answer_id`),
  ADD KEY `attempt_id` (`attempt_id`),
  ADD KEY `question_id` (`question_id`),
  ADD KEY `selected_option_id` (`selected_option_id`);

--
-- Indexes for table `quiz_attempts`
--
ALTER TABLE `quiz_attempts`
  ADD PRIMARY KEY (`attempt_id`),
  ADD KEY `quiz_id` (`quiz_id`),
  ADD KEY `idx_student_quiz` (`student_id`,`quiz_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD UNIQUE KEY `unique_review` (`course_id`,`student_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `idx_course` (`course_id`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`section_id`),
  ADD KEY `idx_course` (`course_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`setting_id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`);

--
-- Indexes for table `student_profiles`
--
ALTER TABLE `student_profiles`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `subscription_plans`
--
ALTER TABLE `subscription_plans`
  ADD PRIMARY KEY (`plan_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transaction_id`),
  ADD UNIQUE KEY `transaction_code` (`transaction_code`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_status` (`payment_status`);

--
-- Indexes for table `transaction_items`
--
ALTER TABLE `transaction_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `transaction_id` (`transaction_id`),
  ADD KEY `course_id` (`course_id`),
  ADD KEY `plan_id` (`plan_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_role` (`role`);

--
-- Indexes for table `user_subscriptions`
--
ALTER TABLE `user_subscriptions`
  ADD PRIMARY KEY (`subscription_id`),
  ADD KEY `plan_id` (`plan_id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`wishlist_id`),
  ADD UNIQUE KEY `unique_wishlist_item` (`user_id`,`course_id`),
  ADD KEY `course_id` (`course_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `balance_history`
--
ALTER TABLE `balance_history`
  MODIFY `history_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `cart_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `certificates`
--
ALTER TABLE `certificates`
  MODIFY `certificate_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `coupon_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `course_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `enrollments`
--
ALTER TABLE `enrollments`
  MODIFY `enrollment_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `forums`
--
ALTER TABLE `forums`
  MODIFY `forum_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `forum_posts`
--
ALTER TABLE `forum_posts`
  MODIFY `post_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `materials`
--
ALTER TABLE `materials`
  MODIFY `material_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `material_progress`
--
ALTER TABLE `material_progress`
  MODIFY `progress_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `post_votes`
--
ALTER TABLE `post_votes`
  MODIFY `vote_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `project_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_submissions`
--
ALTER TABLE `project_submissions`
  MODIFY `submission_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `question_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `question_options`
--
ALTER TABLE `question_options`
  MODIFY `option_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quizzes`
--
ALTER TABLE `quizzes`
  MODIFY `quiz_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quiz_answers`
--
ALTER TABLE `quiz_answers`
  MODIFY `answer_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quiz_attempts`
--
ALTER TABLE `quiz_attempts`
  MODIFY `attempt_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `section_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `setting_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `subscription_plans`
--
ALTER TABLE `subscription_plans`
  MODIFY `plan_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `transaction_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaction_items`
--
ALTER TABLE `transaction_items`
  MODIFY `item_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_subscriptions`
--
ALTER TABLE `user_subscriptions`
  MODIFY `subscription_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `wishlist_id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `balance_history`
--
ALTER TABLE `balance_history`
  ADD CONSTRAINT `balance_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_items_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;

--
-- Constraints for table `certificates`
--
ALTER TABLE `certificates`
  ADD CONSTRAINT `certificates_ibfk_1` FOREIGN KEY (`enrollment_id`) REFERENCES `enrollments` (`enrollment_id`) ON DELETE CASCADE;

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`lecturer_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `courses_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Constraints for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD CONSTRAINT `enrollments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `enrollments_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;

--
-- Constraints for table `forums`
--
ALTER TABLE `forums`
  ADD CONSTRAINT `forums_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;

--
-- Constraints for table `forum_posts`
--
ALTER TABLE `forum_posts`
  ADD CONSTRAINT `forum_posts_ibfk_1` FOREIGN KEY (`forum_id`) REFERENCES `forums` (`forum_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `forum_posts_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `forum_posts_ibfk_3` FOREIGN KEY (`parent_id`) REFERENCES `forum_posts` (`post_id`) ON DELETE CASCADE;

--
-- Constraints for table `lecturer_profiles`
--
ALTER TABLE `lecturer_profiles`
  ADD CONSTRAINT `lecturer_profiles_ibfk_1` FOREIGN KEY (`lecturer_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `materials`
--
ALTER TABLE `materials`
  ADD CONSTRAINT `materials_ibfk_1` FOREIGN KEY (`section_id`) REFERENCES `sections` (`section_id`) ON DELETE CASCADE;

--
-- Constraints for table `material_progress`
--
ALTER TABLE `material_progress`
  ADD CONSTRAINT `material_progress_ibfk_1` FOREIGN KEY (`enrollment_id`) REFERENCES `enrollments` (`enrollment_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `material_progress_ibfk_2` FOREIGN KEY (`material_id`) REFERENCES `materials` (`material_id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `post_votes`
--
ALTER TABLE `post_votes`
  ADD CONSTRAINT `post_votes_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `forum_posts` (`post_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `post_votes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `projects`
--
ALTER TABLE `projects`
  ADD CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`material_id`) REFERENCES `materials` (`material_id`) ON DELETE CASCADE;

--
-- Constraints for table `project_submissions`
--
ALTER TABLE `project_submissions`
  ADD CONSTRAINT `project_submissions_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `project_submissions_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `project_submissions_ibfk_3` FOREIGN KEY (`graded_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`quiz_id`) ON DELETE CASCADE;

--
-- Constraints for table `question_options`
--
ALTER TABLE `question_options`
  ADD CONSTRAINT `question_options_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`question_id`) ON DELETE CASCADE;

--
-- Constraints for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD CONSTRAINT `quizzes_ibfk_1` FOREIGN KEY (`material_id`) REFERENCES `materials` (`material_id`) ON DELETE CASCADE;

--
-- Constraints for table `quiz_answers`
--
ALTER TABLE `quiz_answers`
  ADD CONSTRAINT `quiz_answers_ibfk_1` FOREIGN KEY (`attempt_id`) REFERENCES `quiz_attempts` (`attempt_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quiz_answers_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `questions` (`question_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quiz_answers_ibfk_3` FOREIGN KEY (`selected_option_id`) REFERENCES `question_options` (`option_id`);

--
-- Constraints for table `quiz_attempts`
--
ALTER TABLE `quiz_attempts`
  ADD CONSTRAINT `quiz_attempts_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quiz_attempts_ibfk_2` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`quiz_id`) ON DELETE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `sections`
--
ALTER TABLE `sections`
  ADD CONSTRAINT `sections_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;

--
-- Constraints for table `student_profiles`
--
ALTER TABLE `student_profiles`
  ADD CONSTRAINT `student_profiles_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `transaction_items`
--
ALTER TABLE `transaction_items`
  ADD CONSTRAINT `transaction_items_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`transaction_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transaction_items_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`),
  ADD CONSTRAINT `transaction_items_ibfk_3` FOREIGN KEY (`plan_id`) REFERENCES `subscription_plans` (`plan_id`);

--
-- Constraints for table `user_subscriptions`
--
ALTER TABLE `user_subscriptions`
  ADD CONSTRAINT `user_subscriptions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_subscriptions_ibfk_2` FOREIGN KEY (`plan_id`) REFERENCES `subscription_plans` (`plan_id`);

--
-- Constraints for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
