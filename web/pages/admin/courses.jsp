<%-- 
    Document   : courses
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Admin Course Management Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manajemen Kursus - Admin NusaTech</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <jsp:include page="/pages/common/navbar-dashboard.jsp"/>
    
    <div class="dashboard-layout">
        <!-- Admin Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-menu">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-item">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/admin/users" class="sidebar-item">
                    <i class="fas fa-users"></i> Pengguna
                </a>
                <a href="${pageContext.request.contextPath}/admin/courses" class="sidebar-item active">
                    <i class="fas fa-book"></i> Kursus
                </a>
                <a href="${pageContext.request.contextPath}/admin/categories" class="sidebar-item">
                    <i class="fas fa-folder"></i> Kategori
                </a>
                <a href="${pageContext.request.contextPath}/admin/transactions" class="sidebar-item">
                    <i class="fas fa-credit-card"></i> Transaksi
                </a>
                <a href="${pageContext.request.contextPath}/admin/reports" class="sidebar-item">
                    <i class="fas fa-chart-bar"></i> Laporan
                </a>
                <div class="sidebar-divider"></div>
                <a href="${pageContext.request.contextPath}/admin/settings" class="sidebar-item">
                    <i class="fas fa-cog"></i> Pengaturan
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="sidebar-item" style="color: var(--error);">
                    <i class="fas fa-sign-out-alt"></i> Keluar
                </a>
            </div>
        </aside>
        
        <!-- Main Content -->
        <main class="main-content">
            <div class="page-header">
                <h1 class="page-title">Manajemen Kursus</h1>
                <p class="page-subtitle">Kelola semua kursus di platform</p>
            </div>
            
            <!-- Filter Tabs -->
            <div class="tabs" style="margin-bottom: 1.5rem;">
                <a href="${pageContext.request.contextPath}/admin/courses" class="tab-item ${empty param.status ? 'active' : ''}">Semua</a>
                <a href="${pageContext.request.contextPath}/admin/courses?status=PUBLISHED" class="tab-item ${param.status == 'PUBLISHED' ? 'active' : ''}">Published</a>
                <a href="${pageContext.request.contextPath}/admin/courses?status=PENDING" class="tab-item ${param.status == 'PENDING' ? 'active' : ''}">Pending Review</a>
                <a href="${pageContext.request.contextPath}/admin/courses?status=DRAFT" class="tab-item ${param.status == 'DRAFT' ? 'active' : ''}">Draft</a>
            </div>
            
            <!-- Search & Actions -->
            <div style="display: flex; gap: 1rem; margin-bottom: 1.5rem; flex-wrap: wrap;">
                <div class="navbar-search" style="flex: 1; max-width: 400px;">
                    <i class="fas fa-search"></i>
                    <input type="text" id="searchCourse" placeholder="Cari kursus..." style="width: 100%;" onkeyup="filterCourses()">
                </div>
                <select id="filterCategory" class="form-input" style="width: auto;" onchange="filterCourses()">
                    <option value="">Semua Kategori</option>
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.categoryId}">${category.name}</option>
                    </c:forEach>
                </select>
            </div>
            
            <!-- Courses Table -->
            <div class="table-container">
                <table class="data-table" id="coursesTable">
                    <thead>
                        <tr>
                            <th>Kursus</th>
                            <th>Pengajar</th>
                            <th>Kategori</th>
                            <th>Harga</th>
                            <th>Pelajar</th>
                            <th>Rating</th>
                            <th>Status</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="course" items="${courses}">
                            <tr data-category="${course.categoryId}">
                                <td>
                                    <div style="display: flex; align-items: center; gap: 0.75rem;">
                                        <img src="${not empty course.thumbnail && !course.thumbnail.equals('default-course.png') ? course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=60&h=40&fit=crop'}" 
                                             style="width: 80px; height: 50px; border-radius: var(--radius-md); object-fit: cover;">
                                        <div>
                                            <strong style="display: block; max-width: 250px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${course.title}</strong>
                                            <small style="color: var(--gray-500);">${course.levelDisplayName}</small>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div style="display: flex; align-items: center; gap: 0.5rem;">
                                        <img src="https://ui-avatars.com/api/?name=${course.lecturer.name}&background=8B1538&color=fff&size=28" 
                                             style="width: 28px; height: 28px; border-radius: 50%;">
                                        ${course.lecturer.name}
                                    </div>
                                </td>
                                <td><span class="badge badge-primary">${course.category.name}</span></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${course.free}">
                                            <span style="color: var(--success); font-weight: 600;">Gratis</span>
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber value="${course.price}" type="currency" currencySymbol="Rp " maxFractionDigits="0"/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${course.totalStudents}</td>
                                <td>
                                    <span style="display: flex; align-items: center; gap: 0.25rem;">
                                        <i class="fas fa-star" style="color: var(--warning);"></i>
                                        <fmt:formatNumber value="${course.avgRating}" maxFractionDigits="1"/>
                                    </span>
                                </td>
                                <td>
                                    <span class="badge badge-${course.status == 'PUBLISHED' ? 'success' : course.status == 'PENDING' ? 'warning' : 'info'}">
                                        ${course.statusDisplayName}
                                    </span>
                                </td>
                                <td>
                                    <div style="display: flex; gap: 0.5rem;">
                                        <a href="${pageContext.request.contextPath}/course/${course.slug}" class="btn btn-sm btn-ghost" title="Lihat">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <c:if test="${course.status == 'PENDING'}">
                                            <button onclick="approveCourse(${course.courseId})" class="btn btn-sm btn-ghost" title="Approve" style="color: var(--success);">
                                                <i class="fas fa-check"></i>
                                            </button>
                                            <button onclick="rejectCourse(${course.courseId})" class="btn btn-sm btn-ghost" title="Reject" style="color: var(--error);">
                                                <i class="fas fa-times"></i>
                                            </button>
                                        </c:if>
                                        <button onclick="toggleFeatured(${course.courseId}, ${course.featured})" 
                                                class="btn btn-sm btn-ghost" 
                                                title="${course.featured ? 'Hapus dari Featured' : 'Jadikan Featured'}"
                                                style="color: ${course.featured ? 'var(--secondary)' : 'var(--gray-400)'}">
                                            <i class="fas fa-star"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty courses}">
                            <tr>
                                <td colspan="8" style="text-align: center; padding: 3rem;">
                                    <i class="fas fa-book" style="font-size: 3rem; color: var(--gray-300); margin-bottom: 1rem;"></i>
                                    <p style="color: var(--gray-500);">Belum ada kursus</p>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
    
    <script>
        function filterCourses() {
            const searchTerm = document.getElementById('searchCourse').value.toLowerCase();
            const categoryFilter = document.getElementById('filterCategory').value;
            
            document.querySelectorAll('#coursesTable tbody tr').forEach(row => {
                const text = row.textContent.toLowerCase();
                const category = row.dataset.category;
                
                const matchesSearch = text.includes(searchTerm);
                const matchesCategory = !categoryFilter || category === categoryFilter;
                
                row.style.display = matchesSearch && matchesCategory ? '' : 'none';
            });
        }
        
        function approveCourse(courseId) {
            if (confirm('Approve kursus ini?')) {
                window.location.href = '${pageContext.request.contextPath}/admin/course/approve/' + courseId;
            }
        }
        
        function rejectCourse(courseId) {
            const reason = prompt('Alasan penolakan:');
            if (reason !== null) {
                window.location.href = '${pageContext.request.contextPath}/admin/course/reject/' + courseId + '?reason=' + encodeURIComponent(reason);
            }
        }
        
        function toggleFeatured(courseId, isFeatured) {
            window.location.href = '${pageContext.request.contextPath}/admin/course/featured/' + courseId;
        }
    </script>
</body>
</html>
