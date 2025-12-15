<%-- 
    Document   : my-learning
    Created on : Dec 10, 2025, 4:43:06 PM
    Author     : user
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Belajar Saya - NusaTech</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        .filter-tabs { display: flex; gap: 0.5rem; margin-bottom: 2rem; }
        .filter-tab { padding: 0.75rem 1.5rem; border-radius: var(--radius-full); font-weight: 600; color: var(--gray-600); background: var(--white); border: 2px solid var(--gray-200); transition: 0.2s; }
        .filter-tab:hover { border-color: var(--primary); color: var(--primary); }
        .filter-tab.active { background: var(--primary); color: var(--white); border-color: var(--primary); }
    </style>
</head>
<body>
    <jsp:include page="/pages/common/navbar-dashboard.jsp"/>
    <div class="dashboard-layout">
        <jsp:include page="/pages/common/sidebar-student.jsp"/>
        <main class="main-content">
            <div class="page-header">
                <h1 class="page-title">Belajar Saya</h1>
                <p class="page-subtitle">Kelola dan lanjutkan kursus yang Anda ikuti</p>
            </div>
            <div class="filter-tabs">
                <a href="${pageContext.request.contextPath}/my-learning" class="filter-tab ${empty filter ? 'active' : ''}">Semua</a>
                <a href="${pageContext.request.contextPath}/my-learning?filter=active" class="filter-tab ${filter == 'active' ? 'active' : ''}">Sedang Belajar</a>
                <a href="${pageContext.request.contextPath}/my-learning?filter=completed" class="filter-tab ${filter == 'completed' ? 'active' : ''}">Selesai</a>
            </div>
            <c:choose>
                <c:when test="${not empty enrollments}">
                    <c:forEach var="enrollment" items="${enrollments}">
                        <div class="learning-card">
                            <div class="learning-card-image"><img src="${not empty enrollment.course.thumbnail ? enrollment.course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400&h=225&fit=crop'}" alt="${enrollment.course.title}"></div>
                            <div class="learning-card-content">
                                <span class="learning-card-category">Kursus</span>
                                <h3 class="learning-card-title">${enrollment.course.title}</h3>
                                <div class="learning-card-progress"><div class="learning-card-progress-text"><span>Progress</span><span>${enrollment.progressInt}%</span></div><div class="progress"><div class="progress-bar" style="width: ${enrollment.progressInt}%"></div></div></div>
                            </div>
                            <c:choose>
                                <c:when test="${enrollment.status == 'COMPLETED'}">
                                    <a href="${pageContext.request.contextPath}/student/certificates" class="btn btn-secondary"><i class="fas fa-certificate"></i> Sertifikat</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/learn/${enrollment.course.slug}" class="btn btn-primary">Lanjutkan</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 4rem; background: var(--white); border-radius: var(--radius-xl);">
                        <i class="fas fa-book-open" style="font-size: 4rem; color: var(--gray-300); margin-bottom: 1.5rem;"></i>
                        <h3>Belum ada kursus</h3>
                        <p style="color: var(--gray-500); margin-bottom: 1.5rem;">Anda belum mendaftar kursus apapun</p>
                        <a href="${pageContext.request.contextPath}/courses" class="btn btn-primary btn-lg">Jelajahi Kursus</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
</body>
</html>
