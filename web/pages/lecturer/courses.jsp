<%-- 
    Document   : courses
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Lecturer Courses Management with Bootstrap 5
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
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root { --primary: #8B1538; --primary-dark: #6d1029; --secondary: #D4A84B; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #f8f9fa; }
        .btn-primary { background-color: var(--primary); border-color: var(--primary); }
        .btn-primary:hover { background-color: var(--primary-dark); border-color: var(--primary-dark); }
        .btn-outline-primary { color: var(--primary); border-color: var(--primary); }
        .btn-outline-primary:hover { background-color: var(--primary); border-color: var(--primary); }
        .text-primary { color: var(--primary) !important; }
        
        .dashboard-wrapper { display: flex; min-height: 100vh; padding-top: 56px; }
        .main-content { flex: 1; margin-left: 280px; padding: 2rem; }
        @media (max-width: 991.98px) { .main-content { margin-left: 0; } }
        
        .sidebar {
            width: 280px; min-height: calc(100vh - 56px); background: white;
            border-right: 1px solid #e5e7eb; position: fixed; top: 56px; left: 0; z-index: 1020;
        }
        .sidebar-user { padding: 1.5rem; background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%); color: white; }
        .sidebar-menu { padding: 1rem; }
        .sidebar-item { display: flex; align-items: center; gap: 0.75rem; padding: 0.85rem 1rem; border-radius: 0.75rem; color: #4b5563; text-decoration: none; font-weight: 500; margin-bottom: 0.25rem; transition: all 0.2s; }
        .sidebar-item:hover { background: rgba(139, 21, 56, 0.08); color: var(--primary); }
        .sidebar-item.active { background: rgba(139, 21, 56, 0.12); color: var(--primary); font-weight: 600; }
        .sidebar-item i { width: 20px; text-align: center; }
        .sidebar-divider { height: 1px; background: #e5e7eb; margin: 1rem 0; }
        
        .stat-card { background: white; border-radius: 1rem; padding: 1.25rem; box-shadow: 0 2px 8px rgba(0,0,0,0.04); }
        .stat-icon { width: 48px; height: 48px; border-radius: 0.75rem; display: flex; align-items: center; justify-content: center; font-size: 1.25rem; }
        .stat-icon.primary { background: rgba(139, 21, 56, 0.1); color: var(--primary); }
        .stat-icon.success { background: rgba(16, 185, 129, 0.1); color: #10b981; }
        .stat-icon.warning { background: rgba(245, 158, 11, 0.1); color: #f59e0b; }
        .stat-icon.secondary { background: rgba(107, 114, 128, 0.1); color: #6b7280; }
        .stat-value { font-size: 1.5rem; font-weight: 800; color: #1f2937; }
        .stat-label { font-size: 0.8rem; color: #6b7280; }
        
        .nav-tabs-custom { border: none; background: white; border-radius: 0.75rem; padding: 0.35rem; margin-bottom: 1.5rem; }
        .nav-tabs-custom .nav-link { border: none; border-radius: 0.5rem; padding: 0.6rem 1.25rem; font-weight: 600; color: #6b7280; }
        .nav-tabs-custom .nav-link:hover { color: var(--primary); background: rgba(139, 21, 56, 0.05); }
        .nav-tabs-custom .nav-link.active { background: var(--primary); color: white; }
        
        .course-card { border: none; border-radius: 1rem; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.04); transition: all 0.3s; height: 100%; }
        .course-card:hover { transform: translateY(-4px); box-shadow: 0 8px 20px rgba(0,0,0,0.08); }
        .course-card-img { height: 160px; overflow: hidden; position: relative; }
        .course-card-img img { width: 100%; height: 100%; object-fit: cover; }
        .course-badge { position: absolute; top: 10px; left: 10px; font-size: 0.7rem; font-weight: 600; padding: 0.3rem 0.6rem; border-radius: 0.5rem; }
        .course-card-body { padding: 1.25rem; }
        .course-title { font-size: 1rem; font-weight: 700; margin-bottom: 0.5rem; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; line-height: 1.4; }
        .course-meta { font-size: 0.8rem; color: #6b7280; margin-bottom: 0.75rem; }
        .course-footer { display: flex; align-items: center; justify-content: space-between; padding-top: 0.75rem; border-top: 1px solid #f3f4f6; }
        
        .empty-state { text-align: center; padding: 4rem 2rem; background: white; border-radius: 1rem; }
        .empty-state-icon { width: 100px; height: 100px; background: rgba(139, 21, 56, 0.1); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; font-size: 2.5rem; color: var(--primary); }
        
        .page-link { color: var(--primary); }
        .page-item.active .page-link { background-color: var(--primary); border-color: var(--primary); }
        
        @media (max-width: 991.98px) {
            .sidebar { transform: translateX(-100%); transition: transform 0.3s; }
            .sidebar.show { transform: translateX(0); }
        }
    </style>
</head>
<body>
    <jsp:include page="/pages/common/navbar-dashboard.jsp"/>
    
    <div class="dashboard-wrapper">
        <!-- Sidebar -->
        <aside class="sidebar" id="sidebar">
            <div class="sidebar-user">
                <div class="d-flex align-items-center gap-3">
                    <img src="https://ui-avatars.com/api/?name=${sessionScope.user.name}&background=ffffff&color=8B1538" 
                         class="rounded-circle" style="width: 48px; height: 48px;">
                    <div>
                        <div class="fw-semibold">${sessionScope.user.name}</div>
                        <small class="opacity-75"><i class="fas fa-chalkboard-teacher me-1"></i> Pengajar</small>
                    </div>
                </div>
            </div>
            <nav class="sidebar-menu">
                <a href="${pageContext.request.contextPath}/lecturer/dashboard" class="sidebar-item"><i class="fas fa-home"></i> Dashboard</a>
                <a href="${pageContext.request.contextPath}/lecturer/courses" class="sidebar-item active"><i class="fas fa-book"></i> Kursus Saya</a>
                <a href="${pageContext.request.contextPath}/lecturer/course/create" class="sidebar-item"><i class="fas fa-plus-circle"></i> Buat Kursus</a>
                <a href="${pageContext.request.contextPath}/lecturer/students" class="sidebar-item"><i class="fas fa-users"></i> Pelajar</a>
                <a href="${pageContext.request.contextPath}/lecturer/earnings" class="sidebar-item"><i class="fas fa-wallet"></i> Pendapatan</a>
                <div class="sidebar-divider"></div>
                <a href="${pageContext.request.contextPath}/lecturer/profile" class="sidebar-item"><i class="fas fa-user-circle"></i> Profil</a>
                <a href="${pageContext.request.contextPath}/logout" class="sidebar-item text-danger"><i class="fas fa-sign-out-alt"></i> Keluar</a>
            </nav>
        </aside>
        
        <!-- Main Content -->
        <main class="main-content">
            <button class="btn btn-outline-secondary d-lg-none mb-3" onclick="document.getElementById('sidebar').classList.toggle('show')">
                <i class="fas fa-bars me-2"></i> Menu
            </button>
            
            <!-- Header -->
            <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
                <div>
                    <h1 class="h3 fw-bold mb-1"><i class="fas fa-book text-primary me-2"></i>Kursus Saya</h1>
                    <p class="text-muted mb-0">Kelola semua kursus yang Anda buat</p>
                </div>
                <a href="${pageContext.request.contextPath}/lecturer/course/create" class="btn btn-primary">
                    <i class="fas fa-plus me-2"></i> Buat Kursus Baru
                </a>
            </div>
            
            <!-- Stats Row -->
            <div class="row g-3 mb-4">
                <div class="col-6 col-lg-3">
                    <div class="stat-card d-flex align-items-center gap-3">
                        <div class="stat-icon success"><i class="fas fa-check-circle"></i></div>
                        <div>
                            <div class="stat-value">${publishedCount != null ? publishedCount : 0}</div>
                            <div class="stat-label">Dipublikasikan</div>
                        </div>
                    </div>
                </div>
                <div class="col-6 col-lg-3">
                    <div class="stat-card d-flex align-items-center gap-3">
                        <div class="stat-icon warning"><i class="fas fa-clock"></i></div>
                        <div>
                            <div class="stat-value">${pendingCount != null ? pendingCount : 0}</div>
                            <div class="stat-label">Pending Review</div>
                        </div>
                    </div>
                </div>
                <div class="col-6 col-lg-3">
                    <div class="stat-card d-flex align-items-center gap-3">
                        <div class="stat-icon secondary"><i class="fas fa-pencil-alt"></i></div>
                        <div>
                            <div class="stat-value">${draftCount != null ? draftCount : 0}</div>
                            <div class="stat-label">Draft</div>
                        </div>
                    </div>
                </div>
                <div class="col-6 col-lg-3">
                    <div class="stat-card d-flex align-items-center gap-3">
                        <div class="stat-icon primary"><i class="fas fa-users"></i></div>
                        <div>
                            <div class="stat-value">${totalStudents != null ? totalStudents : 0}</div>
                            <div class="stat-label">Total Pelajar</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Filter Bar -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-body py-3">
                    <div class="row g-3 align-items-center">
                        <div class="col-md-6">
                            <ul class="nav nav-tabs-custom" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link ${empty param.status ? 'active' : ''}" href="${pageContext.request.contextPath}/lecturer/courses">Semua</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link ${param.status == 'PUBLISHED' ? 'active' : ''}" href="${pageContext.request.contextPath}/lecturer/courses?status=PUBLISHED">Published</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link ${param.status == 'PENDING' ? 'active' : ''}" href="${pageContext.request.contextPath}/lecturer/courses?status=PENDING">Pending</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link ${param.status == 'DRAFT' ? 'active' : ''}" href="${pageContext.request.contextPath}/lecturer/courses?status=DRAFT">Draft</a>
                                </li>
                            </ul>
                        </div>
                        <div class="col-md-6">
                            <form action="${pageContext.request.contextPath}/lecturer/courses" method="get" class="d-flex gap-2">
                                <input type="hidden" name="status" value="${param.status}">
                                <div class="input-group">
                                    <span class="input-group-text bg-white"><i class="fas fa-search text-muted"></i></span>
                                    <input type="text" name="search" class="form-control" placeholder="Cari kursus..." value="${param.search}">
                                </div>
                                <button type="submit" class="btn btn-primary">Cari</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            
            <c:choose>
                <c:when test="${not empty courses}">
                    <!-- Courses Grid -->
                    <div class="row row-cols-1 row-cols-md-2 row-cols-xl-3 g-4">
                        <c:forEach var="course" items="${courses}">
                            <div class="col">
                                <div class="card course-card h-100">
                                    <div class="course-card-img">
                                        <img src="${not empty course.thumbnail ? course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400&h=225&fit=crop'}" 
                                             alt="${course.title}">
                                        <c:choose>
                                            <c:when test="${course.status == 'PUBLISHED'}">
                                                <span class="course-badge bg-success text-white">Published</span>
                                            </c:when>
                                            <c:when test="${course.status == 'PENDING'}">
                                                <span class="course-badge bg-warning text-dark">Pending</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="course-badge bg-secondary text-white">Draft</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="course-card-body">
                                        <h5 class="course-title">${course.title}</h5>
                                        <div class="course-meta">
                                            <span class="me-3"><i class="fas fa-users me-1"></i> ${course.totalStudents} pelajar</span>
                                            <span><i class="fas fa-star text-warning me-1"></i> <fmt:formatNumber value="${course.avgRating}" maxFractionDigits="1"/></span>
                                        </div>
                                        <div class="course-meta">
                                            <span class="me-3"><i class="fas fa-layer-group me-1"></i> ${course.totalSections} bab</span>
                                            <span><i class="fas fa-file-alt me-1"></i> ${course.totalMaterials} materi</span>
                                        </div>
                                        <div class="course-footer">
                                            <c:choose>
                                                <c:when test="${course.free}">
                                                    <span class="fw-bold text-success">GRATIS</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="fw-bold" style="color: var(--primary);">Rp <fmt:formatNumber value="${course.price}" pattern="#,###"/></span>
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="btn-group">
                                                <a href="${pageContext.request.contextPath}/lecturer/course/edit/${course.courseId}" 
                                                   class="btn btn-sm btn-outline-primary" title="Edit Info">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/lecturer/course/content/${course.courseId}" 
                                                   class="btn btn-sm btn-outline-primary" title="Kelola Materi">
                                                    <i class="fas fa-list-ol"></i>
                                                </a>
                                                <button type="button" class="btn btn-sm btn-outline-danger" 
                                                        onclick="confirmDelete(${course.courseId}, '${course.title}')" title="Hapus">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <nav class="mt-4">
                            <ul class="pagination justify-content-center">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/lecturer/courses?page=${currentPage - 1}&status=${param.status}">
                                            <i class="fas fa-chevron-left"></i>
                                        </a>
                                    </li>
                                </c:if>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/lecturer/courses?page=${i}&status=${param.status}">${i}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/lecturer/courses?page=${currentPage + 1}&status=${param.status}">
                                            <i class="fas fa-chevron-right"></i>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-state-icon"><i class="fas fa-book"></i></div>
                        <h4 class="fw-bold mb-2">Belum Ada Kursus</h4>
                        <p class="text-muted mb-4">
                            <c:choose>
                                <c:when test="${not empty param.status}">Tidak ada kursus dengan status "${param.status}".</c:when>
                                <c:when test="${not empty param.search}">Tidak ada kursus dengan kata kunci "${param.search}".</c:when>
                                <c:otherwise>Mulai buat kursus pertama Anda dan bagikan pengetahuan dengan ribuan pelajar.</c:otherwise>
                            </c:choose>
                        </p>
                        <a href="${pageContext.request.contextPath}/lecturer/course/create" class="btn btn-primary btn-lg">
                            <i class="fas fa-plus me-2"></i> Buat Kursus Baru
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
    
    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-0">
                    <h5 class="modal-title text-danger"><i class="fas fa-exclamation-triangle me-2"></i>Hapus Kursus</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Apakah Anda yakin ingin menghapus kursus "<strong id="deleteCourseTitle"></strong>"?</p>
                    <p class="text-muted small mb-0">Tindakan ini tidak dapat dibatalkan dan akan menghapus semua materi di dalamnya.</p>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <form id="deleteForm" action="" method="POST" style="display: inline;">
                        <button type="submit" class="btn btn-danger">Ya, Hapus</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(courseId, title) {
            document.getElementById('deleteCourseTitle').textContent = title;
            document.getElementById('deleteForm').action = '${pageContext.request.contextPath}/lecturer/course/delete/' + courseId;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
    </script>
</body>
</html>
