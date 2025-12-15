<%-- 
    Document   : list
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Course Listing Page
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
    <jsp:include page="/pages/common/navbar.jsp"/>
    
    <!-- Page Header -->
    <section style="background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%); padding: 6rem 0 4rem; margin-top: 72px;">
        <div class="container">
            <nav style="margin-bottom: 1rem;">
                <a href="${pageContext.request.contextPath}/" style="color: rgba(255,255,255,0.7);">Beranda</a>
                <span style="color: rgba(255,255,255,0.5); margin: 0 0.5rem;">/</span>
                <span style="color: white;">Kursus</span>
            </nav>
            <h1 style="color: white; font-size: 2.5rem; margin-bottom: 0.5rem;">
                <c:choose>
                    <c:when test="${not empty selectedCategory}">
                        ${selectedCategory.name}
                    </c:when>
                    <c:otherwise>
                        Jelajahi Semua Kursus
                    </c:otherwise>
                </c:choose>
            </h1>
            <p style="color: rgba(255,255,255,0.9); font-size: 1.125rem;">
                <c:choose>
                    <c:when test="${not empty selectedCategory}">
                        ${selectedCategory.description}
                    </c:when>
                    <c:otherwise>
                        Temukan ${totalCourses > 0 ? totalCourses : 'berbagai'} kursus berkualitas untuk mengembangkan kemampuan Anda
                    </c:otherwise>
                </c:choose>
            </p>
        </div>
    </section>
    
    <!-- Main Content -->
    <section class="section" style="background: var(--gray-50);">
        <div class="container">
            <div style="display: grid; grid-template-columns: 280px 1fr; gap: 2rem;">
                <!-- Sidebar Filters -->
                <aside>
                    <div style="background: white; border-radius: var(--radius-2xl); padding: 1.5rem; position: sticky; top: 88px;">
                        <h3 style="font-size: 1.125rem; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.5rem;">
                            <i class="fas fa-filter"></i> Filter
                        </h3>
                        
                        <!-- Categories -->
                        <div style="margin-bottom: 1.5rem;">
                            <h4 style="font-size: 0.875rem; font-weight: 600; color: var(--gray-600); margin-bottom: 1rem; text-transform: uppercase; letter-spacing: 0.5px;">Kategori</h4>
                            <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                                <a href="${pageContext.request.contextPath}/courses" 
                                   class="${empty selectedCategory ? 'active' : ''}"
                                   style="display: flex; align-items: center; justify-content: space-between; padding: 0.75rem 1rem; border-radius: var(--radius-lg); color: ${empty selectedCategory ? 'var(--primary)' : 'var(--gray-700)'}; background: ${empty selectedCategory ? 'var(--primary-100)' : 'transparent'};">
                                    <span>Semua Kategori</span>
                                    <span style="font-size: 0.75rem; color: var(--gray-500);">${totalCourses}</span>
                                </a>
                                <c:forEach var="category" items="${categories}">
                                    <a href="${pageContext.request.contextPath}/courses?category=${category.slug}" 
                                       class="${selectedCategory.categoryId == category.categoryId ? 'active' : ''}"
                                       style="display: flex; align-items: center; justify-content: space-between; padding: 0.75rem 1rem; border-radius: var(--radius-lg); color: ${selectedCategory.categoryId == category.categoryId ? 'var(--primary)' : 'var(--gray-700)'}; background: ${selectedCategory.categoryId == category.categoryId ? 'var(--primary-100)' : 'transparent'};">
                                        <span style="display: flex; align-items: center; gap: 0.5rem;">
                                            <i class="${category.icon}" style="width: 18px;"></i>
                                            ${category.name}
                                        </span>
                                        <span style="font-size: 0.75rem; color: var(--gray-500);">${category.courseCount}</span>
                                    </a>
                                </c:forEach>
                            </div>
                        </div>
                        
                        <!-- Level Filter -->
                        <div style="margin-bottom: 1.5rem;">
                            <h4 style="font-size: 0.875rem; font-weight: 600; color: var(--gray-600); margin-bottom: 1rem; text-transform: uppercase; letter-spacing: 0.5px;">Tingkat Kesulitan</h4>
                            <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                                <label class="form-check" style="padding: 0.5rem 0;">
                                    <input type="checkbox" name="level" value="BEGINNER">
                                    <span>Pemula</span>
                                </label>
                                <label class="form-check" style="padding: 0.5rem 0;">
                                    <input type="checkbox" name="level" value="INTERMEDIATE">
                                    <span>Menengah</span>
                                </label>
                                <label class="form-check" style="padding: 0.5rem 0;">
                                    <input type="checkbox" name="level" value="ADVANCED">
                                    <span>Mahir</span>
                                </label>
                                <label class="form-check" style="padding: 0.5rem 0;">
                                    <input type="checkbox" name="level" value="ALL_LEVELS">
                                    <span>Semua Level</span>
                                </label>
                            </div>
                        </div>
                        
                        <!-- Price Filter -->
                        <div style="margin-bottom: 1.5rem;">
                            <h4 style="font-size: 0.875rem; font-weight: 600; color: var(--gray-600); margin-bottom: 1rem; text-transform: uppercase; letter-spacing: 0.5px;">Harga</h4>
                            <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                                <label class="form-check" style="padding: 0.5rem 0;">
                                    <input type="checkbox" name="price" value="free">
                                    <span>Gratis</span>
                                </label>
                                <label class="form-check" style="padding: 0.5rem 0;">
                                    <input type="checkbox" name="price" value="paid">
                                    <span>Berbayar</span>
                                </label>
                            </div>
                        </div>
                        
                        <!-- Rating Filter -->
                        <div>
                            <h4 style="font-size: 0.875rem; font-weight: 600; color: var(--gray-600); margin-bottom: 1rem; text-transform: uppercase; letter-spacing: 0.5px;">Rating</h4>
                            <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                                <label class="form-check" style="padding: 0.5rem 0;">
                                    <input type="checkbox" name="rating" value="4">
                                    <span style="display: flex; align-items: center; gap: 0.25rem;">
                                        <i class="fas fa-star" style="color: var(--warning);"></i>
                                        4.0 ke atas
                                    </span>
                                </label>
                                <label class="form-check" style="padding: 0.5rem 0;">
                                    <input type="checkbox" name="rating" value="3">
                                    <span style="display: flex; align-items: center; gap: 0.25rem;">
                                        <i class="fas fa-star" style="color: var(--warning);"></i>
                                        3.0 ke atas
                                    </span>
                                </label>
                            </div>
                        </div>
                    </div>
                </aside>
                
                <!-- Course Grid -->
                <div>
                    <!-- Sort & Results Info -->
                    <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 1.5rem; flex-wrap: wrap; gap: 1rem;">
                        <p style="color: var(--gray-600);">
                            Menampilkan <strong>${courses.size()}</strong> dari <strong>${totalCourses}</strong> kursus
                        </p>
                        <div style="display: flex; align-items: center; gap: 1rem;">
                            <select class="form-input" style="width: auto; padding: 0.5rem 1rem;" onchange="window.location.href=this.value">
                                <option value="${pageContext.request.contextPath}/courses?sort=popular">Terpopuler</option>
                                <option value="${pageContext.request.contextPath}/courses?sort=newest">Terbaru</option>
                                <option value="${pageContext.request.contextPath}/courses?sort=price-low">Harga: Terendah</option>
                                <option value="${pageContext.request.contextPath}/courses?sort=price-high">Harga: Tertinggi</option>
                                <option value="${pageContext.request.contextPath}/courses?sort=rating">Rating Tertinggi</option>
                            </select>
                        </div>
                    </div>
                    
                    <!-- Course Cards -->
                    <c:choose>
                        <c:when test="${not empty courses}">
                            <div class="grid grid-3">
                                <c:forEach var="course" items="${courses}">
                                    <div class="card course-card">
                                        <div class="course-card-image">
                                            <img src="${not empty course.thumbnail && !course.thumbnail.equals('default-course.png') ? course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400&h=225&fit=crop'}" 
                                                 alt="${course.title}">
                                            <c:if test="${course.free}">
                                                <span class="course-card-badge free">GRATIS</span>
                                            </c:if>
                                            <c:if test="${course.hasDiscount() && !course.free}">
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
                                                <span><i class="fas fa-book"></i> ${course.totalMaterials} materi</span>
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
                                                    Lihat
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            
                            <!-- Pagination -->
                            <c:if test="${totalPages > 1}">
                                <nav class="pagination">
                                    <c:if test="${currentPage > 1}">
                                        <a href="${pageContext.request.contextPath}/courses?page=${currentPage - 1}${not empty selectedCategory ? '&category='.concat(selectedCategory.slug) : ''}" class="pagination-item">
                                            <i class="fas fa-chevron-left"></i>
                                        </a>
                                    </c:if>
                                    
                                    <c:forEach begin="1" end="${totalPages}" var="page">
                                        <c:if test="${page <= 5 || page == totalPages || (page >= currentPage - 1 && page <= currentPage + 1)}">
                                            <a href="${pageContext.request.contextPath}/courses?page=${page}${not empty selectedCategory ? '&category='.concat(selectedCategory.slug) : ''}" 
                                               class="pagination-item ${page == currentPage ? 'active' : ''}">
                                                ${page}
                                            </a>
                                        </c:if>
                                    </c:forEach>
                                    
                                    <c:if test="${currentPage < totalPages}">
                                        <a href="${pageContext.request.contextPath}/courses?page=${currentPage + 1}${not empty selectedCategory ? '&category='.concat(selectedCategory.slug) : ''}" class="pagination-item">
                                            <i class="fas fa-chevron-right"></i>
                                        </a>
                                    </c:if>
                                </nav>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <!-- Empty State -->
                            <div class="empty-state">
                                <div class="empty-state-icon">
                                    <i class="fas fa-book-open"></i>
                                </div>
                                <h3 class="empty-state-title">Belum Ada Kursus</h3>
                                <p class="empty-state-description">
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
                                    Lihat Semua Kursus
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
    
    <script>
        // Navbar scroll effect
        window.addEventListener('scroll', function() {
            const navbar = document.getElementById('navbar');
            if (navbar && window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else if (navbar) {
                navbar.classList.remove('scrolled');
            }
        });
    </script>
</body>
</html>
