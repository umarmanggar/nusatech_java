-- Sample Data for NusaTech Learning Platform
-- Run this after nusatech.sql to populate the database with test data

USE nusatech;

-- --------------------------------------------------------
-- Sample Users (Password: password123 - using SHA-256 hash with salt)
-- Note: In production, use proper password hashing
-- --------------------------------------------------------

-- Admin already exists (user_id = 1)

-- Lecturers
INSERT INTO `users` (`user_id`, `email`, `password`, `name`, `phone`, `profile_picture`, `role`, `balance`, `is_active`, `email_verified`, `created_at`) VALUES
(2, 'budi.lecturer@nusatech.id', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Budi Santoso', '081234567890', 'default-avatar.png', 'LECTURER', '2500000.00', 1, 1, NOW()),
(3, 'siti.lecturer@nusatech.id', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Siti Rahayu', '081234567891', 'default-avatar.png', 'LECTURER', '1800000.00', 1, 1, NOW()),
(4, 'ahmad.lecturer@nusatech.id', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Ahmad Fauzi', '081234567892', 'default-avatar.png', 'LECTURER', '3200000.00', 1, 1, NOW());

-- Students
INSERT INTO `users` (`user_id`, `email`, `password`, `name`, `phone`, `profile_picture`, `role`, `balance`, `is_active`, `email_verified`, `created_at`) VALUES
(5, 'dewi.student@gmail.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Dewi Lestari', '081345678901', 'default-avatar.png', 'STUDENT', '0.00', 1, 1, NOW()),
(6, 'andi.student@gmail.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Andi Wijaya', '081345678902', 'default-avatar.png', 'STUDENT', '0.00', 1, 1, NOW()),
(7, 'maya.student@gmail.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Maya Putri', '081345678903', 'default-avatar.png', 'STUDENT', '0.00', 1, 1, NOW()),
(8, 'reza.student@gmail.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Reza Pratama', '081345678904', 'default-avatar.png', 'STUDENT', '0.00', 1, 1, NOW()),
(9, 'nina.student@gmail.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Nina Kusuma', '081345678905', 'default-avatar.png', 'STUDENT', '0.00', 1, 1, NOW());

-- Lecturer Profiles
INSERT INTO `lecturer_profiles` (`lecturer_id`, `headline`, `bio`, `expertise`, `total_courses`, `total_students`, `avg_rating`) VALUES
(2, 'Senior Full-Stack Developer', 'Berpengalaman 10+ tahun di industri software development. Pernah bekerja di berbagai startup unicorn Indonesia.', 'JavaScript, React, Node.js, Python', 3, 150, 4.85),
(3, 'Data Scientist & AI Specialist', 'PhD in Computer Science, specializing in Machine Learning and Artificial Intelligence.', 'Python, Machine Learning, Deep Learning, Data Analysis', 2, 89, 4.92),
(4, 'Cloud Architecture Expert', 'AWS Certified Solutions Architect. 8 tahun pengalaman di cloud computing.', 'AWS, GCP, Docker, Kubernetes, DevOps', 2, 75, 4.78);

-- Student Profiles
INSERT INTO `student_profiles` (`student_id`, `institution`, `level`, `total_courses_enrolled`, `total_courses_completed`, `total_certificates`) VALUES
(5, 'Universitas Indonesia', 'INTERMEDIATE', 4, 2, 2),
(6, 'Institut Teknologi Bandung', 'BEGINNER', 2, 1, 1),
(7, 'Universitas Gadjah Mada', 'BEGINNER', 3, 0, 0),
(8, 'Telkom University', 'INTERMEDIATE', 5, 3, 3),
(9, 'Bina Nusantara University', 'BEGINNER', 1, 0, 0);

-- --------------------------------------------------------
-- Sample Courses
-- --------------------------------------------------------

INSERT INTO `courses` (`course_id`, `lecturer_id`, `category_id`, `title`, `slug`, `description`, `short_description`, `thumbnail`, `preview_video`, `price`, `discount_price`, `level`, `language`, `duration_hours`, `total_sections`, `total_materials`, `total_students`, `avg_rating`, `total_reviews`, `requirements`, `objectives`, `target_audience`, `status`, `is_featured`, `is_free`, `created_at`, `published_at`) VALUES

-- Course 1: Web Development Fundamentals
(1, 2, 1, 'Belajar HTML, CSS, dan JavaScript dari Nol', 'belajar-html-css-javascript-dari-nol', 
'Kursus ini dirancang khusus untuk pemula yang ingin memulai karir di bidang web development. Anda akan belajar dasar-dasar HTML untuk struktur halaman, CSS untuk styling, dan JavaScript untuk interaktivitas.\n\nSetelah menyelesaikan kursus ini, Anda akan mampu membuat website sederhana yang responsif dan interaktif.',
'Pelajari dasar-dasar web development dengan HTML, CSS, dan JavaScript. Cocok untuk pemula yang ingin memulai karir sebagai web developer.',
'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=800&h=450&fit=crop',
'https://www.youtube.com/watch?v=example1',
199000.00, 149000.00, 'BEGINNER', 'Bahasa Indonesia', 12, 5, 25, 85, 4.75, 42,
'- Komputer dengan koneksi internet\n- Browser modern (Chrome/Firefox/Edge)\n- Text editor (VS Code direkomendasikan)',
'- Memahami struktur dasar HTML\n- Mampu styling dengan CSS\n- Membuat website responsif\n- Menambahkan interaktivitas dengan JavaScript\n- Deploy website ke internet',
'- Pemula yang ingin belajar web development\n- Mahasiswa IT\n- Profesional yang ingin switch career',
'PUBLISHED', 1, 0, DATE_SUB(NOW(), INTERVAL 30 DAY), DATE_SUB(NOW(), INTERVAL 28 DAY)),

-- Course 2: React JS Masterclass
(2, 2, 1, 'React JS Masterclass: Membangun Aplikasi Web Modern', 'react-js-masterclass',
'Kuasai React JS, library JavaScript paling populer untuk membangun user interface. Dalam kursus ini, Anda akan belajar dari konsep dasar hingga advanced patterns yang digunakan di industri.\n\nKursus ini mencakup React Hooks, Context API, Redux, React Router, dan best practices untuk development skala enterprise.',
'Kuasai React JS dari dasar hingga mahir. Belajar membangun aplikasi web modern dengan library JavaScript paling populer.',
'https://images.unsplash.com/photo-1633356122544-f134324a6cee?w=800&h=450&fit=crop',
NULL,
349000.00, NULL, 'INTERMEDIATE', 'Bahasa Indonesia', 20, 8, 45, 52, 4.88, 28,
'- Menguasai HTML, CSS, dan JavaScript dasar\n- Familiar dengan ES6+ syntax\n- Node.js terinstall',
'- Memahami component-based architecture\n- Menguasai React Hooks\n- State management dengan Redux\n- Routing dengan React Router\n- Testing aplikasi React\n- Deploy ke Vercel/Netlify',
'- Web developer yang ingin upgrade skill\n- Frontend developer\n- Programmer yang ingin belajar React',
'PUBLISHED', 1, 0, DATE_SUB(NOW(), INTERVAL 25 DAY), DATE_SUB(NOW(), INTERVAL 23 DAY)),

-- Course 3: Python for Data Science
(3, 3, 3, 'Python untuk Data Science dan Machine Learning', 'python-data-science-ml',
'Mulai perjalanan Anda di dunia Data Science dengan Python! Kursus komprehensif ini akan membawa Anda dari pemula hingga siap bekerja sebagai data scientist.\n\nAnda akan belajar Python, pandas, NumPy, Matplotlib, Scikit-learn, dan dasar-dasar machine learning.',
'Mulai karir di Data Science dengan Python. Belajar analisis data, visualisasi, dan machine learning dari dasar.',
'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&h=450&fit=crop',
'https://www.youtube.com/watch?v=example2',
499000.00, 399000.00, 'BEGINNER', 'Bahasa Indonesia', 25, 10, 60, 67, 4.92, 35,
'- Tidak perlu pengalaman programming sebelumnya\n- Komputer dengan RAM minimal 4GB\n- Kemauan belajar yang tinggi',
'- Menguasai Python untuk data analysis\n- Manipulasi data dengan pandas\n- Visualisasi dengan Matplotlib dan Seaborn\n- Membangun model machine learning\n- Project portofolio nyata',
'- Pemula yang tertarik Data Science\n- Analyst yang ingin upgrade skill\n- Programmer yang ingin belajar ML',
'PUBLISHED', 1, 0, DATE_SUB(NOW(), INTERVAL 45 DAY), DATE_SUB(NOW(), INTERVAL 42 DAY)),

-- Course 4: AWS Cloud Practitioner
(4, 4, 5, 'AWS Cloud Practitioner: Panduan Lengkap', 'aws-cloud-practitioner',
'Persiapkan diri Anda untuk sertifikasi AWS Cloud Practitioner dengan kursus komprehensif ini. Anda akan mempelajari fundamental cloud computing dan services AWS yang essential.\n\nKursus ini cocok untuk pemula di cloud computing dan akan mempersiapkan Anda untuk ujian sertifikasi.',
'Panduan lengkap persiapan sertifikasi AWS Cloud Practitioner. Pelajari fundamental cloud computing dan AWS.',
'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&h=450&fit=crop',
NULL,
299000.00, NULL, 'BEGINNER', 'Bahasa Indonesia', 15, 6, 35, 43, 4.78, 22,
'- Tidak perlu pengalaman cloud sebelumnya\n- Pemahaman dasar tentang internet dan networking\n- Akun AWS Free Tier',
'- Memahami konsep cloud computing\n- Mengenal layanan-layanan AWS\n- Praktik hands-on dengan AWS\n- Siap mengikuti ujian sertifikasi\n- Memahami pricing dan support AWS',
'- IT professional yang ingin belajar cloud\n- Developer yang ingin expand skill\n- Fresh graduate di bidang IT',
'PUBLISHED', 0, 0, DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 18 DAY)),

-- Course 5: Free JavaScript Basics
(5, 2, 1, 'JavaScript Basics: Kursus Gratis untuk Pemula', 'javascript-basics-gratis',
'Kursus gratis untuk memulai belajar JavaScript! Ideal untuk pemula yang ingin mencoba programming tanpa biaya.\n\nAnda akan belajar syntax dasar, variabel, fungsi, dan konsep programming fundamental.',
'Kursus gratis JavaScript untuk pemula. Mulai belajar programming tanpa biaya!',
'https://images.unsplash.com/photo-1579468118864-1b9ea3c0db4a?w=800&h=450&fit=crop',
NULL,
0.00, NULL, 'BEGINNER', 'Bahasa Indonesia', 5, 3, 15, 234, 4.65, 89,
'- Komputer dengan browser modern\n- Tidak perlu pengalaman programming',
'- Memahami syntax JavaScript\n- Membuat program sederhana\n- Fondasi untuk belajar framework',
'- Pemula absolut dalam programming\n- Pelajar SMA/SMK\n- Siapapun yang ingin mencoba coding',
'PUBLISHED', 1, 1, DATE_SUB(NOW(), INTERVAL 60 DAY), DATE_SUB(NOW(), INTERVAL 58 DAY)),

-- Course 6: Deep Learning with TensorFlow
(6, 3, 4, 'Deep Learning dengan TensorFlow dan Keras', 'deep-learning-tensorflow',
'Kursus advanced untuk mempelajari Deep Learning menggunakan TensorFlow dan Keras. Cocok untuk yang sudah memahami dasar Machine Learning.\n\nTopik meliputi CNN, RNN, LSTM, Transfer Learning, dan deployment model.',
'Master Deep Learning dengan TensorFlow. Bangun neural networks untuk computer vision dan NLP.',
'https://images.unsplash.com/photo-1555949963-aa79dcee981c?w=800&h=450&fit=crop',
NULL,
599000.00, NULL, 'ADVANCED', 'Bahasa Indonesia', 30, 12, 70, 22, 4.95, 12,
'- Menguasai Python\n- Pemahaman dasar Machine Learning\n- Familiar dengan NumPy dan pandas\n- GPU untuk training (opsional)',
'- Membangun neural networks dari scratch\n- Computer Vision dengan CNN\n- NLP dengan RNN/LSTM\n- Transfer Learning\n- Deploy model ke production',
'- Data Scientist\n- ML Engineer\n- Researcher yang butuh deep learning',
'PUBLISHED', 0, 0, DATE_SUB(NOW(), INTERVAL 15 DAY), DATE_SUB(NOW(), INTERVAL 13 DAY)),

-- Course 7: Docker & Kubernetes (Draft)
(7, 4, 7, 'Docker dan Kubernetes untuk DevOps', 'docker-kubernetes-devops',
'Pelajari containerization dengan Docker dan orchestration dengan Kubernetes. Kursus praktis untuk DevOps engineer.\n\nMasih dalam pengembangan - coming soon!',
'Master Docker dan Kubernetes untuk modern DevOps practices.',
'https://images.unsplash.com/photo-1605745341112-85968b19335b?w=800&h=450&fit=crop',
NULL,
449000.00, NULL, 'INTERMEDIATE', 'Bahasa Indonesia', 18, 0, 0, 0, 0.00, 0,
'- Familiar dengan Linux command line\n- Pemahaman dasar networking\n- Cloud account (AWS/GCP)',
'- Containerization dengan Docker\n- Kubernetes fundamentals\n- CI/CD pipelines\n- Monitoring dan logging',
'- DevOps Engineer\n- Backend Developer\n- System Administrator',
'DRAFT', 0, 0, DATE_SUB(NOW(), INTERVAL 5 DAY), NULL);

-- --------------------------------------------------------
-- Sample Sections for Course 1 (HTML, CSS, JavaScript)
-- --------------------------------------------------------

INSERT INTO `sections` (`section_id`, `course_id`, `title`, `description`, `display_order`, `is_preview`, `created_at`) VALUES
(1, 1, 'Pengenalan Web Development', 'Memahami dasar-dasar web dan bagaimana website bekerja', 1, 1, NOW()),
(2, 1, 'HTML Fundamentals', 'Belajar struktur dasar HTML dan tag-tag penting', 2, 0, NOW()),
(3, 1, 'CSS Styling', 'Mendesain tampilan website dengan CSS', 3, 0, NOW()),
(4, 1, 'JavaScript Dasar', 'Menambahkan interaktivitas dengan JavaScript', 4, 0, NOW()),
(5, 1, 'Project Akhir', 'Membangun website portfolio lengkap', 5, 0, NOW());

-- Sections for Course 2 (React)
INSERT INTO `sections` (`section_id`, `course_id`, `title`, `description`, `display_order`, `is_preview`, `created_at`) VALUES
(6, 2, 'Introduction to React', 'Mengenal React dan ekosistemnya', 1, 1, NOW()),
(7, 2, 'Components & Props', 'Membangun UI dengan components', 2, 0, NOW()),
(8, 2, 'State & Lifecycle', 'Mengelola state dalam React', 3, 0, NOW()),
(9, 2, 'React Hooks', 'Modern React dengan Hooks API', 4, 0, NOW()),
(10, 2, 'Context & Redux', 'Global state management', 5, 0, NOW()),
(11, 2, 'React Router', 'Client-side routing', 6, 0, NOW()),
(12, 2, 'Testing React Apps', 'Unit dan integration testing', 7, 0, NOW()),
(13, 2, 'Deployment', 'Deploy aplikasi React ke production', 8, 0, NOW());

-- Sections for Course 3 (Python Data Science)
INSERT INTO `sections` (`section_id`, `course_id`, `title`, `description`, `display_order`, `is_preview`, `created_at`) VALUES
(14, 3, 'Python Fundamentals', 'Dasar-dasar programming Python', 1, 1, NOW()),
(15, 3, 'NumPy Essentials', 'Numerical computing dengan NumPy', 2, 0, NOW()),
(16, 3, 'Pandas for Data Analysis', 'Manipulasi dan analisis data', 3, 0, NOW()),
(17, 3, 'Data Visualization', 'Visualisasi dengan Matplotlib dan Seaborn', 4, 0, NOW()),
(18, 3, 'Introduction to ML', 'Konsep dasar Machine Learning', 5, 0, NOW()),
(19, 3, 'Supervised Learning', 'Classification dan Regression', 6, 0, NOW()),
(20, 3, 'Unsupervised Learning', 'Clustering dan Dimensionality Reduction', 7, 0, NOW()),
(21, 3, 'Model Evaluation', 'Evaluasi dan tuning model', 8, 0, NOW()),
(22, 3, 'Feature Engineering', 'Teknik feature engineering', 9, 0, NOW()),
(23, 3, 'Capstone Project', 'End-to-end data science project', 10, 0, NOW());

-- --------------------------------------------------------
-- Sample Materials for Section 1 (Course 1)
-- --------------------------------------------------------

INSERT INTO `materials` (`material_id`, `section_id`, `title`, `content_type`, `content`, `video_url`, `video_duration`, `attachment_url`, `display_order`, `is_preview`, `is_mandatory`, `created_at`) VALUES
(1, 1, 'Apa itu Web Development?', 'VIDEO', 'Dalam video ini, kita akan membahas apa itu web development dan mengapa skill ini sangat dibutuhkan di era digital.', 'https://www.youtube.com/watch?v=demo1', 600, NULL, 1, 1, 1, NOW()),
(2, 1, 'Cara Kerja Website', 'VIDEO', 'Pelajari bagaimana website bekerja: dari browser request hingga server response.', 'https://www.youtube.com/watch?v=demo2', 480, NULL, 2, 1, 1, NOW()),
(3, 1, 'Tools yang Dibutuhkan', 'TEXT', '<h2>Tools untuk Web Development</h2><p>Berikut adalah tools yang perlu Anda siapkan:</p><ul><li>Text Editor: VS Code (recommended)</li><li>Browser: Chrome dengan DevTools</li><li>Git untuk version control</li></ul>', NULL, 0, NULL, 3, 0, 1, NOW()),
(4, 1, 'Quiz: Pengenalan Web', 'QUIZ', NULL, NULL, 0, NULL, 4, 0, 1, NOW()),
(5, 1, 'Setup Environment', 'VIDEO', 'Tutorial instalasi VS Code dan extension yang dibutuhkan.', 'https://www.youtube.com/watch?v=demo3', 720, NULL, 5, 0, 1, NOW());

-- Materials for Section 2 (HTML)
INSERT INTO `materials` (`material_id`, `section_id`, `title`, `content_type`, `content`, `video_url`, `video_duration`, `attachment_url`, `display_order`, `is_preview`, `is_mandatory`, `created_at`) VALUES
(6, 2, 'Struktur Dasar HTML', 'VIDEO', 'Memahami struktur dasar dokumen HTML: DOCTYPE, html, head, body.', 'https://www.youtube.com/watch?v=demo4', 540, NULL, 1, 0, 1, NOW()),
(7, 2, 'Tag-tag Penting HTML', 'VIDEO', 'Belajar tag heading, paragraph, link, image, dan lainnya.', 'https://www.youtube.com/watch?v=demo5', 900, NULL, 2, 0, 1, NOW()),
(8, 2, 'Forms dan Input', 'VIDEO', 'Membuat form untuk interaksi user.', 'https://www.youtube.com/watch?v=demo6', 660, NULL, 3, 0, 1, NOW()),
(9, 2, 'Semantic HTML', 'TEXT', '<h2>Semantic HTML5</h2><p>Semantic HTML memberikan makna pada konten. Gunakan tag seperti header, nav, main, article, section, aside, footer.</p>', NULL, 0, NULL, 4, 0, 1, NOW()),
(10, 2, 'Practice: Membuat Halaman Profile', 'PROJECT', 'Buat halaman profile sederhana menggunakan tag HTML yang sudah dipelajari.', NULL, 0, NULL, 5, 0, 1, NOW());

-- Materials for Course 5 (Free JavaScript - Section would need to be created)
INSERT INTO `sections` (`section_id`, `course_id`, `title`, `description`, `display_order`, `is_preview`, `created_at`) VALUES
(24, 5, 'Memulai JavaScript', 'Pengenalan dan setup JavaScript', 1, 1, NOW()),
(25, 5, 'Variabel dan Tipe Data', 'Belajar variabel, string, number, boolean', 2, 0, NOW()),
(26, 5, 'Functions dan Control Flow', 'Functions, if-else, loops', 3, 0, NOW());

INSERT INTO `materials` (`material_id`, `section_id`, `title`, `content_type`, `content`, `video_url`, `video_duration`, `attachment_url`, `display_order`, `is_preview`, `is_mandatory`, `created_at`) VALUES
(11, 24, 'Apa itu JavaScript?', 'VIDEO', 'Pengenalan JavaScript dan mengapa penting untuk web development.', 'https://www.youtube.com/watch?v=jsdemo1', 480, NULL, 1, 1, 1, NOW()),
(12, 24, 'JavaScript di Browser', 'VIDEO', 'Cara menjalankan JavaScript di browser menggunakan console.', 'https://www.youtube.com/watch?v=jsdemo2', 360, NULL, 2, 1, 1, NOW()),
(13, 24, 'Hello World!', 'VIDEO', 'Membuat program JavaScript pertama Anda.', 'https://www.youtube.com/watch?v=jsdemo3', 300, NULL, 3, 0, 1, NOW()),
(14, 25, 'Variabel: let, const, var', 'VIDEO', 'Memahami perbedaan let, const, dan var.', 'https://www.youtube.com/watch?v=jsdemo4', 540, NULL, 1, 0, 1, NOW()),
(15, 25, 'Tipe Data di JavaScript', 'VIDEO', 'String, Number, Boolean, null, undefined, object.', 'https://www.youtube.com/watch?v=jsdemo5', 600, NULL, 2, 0, 1, NOW());

-- --------------------------------------------------------
-- Sample Enrollments
-- --------------------------------------------------------

INSERT INTO `enrollments` (`enrollment_id`, `student_id`, `course_id`, `enrolled_at`, `progress_percentage`, `last_accessed_at`, `completed_at`, `certificate_issued`, `status`) VALUES
(1, 5, 1, DATE_SUB(NOW(), INTERVAL 20 DAY), 100.00, DATE_SUB(NOW(), INTERVAL 2 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY), 1, 'COMPLETED'),
(2, 5, 2, DATE_SUB(NOW(), INTERVAL 15 DAY), 45.00, DATE_SUB(NOW(), INTERVAL 1 DAY), NULL, 0, 'ACTIVE'),
(3, 5, 3, DATE_SUB(NOW(), INTERVAL 10 DAY), 100.00, DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 3 DAY), 1, 'COMPLETED'),
(4, 5, 5, DATE_SUB(NOW(), INTERVAL 25 DAY), 80.00, DATE_SUB(NOW(), INTERVAL 5 DAY), NULL, 0, 'ACTIVE'),
(5, 6, 1, DATE_SUB(NOW(), INTERVAL 18 DAY), 100.00, DATE_SUB(NOW(), INTERVAL 4 DAY), DATE_SUB(NOW(), INTERVAL 4 DAY), 1, 'COMPLETED'),
(6, 6, 5, DATE_SUB(NOW(), INTERVAL 12 DAY), 60.00, DATE_SUB(NOW(), INTERVAL 2 DAY), NULL, 0, 'ACTIVE'),
(7, 7, 1, DATE_SUB(NOW(), INTERVAL 8 DAY), 30.00, NOW(), NULL, 0, 'ACTIVE'),
(8, 7, 3, DATE_SUB(NOW(), INTERVAL 5 DAY), 15.00, DATE_SUB(NOW(), INTERVAL 1 DAY), NULL, 0, 'ACTIVE'),
(9, 7, 5, DATE_SUB(NOW(), INTERVAL 7 DAY), 40.00, DATE_SUB(NOW(), INTERVAL 2 DAY), NULL, 0, 'ACTIVE'),
(10, 8, 1, DATE_SUB(NOW(), INTERVAL 30 DAY), 100.00, DATE_SUB(NOW(), INTERVAL 10 DAY), DATE_SUB(NOW(), INTERVAL 10 DAY), 1, 'COMPLETED'),
(11, 8, 2, DATE_SUB(NOW(), INTERVAL 25 DAY), 100.00, DATE_SUB(NOW(), INTERVAL 7 DAY), DATE_SUB(NOW(), INTERVAL 7 DAY), 1, 'COMPLETED'),
(12, 8, 3, DATE_SUB(NOW(), INTERVAL 20 DAY), 100.00, DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY), 1, 'COMPLETED'),
(13, 8, 4, DATE_SUB(NOW(), INTERVAL 15 DAY), 70.00, NOW(), NULL, 0, 'ACTIVE'),
(14, 8, 6, DATE_SUB(NOW(), INTERVAL 10 DAY), 25.00, DATE_SUB(NOW(), INTERVAL 1 DAY), NULL, 0, 'ACTIVE'),
(15, 9, 5, DATE_SUB(NOW(), INTERVAL 3 DAY), 20.00, NOW(), NULL, 0, 'ACTIVE');

