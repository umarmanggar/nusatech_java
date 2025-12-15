<%-- 
    Document   : dashboard
    Created on : Dec 10, 2025, 4:38:27 PM
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
    <title>Admin Dashboard - NusaTech</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <jsp:include page="/pages/common/navbar-dashboard.jsp"/>
    <div class="dashboard-layout">
        <aside class="sidebar">
            <div class="sidebar-menu">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-item active"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/users" class="sidebar-item"><i class="fas fa-users"></i> Pengguna</a>
                <a href="${pageContext.request.contextPath}/admin/courses" class="sidebar-item"><i class="fas fa-book"></i> Kursus</a>
                <a href="${pageContext.request.contextPath}/admin/categories" class="sidebar-item"><i class="fas fa-folder"></i> Kategori</a>
                <a href="${pageContext.request.contextPath}/admin/transactions" class="sidebar-item"><i class="fas fa-credit-card"></i> Transaksi</a>
                <a href="${pageContext.request.contextPath}/admin/reports" class="sidebar-item"><i class="fas fa-chart-bar"></i> Laporan</a>
                <hr style="margin: 1rem 0; border: none; border-top: 1px solid var(--gray-200);">
                <a href="${pageContext.request.contextPath}/admin/settings" class="sidebar-item"><i class="fas fa-cog"></i> Pengaturan</a>
                <a href="${pageContext.request.contextPath}/logout" class="sidebar-item" style="color: var(--error);"><i class="fas fa-sign-out-alt"></i> Keluar</a>
            </div>
        </aside>
        <main class="main-content">
            <div class="page-header">
                <h1 class="page-title">Admin Dashboard</h1>
                <p class="page-subtitle">Selamat datang di panel administrasi NusaTech</p>
            </div>
            <div class="stats-grid">
                <div class="stat-card"><div class="stat-card-icon primary"><i class="fas fa-users"></i></div><div class="stat-card-value">${totalStudents != null ? totalStudents : 0}</div><div class="stat-card-label">Total Pelajar</div></div>
                <div class="stat-card"><div class="stat-card-icon success"><i class="fas fa-chalkboard-teacher"></i></div><div class="stat-card-value">${totalLecturers != null ? totalLecturers : 0}</div><div class="stat-card-label">Total Pengajar</div></div>
                <div class="stat-card"><div class="stat-card-icon warning"><i class="fas fa-book"></i></div><div class="stat-card-value">${totalCourses != null ? totalCourses : 0}</div><div class="stat-card-label">Total Kursus</div></div>
                <div class="stat-card"><div class="stat-card-icon info"><i class="fas fa-money-bill-wave"></i></div><div class="stat-card-value">Rp <fmt:formatNumber value="${totalRevenue != null ? totalRevenue : 0}" pattern="#,###"/></div><div class="stat-card-label">Total Pendapatan</div></div>
            </div>
            
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-top: 2rem;">
                <div style="background: var(--white); border-radius: var(--radius-xl); padding: 1.5rem;">
                    <h3 style="margin-bottom: 1rem;">Pengguna Terbaru</h3>
                    <c:forEach var="user" items="${recentUsers}" end="4">
                        <div style="display: flex; align-items: center; gap: 1rem; padding: 0.75rem 0; border-bottom: 1px solid var(--gray-100);">
                            <img src="https://ui-avatars.com/api/?name=${user.name}&background=8B1538&color=fff" style="width: 40px; height: 40px; border-radius: 50%;">
                            <div style="flex: 1;"><strong>${user.name}</strong><br><span style="font-size: 0.875rem; color: var(--gray-500);">${user.email}</span></div>
                            <span class="badge badge-${user.role == 'STUDENT' ? 'primary' : 'success'}">${user.roleDisplayName}</span>
                        </div>
                    </c:forEach>
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline w-100" style="margin-top: 1rem;">Lihat Semua</a>
                </div>
                <div style="background: var(--white); border-radius: var(--radius-xl); padding: 1.5rem;">
                    <h3 style="margin-bottom: 1rem;">Kursus Terbaru</h3>
                    <c:forEach var="course" items="${recentCourses}" end="4">
                        <div style="display: flex; align-items: center; gap: 1rem; padding: 0.75rem 0; border-bottom: 1px solid var(--gray-100);">
                            <img src="${not empty course.thumbnail ? course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=60&h=40&fit=crop'}" style="width: 60px; height: 40px; border-radius: var(--radius-sm); object-fit: cover;">
                            <div style="flex: 1;"><strong>${course.title}</strong><br><span style="font-size: 0.875rem; color: var(--gray-500);">oleh ${course.lecturer.name}</span></div>
                            <span class="badge badge-${course.status == 'PUBLISHED' ? 'success' : 'warning'}">${course.statusDisplayName}</span>
                        </div>
                    </c:forEach>
                    <a href="${pageContext.request.contextPath}/admin/courses" class="btn btn-outline w-100" style="margin-top: 1rem;">Lihat Semua</a>
                </div>
            </div>
        </main>
    </div>
</body>
</html>

