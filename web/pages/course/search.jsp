<%-- 
    Document   : search
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Course Search Results Page with Bootstrap 5
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hasil Pencarian: ${keyword} - NusaTech</title>
    
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
        .btn-secondary {
            background-color: var(--secondary);
            border-color: var(--secondary);
            color: #1f2937;
        }
        .btn-secondary:hover {
            background-color: #c69a3e;
            border-color: #c69a3e;
            color: #1f2937;
        }
        
        .text-primary { color: var(--primary) !important; }
        .bg-primary { background-color: var(--primary) !important; }
        
        /* Search Header */
        .search-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            padding: 5rem 0 3rem;
            margin-top: 56px;
        }
        
        .search-box {
            background: white;
            border-radius: 1rem;
            padding: 0.5rem;
            display: flex;
            gap: 0.5rem;
            max-width: 700px;
        }
        .search-box input {
            border: none;
            flex: 1;
            padding: 0.75rem 1rem;
            font-size: 1rem;
        }
        .search-box input:focus {
            outline: none;
        }
        
        /* Filter Chips */
        .filter-chips {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
        }
        .filter-chip {
            padding: 0.5rem 1rem;
            border-radius: 2rem;
            font-size: 0.875rem;
            font-weight: 500;
            background: white;
            color: #6b7280;
            border: 1px solid #e5e7eb;
            text-decoration: none;
            transition: all 0.2s;
        }
        .filter-chip:hover {
            background: rgba(139, 21, 56, 0.08);
            color: var(--primary);
            border-color: var(--primary);
        }
        .filter-chip.active {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
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
        
        /* Sort Dropdown */
        .sort-btn {
            border: 1px solid #e5e7eb;
            background: white;
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            font-size: 0.875rem;
            color: #4b5563;
        }
        .sort-btn:hover {
            border-color: var(--primary);
            color: var(--primary);
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
        
        /* Form Checks */
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
            width: 100px;
            height: 100px;
            background: rgba(139, 21, 56, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 2.5rem;
            color: var(--primary);
        }
        
        /* Popular Search Tags */
        .search-tag {
            display: inline-block;
            padding: 0.6rem 1.25rem;
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 2rem;
            font-size: 0.9rem;
            color: #4b5563;
            text-decoration: none;
            transition: all 0.2s;
        }
        .search-tag:hover {
            background: var(--primary);
            border-color: var(--primary);
            color: white;
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
    
    <!-- Search Header -->
    <section class="search-header">
        <div class="container">
            <h1 class="text-white fw-bold h2 mb-3">
                Hasil Pencarian untuk "<span style="color: var(--secondary);">${keyword}</span>"
            </h1>
            <p class="text-white-50 mb-4">
                Ditemukan <strong class="text-white">${totalCourses}</strong> kursus yang sesuai
            </p>
            
            <!-- Search Box -->
            <form action="${pageContext.request.contextPath}/search" method="GET">
                <div class="search-box">
                    <i class="fas fa-search text-muted align-self-center ms-3"></i>
                    <input type="text" name="q" value="${keyword}" placeholder="Cari kursus, topik, atau instruktur...">
                    <button type="submit" class="btn btn-secondary px-4">
                        <i class="fas fa-search me-2"></i> Cari
                    </button>
                </div>
            </form>
        </div>
    </section>
    
    <!-- Main Content -->
    <section class="py-5">
        <div class="container">
            <div class="row g-4">
                <!-- Mobile Filter Toggle -->
                <div class="col-12 d-lg-none mb-2">
                    <button class="btn btn-outline-primary w-100" onclick="toggleFilter()">
                        <i class="fas fa-filter me-2"></i> Filter & Urutkan
                    </button>
                </div>
                
                <!-- Filter Overlay (Mobile) -->
                <div class="filter-overlay" id="filterOverlay" onclick="toggleFilter()"></div>
                
                <!-- Sidebar Filters -->
                <div class="col-lg-3">
                    <aside class="filter-section" id="filterSidebar">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h5 class="mb-0 fw-bold"><i class="fas fa-sliders-h me-2"></i> Filter</h5>
                            <button class="btn btn-sm btn-outline-secondary d-lg-none" onclick="toggleFilter()">
                                <i class="fas fa-times"></i>
                            </button>
                        </div>
                        
                        <!-- Categories -->
                        <div class="mb-4">
                            <h6 class="filter-title">Kategori</h6>
                            <div class="d-flex flex-column gap-2">
                                <c:forEach var="category" items="${categories}">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="category" 
                                               value="${category.slug}" id="cat${category.categoryId}"
                                               ${param.category == category.slug ? 'checked' : ''}>
                                        <label class="form-check-label" for="cat${category.categoryId}">
                                            <i class="${category.icon} me-1"></i> ${category.name}
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        
                        <!-- Level Filter -->
                        <div class="mb-4">
                            <h6 class="filter-title">Tingkat Kesulitan</h6>
                            <div class="d-flex flex-column gap-2">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="level" value="BEGINNER" id="levelBeginner"
                                           ${param.level == 'BEGINNER' ? 'checked' : ''}>
                                    <label class="form-check-label" for="levelBeginner">
                                        <i class="fas fa-seedling text-success me-1"></i> Pemula
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="level" value="INTERMEDIATE" id="levelIntermediate"
                                           ${param.level == 'INTERMEDIATE' ? 'checked' : ''}>
                                    <label class="form-check-label" for="levelIntermediate">
                                        <i class="fas fa-leaf text-info me-1"></i> Menengah
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="level" value="ADVANCED" id="levelAdvanced"
                                           ${param.level == 'ADVANCED' ? 'checked' : ''}>
                                    <label class="form-check-label" for="levelAdvanced">
                                        <i class="fas fa-tree text-primary me-1"></i> Mahir
                                    </label>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Price Filter -->
                        <div class="mb-4">
                            <h6 class="filter-title">Harga</h6>
                            <div class="d-flex flex-column gap-2">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="price" value="free" id="priceFree"
                                           ${param.price == 'free' ? 'checked' : ''}>
                                    <label class="form-check-label" for="priceFree">
                                        <i class="fas fa-gift text-success me-1"></i> Gratis
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="price" value="paid" id="pricePaid"
                                           ${param.price == 'paid' ? 'checked' : ''}>
                                    <label class="form-check-label" for="pricePaid">
                                        <i class="fas fa-tag me-1" style="color: var(--primary);"></i> Berbayar
                                    </label>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Rating Filter -->
                        <div class="mb-4">
                            <h6 class="filter-title">Rating Minimal</h6>
                            <div class="d-flex flex-column gap-2">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="rating" value="4.5" id="rating45"
                                           ${param.rating == '4.5' ? 'checked' : ''}>
                                    <label class="form-check-label" for="rating45">
                                        <span class="text-warning">
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star-half-alt"></i>
                                        </span>
                                        4.5+
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="rating" value="4" id="rating4"
                                           ${param.rating == '4' ? 'checked' : ''}>
                                    <label class="form-check-label" for="rating4">
                                        <span class="text-warning">
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="far fa-star"></i>
                                        </span>
                                        4.0+
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="rating" value="3" id="rating3"
                                           ${param.rating == '3' ? 'checked' : ''}>
                                    <label class="form-check-label" for="rating3">
                                        <span class="text-warning">
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="far fa-star"></i>
                                            <i class="far fa-star"></i>
                                        </span>
                                        3.0+
                                    </label>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Apply/Reset Buttons -->
                        <div class="d-grid gap-2">
                            <button class="btn btn-primary" onclick="applyFilters()">
                                <i class="fas fa-check me-2"></i> Terapkan Filter
                            </button>
                            <a href="${pageContext.request.contextPath}/search?q=${keyword}" class="btn btn-outline-secondary">
                                <i class="fas fa-undo me-2"></i> Reset Filter
                            </a>
                        </div>
                    </aside>
                </div>
                
                <!-- Search Results -->
                <div class="col-lg-9">
                    <!-- Results Header -->
                    <div class="d-flex flex-wrap align-items-center justify-content-between mb-4 gap-3">
                        <p class="text-muted mb-0">
                            Menampilkan <strong class="text-dark">${courses.size()}</strong> dari <strong class="text-dark">${totalCourses}</strong> hasil
                        </p>
                        
                        <!-- Sort Dropdown -->
                        <div class="dropdown">
                            <button class="btn sort-btn dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                <i class="fas fa-sort-amount-down me-2"></i>
                                <c:choose>
                                    <c:when test="${param.sort == 'newest'}">Terbaru</c:when>
                                    <c:when test="${param.sort == 'popular'}">Terpopuler</c:when>
                                    <c:when test="${param.sort == 'price-low'}">Harga: Terendah</c:when>
                                    <c:when test="${param.sort == 'price-high'}">Harga: Tertinggi</c:when>
                                    <c:when test="${param.sort == 'rating'}">Rating Tertinggi</c:when>
                                    <c:otherwise>Relevansi</c:otherwise>
                                </c:choose>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item ${empty param.sort ? 'active' : ''}" href="${pageContext.request.contextPath}/search?q=${keyword}">
                                    <i class="fas fa-bullseye me-2"></i> Relevansi
                                </a></li>
                                <li><a class="dropdown-item ${param.sort == 'newest' ? 'active' : ''}" href="${pageContext.request.contextPath}/search?q=${keyword}&sort=newest">
                                    <i class="fas fa-clock me-2"></i> Terbaru
                                </a></li>
                                <li><a class="dropdown-item ${param.sort == 'popular' ? 'active' : ''}" href="${pageContext.request.contextPath}/search?q=${keyword}&sort=popular">
                                    <i class="fas fa-fire me-2"></i> Terpopuler
                                </a></li>
                                <li><a class="dropdown-item ${param.sort == 'rating' ? 'active' : ''}" href="${pageContext.request.contextPath}/search?q=${keyword}&sort=rating">
                                    <i class="fas fa-star me-2"></i> Rating Tertinggi
                                </a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item ${param.sort == 'price-low' ? 'active' : ''}" href="${pageContext.request.contextPath}/search?q=${keyword}&sort=price-low">
                                    <i class="fas fa-sort-amount-up me-2"></i> Harga: Terendah
                                </a></li>
                                <li><a class="dropdown-item ${param.sort == 'price-high' ? 'active' : ''}" href="${pageContext.request.contextPath}/search?q=${keyword}&sort=price-high">
                                    <i class="fas fa-sort-amount-down me-2"></i> Harga: Tertinggi
                                </a></li>
                            </ul>
                        </div>
                    </div>
                    
                    <!-- Quick Category Filter -->
                    <div class="filter-chips mb-4">
                        <a href="${pageContext.request.contextPath}/search?q=${keyword}" 
                           class="filter-chip ${empty param.category ? 'active' : ''}">
                            Semua
                        </a>
                        <c:forEach var="category" items="${categories}" end="5">
                            <a href="${pageContext.request.contextPath}/search?q=${keyword}&category=${category.slug}" 
                               class="filter-chip ${param.category == category.slug ? 'active' : ''}">
                                ${category.name}
                            </a>
                        </c:forEach>
                    </div>
                    
                    <c:choose>
                        <c:when test="${not empty courses}">
                            <!-- Course Cards -->
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
                                <nav class="mt-5" aria-label="Search results pagination">
                                    <ul class="pagination justify-content-center">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="${pageContext.request.contextPath}/search?q=${keyword}&page=${currentPage - 1}${not empty param.sort ? '&sort='.concat(param.sort) : ''}${not empty param.category ? '&category='.concat(param.category) : ''}">
                                                    <i class="fas fa-chevron-left"></i>
                                                </a>
                                            </li>
                                        </c:if>
                                        
                                        <c:forEach begin="1" end="${totalPages}" var="page">
                                            <c:if test="${page <= 5 || page == totalPages || (page >= currentPage - 1 && page <= currentPage + 1)}">
                                                <li class="page-item ${page == currentPage ? 'active' : ''}">
                                                    <a class="page-link" href="${pageContext.request.contextPath}/search?q=${keyword}&page=${page}${not empty param.sort ? '&sort='.concat(param.sort) : ''}${not empty param.category ? '&category='.concat(param.category) : ''}">
                                                        ${page}
                                                    </a>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                        
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="${pageContext.request.contextPath}/search?q=${keyword}&page=${currentPage + 1}${not empty param.sort ? '&sort='.concat(param.sort) : ''}${not empty param.category ? '&category='.concat(param.category) : ''}">
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
                                    <i class="fas fa-search"></i>
                                </div>
                                <h4 class="fw-bold mb-2">Tidak Ada Hasil</h4>
                                <p class="text-muted mb-4 mx-auto" style="max-width: 400px;">
                                    Maaf, tidak ada kursus yang cocok dengan pencarian "<strong>${keyword}</strong>". 
                                    Coba gunakan kata kunci lain atau jelajahi kategori kursus kami.
                                </p>
                                <div class="d-flex gap-3 justify-content-center">
                                    <a href="${pageContext.request.contextPath}/courses" class="btn btn-primary">
                                        <i class="fas fa-compass me-2"></i> Jelajahi Kursus
                                    </a>
                                    <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary">
                                        <i class="fas fa-home me-2"></i> Beranda
                                    </a>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Popular Searches -->
    <section class="py-5 bg-white">
        <div class="container">
            <div class="text-center mb-4">
                <h4 class="fw-bold mb-2">Pencarian Populer</h4>
                <p class="text-muted">Topik yang sedang banyak dicari</p>
            </div>
            <div class="d-flex flex-wrap justify-content-center gap-3">
                <a href="${pageContext.request.contextPath}/search?q=javascript" class="search-tag">
                    <i class="fab fa-js-square text-warning me-1"></i> JavaScript
                </a>
                <a href="${pageContext.request.contextPath}/search?q=python" class="search-tag">
                    <i class="fab fa-python text-info me-1"></i> Python
                </a>
                <a href="${pageContext.request.contextPath}/search?q=react" class="search-tag">
                    <i class="fab fa-react text-primary me-1"></i> React
                </a>
                <a href="${pageContext.request.contextPath}/search?q=flutter" class="search-tag">
                    <i class="fas fa-mobile-alt text-info me-1"></i> Flutter
                </a>
                <a href="${pageContext.request.contextPath}/search?q=machine learning" class="search-tag">
                    <i class="fas fa-brain text-purple me-1"></i> Machine Learning
                </a>
                <a href="${pageContext.request.contextPath}/search?q=web development" class="search-tag">
                    <i class="fas fa-globe text-success me-1"></i> Web Development
                </a>
                <a href="${pageContext.request.contextPath}/search?q=android" class="search-tag">
                    <i class="fab fa-android text-success me-1"></i> Android
                </a>
                <a href="${pageContext.request.contextPath}/search?q=java" class="search-tag">
                    <i class="fab fa-java text-danger me-1"></i> Java
                </a>
                <a href="${pageContext.request.contextPath}/search?q=laravel" class="search-tag">
                    <i class="fab fa-laravel text-danger me-1"></i> Laravel
                </a>
                <a href="${pageContext.request.contextPath}/search?q=node.js" class="search-tag">
                    <i class="fab fa-node-js text-success me-1"></i> Node.js
                </a>
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
        
        function applyFilters() {
            const params = new URLSearchParams();
            params.set('q', '${keyword}');
            
            // Get selected categories
            document.querySelectorAll('input[name="category"]:checked').forEach(el => {
                params.append('category', el.value);
            });
            
            // Get selected levels
            document.querySelectorAll('input[name="level"]:checked').forEach(el => {
                params.append('level', el.value);
            });
            
            // Get selected price
            document.querySelectorAll('input[name="price"]:checked').forEach(el => {
                params.append('price', el.value);
            });
            
            // Get selected rating
            const rating = document.querySelector('input[name="rating"]:checked');
            if (rating) {
                params.set('rating', rating.value);
            }
            
            window.location.href = '${pageContext.request.contextPath}/search?' + params.toString();
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
