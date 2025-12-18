<%-- 
    Document   : wishlist
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Student Wishlist Page with Bootstrap 5
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wishlist - NusaTech</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #8B1538;
            --primary-dark: #6d1029;
            --secondary: #D4A84B;
        }
        
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8f9fa;
        }
        
        .btn-primary { background-color: var(--primary); border-color: var(--primary); }
        .btn-primary:hover { background-color: var(--primary-dark); border-color: var(--primary-dark); }
        .btn-outline-primary { color: var(--primary); border-color: var(--primary); }
        .btn-outline-primary:hover { background-color: var(--primary); border-color: var(--primary); }
        .text-primary { color: var(--primary) !important; }
        
        /* Layout */
        .dashboard-wrapper {
            display: flex;
            min-height: 100vh;
            padding-top: 56px;
        }
        
        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 2rem;
        }
        
        @media (max-width: 991.98px) {
            .main-content { margin-left: 0; }
        }
        
        /* Page Header */
        .page-title {
            font-size: 1.75rem;
            font-weight: 800;
            color: #1f2937;
            margin-bottom: 0.25rem;
        }
        
        .page-subtitle {
            color: #6b7280;
        }
        
        /* Course Card */
        .course-card {
            border: none;
            border-radius: 1rem;
            overflow: hidden;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            height: 100%;
        }
        
        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 24px rgba(0,0,0,0.12);
        }
        
        .course-card-img {
            position: relative;
            height: 160px;
            overflow: hidden;
        }
        
        .course-card-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s;
        }
        
        .course-card:hover .course-card-img img {
            transform: scale(1.05);
        }
        
        .course-badge {
            position: absolute;
            top: 12px;
            left: 12px;
            font-size: 0.7rem;
            font-weight: 700;
            padding: 0.35rem 0.75rem;
            border-radius: 0.5rem;
        }
        
        .course-badge.free {
            background-color: #10b981;
            color: white;
        }
        
        .course-badge.discount {
            background-color: #ef4444;
            color: white;
        }
        
        .wishlist-btn {
            position: absolute;
            top: 12px;
            right: 12px;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: white;
            border: none;
            color: #ef4444;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .wishlist-btn:hover {
            transform: scale(1.1);
            background: #ef4444;
            color: white;
        }
        
        .course-card-body {
            padding: 1.25rem;
        }
        
        .course-category {
            font-size: 0.7rem;
            font-weight: 600;
            color: var(--primary);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .course-title {
            font-size: 0.95rem;
            font-weight: 700;
            margin: 0.5rem 0;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            line-height: 1.4;
            min-height: 2.8em;
        }
        
        .course-title a {
            color: #1f2937;
            text-decoration: none;
        }
        
        .course-title a:hover {
            color: var(--primary);
        }
        
        .course-instructor {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin: 0.75rem 0;
            font-size: 0.8rem;
            color: #6b7280;
        }
        
        .course-instructor img {
            width: 24px;
            height: 24px;
            border-radius: 50%;
        }
        
        .course-meta {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 0.75rem;
            color: #9ca3af;
            margin-bottom: 1rem;
        }
        
        .course-rating {
            color: #f59e0b;
        }
        
        .course-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-top: 0.75rem;
            border-top: 1px solid #f3f4f6;
        }
        
        .course-price-free {
            font-weight: 700;
            color: #10b981;
        }
        
        .course-price-current {
            font-weight: 700;
            color: var(--primary);
        }
        
        .course-price-original {
            font-size: 0.75rem;
            color: #9ca3af;
            text-decoration: line-through;
            margin-left: 0.35rem;
        }
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 1rem;
        }
        
        .empty-state-icon {
            width: 100px;
            height: 100px;
            background: rgba(239, 68, 68, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 2.5rem;
            color: #ef4444;
        }
        
        /* Toast Notification */
        .toast-container {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1080;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <jsp:include page="/pages/common/navbar-dashboard.jsp"/>
    
    <div class="dashboard-wrapper">
        <!-- Sidebar -->
        <jsp:include page="/pages/common/sidebar-student.jsp"/>
        
        <!-- Main Content -->
        <main class="main-content">
            <!-- Mobile Sidebar Toggle -->
            <button class="btn btn-outline-secondary d-lg-none mb-3" onclick="toggleSidebar()">
                <i class="fas fa-bars me-2"></i> Menu
            </button>
            
            <!-- Page Header -->
            <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
                <div>
                    <h1 class="page-title">
                        <i class="fas fa-heart text-danger me-2"></i> Wishlist
                    </h1>
                    <p class="page-subtitle mb-0">Kursus yang Anda simpan untuk nanti</p>
                </div>
                <c:if test="${not empty wishlistCourses}">
                    <div class="d-flex gap-2">
                        <button class="btn btn-outline-danger" onclick="clearWishlist()">
                            <i class="fas fa-trash me-2"></i> Hapus Semua
                        </button>
                        <button class="btn btn-primary" onclick="addAllToCart()">
                            <i class="fas fa-cart-plus me-2"></i> Tambah Semua ke Cart
                        </button>
                    </div>
                </c:if>
            </div>
            
            <c:choose>
                <c:when test="${not empty wishlistCourses}">
                    <!-- Info Banner -->
                    <div class="alert alert-info d-flex align-items-center mb-4" role="alert">
                        <i class="fas fa-info-circle me-3"></i>
                        <div>
                            <strong>${wishlistCourses.size()} kursus</strong> di wishlist Anda. Segera tambahkan ke keranjang sebelum kehabisan diskon!
                        </div>
                    </div>
                    
                    <!-- Wishlist Grid -->
                    <div class="row row-cols-1 row-cols-md-2 row-cols-xl-3 row-cols-xxl-4 g-4">
                        <c:forEach var="course" items="${wishlistCourses}">
                            <div class="col" id="wishlist-item-${course.courseId}">
                                <div class="card course-card h-100">
                                    <div class="course-card-img">
                                        <img src="${not empty course.thumbnail && !course.thumbnail.equals('default-course.png') ? course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400&h=225&fit=crop'}" 
                                             alt="${course.title}">
                                        <c:if test="${course.free}">
                                            <span class="course-badge free">GRATIS</span>
                                        </c:if>
                                        <c:if test="${course.hasDiscount() && !course.free}">
                                            <span class="course-badge discount">-${course.discountPercentage}%</span>
                                        </c:if>
                                        <button class="wishlist-btn" onclick="removeFromWishlist(${course.courseId})" title="Hapus dari Wishlist">
                                            <i class="fas fa-heart"></i>
                                        </button>
                                    </div>
                                    <div class="course-card-body">
                                        <span class="course-category">${course.category.name}</span>
                                        <h5 class="course-title">
                                            <a href="${pageContext.request.contextPath}/course/${course.slug}">${course.title}</a>
                                        </h5>
                                        <div class="course-instructor">
                                            <img src="https://ui-avatars.com/api/?name=${course.lecturer.name}&background=8B1538&color=fff" 
                                                 alt="${course.lecturer.name}">
                                            <span>${course.lecturer.name}</span>
                                        </div>
                                        <div class="course-meta">
                                            <span><i class="fas fa-users me-1"></i> ${course.totalStudents}</span>
                                            <span class="course-rating">
                                                <i class="fas fa-star me-1"></i> 
                                                <fmt:formatNumber value="${course.avgRating}" maxFractionDigits="1"/>
                                            </span>
                                        </div>
                                        <div class="course-footer">
                                            <div>
                                                <c:choose>
                                                    <c:when test="${course.free}">
                                                        <span class="course-price-free">Gratis</span>
                                                    </c:when>
                                                    <c:when test="${course.hasDiscount()}">
                                                        <span class="course-price-current">
                                                            Rp <fmt:formatNumber value="${course.discountPrice}" pattern="#,###"/>
                                                        </span>
                                                        <span class="course-price-original">
                                                            Rp <fmt:formatNumber value="${course.price}" pattern="#,###"/>
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="course-price-current">
                                                            Rp <fmt:formatNumber value="${course.price}" pattern="#,###"/>
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <button class="btn btn-sm btn-primary" onclick="addToCart(${course.courseId})">
                                                <i class="fas fa-cart-plus"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Empty State -->
                    <div class="empty-state">
                        <div class="empty-state-icon">
                            <i class="far fa-heart"></i>
                        </div>
                        <h4 class="fw-bold mb-2">Wishlist Kosong</h4>
                        <p class="text-muted mb-4 mx-auto" style="max-width: 400px;">
                            Simpan kursus yang Anda minati untuk dibeli nanti dengan menekan tombol 
                            <i class="far fa-heart text-danger"></i> pada halaman kursus.
                        </p>
                        <a href="${pageContext.request.contextPath}/courses" class="btn btn-primary btn-lg">
                            <i class="fas fa-compass me-2"></i> Jelajahi Kursus
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
    
    <!-- Toast Container -->
    <div class="toast-container">
        <div id="toastNotif" class="toast align-items-center text-white border-0" role="alert">
            <div class="d-flex">
                <div class="toast-body" id="toastMessage"></div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function showToast(message, type) {
            const toast = document.getElementById('toastNotif');
            const toastMessage = document.getElementById('toastMessage');
            
            toast.classList.remove('bg-success', 'bg-danger', 'bg-warning');
            toast.classList.add(type === 'success' ? 'bg-success' : type === 'error' ? 'bg-danger' : 'bg-warning');
            toastMessage.textContent = message;
            
            const bsToast = new bootstrap.Toast(toast);
            bsToast.show();
        }
        
        function removeFromWishlist(courseId) {
            if (confirm('Hapus kursus ini dari wishlist?')) {
                fetch('${pageContext.request.contextPath}/wishlist/remove', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'courseId=' + courseId
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        document.getElementById('wishlist-item-' + courseId).remove();
                        showToast('Kursus dihapus dari wishlist', 'success');
                        
                        // Check if wishlist is empty
                        if (document.querySelectorAll('.course-card').length === 0) {
                            location.reload();
                        }
                    } else {
                        showToast(data.message || 'Gagal menghapus', 'error');
                    }
                })
                .catch(error => {
                    showToast('Terjadi kesalahan', 'error');
                });
            }
        }
        
        function addToCart(courseId) {
            fetch('${pageContext.request.contextPath}/cart/add', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'courseId=' + courseId
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showToast('Kursus ditambahkan ke keranjang', 'success');
                } else {
                    showToast(data.message || 'Gagal menambahkan ke keranjang', 'error');
                }
            })
            .catch(error => {
                showToast('Terjadi kesalahan', 'error');
            });
        }
        
        function clearWishlist() {
            if (confirm('Hapus semua kursus dari wishlist?')) {
                window.location.href = '${pageContext.request.contextPath}/wishlist/clear';
            }
        }
        
        function addAllToCart() {
            fetch('${pageContext.request.contextPath}/cart/add-all-from-wishlist', {
                method: 'POST'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showToast('Semua kursus ditambahkan ke keranjang', 'success');
                    setTimeout(() => {
                        window.location.href = '${pageContext.request.contextPath}/cart';
                    }, 1000);
                } else {
                    showToast(data.message || 'Gagal menambahkan', 'error');
                }
            })
            .catch(error => {
                showToast('Terjadi kesalahan', 'error');
            });
        }
    </script>
</body>
</html>
