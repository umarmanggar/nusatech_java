-- Sample Data for NusaTech Learning Platform
-- Run this AFTER nusatech.sql
-- Versi yang diperbaiki

USE nusatech;

-- Disable foreign key checks temporarily
SET FOREIGN_KEY_CHECKS = 0;

-- --------------------------------------------------------
-- Sample Users
-- Password: 123 (SHA-256 hash)
-- --------------------------------------------------------

-- Lecturers (user_id 2, 3, 4)
INSERT INTO `users` (`user_id`, `email`, `password`, `name`, `phone`, `profile_picture`, `role`, `balance`, `is_active`, `email_verified`, `created_at`) VALUES
(2, 'budi.lecturer@nusatech.id', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Budi Santoso', '081234567890', 'default-avatar.png', 'LECTURER', 2500000.00, 1, 1, NOW())
ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO `users` (`user_id`, `email`, `password`, `name`, `phone`, `profile_picture`, `role`, `balance`, `is_active`, `email_verified`, `created_at`) VALUES
(3, 'siti.lecturer@nusatech.id', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Siti Rahayu', '081234567891', 'default-avatar.png', 'LECTURER', 1800000.00, 1, 1, NOW())
ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO `users` (`user_id`, `email`, `password`, `name`, `phone`, `profile_picture`, `role`, `balance`, `is_active`, `email_verified`, `created_at`) VALUES
(4, 'ahmad.lecturer@nusatech.id', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Ahmad Fauzi', '081234567892', 'default-avatar.png', 'LECTURER', 3200000.00, 1, 1, NOW())
ON DUPLICATE KEY UPDATE name = VALUES(name);

-- Students (user_id 5, 6, 7, 8, 9)
INSERT INTO `users` (`user_id`, `email`, `password`, `name`, `phone`, `profile_picture`, `role`, `balance`, `is_active`, `email_verified`, `created_at`) VALUES
(5, 'dewi.student@gmail.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Dewi Lestari', '081345678901', 'default-avatar.png', 'STUDENT', 0.00, 1, 1, NOW())
ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO `users` (`user_id`, `email`, `password`, `name`, `phone`, `profile_picture`, `role`, `balance`, `is_active`, `email_verified`, `created_at`) VALUES
(6, 'andi.student@gmail.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Andi Wijaya', '081345678902', 'default-avatar.png', 'STUDENT', 0.00, 1, 1, NOW())
ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO `users` (`user_id`, `email`, `password`, `name`, `phone`, `profile_picture`, `role`, `balance`, `is_active`, `email_verified`, `created_at`) VALUES
(7, 'maya.student@gmail.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Maya Putri', '081345678903', 'default-avatar.png', 'STUDENT', 0.00, 1, 1, NOW())
ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO `users` (`user_id`, `email`, `password`, `name`, `phone`, `profile_picture`, `role`, `balance`, `is_active`, `email_verified`, `created_at`) VALUES
(8, 'reza.student@gmail.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Reza Pratama', '081345678904', 'default-avatar.png', 'STUDENT', 0.00, 1, 1, NOW())
ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO `users` (`user_id`, `email`, `password`, `name`, `phone`, `profile_picture`, `role`, `balance`, `is_active`, `email_verified`, `created_at`) VALUES
(9, 'nina.student@gmail.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Nina Kusuma', '081345678905', 'default-avatar.png', 'STUDENT', 0.00, 1, 1, NOW())
ON DUPLICATE KEY UPDATE name = VALUES(name);

-- --------------------------------------------------------
-- Lecturer Profiles (sesuai struktur tabel yang benar)
-- Kolom: lecturer_id, bio, expertise, linkedin_url, website_url, total_students, total_courses, avg_rating, is_verified
-- --------------------------------------------------------
INSERT INTO `lecturer_profiles` (`lecturer_id`, `bio`, `expertise`, `total_courses`, `total_students`, `avg_rating`, `is_verified`) VALUES
(2, 'Berpengalaman 10+ tahun di industri software development. Pernah bekerja di berbagai startup unicorn Indonesia.', 'JavaScript, React, Node.js, Python', 3, 150, 4.85, 1)
ON DUPLICATE KEY UPDATE bio = VALUES(bio);

INSERT INTO `lecturer_profiles` (`lecturer_id`, `bio`, `expertise`, `total_courses`, `total_students`, `avg_rating`, `is_verified`) VALUES
(3, 'PhD in Computer Science, specializing in Machine Learning and Artificial Intelligence.', 'Python, Machine Learning, Deep Learning, Data Analysis', 2, 89, 4.92, 1)
ON DUPLICATE KEY UPDATE bio = VALUES(bio);

INSERT INTO `lecturer_profiles` (`lecturer_id`, `bio`, `expertise`, `total_courses`, `total_students`, `avg_rating`, `is_verified`) VALUES
(4, 'AWS Certified Solutions Architect. 8 tahun pengalaman di cloud computing.', 'AWS, GCP, Docker, Kubernetes, DevOps', 2, 75, 4.78, 1)
ON DUPLICATE KEY UPDATE bio = VALUES(bio);

-- --------------------------------------------------------
-- Student Profiles
-- --------------------------------------------------------
INSERT INTO `student_profiles` (`student_id`, `institution`, `level`, `total_courses_enrolled`, `total_courses_completed`, `total_certificates`) VALUES
(5, 'Universitas Indonesia', 'INTERMEDIATE', 4, 2, 2)
ON DUPLICATE KEY UPDATE institution = VALUES(institution);

INSERT INTO `student_profiles` (`student_id`, `institution`, `level`, `total_courses_enrolled`, `total_courses_completed`, `total_certificates`) VALUES
(6, 'Institut Teknologi Bandung', 'BEGINNER', 2, 1, 1)
ON DUPLICATE KEY UPDATE institution = VALUES(institution);

INSERT INTO `student_profiles` (`student_id`, `institution`, `level`, `total_courses_enrolled`, `total_courses_completed`, `total_certificates`) VALUES
(7, 'Universitas Gadjah Mada', 'BEGINNER', 3, 0, 0)
ON DUPLICATE KEY UPDATE institution = VALUES(institution);

INSERT INTO `student_profiles` (`student_id`, `institution`, `level`, `total_courses_enrolled`, `total_courses_completed`, `total_certificates`) VALUES
(8, 'Telkom University', 'INTERMEDIATE', 5, 3, 3)
ON DUPLICATE KEY UPDATE institution = VALUES(institution);

INSERT INTO `student_profiles` (`student_id`, `institution`, `level`, `total_courses_enrolled`, `total_courses_completed`, `total_certificates`) VALUES
(9, 'Bina Nusantara University', 'BEGINNER', 1, 0, 0)
ON DUPLICATE KEY UPDATE institution = VALUES(institution);

-- --------------------------------------------------------
-- Sample Courses
-- --------------------------------------------------------

-- Course 1: Web Development Fundamentals
INSERT INTO `courses` (`course_id`, `lecturer_id`, `category_id`, `title`, `slug`, `description`, `short_description`, `thumbnail`, `price`, `discount_price`, `level`, `language`, `duration_hours`, `total_sections`, `total_materials`, `total_students`, `avg_rating`, `total_reviews`, `requirements`, `objectives`, `target_audience`, `status`, `is_featured`, `is_free`, `created_at`, `published_at`) VALUES
(1, 2, 1, 'Belajar HTML, CSS, dan JavaScript dari Nol', 'belajar-html-css-javascript-dari-nol', 
'Kursus ini dirancang khusus untuk pemula yang ingin memulai karir di bidang web development.',
'Pelajari dasar-dasar web development dengan HTML, CSS, dan JavaScript.',
'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=800&h=450&fit=crop',
199000.00, 149000.00, 'BEGINNER', 'Bahasa Indonesia', 12, 5, 25, 85, 4.75, 42,
'Komputer dengan koneksi internet\nBrowser modern\nText editor',
'Memahami struktur dasar HTML\nMampu styling dengan CSS\nMembuat website responsif',
'Pemula yang ingin belajar web development\nMahasiswa IT',
'PUBLISHED', 1, 0, DATE_SUB(NOW(), INTERVAL 30 DAY), DATE_SUB(NOW(), INTERVAL 28 DAY))
ON DUPLICATE KEY UPDATE title = VALUES(title);

-- Course 2: React JS Masterclass
INSERT INTO `courses` (`course_id`, `lecturer_id`, `category_id`, `title`, `slug`, `description`, `short_description`, `thumbnail`, `price`, `level`, `language`, `duration_hours`, `total_sections`, `total_materials`, `total_students`, `avg_rating`, `total_reviews`, `requirements`, `objectives`, `target_audience`, `status`, `is_featured`, `is_free`, `created_at`, `published_at`) VALUES
(2, 2, 1, 'React JS Masterclass: Membangun Aplikasi Web Modern', 'react-js-masterclass',
'Kuasai React JS, library JavaScript paling populer untuk membangun user interface.',
'Kuasai React JS dari dasar hingga mahir.',
'https://images.unsplash.com/photo-1633356122544-f134324a6cee?w=800&h=450&fit=crop',
349000.00, 'INTERMEDIATE', 'Bahasa Indonesia', 20, 8, 45, 52, 4.88, 28,
'Menguasai HTML, CSS, dan JavaScript dasar\nFamiliar dengan ES6+',
'Memahami component-based architecture\nMenguasai React Hooks\nState management dengan Redux',
'Web developer yang ingin upgrade skill\nFrontend developer',
'PUBLISHED', 1, 0, DATE_SUB(NOW(), INTERVAL 25 DAY), DATE_SUB(NOW(), INTERVAL 23 DAY))
ON DUPLICATE KEY UPDATE title = VALUES(title);

-- Course 3: Python for Data Science
INSERT INTO `courses` (`course_id`, `lecturer_id`, `category_id`, `title`, `slug`, `description`, `short_description`, `thumbnail`, `price`, `discount_price`, `level`, `language`, `duration_hours`, `total_sections`, `total_materials`, `total_students`, `avg_rating`, `total_reviews`, `requirements`, `objectives`, `target_audience`, `status`, `is_featured`, `is_free`, `created_at`, `published_at`) VALUES
(3, 3, 3, 'Python untuk Data Science dan Machine Learning', 'python-data-science-ml',
'Mulai perjalanan Anda di dunia Data Science dengan Python!',
'Mulai karir di Data Science dengan Python.',
'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&h=450&fit=crop',
499000.00, 399000.00, 'BEGINNER', 'Bahasa Indonesia', 25, 10, 60, 67, 4.92, 35,
'Tidak perlu pengalaman programming sebelumnya\nKomputer dengan RAM minimal 4GB',
'Menguasai Python untuk data analysis\nManipulasi data dengan pandas\nMembangun model machine learning',
'Pemula yang tertarik Data Science\nAnalyst yang ingin upgrade skill',
'PUBLISHED', 1, 0, DATE_SUB(NOW(), INTERVAL 45 DAY), DATE_SUB(NOW(), INTERVAL 42 DAY))
ON DUPLICATE KEY UPDATE title = VALUES(title);

-- Course 4: AWS Cloud Practitioner
INSERT INTO `courses` (`course_id`, `lecturer_id`, `category_id`, `title`, `slug`, `description`, `short_description`, `thumbnail`, `price`, `level`, `language`, `duration_hours`, `total_sections`, `total_materials`, `total_students`, `avg_rating`, `total_reviews`, `requirements`, `objectives`, `target_audience`, `status`, `is_featured`, `is_free`, `created_at`, `published_at`) VALUES
(4, 4, 5, 'AWS Cloud Practitioner: Panduan Lengkap', 'aws-cloud-practitioner',
'Persiapkan diri Anda untuk sertifikasi AWS Cloud Practitioner.',
'Panduan lengkap persiapan sertifikasi AWS Cloud Practitioner.',
'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&h=450&fit=crop',
299000.00, 'BEGINNER', 'Bahasa Indonesia', 15, 6, 35, 43, 4.78, 22,
'Tidak perlu pengalaman cloud sebelumnya\nPemahaman dasar tentang internet',
'Memahami konsep cloud computing\nMengenal layanan-layanan AWS\nSiap mengikuti ujian sertifikasi',
'IT professional yang ingin belajar cloud\nDeveloper yang ingin expand skill',
'PUBLISHED', 0, 0, DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 18 DAY))
ON DUPLICATE KEY UPDATE title = VALUES(title);

-- Course 5: Free JavaScript Basics
INSERT INTO `courses` (`course_id`, `lecturer_id`, `category_id`, `title`, `slug`, `description`, `short_description`, `thumbnail`, `price`, `level`, `language`, `duration_hours`, `total_sections`, `total_materials`, `total_students`, `avg_rating`, `total_reviews`, `requirements`, `objectives`, `target_audience`, `status`, `is_featured`, `is_free`, `created_at`, `published_at`) VALUES
(5, 2, 1, 'JavaScript Basics: Kursus Gratis untuk Pemula', 'javascript-basics-gratis',
'Kursus gratis untuk memulai belajar JavaScript!',
'Kursus gratis JavaScript untuk pemula.',
'https://images.unsplash.com/photo-1579468118864-1b9ea3c0db4a?w=800&h=450&fit=crop',
0.00, 'BEGINNER', 'Bahasa Indonesia', 5, 3, 15, 234, 4.65, 89,
'Komputer dengan browser modern',
'Memahami syntax JavaScript\nMembuat program sederhana',
'Pemula absolut dalam programming\nPelajar SMA/SMK',
'PUBLISHED', 1, 1, DATE_SUB(NOW(), INTERVAL 60 DAY), DATE_SUB(NOW(), INTERVAL 58 DAY))
ON DUPLICATE KEY UPDATE title = VALUES(title);

-- Course 6: Deep Learning with TensorFlow
INSERT INTO `courses` (`course_id`, `lecturer_id`, `category_id`, `title`, `slug`, `description`, `short_description`, `thumbnail`, `price`, `level`, `language`, `duration_hours`, `total_sections`, `total_materials`, `total_students`, `avg_rating`, `total_reviews`, `requirements`, `objectives`, `target_audience`, `status`, `is_featured`, `is_free`, `created_at`, `published_at`) VALUES
(6, 3, 4, 'Deep Learning dengan TensorFlow dan Keras', 'deep-learning-tensorflow',
'Kursus advanced untuk mempelajari Deep Learning menggunakan TensorFlow dan Keras.',
'Master Deep Learning dengan TensorFlow.',
'https://images.unsplash.com/photo-1555949963-aa79dcee981c?w=800&h=450&fit=crop',
599000.00, 'ADVANCED', 'Bahasa Indonesia', 30, 12, 70, 22, 4.95, 12,
'Menguasai Python\nPemahaman dasar Machine Learning',
'Membangun neural networks dari scratch\nComputer Vision dengan CNN\nNLP dengan RNN/LSTM',
'Data Scientist\nML Engineer',
'PUBLISHED', 0, 0, DATE_SUB(NOW(), INTERVAL 15 DAY), DATE_SUB(NOW(), INTERVAL 13 DAY))
ON DUPLICATE KEY UPDATE title = VALUES(title);

-- --------------------------------------------------------
-- Sample Sections for Course 1
-- --------------------------------------------------------
INSERT INTO `sections` (`section_id`, `course_id`, `title`, `description`, `display_order`, `is_preview`, `created_at`) VALUES
(1, 1, 'Pengenalan Web Development', 'Memahami dasar-dasar web', 1, 1, NOW())
ON DUPLICATE KEY UPDATE title = VALUES(title);

INSERT INTO `sections` (`section_id`, `course_id`, `title`, `description`, `display_order`, `is_preview`, `created_at`) VALUES
(2, 1, 'HTML Fundamentals', 'Belajar struktur dasar HTML', 2, 0, NOW())
ON DUPLICATE KEY UPDATE title = VALUES(title);

INSERT INTO `sections` (`section_id`, `course_id`, `title`, `description`, `display_order`, `is_preview`, `created_at`) VALUES
(3, 1, 'CSS Styling', 'Mendesain tampilan website dengan CSS', 3, 0, NOW())
ON DUPLICATE KEY UPDATE title = VALUES(title);

INSERT INTO `sections` (`section_id`, `course_id`, `title`, `description`, `display_order`, `is_preview`, `created_at`) VALUES
(4, 1, 'JavaScript Dasar', 'Menambahkan interaktivitas', 4, 0, NOW())
ON DUPLICATE KEY UPDATE title = VALUES(title);

INSERT INTO `sections` (`section_id`, `course_id`, `title`, `description`, `display_order`, `is_preview`, `created_at`) VALUES
(5, 1, 'Project Akhir', 'Membangun website portfolio', 5, 0, NOW())
ON DUPLICATE KEY UPDATE title = VALUES(title);

-- Sections for Course 5 (Free JavaScript)
INSERT INTO `sections` (`section_id`, `course_id`, `title`, `description`, `display_order`, `is_preview`, `created_at`) VALUES
(6, 5, 'Memulai JavaScript', 'Pengenalan dan setup', 1, 1, NOW())
ON DUPLICATE KEY UPDATE title = VALUES(title);

INSERT INTO `sections` (`section_id`, `course_id`, `title`, `description`, `display_order`, `is_preview`, `created_at`) VALUES
(7, 5, 'Variabel dan Tipe Data', 'Belajar variabel, string, number', 2, 0, NOW())
ON DUPLICATE KEY UPDATE title = VALUES(title);

INSERT INTO `sections` (`section_id`, `course_id`, `title`, `description`, `display_order`, `is_preview`, `created_at`) VALUES
(8, 5, 'Functions dan Control Flow', 'Functions, if-else, loops', 3, 0, NOW())
ON DUPLICATE KEY UPDATE title = VALUES(title);

-- --------------------------------------------------------
-- Sample Materials
-- --------------------------------------------------------
INSERT INTO `materials` (`material_id`, `section_id`, `title`, `content_type`, `content`, `video_url`, `video_duration`, `display_order`, `is_preview`, `is_mandatory`, `created_at`) VALUES
(1, 1, 'Apa itu Web Development?', 'VIDEO', 'Pengenalan web development', 'https://www.youtube.com/watch?v=demo1', 600, 1, 1, 1, NOW())
ON DUPLICATE KEY UPDATE title = VALUES(title);

INSERT INTO `materials` (`material_id`, `section_id`, `title`, `content_type`, `content`, `video_url`, `video_duration`, `display_order`, `is_preview`, `is_mandatory`, `created_at`) VALUES
(2, 1, 'Cara Kerja Website', 'VIDEO', 'Bagaimana website bekerja', 'https://www.youtube.com/watch?v=demo2', 480, 2, 1, 1, NOW())
ON DUPLICATE KEY UPDATE title = VALUES(title);

INSERT INTO `materials` (`material_id`, `section_id`, `title`, `content_type`, `content`, `video_url`, `video_duration`, `display_order`, `is_preview`, `is_mandatory`, `created_at`) VALUES
(3, 1, 'Tools yang Dibutuhkan', 'TEXT', '<h2>Tools untuk Web Development</h2><p>Text Editor: VS Code</p><p>Browser: Chrome</p>', NULL, 0, 3, 0, 1, NOW())
ON DUPLICATE KEY UPDATE title = VALUES(title);

INSERT INTO `materials` (`material_id`, `section_id`, `title`, `content_type`, `content`, `video_url`, `video_duration`, `display_order`, `is_preview`, `is_mandatory`, `created_at`) VALUES
(4, 2, 'Struktur Dasar HTML', 'VIDEO', 'Belajar DOCTYPE, html, head, body', 'https://www.youtube.com/watch?v=demo3', 540, 1, 0, 1, NOW())
ON DUPLICATE KEY UPDATE title = VALUES(title);

INSERT INTO `materials` (`material_id`, `section_id`, `title`, `content_type`, `content`, `video_url`, `video_duration`, `display_order`, `is_preview`, `is_mandatory`, `created_at`) VALUES
(5, 2, 'Tag-tag HTML Penting', 'VIDEO', 'Heading, paragraph, link, image', 'https://www.youtube.com/watch?v=demo4', 720, 2, 0, 1, NOW())
ON DUPLICATE KEY UPDATE title = VALUES(title);

INSERT INTO `materials` (`material_id`, `section_id`, `title`, `content_type`, `content`, `video_url`, `video_duration`, `display_order`, `is_preview`, `is_mandatory`, `created_at`) VALUES
(6, 6, 'Apa itu JavaScript?', 'VIDEO', 'Pengenalan JavaScript', 'https://www.youtube.com/watch?v=jsdemo1', 480, 1, 1, 1, NOW())
ON DUPLICATE KEY UPDATE title = VALUES(title);

INSERT INTO `materials` (`material_id`, `section_id`, `title`, `content_type`, `content`, `video_url`, `video_duration`, `display_order`, `is_preview`, `is_mandatory`, `created_at`) VALUES
(7, 6, 'Hello World!', 'VIDEO', 'Program JavaScript pertama', 'https://www.youtube.com/watch?v=jsdemo2', 300, 2, 0, 1, NOW())
ON DUPLICATE KEY UPDATE title = VALUES(title);

-- --------------------------------------------------------
-- Sample Enrollments
-- --------------------------------------------------------
INSERT INTO `enrollments` (`enrollment_id`, `student_id`, `course_id`, `enrolled_at`, `progress_percentage`, `last_accessed_at`, `completed_at`, `certificate_issued`, `status`) VALUES
(1, 5, 1, DATE_SUB(NOW(), INTERVAL 20 DAY), 100.00, NOW(), DATE_SUB(NOW(), INTERVAL 5 DAY), 1, 'COMPLETED')
ON DUPLICATE KEY UPDATE progress_percentage = VALUES(progress_percentage);

INSERT INTO `enrollments` (`enrollment_id`, `student_id`, `course_id`, `enrolled_at`, `progress_percentage`, `last_accessed_at`, `status`) VALUES
(2, 5, 2, DATE_SUB(NOW(), INTERVAL 15 DAY), 45.00, NOW(), 'ACTIVE')
ON DUPLICATE KEY UPDATE progress_percentage = VALUES(progress_percentage);

INSERT INTO `enrollments` (`enrollment_id`, `student_id`, `course_id`, `enrolled_at`, `progress_percentage`, `last_accessed_at`, `status`) VALUES
(3, 5, 5, DATE_SUB(NOW(), INTERVAL 25 DAY), 80.00, NOW(), 'ACTIVE')
ON DUPLICATE KEY UPDATE progress_percentage = VALUES(progress_percentage);

INSERT INTO `enrollments` (`enrollment_id`, `student_id`, `course_id`, `enrolled_at`, `progress_percentage`, `last_accessed_at`, `completed_at`, `certificate_issued`, `status`) VALUES
(4, 6, 1, DATE_SUB(NOW(), INTERVAL 18 DAY), 100.00, NOW(), DATE_SUB(NOW(), INTERVAL 4 DAY), 1, 'COMPLETED')
ON DUPLICATE KEY UPDATE progress_percentage = VALUES(progress_percentage);

INSERT INTO `enrollments` (`enrollment_id`, `student_id`, `course_id`, `enrolled_at`, `progress_percentage`, `last_accessed_at`, `status`) VALUES
(5, 6, 5, DATE_SUB(NOW(), INTERVAL 12 DAY), 60.00, NOW(), 'ACTIVE')
ON DUPLICATE KEY UPDATE progress_percentage = VALUES(progress_percentage);

INSERT INTO `enrollments` (`enrollment_id`, `student_id`, `course_id`, `enrolled_at`, `progress_percentage`, `last_accessed_at`, `status`) VALUES
(6, 7, 1, DATE_SUB(NOW(), INTERVAL 8 DAY), 30.00, NOW(), 'ACTIVE')
ON DUPLICATE KEY UPDATE progress_percentage = VALUES(progress_percentage);

INSERT INTO `enrollments` (`enrollment_id`, `student_id`, `course_id`, `enrolled_at`, `progress_percentage`, `last_accessed_at`, `status`) VALUES
(7, 8, 3, DATE_SUB(NOW(), INTERVAL 10 DAY), 70.00, NOW(), 'ACTIVE')
ON DUPLICATE KEY UPDATE progress_percentage = VALUES(progress_percentage);

-- --------------------------------------------------------
-- Sample Reviews
-- --------------------------------------------------------
INSERT INTO `reviews` (`review_id`, `course_id`, `student_id`, `rating`, `review_text`, `is_approved`, `helpful_count`, `created_at`) VALUES
(1, 1, 5, 5, 'Kursus yang sangat bagus untuk pemula! Penjelasannya mudah dipahami.', 1, 15, NOW())
ON DUPLICATE KEY UPDATE review_text = VALUES(review_text);

INSERT INTO `reviews` (`review_id`, `course_id`, `student_id`, `rating`, `review_text`, `is_approved`, `helpful_count`, `created_at`) VALUES
(2, 1, 6, 5, 'Recommended banget! Setelah kursus ini saya dapat kerja sebagai web developer.', 1, 23, NOW())
ON DUPLICATE KEY UPDATE review_text = VALUES(review_text);

INSERT INTO `reviews` (`review_id`, `course_id`, `student_id`, `rating`, `review_text`, `is_approved`, `helpful_count`, `created_at`) VALUES
(3, 5, 7, 4, 'Bagus untuk yang baru mulai belajar coding. Gratis pula!', 1, 45, NOW())
ON DUPLICATE KEY UPDATE review_text = VALUES(review_text);

-- --------------------------------------------------------
-- Sample Forums
-- --------------------------------------------------------
INSERT INTO `forums` (`forum_id`, `course_id`, `title`, `description`, `created_at`) VALUES
(1, 1, 'Forum Diskusi: HTML, CSS, JavaScript', 'Tempat diskusi seputar kursus', NOW())
ON DUPLICATE KEY UPDATE title = VALUES(title);

INSERT INTO `forums` (`forum_id`, `course_id`, `title`, `description`, `created_at`) VALUES
(2, 5, 'Forum Diskusi: JavaScript Basics', 'Diskusi JavaScript dasar', NOW())
ON DUPLICATE KEY UPDATE title = VALUES(title);

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

-- Update course statistics
UPDATE courses c SET 
    total_sections = (SELECT COUNT(*) FROM sections s WHERE s.course_id = c.course_id),
    total_materials = (SELECT COUNT(*) FROM materials m JOIN sections s ON m.section_id = s.section_id WHERE s.course_id = c.course_id)
WHERE c.course_id IN (1, 2, 3, 4, 5, 6);

SELECT 'Sample data berhasil diimport!' AS status;
