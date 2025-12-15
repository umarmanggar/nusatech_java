<%-- 
    Document   : courses
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Lecturer Courses Management Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kursus Saya - NusaTech</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <jsp:include page="/pages/common/navbar-dashboard.jsp"/>
    
    <div class="dashboard-layout">
        <aside class="sidebar">
            <div class="sidebar-menu">
                <a href="${pageContext.request.contextPath}/lecturer/dashboard" class="sidebar-item">
                    <i class="fas fa-home"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/lecturer/courses" class="sidebar-item active">
                    <i class="fas fa-book"></i> Kursus Saya
                </a>
                <a href="${pageContext.request.contextPath}/lecturer/course/create" class="sidebar-item">
                    <i class="fas fa-plus-circle"></i> Buat Kursus
                </a>
                <a href="${pageContext.request.contextPath}/lecturer/students" class="sidebar-item">
                    <i class="fas fa-users"></i> Pelajar
                </a>
                <a href="${pageContext.request.contextPath}/lecturer/earnings" class="sidebar-item">
                    <i class="fas fa-wallet"></i> Pendapatan
                </a>
                <hr style="margin: 1rem 0; border: none; border-top: 1px solid var(--gray-200);">
                <a href="${pageContext.request.contextPath}/lecturer/profile" class="sidebar-item">
                    <i class="fas fa-user"></i> Profil
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="sidebar-item" style="color: var(--error);">
                    <i class="fas fa-sign-out-alt"></i> Keluar
                </a>
            </div>
        </aside>
        
        <main class="main-content">
            <div class="page-header" style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
                <div>
                    <h1 class="page-title">
                        <i class="fas fa-book" style="color: var(--primary);"></i> Kursus Saya
                    </h1>
                    <p class="page-subtitle">Kelola semua kursus yang Anda buat</p>
                </div>
                <a href="${pageContext.request.contextPath}/lecturer/course/create" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Buat Kursus Baru
                </a>
            </div>
            
            <!-- Course Statistics -->
            <div class="stats-grid" style="margin-bottom: 2rem;">
                <div class="stat-card">
                    <div class="stat-card-icon primary"><i class="fas fa-book-open"></i></div>
                    <div class="stat-card-value">${publishedCount != null ? publishedCount : 0}</div>
                    <div class="stat-card-label">Dipublikasikan</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-icon warning"><i class="fas fa-clock"></i></div>
                    <div class="stat-card-value">${pendingCount != null ? pendingCount : 0}</div>
                    <div class="stat-card-label">Menunggu Review</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-icon info"><i class="fas fa-pencil-alt"></i></div>
                    <div class="stat-card-value">${draftCount != null ? draftCount : 0}</div>
                    <div class="stat-card-label">Draft</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-icon success"><i class="fas fa-users"></i></div>
                    <div class="stat-card-value">${totalStudents != null ? totalStudents : 0}</div>
                    <div class="stat-card-label">Total Pelajar</div>
                </div>
            </div>
            
            <!-- Filter Bar -->
            <div class="card" style="margin-bottom: 1.5rem;">
                <div style="padding: 1rem; display: flex; gap: 1rem; flex-wrap: wrap; align-items: center;">
                    <div class="btn-group">
                        <a href="${pageContext.request.contextPath}/lecturer/courses" 
                           class="btn ${empty param.status ? 'btn-primary' : 'btn-outline'}">Semua</a>
                        <a href="${pageContext.request.contextPath}/lecturer/courses?status=PUBLISHED" 
                           class="btn ${param.status == 'PUBLISHED' ? 'btn-primary' : 'btn-outline'}">Dipublikasikan</a>
                        <a href="${pageContext.request.contextPath}/lecturer/courses?status=PENDING" 
                           class="btn ${param.status == 'PENDING' ? 'btn-primary' : 'btn-outline'}">Pending</a>
                        <a href="${pageContext.request.contextPath}/lecturer/courses?status=DRAFT" 
                           class="btn ${param.status == 'DRAFT' ? 'btn-primary' : 'btn-outline'}">Draft</a>
                    </div>
                    <div style="flex: 1; min-width: 200px;">
                        <form action="${pageContext.request.contextPath}/lecturer/courses" method="get" style="display: flex; gap: 0.5rem;">
                            <input type="hidden" name="status" value="${param.status}">
                            <input type="text" name="search" class="form-control" placeholder="Cari kursus..." value="${param.search}">
                            <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i></button>
                        </form>
                    </div>
                </div>
            </div>
            
            <!-- Courses Grid -->
            <c:choose>
                <c:when test="${not empty courses}">
                    <div class="grid grid-3">
                        <c:forEach var="course" items="${courses}">
                            <div class="card course-card">
                                <div class="course-card-image">
                                    <img src="${not empty course.thumbnail ? course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400&h=225&fit=crop'}" 
                                         alt="${course.title}">
                                    <c:choose>
                                        <c:when test="${course.status == 'PUBLISHED'}">
                                            <span class="course-card-badge" style="background: var(--success);">Dipublikasikan</span>
                                        </c:when>
                                        <c:when test="${course.status == 'PENDING'}">
                                            <span class="course-card-badge" style="background: var(--warning);">Pending</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="course-card-badge" style="background: var(--gray-500);">Draft</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="course-card-body">
                                    <h3 class="course-card-title">${course.title}</h3>
                                    <div class="course-card-meta">
                                        <span><i class="fas fa-users"></i> ${course.totalStudents} pelajar</span>
                                        <span class="course-card-rating">
                                            <i class="fas fa-star"></i> 
                                            <fmt:formatNumber value="${course.avgRating}" maxFractionDigits="1"/>
                                        </span>
                                    </div>
                                    <div style="margin: 0.75rem 0; font-size: 0.875rem; color: var(--gray-500);">
                                        <span><i class="fas fa-book-open"></i> ${course.totalSections} bab</span>
                                        <span style="margin-left: 1rem;"><i class="fas fa-file-alt"></i> ${course.totalMaterials} materi</span>
                                    </div>
                                    <div class="course-card-footer">
                                        <c:choose>
                                            <c:when test="${course.isFree}">
                                                <span style="font-weight: 600; color: var(--success);">GRATIS</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="font-weight: 600; color: var(--success);">
                                                    Rp <fmt:formatNumber value="${course.price}" pattern="#,###"/>
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                        <div style="display: flex; gap: 0.5rem;">
                                            <a href="${pageContext.request.contextPath}/lecturer/course/edit/${course.courseId}" 
                                               class="btn btn-sm btn-outline" title="Edit Kursus">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/lecturer/course/content/${course.courseId}" 
                                               class="btn btn-sm btn-primary" title="Kelola Materi">
                                                <i class="fas fa-list"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <div class="pagination" style="margin-top: 2rem;">
                            <c:if test="${currentPage > 1}">
                                <a href="${pageContext.request.contextPath}/lecturer/courses?page=${currentPage - 1}&status=${param.status}" 
                                   class="pagination-item">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </c:if>
                            
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <a href="${pageContext.request.contextPath}/lecturer/courses?page=${i}&status=${param.status}" 
                                   class="pagination-item ${i == currentPage ? 'active' : ''}">${i}</a>
                            </c:forEach>
                            
                            <c:if test="${currentPage < totalPages}">
                                <a href="${pageContext.request.contextPath}/lecturer/courses?page=${currentPage + 1}&status=${param.status}" 
                                   class="pagination-item">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </c:if>
                        </div>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-state-icon">
                            <i class="fas fa-book"></i>
                        </div>
                        <h3 class="empty-state-title">Belum Ada Kursus</h3>
                        <p class="empty-state-description">
                            <c:choose>
                                <c:when test="${not empty param.status}">
                                    Tidak ada kursus dengan status "${param.status}".
                                </c:when>
                                <c:when test="${not empty param.search}">
                                    Tidak ada kursus dengan kata kunci "${param.search}".
                                </c:when>
                                <c:otherwise>
                                    Mulai buat kursus pertama Anda dan bagikan pengetahuan dengan ribuan pelajar.
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <a href="${pageContext.request.contextPath}/lecturer/course/create" class="btn btn-primary btn-lg">
                            <i class="fas fa-plus"></i> Buat Kursus Baru
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
</body>
</html>