-- --------------------------------------------------------
-- Sample Reviews
-- --------------------------------------------------------

INSERT INTO `reviews` (`review_id`, `course_id`, `student_id`, `rating`, `review_text`, `is_approved`, `helpful_count`, `created_at`) VALUES
(1, 1, 5, 5, 'Kursus yang sangat bagus untuk pemula! Penjelasannya mudah dipahami dan projectnya relevan dengan dunia kerja.', 1, 15, DATE_SUB(NOW(), INTERVAL 5 DAY)),
(2, 1, 6, 5, 'Recommended banget! Setelah menyelesaikan kursus ini, saya berhasil dapat kerja sebagai junior web developer.', 1, 23, DATE_SUB(NOW(), INTERVAL 4 DAY)),
(3, 1, 8, 4, 'Materinya lengkap dan terstruktur. Hanya saja beberapa video agak panjang. Overall bagus!', 1, 8, DATE_SUB(NOW(), INTERVAL 10 DAY)),
(4, 2, 5, 5, 'React JS explained dengan sangat baik. Hooks dan Redux jadi mudah dipahami.', 1, 12, DATE_SUB(NOW(), INTERVAL 3 DAY)),
(5, 2, 8, 5, 'Best React course in Bahasa Indonesia! Pak Budi memang expert di bidangnya.', 1, 18, DATE_SUB(NOW(), INTERVAL 7 DAY)),
(6, 3, 5, 5, 'Dari tidak tahu apa-apa tentang data science, sekarang sudah bisa buat ML model sendiri!', 1, 20, DATE_SUB(NOW(), INTERVAL 3 DAY)),
(7, 3, 8, 5, 'Kursus paling komprehensif untuk data science dalam bahasa Indonesia.', 1, 14, DATE_SUB(NOW(), INTERVAL 5 DAY)),
(8, 4, 8, 5, 'Persiapan sertifikasi AWS jadi mudah dengan kursus ini. Lulus dengan skor tinggi!', 1, 10, DATE_SUB(NOW(), INTERVAL 5 DAY)),
(9, 5, 5, 4, 'Bagus untuk yang baru mulai belajar coding. Gratis pula!', 1, 45, DATE_SUB(NOW(), INTERVAL 20 DAY)),
(10, 5, 7, 5, 'Kursus gratis tapi kualitasnya premium. Terima kasih NusaTech!', 1, 32, DATE_SUB(NOW(), INTERVAL 5 DAY));

