<%-- 
    Document   : search
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Course Search Results Page
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
    
    <!-- Search Header -->
    <section style="background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%); padding: 6rem 0 4rem; margin-top: 72px;">
        <div class="container">
            <h1 style="color: white; font-size: 2rem; margin-bottom: 1rem;">
                Hasil Pencarian untuk "<span style="color: var(--secondary);">${keyword}</span>"
            </h1>
            <p style="color: rgba(255,255,255,0.9);">
                Ditemukan ${totalCourses} kursus yang sesuai
            </p>
            
            <!-- Search Bar -->
            <form action="${pageContext.request.contextPath}/search" method="GET" style="margin-top: 1.5rem;">
                <div style="display: flex; gap: 1rem; max-width: 600px;">
                    <input type="text" name="q" value="${keyword}" 
                           placeholder="Cari kursus lainnya..." 
                           style="flex: 1; padding: 1rem 1.5rem; border: none; border-radius: var(--radius-xl); font-size: 1rem;">
                    <button type="submit" class="btn btn-secondary btn-lg">
                        <i class="fas fa-search"></i> Cari
                    </button>
                </div>
            </form>
        </div>
    </section>
    
    <!-- Search Results -->
    <section class="section" style="background: var(--gray-50);">
        <div class="container">
            <c:choose>
                <c:when test="${not empty courses}">
                    <!-- Quick Filters -->
                    <div style="display: flex; gap: 0.5rem; margin-bottom: 2rem; flex-wrap: wrap;">
                        <span style="padding: 0.5rem 1rem; color: var(--gray-600);">Filter:</span>
                        <c:forEach var="category" items="${categories}">
                            <a href="${pageContext.request.contextPath}/search?q=${keyword}&category=${category.slug}" 
                               class="btn btn-sm ${param.category == category.slug ? 'btn-primary' : 'btn-ghost'}" 
                               style="border: 1px solid var(--gray-200);">
                                ${category.name}
                            </a>
                        </c:forEach>
                    </div>
                    
                    <!-- Results Grid -->
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
                </c:when>
                <c:otherwise>
                    <!-- No Results -->
                    <div class="empty-state">
                        <div class="empty-state-icon">
                            <i class="fas fa-search"></i>
                        </div>
                        <h3 class="empty-state-title">Tidak Ada Hasil</h3>
                        <p class="empty-state-description">
                            Maaf, tidak ada kursus yang cocok dengan pencarian "${keyword}". 
                            Coba gunakan kata kunci lain atau jelajahi kategori kursus kami.
                        </p>
                        <div style="display: flex; gap: 1rem; justify-content: center;">
                            <a href="${pageContext.request.contextPath}/courses" class="btn btn-primary">
                                Jelajahi Kursus
                            </a>
                            <a href="${pageContext.request.contextPath}/" class="btn btn-outline">
                                Kembali ke Beranda
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
    
    <!-- Popular Searches -->
    <section class="section" style="background: white;">
        <div class="container">
            <h2 class="section-title" style="text-align: center; margin-bottom: 2rem;">Pencarian Populer</h2>
            <div style="display: flex; flex-wrap: wrap; justify-content: center; gap: 1rem;">
                <a href="${pageContext.request.contextPath}/search?q=javascript" class="btn btn-ghost" style="border: 1px solid var(--gray-200);">JavaScript</a>
                <a href="${pageContext.request.contextPath}/search?q=python" class="btn btn-ghost" style="border: 1px solid var(--gray-200);">Python</a>
                <a href="${pageContext.request.contextPath}/search?q=react" class="btn btn-ghost" style="border: 1px solid var(--gray-200);">React</a>
                <a href="${pageContext.request.contextPath}/search?q=flutter" class="btn btn-ghost" style="border: 1px solid var(--gray-200);">Flutter</a>
                <a href="${pageContext.request.contextPath}/search?q=machine learning" class="btn btn-ghost" style="border: 1px solid var(--gray-200);">Machine Learning</a>
                <a href="${pageContext.request.contextPath}/search?q=web development" class="btn btn-ghost" style="border: 1px solid var(--gray-200);">Web Development</a>
                <a href="${pageContext.request.contextPath}/search?q=android" class="btn btn-ghost" style="border: 1px solid var(--gray-200);">Android</a>
                <a href="${pageContext.request.contextPath}/search?q=java" class="btn btn-ghost" style="border: 1px solid var(--gray-200);">Java</a>
            </div>
        </div>
    </section>
    
    <!-- Footer -->
    <jsp:include page="/pages/common/footer.jsp"/>
    
    <script>
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
