<%-- 
    Document   : dashboard
    Created on : Dec 10, 2025, 4:41:59 PM
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
    <title>Dashboard Pengajar - NusaTech</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <jsp:include page="/pages/common/navbar-dashboard.jsp"/>
    <div class="dashboard-layout">
        <aside class="sidebar">
            <div class="sidebar-menu">
                <a href="${pageContext.request.contextPath}/lecturer/dashboard" class="sidebar-item active"><i class="fas fa-home"></i> Dashboard</a>
                <a href="${pageContext.request.contextPath}/lecturer/courses" class="sidebar-item"><i class="fas fa-book"></i> Kursus Saya</a>
                <a href="${pageContext.request.contextPath}/lecturer/course/create" class="sidebar-item"><i class="fas fa-plus-circle"></i> Buat Kursus</a>
                <a href="${pageContext.request.contextPath}/lecturer/students" class="sidebar-item"><i class="fas fa-users"></i> Pelajar</a>
                <a href="${pageContext.request.contextPath}/lecturer/earnings" class="sidebar-item"><i class="fas fa-wallet"></i> Pendapatan</a>
                <hr style="margin: 1rem 0; border: none; border-top: 1px solid var(--gray-200);">
                <a href="${pageContext.request.contextPath}/lecturer/profile" class="sidebar-item"><i class="fas fa-user"></i> Profil</a>
                <a href="${pageContext.request.contextPath}/logout" class="sidebar-item" style="color: var(--error);"><i class="fas fa-sign-out-alt"></i> Keluar</a>
            </div>
        </aside>
        <main class="main-content">
            <div class="page-header" style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h1 class="page-title">Dashboard Pengajar</h1>
                    <p class="page-subtitle">Selamat datang, ${sessionScope.user.name}!</p>
                </div>
                <a href="${pageContext.request.contextPath}/lecturer/course/create" class="btn btn-primary"><i class="fas fa-plus"></i> Buat Kursus Baru</a>
            </div>
            <div class="stats-grid">
                <div class="stat-card"><div class="stat-card-icon primary"><i class="fas fa-book"></i></div><div class="stat-card-value">${totalCourses != null ? totalCourses : 0}</div><div class="stat-card-label">Total Kursus</div></div>
                <div class="stat-card"><div class="stat-card-icon success"><i class="fas fa-users"></i></div><div class="stat-card-value">${totalStudents != null ? totalStudents : 0}</div><div class="stat-card-label">Total Pelajar</div></div>
                <div class="stat-card"><div class="stat-card-icon warning"><i class="fas fa-wallet"></i></div><div class="stat-card-value">Rp <fmt:formatNumber value="${sessionScope.user.balance != null ? sessionScope.user.balance : 0}" pattern="#,###"/></div><div class="stat-card-label">Saldo</div></div>
                <div class="stat-card"><div class="stat-card-icon info"><i class="fas fa-star"></i></div><div class="stat-card-value">4.8</div><div class="stat-card-label">Rating</div></div>
            </div>
            
            <div style="margin-top: 2rem;">
                <div class="section-header"><h2 style="font-size: 1.5rem;">Kursus Saya</h2><a href="${pageContext.request.contextPath}/lecturer/courses" class="section-link">Lihat Semua <i class="fas fa-arrow-right"></i></a></div>
                <c:choose>
                    <c:when test="${not empty courses}">
                        <div class="grid grid-3">
                            <c:forEach var="course" items="${courses}" end="2">
                                <div class="card course-card">
                                    <div class="course-card-image"><img src="${not empty course.thumbnail ? course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400&h=225&fit=crop'}" alt="${course.title}"><span class="course-card-badge" style="background: ${course.status == 'PUBLISHED' ? 'var(--success)' : 'var(--warning)'};">${course.statusDisplayName}</span></div>
                                    <div class="course-card-body">
                                        <h3 class="course-card-title">${course.title}</h3>
                                        <div class="course-card-meta"><span><i class="fas fa-users"></i> ${course.totalStudents} pelajar</span><span class="course-card-rating"><i class="fas fa-star"></i> <fmt:formatNumber value="${course.avgRating}" maxFractionDigits="1"/></span></div>
                                        <div class="course-card-footer"><span style="font-weight: 600; color: var(--success);">Rp <fmt:formatNumber value="${course.price}" pattern="#,###"/></span><a href="${pageContext.request.contextPath}/lecturer/course/edit/${course.courseId}" class="btn btn-sm btn-outline">Edit</a></div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align: center; padding: 4rem; background: var(--white); border-radius: var(--radius-xl);">
                            <i class="fas fa-book" style="font-size: 4rem; color: var(--gray-300); margin-bottom: 1.5rem;"></i>
                            <h3>Belum ada kursus</h3>
                            <p style="color: var(--gray-500); margin-bottom: 1.5rem;">Mulai buat kursus pertama Anda</p>
                            <a href="${pageContext.request.contextPath}/lecturer/course/create" class="btn btn-primary btn-lg"><i class="fas fa-plus"></i> Buat Kursus</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>
</body>
</html>