-- --------------------------------------------------------
-- Sample Forums (automatically created with courses, but let's add some posts)
-- --------------------------------------------------------

INSERT INTO `forums` (`forum_id`, `course_id`, `title`, `description`, `created_at`) VALUES
(1, 1, 'Forum Diskusi: HTML, CSS, JavaScript', 'Tempat diskusi seputar kursus HTML, CSS, dan JavaScript', NOW()),
(2, 2, 'Forum Diskusi: React JS Masterclass', 'Diskusi React JS', NOW()),
(3, 3, 'Forum Diskusi: Python Data Science', 'Diskusi Python dan Data Science', NOW()),
(4, 5, 'Forum Diskusi: JavaScript Basics', 'Diskusi JavaScript dasar', NOW());

INSERT INTO `forum_posts` (`post_id`, `forum_id`, `user_id`, `parent_post_id`, `content`, `vote_count`, `is_answer`, `created_at`) VALUES
(1, 1, 5, NULL, 'Halo semua! Apakah ada yang bisa jelaskan perbedaan antara display: flex dan display: grid?', 5, 0, DATE_SUB(NOW(), INTERVAL 10 DAY)),
(2, 1, 2, 1, 'Flexbox (display: flex) cocok untuk layout 1 dimensi (baris ATAU kolom), sedangkan Grid (display: grid) cocok untuk layout 2 dimensi (baris DAN kolom sekaligus). Untuk navbar atau card horizontal, gunakan flex. Untuk layout halaman kompleks, gunakan grid.', 12, 1, DATE_SUB(NOW(), INTERVAL 10 DAY)),
(3, 1, 7, NULL, 'Bagaimana cara membuat website responsif? Saya masih bingung dengan media queries.', 3, 0, DATE_SUB(NOW(), INTERVAL 5 DAY)),
(4, 1, 6, 3, 'Gunakan pendekatan mobile-first. Tulis CSS untuk mobile dulu, lalu tambahkan media query untuk layar lebih besar. Contoh: @media (min-width: 768px) { ... }', 8, 1, DATE_SUB(NOW(), INTERVAL 5 DAY)),
(5, 3, 8, NULL, 'Ada rekomendasi dataset untuk latihan pandas?', 4, 0, DATE_SUB(NOW(), INTERVAL 7 DAY)),
(6, 3, 3, 5, 'Coba cek Kaggle! Ada banyak dataset gratis untuk latihan. Untuk pemula, saya sarankan mulai dengan Titanic dataset atau Iris dataset.', 10, 1, DATE_SUB(NOW(), INTERVAL 7 DAY));

-- --------------------------------------------------------
-- Sample Wishlist
-- --------------------------------------------------------

INSERT INTO `wishlist` (`wishlist_id`, `user_id`, `course_id`, `added_at`) VALUES
(1, 5, 4, DATE_SUB(NOW(), INTERVAL 10 DAY)),
(2, 5, 6, DATE_SUB(NOW(), INTERVAL 5 DAY)),
(3, 6, 2, DATE_SUB(NOW(), INTERVAL 8 DAY)),
(4, 6, 3, DATE_SUB(NOW(), INTERVAL 3 DAY)),
(5, 7, 2, DATE_SUB(NOW(), INTERVAL 2 DAY)),
(6, 9, 1, NOW()),
(7, 9, 3, NOW());

-- --------------------------------------------------------
-- Sample Transactions (some completed)
-- --------------------------------------------------------

INSERT INTO `transactions` (`transaction_id`, `user_id`, `transaction_code`, `total_amount`, `payment_method`, `payment_status`, `paid_at`, `created_at`) VALUES
(1, 5, 'TRX-20251115-001', 149000.00, 'BANK_TRANSFER', 'PAID', DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 20 DAY)),
(2, 5, 'TRX-20251120-002', 349000.00, 'E_WALLET', 'PAID', DATE_SUB(NOW(), INTERVAL 15 DAY), DATE_SUB(NOW(), INTERVAL 15 DAY)),
(3, 5, 'TRX-20251125-003', 399000.00, 'BANK_TRANSFER', 'PAID', DATE_SUB(NOW(), INTERVAL 10 DAY), DATE_SUB(NOW(), INTERVAL 10 DAY)),
(4, 6, 'TRX-20251127-004', 149000.00, 'E_WALLET', 'PAID', DATE_SUB(NOW(), INTERVAL 18 DAY), DATE_SUB(NOW(), INTERVAL 18 DAY)),
(5, 8, 'TRX-20251110-005', 149000.00, 'CREDIT_CARD', 'PAID', DATE_SUB(NOW(), INTERVAL 30 DAY), DATE_SUB(NOW(), INTERVAL 30 DAY)),
(6, 8, 'TRX-20251115-006', 349000.00, 'E_WALLET', 'PAID', DATE_SUB(NOW(), INTERVAL 25 DAY), DATE_SUB(NOW(), INTERVAL 25 DAY)),
(7, 8, 'TRX-20251120-007', 399000.00, 'BANK_TRANSFER', 'PAID', DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 20 DAY)),
(8, 8, 'TRX-20251125-008', 299000.00, 'E_WALLET', 'PAID', DATE_SUB(NOW(), INTERVAL 15 DAY), DATE_SUB(NOW(), INTERVAL 15 DAY)),
(9, 8, 'TRX-20251130-009', 599000.00, 'CREDIT_CARD', 'PAID', DATE_SUB(NOW(), INTERVAL 10 DAY), DATE_SUB(NOW(), INTERVAL 10 DAY));

