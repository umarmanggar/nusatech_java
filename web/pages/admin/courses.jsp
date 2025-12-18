<%-- 
    Document   : courses
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Admin Course Management with Bootstrap 5
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
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root { --primary: #8B1538; --admin: #1f2937; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #f8f9fa; }
        .btn-primary { background-color: var(--admin); border-color: var(--admin); }
        .btn-primary:hover { background-color: #374151; border-color: #374151; }
        .form-control:focus, .form-select:focus { border-color: var(--admin); box-shadow: 0 0 0 0.2rem rgba(31, 41, 55, 0.15); }
        
        .dashboard-wrapper { display: flex; min-height: 100vh; padding-top: 56px; }
        .main-content { flex: 1; margin-left: 280px; padding: 2rem; }
        @media (max-width: 991.98px) { .main-content { margin-left: 0; } }
        
        .nav-tabs-custom { border: none; background: white; border-radius: 0.75rem; padding: 0.35rem; margin-bottom: 1.5rem; box-shadow: 0 2px 8px rgba(0,0,0,0.04); }
        .nav-tabs-custom .nav-link { border: none; border-radius: 0.5rem; padding: 0.6rem 1.25rem; font-weight: 600; color: #6b7280; }
        .nav-tabs-custom .nav-link:hover { color: var(--admin); background: rgba(31, 41, 55, 0.05); }
        .nav-tabs-custom .nav-link.active { background: var(--admin); color: white; }
        .nav-tabs-custom .badge { font-size: 0.65rem; margin-left: 0.5rem; }
        
        .table-card { background: white; border-radius: 1rem; box-shadow: 0 2px 8px rgba(0,0,0,0.04); overflow: hidden; }
        .table-header { padding: 1.25rem 1.5rem; border-bottom: 1px solid #e5e7eb; }
        
        .course-thumb { width: 80px; height: 50px; border-radius: 0.5rem; object-fit: cover; }
        .lecturer-avatar { width: 28px; height: 28px; border-radius: 50%; }
        
        .status-badge { font-size: 0.75rem; padding: 0.35rem 0.75rem; border-radius: 1rem; font-weight: 600; }
        
        .action-btn { width: 32px; height: 32px; padding: 0; display: inline-flex; align-items: center; justify-content: center; border-radius: 0.5rem; }
        
        .featured-star { color: #f59e0b; }
        .featured-star.inactive { color: #d1d5db; }
        
        .page-link { color: var(--admin); }
        .page-item.active .page-link { background-color: var(--admin); border-color: var(--admin); }
    </style>
</head>
<body>
    <jsp:include page="/pages/common/navbar-dashboard.jsp"/>
    
    <div class="dashboard-wrapper">
        <jsp:include page="/pages/common/sidebar-admin.jsp"/>
        
        <main class="main-content">
            <button class="btn btn-outline-secondary d-lg-none mb-3" onclick="document.getElementById('adminSidebar').classList.toggle('show')">
                <i class="fas fa-bars me-2"></i> Menu
            </button>
            
            <!-- Header -->
            <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
                <div>
                    <h1 class="h3 fw-bold mb-1"><i class="fas fa-book me-2" style="color: var(--admin);"></i>Manajemen Kursus</h1>
                    <p class="text-muted mb-0">Kelola semua kursus di platform</p>
                </div>
            </div>
            
            <!-- Tabs -->
            <ul class="nav nav-tabs-custom">
                <li class="nav-item">
                    <a class="nav-link ${empty param.status ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/courses">
                        Semua <span class="badge bg-secondary">${totalCourses != null ? totalCourses : 0}</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${param.status == 'PUBLISHED' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/courses?status=PUBLISHED">
                        Published <span class="badge bg-success">${publishedCount != null ? publishedCount : 0}</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${param.status == 'PENDING' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/courses?status=PENDING">
                        Pending <span class="badge bg-warning text-dark">${pendingCount != null ? pendingCount : 0}</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${param.status == 'DRAFT' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/courses?status=DRAFT">
                        Draft <span class="badge bg-secondary">${draftCount != null ? draftCount : 0}</span>
                    </a>
                </li>
            </ul>
            
            <!-- Table Card -->
            <div class="table-card">
                <div class="table-header">
                    <div class="row g-3 align-items-center">
                        <div class="col-md-4">
                            <div class="input-group">
                                <span class="input-group-text bg-white"><i class="fas fa-search text-muted"></i></span>
                                <input type="text" class="form-control" id="searchCourse" placeholder="Cari kursus..." onkeyup="filterCourses()">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <select class="form-select" id="filterCategory" onchange="filterCourses()">
                                <option value="">Semua Kategori</option>
                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.categoryId}">${category.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <select class="form-select" id="filterLevel" onchange="filterCourses()">
                                <option value="">Semua Level</option>
                                <option value="BEGINNER">Pemula</option>
                                <option value="INTERMEDIATE">Menengah</option>
                                <option value="ADVANCED">Lanjutan</option>
                            </select>
                        </div>
                        <div class="col-md-3 text-end">
                            <span class="text-muted">Total: <strong id="courseCount">${courses != null ? courses.size() : 0}</strong> kursus</span>
                        </div>
                    </div>
                </div>
                
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0" id="coursesTable">
                        <thead class="table-light">
                            <tr>
                                <th>Kursus</th>
                                <th>Pengajar</th>
                                <th>Kategori</th>
                                <th>Harga</th>
                                <th class="text-center">Pelajar</th>
                                <th class="text-center">Rating</th>
                                <th>Status</th>
                                <th style="width: 150px;">Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="course" items="${courses}">
                                <tr data-category="${course.categoryId}" data-level="${course.level}">
                                    <td>
                                        <div class="d-flex align-items-center gap-2">
                                            <img src="${not empty course.thumbnail ? course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=80&h=50&fit=crop'}" class="course-thumb">
                                            <div>
                                                <div class="fw-semibold text-truncate" style="max-width: 200px;">${course.title}</div>
                                                <small class="text-muted">${course.levelDisplayName}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center gap-2">
                                            <img src="https://ui-avatars.com/api/?name=${course.lecturer.name}&background=10b981&color=fff&size=28" class="lecturer-avatar">
                                            <span class="small">${course.lecturer.name}</span>
                                        </div>
                                    </td>
                                    <td><span class="badge bg-light text-dark">${course.category.name}</span></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${course.free}">
                                                <span class="text-success fw-semibold">Gratis</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="fw-semibold">Rp <fmt:formatNumber value="${course.price}" pattern="#,###"/></span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">${course.totalStudents}</td>
                                    <td class="text-center">
                                        <i class="fas fa-star text-warning"></i>
                                        <fmt:formatNumber value="${course.avgRating}" maxFractionDigits="1"/>
                                    </td>
                                    <td>
                                        <span class="status-badge ${course.status == 'PUBLISHED' ? 'bg-success-subtle text-success' : course.status == 'PENDING' ? 'bg-warning-subtle text-warning' : 'bg-secondary-subtle text-secondary'}">
                                            ${course.statusDisplayName}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="d-flex gap-1 flex-wrap">
                                            <a href="${pageContext.request.contextPath}/course/${course.slug}" target="_blank" class="btn btn-sm action-btn btn-outline-secondary" title="Preview">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <c:if test="${course.status == 'PENDING'}">
                                                <button class="btn btn-sm action-btn btn-outline-success" onclick="approveCourse(${course.courseId})" title="Approve">
                                                    <i class="fas fa-check"></i>
                                                </button>
                                                <button class="btn btn-sm action-btn btn-outline-danger" onclick="rejectCourse(${course.courseId})" title="Reject">
                                                    <i class="fas fa-times"></i>
                                                </button>
                                            </c:if>
                                            <button class="btn btn-sm action-btn btn-outline-warning featured-star ${course.featured ? '' : 'inactive'}" 
                                                    onclick="toggleFeatured(${course.courseId})" title="${course.featured ? 'Unfeatured' : 'Featured'}">
                                                <i class="fas fa-star"></i>
                                            </button>
                                            <button class="btn btn-sm action-btn btn-outline-danger" onclick="deleteCourse(${course.courseId}, '${course.title}')" title="Hapus">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty courses}">
                                <tr>
                                    <td colspan="8" class="text-center py-5">
                                        <i class="fas fa-book fa-3x text-muted mb-3"></i>
                                        <p class="text-muted mb-0">
                                            <c:choose>
                                                <c:when test="${param.status == 'PENDING'}">Tidak ada kursus pending</c:when>
                                                <c:otherwise>Belum ada kursus</c:otherwise>
                                            </c:choose>
                                        </p>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
                
                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <div class="p-3 border-top">
                        <nav>
                            <ul class="pagination justify-content-center mb-0">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentPage - 1}&status=${param.status}"><i class="fas fa-chevron-left"></i></a>
                                    </li>
                                </c:if>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="?page=${i}&status=${param.status}">${i}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentPage + 1}&status=${param.status}"><i class="fas fa-chevron-right"></i></a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                </c:if>
            </div>
        </main>
    </div>
    
    <!-- Reject Modal -->
    <div class="modal fade" id="rejectModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/admin/course/reject" method="POST" id="rejectForm">
                    <input type="hidden" name="courseId" id="rejectCourseId">
                    <div class="modal-header border-0">
                        <h5 class="modal-title text-danger"><i class="fas fa-times-circle me-2"></i>Tolak Kursus</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Alasan Penolakan <span class="text-danger">*</span></label>
                            <textarea name="reason" class="form-control" rows="4" required placeholder="Jelaskan alasan penolakan kursus ini..."></textarea>
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                        <button type="submit" class="btn btn-danger"><i class="fas fa-times me-2"></i>Tolak Kursus</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Delete Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-0">
                    <h5 class="modal-title text-danger"><i class="fas fa-exclamation-triangle me-2"></i>Hapus Kursus</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Apakah Anda yakin ingin menghapus kursus "<strong id="deleteCourseTitle"></strong>"?</p>
                    <p class="text-muted small mb-0">Semua data termasuk materi, enrollment, dan review akan dihapus.</p>
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
        function filterCourses() {
            const search = document.getElementById('searchCourse').value.toLowerCase();
            const category = document.getElementById('filterCategory').value;
            const level = document.getElementById('filterLevel').value;
            let count = 0;
            
            document.querySelectorAll('#coursesTable tbody tr').forEach(row => {
                if (!row.dataset.category) return;
                const text = row.textContent.toLowerCase();
                const matchSearch = text.includes(search);
                const matchCategory = !category || row.dataset.category === category;
                const matchLevel = !level || row.dataset.level === level;
                const show = matchSearch && matchCategory && matchLevel;
                row.style.display = show ? '' : 'none';
                if (show) count++;
            });
            
            document.getElementById('courseCount').textContent = count;
        }
        
        function approveCourse(courseId) {
            if (confirm('Approve kursus ini untuk dipublikasikan?')) {
                window.location.href = '${pageContext.request.contextPath}/admin/course/approve/' + courseId;
            }
        }
        
        function rejectCourse(courseId) {
            document.getElementById('rejectCourseId').value = courseId;
            new bootstrap.Modal(document.getElementById('rejectModal')).show();
        }
        
        function toggleFeatured(courseId) {
            window.location.href = '${pageContext.request.contextPath}/admin/course/featured/' + courseId;
        }
        
        function deleteCourse(courseId, title) {
            document.getElementById('deleteCourseTitle').textContent = title;
            document.getElementById('deleteForm').action = '${pageContext.request.contextPath}/admin/course/delete/' + courseId;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
    </script>
</body>
</html>
