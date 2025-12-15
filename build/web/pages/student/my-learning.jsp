<%-- 
    Document   : my-learning
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Student My Learning Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Belajar Saya - NusaTech</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <jsp:include page="/pages/common/navbar-dashboard.jsp"/>
    
    <div class="dashboard-layout">
        <jsp:include page="/pages/common/sidebar-student.jsp"/>
        
        <main class="main-content">
            <div class="page-header">
                <h1 class="page-title">Belajar Saya</h1>
                <p class="page-subtitle">Pantau progress belajar Anda</p>
            </div>
            
            <!-- Filter Tabs -->
            <div class="tabs" style="margin-bottom: 2rem;">
                <a href="${pageContext.request.contextPath}/my-learning" class="tab-item ${empty filter ? 'active' : ''}">
                    Semua Kursus
                </a>
                <a href="${pageContext.request.contextPath}/my-learning?filter=active" class="tab-item ${filter == 'active' ? 'active' : ''}">
                    Sedang Dipelajari
                </a>
                <a href="${pageContext.request.contextPath}/my-learning?filter=completed" class="tab-item ${filter == 'completed' ? 'active' : ''}">
                    Selesai
                </a>
            </div>
            
            <!-- Courses List -->
            <c:choose>
                <c:when test="${not empty enrollments}">
                    <div style="display: flex; flex-direction: column; gap: 1rem;">
                        <c:forEach var="enrollment" items="${enrollments}">
                            <div class="learning-card">
                                <div class="learning-card-image">
                                    <img src="${not empty enrollment.course.thumbnail && !enrollment.course.thumbnail.equals('default-course.png') ? enrollment.course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400&h=225&fit=crop'}" 
                                         alt="${enrollment.course.title}">
                                </div>
                                <div class="learning-card-content">
                                    <span class="learning-card-category">
                                        <c:choose>
                                            <c:when test="${enrollment.status == 'COMPLETED'}">
                                                <i class="fas fa-check-circle" style="color: var(--success);"></i> Selesai
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-play-circle" style="color: var(--primary);"></i> Sedang Dipelajari
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                    <h3 class="learning-card-title">${enrollment.course.title}</h3>
                                    <div class="learning-card-instructor">
                                        <c:if test="${not empty enrollment.course.lecturer}">
                                            Oleh ${enrollment.course.lecturer.name}
                                        </c:if>
                                    </div>
                                    <div class="learning-card-progress">
                                        <div class="learning-card-progress-text">
                                            <span>Progress</span>
                                            <span>${enrollment.progressInt}%</span>
                                        </div>
                                        <div class="progress">
                                            <div class="progress-bar ${enrollment.status == 'COMPLETED' ? 'success' : ''}" style="width: ${enrollment.progressInt}%"></div>
                                        </div>
                                    </div>
                                </div>
                                <div style="display: flex; flex-direction: column; gap: 0.5rem; min-width: 150px;">
                                    <c:choose>
                                        <c:when test="${enrollment.status == 'COMPLETED'}">
                                            <a href="${pageContext.request.contextPath}/learn/${enrollment.course.slug}" class="btn btn-outline">
                                                <i class="fas fa-redo"></i> Ulangi
                                            </a>
                                            <c:if test="${enrollment.certificateIssued}">
                                                <a href="${enrollment.certificateUrl}" class="btn btn-secondary" target="_blank">
                                                    <i class="fas fa-certificate"></i> Sertifikat
                                                </a>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/learn/${enrollment.course.slug}" class="btn btn-primary">
                                                <i class="fas fa-play"></i> Lanjutkan
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                    <small style="text-align: center; color: var(--gray-500);">
                                        <c:if test="${not empty enrollment.lastAccessedAt}">
                                            Terakhir: <fmt:formatDate value="${enrollment.lastAccessedAt}" pattern="dd MMM yyyy"/>
                                        </c:if>
                                    </small>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Empty State -->
                    <div class="empty-state">
                        <div class="empty-state-icon">
                            <i class="fas fa-book-open"></i>
                        </div>
                        <h3 class="empty-state-title">
                            <c:choose>
                                <c:when test="${filter == 'completed'}">Belum Ada Kursus yang Selesai</c:when>
                                <c:when test="${filter == 'active'}">Tidak Ada Kursus Aktif</c:when>
                                <c:otherwise>Belum Ada Kursus</c:otherwise>
                            </c:choose>
                        </h3>
                        <p class="empty-state-description">
                            <c:choose>
                                <c:when test="${filter == 'completed'}">Selesaikan kursus untuk mendapatkan sertifikat!</c:when>
                                <c:when test="${filter == 'active'}">Mulai belajar kursus baru sekarang.</c:when>
                                <c:otherwise>Mulai perjalanan belajar Anda dengan mengikuti kursus pertama.</c:otherwise>
                            </c:choose>
                        </p>
                        <a href="${pageContext.request.contextPath}/courses" class="btn btn-primary btn-lg">
                            <i class="fas fa-search"></i> Jelajahi Kursus
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
</body>
</html>
