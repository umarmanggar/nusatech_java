<%-- 
    Document   : list
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Course Listing Page with Bootstrap 5
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jelajahi Kursus - NusaTech</title>
    <meta name="description" content="Temukan kursus programming terbaik untuk mengembangkan skill coding Anda">
    
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
            --bs-primary: #8B1538;
            --bs-primary-rgb: 139, 21, 56;
        }
        
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8f9fa;
        }
        
        .btn-primary {
            background-color: var(--primary);
            border-color: var(--primary);
        }
        .btn-primary:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
        }
        .btn-outline-primary {
            color: var(--primary);
            border-color: var(--primary);
        }
        .btn-outline-primary:hover {
            background-color: var(--primary);
            border-color: var(--primary);
        }
        
        .text-primary { color: var(--primary) !important; }
        .bg-primary { background-color: var(--primary) !important; }
        
        /* Page Header */
        .page-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            padding: 5rem 0 3rem;
            margin-top: 56px;
        }
        
        /* Sidebar Filters */
        .filter-section {
            background: white;
            border-radius: 1rem;
            padding: 1.5rem;
            position: sticky;
            top: 80px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }
        
        .filter-title {
            font-size: 0.8rem;
            font-weight: 600;
            color: #6c757d;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 1rem;
        }
        
        .filter-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0.6rem 1rem;
            border-radius: 0.5rem;
            color: #495057;
            text-decoration: none;
            transition: all 0.2s;
        }
        .filter-item:hover {
            background-color: rgba(139, 21, 56, 0.08);
            color: var(--primary);
        }
        .filter-item.active {
            background-color: rgba(139, 21, 56, 0.12);
            color: var(--primary);
            font-weight: 600;
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
            height: 180px;
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
            padding: 0.4rem 0.8rem;
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
        
        .course-card-body {
            padding: 1.25rem;
        }
        
        .course-category {
            font-size: 0.75rem;
            font-weight: 600;
            color: var(--primary);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .course-title {
            font-size: 1rem;
            font-weight: 700;
            margin: 0.5rem 0;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            line-height: 1.4;
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
            font-size: 0.85rem;
            color: #6b7280;
        }
        .course-instructor img {
            width: 28px;
            height: 28px;
            border-radius: 50%;
        }
        
        .course-meta {
            display: flex;
            align-items: center;
            gap: 1rem;
            font-size: 0.8rem;
            color: #9ca3af;
            margin-bottom: 1rem;
        }
        .course-meta i {
            margin-right: 0.25rem;
        }
        
        .course-rating {
            color: #f59e0b;
        }
        
        .course-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-top: 1rem;
            border-top: 1px solid #f3f4f6;
        }
        
        .course-price-free {
            font-weight: 700;
            color: #10b981;
            font-size: 1rem;
        }
        .course-price-current {
            font-weight: 700;
            color: var(--primary);
            font-size: 1rem;
        }
        .course-price-original {
            font-size: 0.8rem;
            color: #9ca3af;
            text-decoration: line-through;
            margin-left: 0.5rem;
        }
        
        /* Custom Form Checks */
        .form-check-input:checked {
            background-color: var(--primary);
            border-color: var(--primary);
        }
        
        /* Pagination */
        .page-link {
            color: var(--primary);
            border-radius: 0.5rem !important;
            margin: 0 0.15rem;
        }
        .page-item.active .page-link {
            background-color: var(--primary);
            border-color: var(--primary);
        }
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 1rem;
        }
        .empty-state-icon {
            width: 80px;
            height: 80px;
            background: rgba(139, 21, 56, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 2rem;
            color: var(--primary);
        }
        
        /* Mobile Filter Toggle */
        @media (max-width: 991.98px) {
            .filter-section {
                position: fixed;
                top: 0;
                left: -100%;
                width: 300px;
                height: 100vh;
                z-index: 1050;
                border-radius: 0;
                transition: left 0.3s;
                overflow-y: auto;
            }
            .filter-section.show {
                left: 0;
            }
            .filter-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0,0,0,0.5);
                z-index: 1040;
            }
            .filter-overlay.show {
                display: block;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <jsp:include page="/pages/common/navbar.jsp"/>
    
    <!-- Page Header -->
    <section class="page-header">
        <div class="container">
            <nav aria-label="breadcrumb" class="mb-2">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/" class="text-white-50">Beranda</a></li>
                    <li class="breadcrumb-item text-white active">Kursus</li>
                </ol>
            </nav>
            <h1 class="text-white fw-bold display-5 mb-2">
                <c:choose>
                    <c:when test="${not empty selectedCategory}">${selectedCategory.name}</c:when>
                    <c:otherwise>Jelajahi Semua Kursus</c:otherwise>
                </c:choose>
            </h1>
            <p class="text-white-50 lead mb-0">
                <c:choose>
                    <c:when test="${not empty selectedCategory}">${selectedCategory.description}</c:when>
                    <c:otherwise>Temukan ${totalCourses > 0 ? totalCourses : 'berbagai'} kursus berkualitas untuk mengembangkan kemampuan Anda</c:otherwise>
                </c:choose>
            </p>
            
            <!-- Search Bar -->
            <div class="row mt-4">
                <div class="col-lg-6">
                    <form action="${pageContext.request.contextPath}/search" method="GET">
                        <div class="input-group input-group-lg">
                            <span class="input-group-text bg-white border-0"><i class="fas fa-search text-muted"></i></span>
                            <input type="text" name="q" class="form-control border-0" placeholder="Cari kursus, topik, atau instruktur...">
                            <button class="btn btn-warning px-4" type="submit" style="background-color: var(--secondary); border-color: var(--secondary);">
                                <i class="fas fa-search"></i> Cari
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Main Content -->
    <section class="py-5">
        <div class="container">
            <div class="row g-4">
                <!-- Mobile Filter Toggle -->
                <div class="col-12 d-lg-none mb-3">
                    <button class="btn btn-outline-primary w-100" onclick="toggleFilter()">
                        <i class="fas fa-filter me-2"></i> Filter Kursus
                    </button>
                </div>
                
                <!-- Filter Overlay (Mobile) -->
                <div class="filter-overlay" id="filterOverlay" onclick="toggleFilter()"></div>
                
                <!-- Sidebar Filters -->
                <div class="col-lg-3">
                    <aside class="filter-section" id="filterSidebar">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h5 class="mb-0 fw-bold"><i class="fas fa-filter me-2"></i> Filter</h5>
                            <button class="btn btn-sm btn-outline-secondary d-lg-none" onclick="toggleFilter()">
                                <i class="fas fa-times"></i>
                            </button>
                        </div>
                        
                        <!-- Categories -->
                        <div class="mb-4">
                            <h6 class="filter-title">Kategori</h6>
                            <div class="d-flex flex-column gap-1">
                                <a href="${pageContext.request.contextPath}/courses" 
                                   class="filter-item ${empty selectedCategory ? 'active' : ''}">
                                    <span>Semua Kategori</span>
                                    <span class="badge bg-light text-dark">${totalCourses}</span>
                                </a>
                                <c:forEach var="category" items="${categories}">
                                    <a href="${pageContext.request.contextPath}/courses?category=${category.slug}" 
                                       class="filter-item ${selectedCategory.categoryId == category.categoryId ? 'active' : ''}">
                                        <span><i class="${category.icon} me-2"></i>${category.name}</span>
                                        <span class="badge bg-light text-dark">${category.courseCount}</span>
                                    </a>
                                </c:forEach>
                            </div>
                        </div>
                        
                        <!-- Level Filter -->
                        <div class="mb-4">
                            <h6 class="filter-title">Tingkat Kesulitan</h6>
                            <div class="d-flex flex-column gap-2">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="level" value="BEGINNER" id="levelBeginner">
                                    <label class="form-check-label" for="levelBeginner">Pemula</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="level" value="INTERMEDIATE" id="levelIntermediate">
                                    <label class="form-check-label" for="levelIntermediate">Menengah</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="level" value="ADVANCED" id="levelAdvanced">
                                    <label class="form-check-label" for="levelAdvanced">Mahir</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="level" value="ALL_LEVELS" id="levelAll">
                                    <label class="form-check-label" for="levelAll">Semua Level</label>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Price Filter -->
                        <div class="mb-4">
                            <h6 class="filter-title">Harga</h6>
                            <div class="d-flex flex-column gap-2">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="price" value="free" id="priceFree">
                                    <label class="form-check-label" for="priceFree">
                                        <i class="fas fa-gift text-success me-1"></i> Gratis
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="price" value="paid" id="pricePaid">
                                    <label class="form-check-label" for="pricePaid">
                                        <i class="fas fa-tag text-primary me-1"></i> Berbayar
                                    </label>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Rating Filter -->
                        <div class="mb-4">
                            <h6 class="filter-title">Rating</h6>
                            <div class="d-flex flex-column gap-2">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="rating" value="4" id="rating4">
                                    <label class="form-check-label" for="rating4">
                                        <i class="fas fa-star text-warning"></i> 4.0 ke atas
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="rating" value="3" id="rating3">
                                    <label class="form-check-label" for="rating3">
                                        <i class="fas fa-star text-warning"></i> 3.0 ke atas
                                    </label>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Apply Button (Mobile) -->
                        <div class="d-lg-none">
                            <button class="btn btn-primary w-100" onclick="toggleFilter()">
                                Terapkan Filter
                            </button>
                        </div>
                    </aside>
                </div>
                
                <!-- Course Grid -->
                <div class="col-lg-9">
                    <!-- Sort & Results Info -->
                    <div class="d-flex flex-wrap align-items-center justify-content-between mb-4 gap-3">
                        <p class="text-muted mb-0">
                            Menampilkan <strong class="text-dark">${courses.size()}</strong> dari <strong class="text-dark">${totalCourses}</strong> kursus
                        </p>
                        <div class="d-flex align-items-center gap-2">
                            <label class="text-muted me-2 d-none d-sm-inline">Urutkan:</label>
                            <select class="form-select form-select-sm" style="width: auto;" onchange="window.location.href=this.value">
                                <option value="${pageContext.request.contextPath}/courses?sort=popular${not empty selectedCategory ? '&category='.concat(selectedCategory.slug) : ''}">Terpopuler</option>
                                <option value="${pageContext.request.contextPath}/courses?sort=newest${not empty selectedCategory ? '&category='.concat(selectedCategory.slug) : ''}">Terbaru</option>
                                <option value="${pageContext.request.contextPath}/courses?sort=price-low${not empty selectedCategory ? '&category='.concat(selectedCategory.slug) : ''}">Harga: Terendah</option>
                                <option value="${pageContext.request.contextPath}/courses?sort=price-high${not empty selectedCategory ? '&category='.concat(selectedCategory.slug) : ''}">Harga: Tertinggi</option>
                                <option value="${pageContext.request.contextPath}/courses?sort=rating${not empty selectedCategory ? '&category='.concat(selectedCategory.slug) : ''}">Rating Tertinggi</option>
                            </select>
                        </div>
                    </div>
                    
                    <!-- Course Cards -->
                    <c:choose>
                        <c:when test="${not empty courses}">
                            <div class="row row-cols-1 row-cols-md-2 row-cols-xl-3 g-4">
                                <c:forEach var="course" items="${courses}">
                                    <div class="col">
                                        <div class="card course-card h-100">
                                            <div class="course-card-img">
                                                <img src="${not empty course.thumbnail && !course.thumbnail.equals('default-course.png') ? course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400&h=225&fit=crop'}" 
                                                     alt="${course.title}" class="card-img-top">
                                                <c:if test="${course.free}">
                                                    <span class="course-badge free">GRATIS</span>
                                                </c:if>
                                                <c:if test="${course.hasDiscount() && !course.free}">
                                                    <span class="course-badge discount">-${course.discountPercentage}%</span>
                                                </c:if>
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
                                                    <span><i class="fas fa-users"></i> ${course.totalStudents}</span>
                                                    <span><i class="fas fa-book"></i> ${course.totalMaterials}</span>
                                                    <span class="course-rating">
                                                        <i class="fas fa-star"></i> 
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
                                                    <a href="${pageContext.request.contextPath}/course/${course.slug}" class="btn btn-sm btn-outline-primary">
                                                        Lihat <i class="fas fa-arrow-right ms-1"></i>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            
                            <!-- Pagination -->
                            <c:if test="${totalPages > 1}">
                                <nav class="mt-5" aria-label="Course pagination">
                                    <ul class="pagination justify-content-center">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="${pageContext.request.contextPath}/courses?page=${currentPage - 1}${not empty selectedCategory ? '&category='.concat(selectedCategory.slug) : ''}">
                                                    <i class="fas fa-chevron-left"></i>
                                                </a>
                                            </li>
                                        </c:if>
                                        
                                        <c:forEach begin="1" end="${totalPages}" var="page">
                                            <c:if test="${page <= 5 || page == totalPages || (page >= currentPage - 1 && page <= currentPage + 1)}">
                                                <li class="page-item ${page == currentPage ? 'active' : ''}">
                                                    <a class="page-link" href="${pageContext.request.contextPath}/courses?page=${page}${not empty selectedCategory ? '&category='.concat(selectedCategory.slug) : ''}">
                                                        ${page}
                                                    </a>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                        
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="${pageContext.request.contextPath}/courses?page=${currentPage + 1}${not empty selectedCategory ? '&category='.concat(selectedCategory.slug) : ''}">
                                                    <i class="fas fa-chevron-right"></i>
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <!-- Empty State -->
                            <div class="empty-state">
                                <div class="empty-state-icon">
                                    <i class="fas fa-book-open"></i>
                                </div>
                                <h4 class="fw-bold mb-2">Belum Ada Kursus</h4>
                                <p class="text-muted mb-4">
                                    <c:choose>
                                        <c:when test="${not empty selectedCategory}">
                                            Belum ada kursus untuk kategori ${selectedCategory.name}.
                                        </c:when>
                                        <c:otherwise>
                                            Belum ada kursus yang tersedia saat ini.
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <a href="${pageContext.request.contextPath}/courses" class="btn btn-primary">
                                    <i class="fas fa-list me-2"></i> Lihat Semua Kursus
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Footer -->
    <jsp:include page="/pages/common/footer.jsp"/>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function toggleFilter() {
            document.getElementById('filterSidebar').classList.toggle('show');
            document.getElementById('filterOverlay').classList.toggle('show');
            document.body.classList.toggle('overflow-hidden');
        }
        
        // Close filter on escape key
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                document.getElementById('filterSidebar').classList.remove('show');
                document.getElementById('filterOverlay').classList.remove('show');
                document.body.classList.remove('overflow-hidden');
            }
        });
    </script>
</body>
</html>
