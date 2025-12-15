<%-- 
    Document   : dashboard
    Created on : Dec 10, 2025, 4:42:22 PM
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
    <title>Dashboard Pelajar - NusaTech</title>
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
                <h1 class="page-title">Selamat Datang, ${sessionScope.user.name}! 👋</h1>
                <p class="page-subtitle">Lanjutkan perjalanan belajar coding Anda</p>
            </div>
            <div class="stats-grid">
                <div class="stat-card"><div class="stat-card-icon primary"><i class="fas fa-book-open"></i></div><div class="stat-card-value">${totalEnrolled != null ? totalEnrolled : 0}</div><div class="stat-card-label">Kursus Terdaftar</div></div>
                <div class="stat-card"><div class="stat-card-icon success"><i class="fas fa-check-circle"></i></div><div class="stat-card-value">${totalCompleted != null ? totalCompleted : 0}</div><div class="stat-card-label">Kursus Selesai</div></div>
                <div class="stat-card"><div class="stat-card-icon warning"><i class="fas fa-certificate"></i></div><div class="stat-card-value">${totalCompleted != null ? totalCompleted : 0}</div><div class="stat-card-label">Sertifikat</div></div>
                <div class="stat-card"><div class="stat-card-icon info"><i class="fas fa-clock"></i></div><div class="stat-card-value">0</div><div class="stat-card-label">Jam Belajar</div></div>
            </div>
            <div style="margin-bottom: 2rem;">
                <div class="section-header"><div><h2 class="section-title" style="font-size: 1.5rem;">Lanjutkan Belajar</h2></div><a href="${pageContext.request.contextPath}/my-learning" class="section-link">Lihat Semua <i class="fas fa-arrow-right"></i></a></div>
                <c:choose>
                    <c:when test="${not empty activeEnrollments}">
                        <c:forEach var="enrollment" items="${activeEnrollments}" end="2">
                            <div class="learning-card">
                                <div class="learning-card-image"><img src="${not empty enrollment.course.thumbnail ? enrollment.course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400&h=225&fit=crop'}" alt="${enrollment.course.title}"></div>
                                <div class="learning-card-content">
                                    <span class="learning-card-category">Kursus</span>
                                    <h3 class="learning-card-title">${enrollment.course.title}</h3>
                                    <div class="learning-card-progress"><div class="learning-card-progress-text"><span>Progress</span><span>${enrollment.progressInt}%</span></div><div class="progress"><div class="progress-bar" style="width: ${enrollment.progressInt}%"></div></div></div>
                                </div>
                                <a href="${pageContext.request.contextPath}/learn/${enrollment.course.slug}" class="btn btn-primary">Lanjutkan</a>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align: center; padding: 3rem; background: var(--white); border-radius: var(--radius-xl);">
                            <i class="fas fa-book-open" style="font-size: 3rem; color: var(--gray-300); margin-bottom: 1rem;"></i>
                            <h3>Belum ada kursus</h3>
                            <p style="color: var(--gray-500); margin-bottom: 1.5rem;">Mulai belajar sekarang!</p>
                            <a href="${pageContext.request.contextPath}/courses" class="btn btn-primary">Jelajahi Kursus</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>
</body>
</html>
