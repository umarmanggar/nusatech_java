<%-- 
    Document   : students
    Created on : Dec 18, 2025
    Author     : NusaTech
    Description: Lecturer's Enrolled Students Page with Bootstrap 5
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pelajar Saya - NusaTech</title>
    
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
        .form-control:focus, .form-select:focus { border-color: var(--primary); box-shadow: 0 0 0 0.2rem rgba(139, 21, 56, 0.15); }
        
        .dashboard-wrapper { display: flex; min-height: 100vh; padding-top: 56px; }
        .main-content { flex: 1; margin-left: 280px; padding: 2rem; }
        @media (max-width: 991.98px) { .main-content { margin-left: 0; } }
        
        .sidebar { width: 280px; min-height: calc(100vh - 56px); background: white; border-right: 1px solid #e5e7eb; position: fixed; top: 56px; left: 0; z-index: 1020; }
        .sidebar-user { padding: 1.5rem; background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%); color: white; }
        .sidebar-menu { padding: 1rem; }
        .sidebar-item { display: flex; align-items: center; gap: 0.75rem; padding: 0.85rem 1rem; border-radius: 0.75rem; color: #4b5563; text-decoration: none; font-weight: 500; margin-bottom: 0.25rem; transition: all 0.2s; }
        .sidebar-item:hover { background: rgba(139, 21, 56, 0.08); color: var(--primary); }
        .sidebar-item.active { background: rgba(139, 21, 56, 0.12); color: var(--primary); font-weight: 600; }
        .sidebar-item i { width: 20px; text-align: center; }
        .sidebar-divider { height: 1px; background: #e5e7eb; margin: 1rem 0; }
        
        .stat-card { background: white; border-radius: 1rem; padding: 1.5rem; box-shadow: 0 2px 8px rgba(0,0,0,0.04); }
        .stat-icon { width: 56px; height: 56px; border-radius: 1rem; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; }
        .stat-icon.primary { background: rgba(139, 21, 56, 0.1); color: var(--primary); }
        .stat-icon.success { background: rgba(16, 185, 129, 0.1); color: #10b981; }
        .stat-icon.warning { background: rgba(245, 158, 11, 0.1); color: #f59e0b; }
        .stat-icon.info { background: rgba(59, 130, 246, 0.1); color: #3b82f6; }
        .stat-value { font-size: 1.75rem; font-weight: 800; color: #1f2937; }
        .stat-label { font-size: 0.875rem; color: #6b7280; }
        
        .student-card { background: white; border-radius: 1rem; padding: 1.5rem; box-shadow: 0 2px 8px rgba(0,0,0,0.04); margin-bottom: 1rem; transition: all 0.3s; }
        .student-card:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.08); }
        .student-avatar { width: 56px; height: 56px; border-radius: 50%; }
        .progress { height: 8px; border-radius: 4px; }
        .progress-bar { background-color: var(--primary); }
        
        .filter-card { background: white; border-radius: 1rem; padding: 1rem 1.5rem; box-shadow: 0 2px 8px rgba(0,0,0,0.04); margin-bottom: 1.5rem; }
        
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
                    <img src="https://ui-avatars.com/api/?name=${sessionScope.user.name}&background=ffffff&color=8B1538" class="rounded-circle" style="width: 48px; height: 48px;">
                    <div>
                        <div class="fw-semibold">${sessionScope.user.name}</div>
                        <small class="opacity-75"><i class="fas fa-chalkboard-teacher me-1"></i> Pengajar</small>
                    </div>
                </div>
            </div>
            <nav class="sidebar-menu">
                <a href="${pageContext.request.contextPath}/lecturer/dashboard" class="sidebar-item"><i class="fas fa-home"></i> Dashboard</a>
                <a href="${pageContext.request.contextPath}/lecturer/courses" class="sidebar-item"><i class="fas fa-book"></i> Kursus Saya</a>
                <a href="${pageContext.request.contextPath}/lecturer/course/create" class="sidebar-item"><i class="fas fa-plus-circle"></i> Buat Kursus</a>
                <a href="${pageContext.request.contextPath}/lecturer/students" class="sidebar-item active"><i class="fas fa-users"></i> Pelajar</a>
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
            <div class="mb-4">
                <h1 class="h3 fw-bold mb-1"><i class="fas fa-users text-primary me-2"></i>Pelajar Saya</h1>
                <p class="text-muted mb-0">Lihat dan pantau progress pelajar di semua kursus Anda</p>
            </div>
            
            <!-- Stats Row -->
            <div class="row g-4 mb-4">
                <div class="col-sm-6 col-xl-3">
                    <div class="stat-card">
                        <div class="d-flex align-items-center gap-3">
                            <div class="stat-icon primary"><i class="fas fa-users"></i></div>
                            <div>
                                <div class="stat-value">${totalStudents != null ? totalStudents : 0}</div>
                                <div class="stat-label">Total Pelajar</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-xl-3">
                    <div class="stat-card">
                        <div class="d-flex align-items-center gap-3">
                            <div class="stat-icon success"><i class="fas fa-user-check"></i></div>
                            <div>
                                <div class="stat-value">${activeStudents != null ? activeStudents : 0}</div>
                                <div class="stat-label">Aktif Belajar</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-xl-3">
                    <div class="stat-card">
                        <div class="d-flex align-items-center gap-3">
                            <div class="stat-icon warning"><i class="fas fa-graduation-cap"></i></div>
                            <div>
                                <div class="stat-value">${completedStudents != null ? completedStudents : 0}</div>
                                <div class="stat-label">Sudah Selesai</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-xl-3">
                    <div class="stat-card">
                        <div class="d-flex align-items-center gap-3">
                            <div class="stat-icon info"><i class="fas fa-user-plus"></i></div>
                            <div>
                                <div class="stat-value">${newThisMonth != null ? newThisMonth : 0}</div>
                                <div class="stat-label">Baru Bulan Ini</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Filter Bar -->
            <div class="filter-card">
                <form action="${pageContext.request.contextPath}/lecturer/students" method="GET" class="row g-3 align-items-end">
                    <div class="col-md-4">
                        <label class="form-label small fw-semibold">Filter Kursus</label>
                        <select name="courseId" class="form-select">
                            <option value="">Semua Kursus</option>
                            <c:forEach var="course" items="${courses}">
                                <option value="${course.courseId}" ${param.courseId == course.courseId ? 'selected' : ''}>${course.title}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small fw-semibold">Status</label>
                        <select name="status" class="form-select">
                            <option value="">Semua Status</option>
                            <option value="ACTIVE" ${param.status == 'ACTIVE' ? 'selected' : ''}>Aktif Belajar</option>
                            <option value="COMPLETED" ${param.status == 'COMPLETED' ? 'selected' : ''}>Selesai</option>
                            <option value="INACTIVE" ${param.status == 'INACTIVE' ? 'selected' : ''}>Tidak Aktif</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small fw-semibold">Cari Pelajar</label>
                        <input type="text" name="search" class="form-control" placeholder="Nama atau email..." value="${param.search}">
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary w-100"><i class="fas fa-search me-1"></i> Filter</button>
                    </div>
                </form>
            </div>
            
            <c:choose>
                <c:when test="${not empty students}">
                    <!-- Students List -->
                    <div class="row">
                        <c:forEach var="enrollment" items="${students}">
                            <div class="col-md-6 col-xl-4">
                                <div class="student-card">
                                    <div class="d-flex align-items-start gap-3 mb-3">
                                        <img src="https://ui-avatars.com/api/?name=${enrollment.student.name}&background=3b82f6&color=fff" 
                                             alt="${enrollment.student.name}" class="student-avatar">
                                        <div class="flex-grow-1">
                                            <h6 class="fw-bold mb-1">${enrollment.student.name}</h6>
                                            <p class="text-muted small mb-1">${enrollment.student.email}</p>
                                            <c:choose>
                                                <c:when test="${enrollment.status == 'COMPLETED'}">
                                                    <span class="badge bg-success"><i class="fas fa-check me-1"></i>Selesai</span>
                                                </c:when>
                                                <c:when test="${enrollment.status == 'ACTIVE'}">
                                                    <span class="badge bg-primary"><i class="fas fa-book-reader me-1"></i>Aktif</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary"><i class="fas fa-pause me-1"></i>Tidak Aktif</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <div class="d-flex justify-content-between small mb-1">
                                            <span class="text-muted">${enrollment.course.title}</span>
                                            <span class="fw-semibold">${enrollment.progressPercentage}%</span>
                                        </div>
                                        <div class="progress">
                                            <div class="progress-bar" style="width: ${enrollment.progressPercentage}%"></div>
                                        </div>
                                    </div>
                                    
                                    <div class="d-flex justify-content-between align-items-center small text-muted">
                                        <span><i class="fas fa-calendar me-1"></i> Bergabung: <fmt:formatDate value="${enrollment.enrolledAt}" pattern="dd MMM yyyy"/></span>
                                        <c:if test="${enrollment.status == 'COMPLETED'}">
                                            <span class="text-success"><i class="fas fa-trophy me-1"></i> <fmt:formatDate value="${enrollment.completedAt}" pattern="dd MMM"/></span>
                                        </c:if>
                                    </div>
                                    
                                    <hr class="my-3">
                                    
                                    <div class="d-flex gap-2">
                                        <button type="button" class="btn btn-sm btn-outline-primary flex-grow-1" onclick="viewProgress(${enrollment.enrollmentId})">
                                            <i class="fas fa-chart-line me-1"></i> Detail Progress
                                        </button>
                                        <a href="mailto:${enrollment.student.email}" class="btn btn-sm btn-outline-secondary" title="Kirim Email">
                                            <i class="fas fa-envelope"></i>
                                        </a>
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
                                        <a class="page-link" href="${pageContext.request.contextPath}/lecturer/students?page=${currentPage - 1}&courseId=${param.courseId}&status=${param.status}&search=${param.search}">
                                            <i class="fas fa-chevron-left"></i>
                                        </a>
                                    </li>
                                </c:if>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/lecturer/students?page=${i}&courseId=${param.courseId}&status=${param.status}&search=${param.search}">${i}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/lecturer/students?page=${currentPage + 1}&courseId=${param.courseId}&status=${param.status}&search=${param.search}">
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
                        <div class="empty-state-icon"><i class="fas fa-users"></i></div>
                        <h4 class="fw-bold mb-2">Belum Ada Pelajar</h4>
                        <p class="text-muted mb-4">
                            <c:choose>
                                <c:when test="${not empty param.courseId || not empty param.status || not empty param.search}">
                                    Tidak ada pelajar yang sesuai dengan filter yang dipilih.
                                </c:when>
                                <c:otherwise>
                                    Belum ada pelajar yang mendaftar di kursus Anda. Bagikan kursus untuk mendapatkan lebih banyak pelajar!
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <a href="${pageContext.request.contextPath}/lecturer/courses" class="btn btn-primary">
                            <i class="fas fa-book me-2"></i> Kelola Kursus
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
    
    <!-- Progress Detail Modal -->
    <div class="modal fade" id="progressModal" tabindex="-1">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-0">
                    <h5 class="modal-title"><i class="fas fa-chart-line text-primary me-2"></i>Detail Progress</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="progressContent">
                    <div class="text-center py-4">
                        <div class="spinner-border text-primary" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function viewProgress(enrollmentId) {
            const modal = new bootstrap.Modal(document.getElementById('progressModal'));
            const content = document.getElementById('progressContent');
            
            // Show loading
            content.innerHTML = '<div class="text-center py-4"><div class="spinner-border text-primary" role="status"></div></div>';
            modal.show();
            
            // Fetch progress data (mock for now)
            setTimeout(() => {
                content.innerHTML = `
                    <div class="row mb-4">
                        <div class="col-md-4 text-center">
                            <div class="fs-2 fw-bold text-primary">75%</div>
                            <div class="text-muted small">Progress Keseluruhan</div>
                        </div>
                        <div class="col-md-4 text-center">
                            <div class="fs-2 fw-bold text-success">12/16</div>
                            <div class="text-muted small">Materi Selesai</div>
                        </div>
                        <div class="col-md-4 text-center">
                            <div class="fs-2 fw-bold text-warning">2/3</div>
                            <div class="text-muted small">Quiz Lulus</div>
                        </div>
                    </div>
                    
                    <h6 class="fw-bold mb-3">Progress per Bab</h6>
                    <div class="list-group">
                        <div class="list-group-item">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span class="fw-semibold">Bab 1: Pengenalan</span>
                                <span class="badge bg-success">100%</span>
                            </div>
                            <div class="progress" style="height: 6px;">
                                <div class="progress-bar bg-success" style="width: 100%"></div>
                            </div>
                        </div>
                        <div class="list-group-item">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span class="fw-semibold">Bab 2: Variabel & Tipe Data</span>
                                <span class="badge bg-success">100%</span>
                            </div>
                            <div class="progress" style="height: 6px;">
                                <div class="progress-bar bg-success" style="width: 100%"></div>
                            </div>
                        </div>
                        <div class="list-group-item">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span class="fw-semibold">Bab 3: Control Flow</span>
                                <span class="badge bg-primary">60%</span>
                            </div>
                            <div class="progress" style="height: 6px;">
                                <div class="progress-bar" style="width: 60%"></div>
                            </div>
                        </div>
                        <div class="list-group-item">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span class="fw-semibold">Bab 4: Functions</span>
                                <span class="badge bg-secondary">0%</span>
                            </div>
                            <div class="progress" style="height: 6px;">
                                <div class="progress-bar" style="width: 0%"></div>
                            </div>
                        </div>
                    </div>
                    
                    <h6 class="fw-bold mt-4 mb-3">Riwayat Quiz</h6>
                    <div class="table-responsive">
                        <table class="table table-sm">
                            <thead>
                                <tr>
                                    <th>Quiz</th>
                                    <th>Tanggal</th>
                                    <th>Skor</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Quiz Bab 1</td>
                                    <td>10 Des 2025</td>
                                    <td>85/100</td>
                                    <td><span class="badge bg-success">Lulus</span></td>
                                </tr>
                                <tr>
                                    <td>Quiz Bab 2</td>
                                    <td>12 Des 2025</td>
                                    <td>90/100</td>
                                    <td><span class="badge bg-success">Lulus</span></td>
                                </tr>
                                <tr>
                                    <td>Quiz Bab 3</td>
                                    <td>15 Des 2025</td>
                                    <td>55/100</td>
                                    <td><span class="badge bg-danger">Tidak Lulus</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                `;
            }, 500);
        }
    </script>
</body>
</html>
