<%-- 
    Document   : index
    Created on : Dec 10, 2025, 4:35:45 PM
    Author     : user
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dikoding Muda Nusantara - Platform Belajar Coding Indonesia</title>
    <meta name="description" content="Platform pembelajaran coding untuk generasi muda Indonesia menuju Indonesia Emas 2045">
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar" id="navbar">
        <div class="navbar-container">
            <a href="${pageContext.request.contextPath}/" class="navbar-brand">
                <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="NusaTech Logo">
                <span class="navbar-brand-text">NUSA<span>TECH</span></span>
            </a>
            
            <div class="navbar-menu" id="navbarMenu">
                <ul class="navbar-nav">
                    <li><a href="${pageContext.request.contextPath}/" class="nav-link active">Beranda</a></li>
                    <li><a href="${pageContext.request.contextPath}/courses" class="nav-link">Kursus</a></li>
                    <li><a href="${pageContext.request.contextPath}/categories" class="nav-link">Kategori</a></li>
                    <li><a href="${pageContext.request.contextPath}/about" class="nav-link">Tentang</a></li>
                </ul>
                
                <div class="navbar-search">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Cari kursus..." id="searchInput">
                </div>
            </div>
            
            <div class="navbar-actions">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/my-learning" class="btn btn-ghost">
                            <i class="fas fa-book-open"></i> Belajar
                        </a>
                        <a href="${pageContext.request.contextPath}/${sessionScope.user.role.name().toLowerCase()}/dashboard" class="btn btn-primary">
                            Dashboard
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-ghost">Masuk</a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">Daftar</a>
                    </c:otherwise>
                </c:choose>
                <button class="navbar-toggle" id="navbarToggle">
                    <i class="fas fa-bars"></i>
                </button>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-shapes">
            <div class="hero-shape hero-shape-1"></div>
            <div class="hero-shape hero-shape-2"></div>
        </div>
        
        <div class="container">
            <div class="hero-content">
                <div class="hero-text">
                    <div class="hero-badge">
                        <i class="fas fa-rocket"></i>
                        <span>Platform Belajar Coding #1 Indonesia</span>
                    </div>
                    
                    <h1 class="hero-title">
                        Bangun Masa Depan<br>
                        <span>Indonesia Emas 2045</span>
                    </h1>
                    
                    <p class="hero-description">
                        Tingkatkan kemampuan coding Anda bersama pengajar terbaik. 
                        Mulai dari pemula hingga mahir, kami siap membantu perjalanan karir teknologi Anda.
                    </p>
                    
                    <div class="hero-actions">
                        <a href="${pageContext.request.contextPath}/courses" class="btn btn-secondary btn-lg">
                            <i class="fas fa-play"></i> Mulai Belajar
                        </a>
                        <a href="${pageContext.request.contextPath}/about" class="btn btn-outline-white btn-lg">
                            Pelajari Lebih Lanjut
                        </a>
                    </div>
                    
                    <div class="hero-stats">
                        <div class="hero-stat">
                            <div class="hero-stat-value">${totalCourses > 0 ? totalCourses : '50'}+</div>
                            <div class="hero-stat-label">Kursus Tersedia</div>
                        </div>
                        <div class="hero-stat">
                            <div class="hero-stat-value">${totalStudents > 0 ? totalStudents : '1000'}+</div>
                            <div class="hero-stat-label">Pelajar Aktif</div>
                        </div>
                        <div class="hero-stat">
                            <div class="hero-stat-value">${totalLecturers > 0 ? totalLecturers : '25'}+</div>
                            <div class="hero-stat-label">Pengajar Ahli</div>
                        </div>
                    </div>
                </div>
                
                <div class="hero-visual">
                    <div class="hero-image-container">
                        <img src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=600&h=400&fit=crop" 
                             alt="Students Learning" class="hero-image">
                        
                        <div class="hero-card hero-card-1">
                            <div class="hero-card-icon primary">
                                <i class="fas fa-code"></i>
                            </div>
                            <div class="hero-card-text">
                                <h4>Learn by Doing</h4>
                                <p>Praktik langsung</p>
                            </div>
                        </div>
                        
                        <div class="hero-card hero-card-2">
                            <div class="hero-card-icon success">
                                <i class="fas fa-certificate"></i>
                            </div>
                            <div class="hero-card-text">
                                <h4>Sertifikat</h4>
                                <p>Diakui industri</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Categories Section -->
    <section class="section categories-section">
        <div class="container">
            <div class="section-header">
                <div>
                    <h2 class="section-title">Jelajahi Kategori</h2>
                    <p class="section-subtitle">Temukan bidang yang sesuai dengan minat Anda</p>
                </div>
                <a href="${pageContext.request.contextPath}/categories" class="section-link">
                    Lihat Semua <i class="fas fa-arrow-right"></i>
                </a>
            </div>
            
            <div class="grid grid-4">
                <c:forEach var="category" items="${categories}" end="7">
                    <a href="${pageContext.request.contextPath}/courses?category=${category.slug}" class="category-card">
                        <div class="category-card-icon">
                            <i class="${category.icon}"></i>
                        </div>
                        <h3 class="category-card-title">${category.name}</h3>
                        <p class="category-card-count">${category.courseCount} Kursus</p>
                    </a>
                </c:forEach>
                
                <c:if test="${empty categories}">
                    <!-- Default categories if empty -->
                    <a href="${pageContext.request.contextPath}/courses?category=web-development" class="category-card">
                        <div class="category-card-icon"><i class="fas fa-globe"></i></div>
                        <h3 class="category-card-title">Web Development</h3>
                        <p class="category-card-count">12 Kursus</p>
                    </a>
                    <a href="${pageContext.request.contextPath}/courses?category=mobile-development" class="category-card">
                        <div class="category-card-icon"><i class="fas fa-mobile-alt"></i></div>
                        <h3 class="category-card-title">Mobile Development</h3>
                        <p class="category-card-count">8 Kursus</p>
                    </a>
                    <a href="${pageContext.request.contextPath}/courses?category=data-science" class="category-card">
                        <div class="category-card-icon"><i class="fas fa-chart-bar"></i></div>
                        <h3 class="category-card-title">Data Science</h3>
                        <p class="category-card-count">10 Kursus</p>
                    </a>
                    <a href="${pageContext.request.contextPath}/courses?category=artificial-intelligence" class="category-card">
                        <div class="category-card-icon"><i class="fas fa-robot"></i></div>
                        <h3 class="category-card-title">Artificial Intelligence</h3>
                        <p class="category-card-count">6 Kursus</p>
                    </a>
                </c:if>
            </div>
        </div>
    </section>

    <!-- Popular Courses Section -->
    <section class="section featured-section">
        <div class="container">
            <div class="section-header">
                <div>
                    <h2 class="section-title">Kursus Populer</h2>
                    <p class="section-subtitle">Kursus paling diminati oleh pelajar kami</p>
                </div>
                <a href="${pageContext.request.contextPath}/courses" class="section-link">
                    Lihat Semua <i class="fas fa-arrow-right"></i>
                </a>
            </div>
            
            <div class="grid grid-4">
                <c:forEach var="course" items="${popularCourses}" end="7">
                    <div class="card course-card">
                        <div class="course-card-image">
                            <img src="${not empty course.thumbnail ? course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400&h=225&fit=crop'}" 
                                 alt="${course.title}">
                            <c:if test="${course.free}">
                                <span class="course-card-badge free">GRATIS</span>
                            </c:if>
                            <c:if test="${course.hasDiscount() and not course.free}">
                                <span class="course-card-badge">-${course.discountPercentage}%</span>
                            </c:if>
                        </div>
                        <div class="course-card-body">
                            <span class="course-card-category">${course.category.name}</span>
                            <h3 class="course-card-title">
                                <a href="${pageContext.request.contextPath}/course/${course.slug}">${course.title}</a>
                            </h3>
                            <div class="course-card-instructor">
                                <img src="https://ui-avatars.com/api/?name=${course.lecturer.name}&background=8B1538&color=fff" 
                                     alt="${course.lecturer.name}">
                                <span>${course.lecturer.name}</span>
                            </div>
                            <div class="course-card-meta">
                                <span><i class="fas fa-users"></i> ${course.totalStudents}</span>
                                <span class="course-card-rating">
                                    <i class="fas fa-star"></i> 
                                    <fmt:formatNumber value="${course.avgRating}" maxFractionDigits="1"/>
                                </span>
                            </div>
                            <div class="course-card-footer">
                                <div class="course-card-price">
                                    <c:choose>
                                        <c:when test="${course.free}">
                                            <span class="course-card-price-free">Gratis</span>
                                        </c:when>
                                        <c:when test="${course.hasDiscount()}">
                                            <span class="course-card-price-current">
                                                Rp <fmt:formatNumber value="${course.discountPrice}" pattern="#,###"/>
                                            </span>
                                            <span class="course-card-price-original">
                                                Rp <fmt:formatNumber value="${course.price}" pattern="#,###"/>
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="course-card-price-current">
                                                Rp <fmt:formatNumber value="${course.price}" pattern="#,###"/>
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <a href="${pageContext.request.contextPath}/course/${course.slug}" class="btn btn-sm btn-outline">
                                    Detail
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                
                <c:if test="${empty popularCourses}">
                    <!-- Demo courses -->
                    <c:forEach begin="1" end="4">
                        <div class="card course-card">
                            <div class="course-card-image">
                                <img src="https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400&h=225&fit=crop" alt="Demo Course">
                                <span class="course-card-badge free">GRATIS</span>
                            </div>
                            <div class="course-card-body">
                                <span class="course-card-category">Web Development</span>
                                <h3 class="course-card-title">
                                    <a href="#">Belajar Dasar HTML & CSS untuk Pemula</a>
                                </h3>
                                <div class="course-card-instructor">
                                    <img src="https://ui-avatars.com/api/?name=John+Doe&background=8B1538&color=fff" alt="Instructor">
                                    <span>John Doe</span>
                                </div>
                                <div class="course-card-meta">
                                    <span><i class="fas fa-users"></i> 1,234</span>
                                    <span class="course-card-rating"><i class="fas fa-star"></i> 4.8</span>
                                </div>
                                <div class="course-card-footer">
                                    <span class="course-card-price-free">Gratis</span>
                                    <a href="#" class="btn btn-sm btn-outline">Detail</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
        <div class="container">
            <h2 class="cta-title">Siap Memulai Perjalanan Coding Anda?</h2>
            <p class="cta-description">
                Bergabunglah dengan ribuan pelajar lainnya dan mulai tingkatkan skill coding Anda hari ini.
            </p>
            <a href="${pageContext.request.contextPath}/register" class="btn btn-secondary btn-lg">
                Daftar Sekarang - Gratis!
            </a>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-grid">
                <div>
                    <div class="footer-brand">
                        <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="NusaTech">
                        <span class="footer-brand-text">NUSA<span>TECH</span></span>
                    </div>
                    <p class="footer-description">
                        Platform pembelajaran coding interaktif untuk generasi muda Indonesia. 
                        Bersama menuju Indonesia Emas 2045.
                    </p>
                    <div class="footer-social">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
                
                <div>
                    <h4 class="footer-title">Kursus</h4>
                    <ul class="footer-links">
                        <li><a href="#">Web Development</a></li>
                        <li><a href="#">Mobile Development</a></li>
                        <li><a href="#">Data Science</a></li>
                        <li><a href="#">Artificial Intelligence</a></li>
                        <li><a href="#">Cloud Computing</a></li>
                    </ul>
                </div>
                
                <div>
                    <h4 class="footer-title">Perusahaan</h4>
                    <ul class="footer-links">
                        <li><a href="#">Tentang Kami</a></li>
                        <li><a href="#">Karir</a></li>
                        <li><a href="#">Blog</a></li>
                        <li><a href="#">Mitra</a></li>
                        <li><a href="#">Kontak</a></li>
                    </ul>
                </div>
                
                <div>
                    <h4 class="footer-title">Bantuan</h4>
                    <ul class="footer-links">
                        <li><a href="#">FAQ</a></li>
                        <li><a href="#">Pusat Bantuan</a></li>
                        <li><a href="#">Kebijakan Privasi</a></li>
                        <li><a href="#">Syarat & Ketentuan</a></li>
                        <li><a href="#">Hubungi Kami</a></li>
                    </ul>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p class="footer-copyright">
                    &copy; 2025 Dikoding Muda Nusantara. All rights reserved.
                </p>
                <p>Made with <i class="fas fa-heart" style="color: var(--primary)"></i> in Indonesia</p>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script>
        // Navbar scroll effect
        window.addEventListener('scroll', function() {
            const navbar = document.getElementById('navbar');
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });
        
        // Mobile menu toggle
        document.getElementById('navbarToggle').addEventListener('click', function() {
            document.getElementById('navbarMenu').classList.toggle('active');
        });
        
        // Search functionality
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                const query = this.value.trim();
                if (query) {
                    window.location.href = '${pageContext.request.contextPath}/search?q=' + encodeURIComponent(query);
                }
            }
        });
    </script>
</body>
</html>