INSERT INTO `transaction_items` (`item_id`, `transaction_id`, `course_id`, `plan_id`, `item_type`, `price`, `discount`) VALUES
(1, 1, 1, NULL, 'COURSE', 149000.00, 50000.00),
(2, 2, 2, NULL, 'COURSE', 349000.00, 0.00),
(3, 3, 3, NULL, 'COURSE', 399000.00, 100000.00),
(4, 4, 1, NULL, 'COURSE', 149000.00, 50000.00),
(5, 5, 1, NULL, 'COURSE', 149000.00, 50000.00),
(6, 6, 2, NULL, 'COURSE', 349000.00, 0.00),
(7, 7, 3, NULL, 'COURSE', 399000.00, 100000.00),
(8, 8, 4, NULL, 'COURSE', 299000.00, 0.00),
(9, 9, 6, NULL, 'COURSE', 599000.00, 0.00);

-- --------------------------------------------------------
-- Update course statistics (totals already set in insert, but let's be safe)
-- --------------------------------------------------------

UPDATE courses c SET 
    total_sections = (SELECT COUNT(*) FROM sections s WHERE s.course_id = c.course_id),
    total_materials = (SELECT COUNT(*) FROM materials m JOIN sections s ON m.section_id = s.section_id WHERE s.course_id = c.course_id);

-- Done!
SELECT 'Sample data inserted successfully!' AS status;
