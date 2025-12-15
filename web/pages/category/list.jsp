<%-- 
    Document   : list (categories)
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Public Categories List Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kategori Kursus - NusaTech</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <jsp:include page="/pages/common/navbar.jsp"/>
    
    <!-- Page Header -->
    <section class="page-header" style="background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%); padding: 4rem 0; color: white;">
        <div class="container">
            <nav class="breadcrumb" style="margin-bottom: 1rem;">
                <a href="${pageContext.request.contextPath}/" style="color: rgba(255,255,255,0.8);">Beranda</a>
                <span style="margin: 0 0.5rem; color: rgba(255,255,255,0.6);">/</span>
                <span>Kategori</span>
            </nav>
            <h1 style="font-size: 2.5rem; font-weight: 800; margin-bottom: 0.5rem;">Kategori Kursus</h1>
            <p style="font-size: 1.125rem; opacity: 0.9;">Jelajahi berbagai kategori pembelajaran untuk mengembangkan skill Anda</p>
        </div>
    </section>
    
    <!-- Categories Grid -->
    <section class="section" style="padding: 4rem 0;">
        <div class="container">
            <c:choose>
                <c:when test="${not empty categories}">
                    <div class="grid grid-4">
                        <c:forEach var="category" items="${categories}">
                            <a href="${pageContext.request.contextPath}/courses?category=${category.categoryId}" class="category-card" style="text-decoration: none;">
                                <div class="category-card-icon" style="background: ${category.color}20; color: ${category.color};">
                                    <i class="fas ${category.icon}"></i>
                                </div>
                                <h3 class="category-card-title">${category.name}</h3>
                                <p class="category-card-desc">${category.description}</p>
                                <span class="category-card-count">${category.courseCount} Kursus</span>
                            </a>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-state-icon">
                            <i class="fas fa-folder-open"></i>
                        </div>
                        <h3 class="empty-state-title">Belum Ada Kategori</h3>
                        <p class="empty-state-description">Kategori kursus akan segera tersedia.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
    
    <!-- Stats Section -->
    <section style="background: var(--gray-50); padding: 4rem 0;">
        <div class="container">
            <div class="grid grid-4" style="text-align: center;">
                <div>
                    <div style="font-size: 3rem; font-weight: 800; color: var(--primary);">${totalCourses != null ? totalCourses : '100'}+</div>
                    <div style="color: var(--gray-600);">Total Kursus</div>
                </div>
                <div>
                    <div style="font-size: 3rem; font-weight: 800; color: var(--primary);">${totalStudents != null ? totalStudents : '5000'}+</div>
                    <div style="color: var(--gray-600);">Pelajar Aktif</div>
                </div>
                <div>
                    <div style="font-size: 3rem; font-weight: 800; color: var(--primary);">${totalLecturers != null ? totalLecturers : '50'}+</div>
                    <div style="color: var(--gray-600);">Pengajar Expert</div>
                </div>
                <div>
                    <div style="font-size: 3rem; font-weight: 800; color: var(--primary);">${not empty categories ? categories.size() : '8'}</div>
                    <div style="color: var(--gray-600);">Kategori</div>
                </div>
            </div>
        </div>
    </section>
    
    <jsp:include page="/pages/common/footer.jsp"/>
</body>
</html>
