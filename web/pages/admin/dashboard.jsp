<%-- 
    Document   : dashboard
    Created on : Dec 10, 2025
    Author     : NusaTech
    Description: Admin Dashboard with Bootstrap 5 and Chart.js
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
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root { --primary: #8B1538; --primary-dark: #6d1029; --secondary: #D4A84B; --admin: #1f2937; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #f8f9fa; }
        .btn-primary { background-color: var(--admin); border-color: var(--admin); }
        .btn-primary:hover { background-color: #374151; border-color: #374151; }
        .text-primary { color: var(--admin) !important; }
        
        .dashboard-wrapper { display: flex; min-height: 100vh; padding-top: 56px; }
        .main-content { flex: 1; margin-left: 280px; padding: 2rem; }
        @media (max-width: 991.98px) { .main-content { margin-left: 0; } }
        
        .stat-card { background: white; border-radius: 1rem; padding: 1.5rem; box-shadow: 0 2px 8px rgba(0,0,0,0.04); height: 100%; }
        .stat-icon { width: 56px; height: 56px; border-radius: 1rem; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; }
        .stat-icon.users { background: rgba(59, 130, 246, 0.1); color: #3b82f6; }
        .stat-icon.courses { background: rgba(16, 185, 129, 0.1); color: #10b981; }
        .stat-icon.revenue { background: rgba(245, 158, 11, 0.1); color: #f59e0b; }
        .stat-icon.students { background: rgba(139, 21, 56, 0.1); color: var(--primary); }
        .stat-value { font-size: 1.75rem; font-weight: 800; color: #1f2937; }
        .stat-label { font-size: 0.875rem; color: #6b7280; }
        .stat-trend { font-size: 0.8rem; margin-top: 0.5rem; }
        .stat-trend.up { color: #10b981; }
        .stat-trend.down { color: #ef4444; }
        
        .chart-card { background: white; border-radius: 1rem; box-shadow: 0 2px 8px rgba(0,0,0,0.04); overflow: hidden; }
        .chart-header { padding: 1.25rem 1.5rem; border-bottom: 1px solid #e5e7eb; display: flex; justify-content: space-between; align-items: center; }
        .chart-header h5 { font-weight: 700; margin: 0; }
        .chart-body { padding: 1.5rem; }
        
        .activity-item { display: flex; gap: 1rem; padding: 1rem 0; border-bottom: 1px solid #f3f4f6; }
        .activity-item:last-child { border-bottom: none; }
        .activity-icon { width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 0.875rem; flex-shrink: 0; }
        .activity-icon.user { background: rgba(59, 130, 246, 0.1); color: #3b82f6; }
        .activity-icon.course { background: rgba(16, 185, 129, 0.1); color: #10b981; }
        .activity-icon.payment { background: rgba(245, 158, 11, 0.1); color: #f59e0b; }
        .activity-icon.review { background: rgba(139, 21, 56, 0.1); color: var(--primary); }
        .activity-time { font-size: 0.75rem; color: #9ca3af; }
        
        .user-row { display: flex; align-items: center; gap: 1rem; padding: 0.75rem 0; border-bottom: 1px solid #f3f4f6; }
        .user-row:last-child { border-bottom: none; }
        .user-avatar { width: 40px; height: 40px; border-radius: 50%; }
        
        .course-row { display: flex; align-items: center; gap: 1rem; padding: 0.75rem 0; border-bottom: 1px solid #f3f4f6; }
        .course-row:last-child { border-bottom: none; }
        .course-thumb { width: 60px; height: 40px; border-radius: 0.5rem; object-fit: cover; }
        
        .pending-card { border-left: 4px solid #f59e0b; background: rgba(245, 158, 11, 0.05); }
    </style>
</head>
<body>
    <!-- Navbar -->
    <jsp:include page="/pages/common/navbar-dashboard.jsp"/>
    
    <div class="dashboard-wrapper">
        <!-- Admin Sidebar -->
        <jsp:include page="/pages/common/sidebar-admin.jsp"/>
        
        <!-- Main Content -->
        <main class="main-content">
            <!-- Mobile Toggle -->
            <button class="btn btn-outline-secondary d-lg-none mb-3" onclick="document.getElementById('adminSidebar').classList.toggle('show')">
                <i class="fas fa-bars me-2"></i> Menu
            </button>
            
            <!-- Header -->
            <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
                <div>
                    <h1 class="h3 fw-bold mb-1">Admin Dashboard</h1>
                    <p class="text-muted mb-0">Selamat datang di panel administrasi NusaTech</p>
                </div>
                <div class="d-flex gap-2">
                    <button class="btn btn-outline-secondary">
                        <i class="fas fa-download me-2"></i>Export Report
                    </button>
                    <button class="btn btn-primary">
                        <i class="fas fa-cog me-2"></i>Settings
                    </button>
                </div>
            </div>
            
            <!-- Stats Row -->
            <div class="row g-4 mb-4">
                <div class="col-sm-6 col-xl-3">
                    <div class="stat-card">
                        <div class="d-flex align-items-start justify-content-between">
                            <div>
                                <div class="stat-label mb-1">Total Pengguna</div>
                                <div class="stat-value">${totalUsers != null ? totalUsers : 1250}</div>
                                <div class="stat-trend up">
                                    <i class="fas fa-arrow-up me-1"></i> +12% dari bulan lalu
                                </div>
                            </div>
                            <div class="stat-icon users">
                                <i class="fas fa-users"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-xl-3">
                    <div class="stat-card">
                        <div class="d-flex align-items-start justify-content-between">
                            <div>
                                <div class="stat-label mb-1">Total Kursus</div>
                                <div class="stat-value">${totalCourses != null ? totalCourses : 85}</div>
                                <div class="stat-trend up">
                                    <i class="fas fa-arrow-up me-1"></i> +8 kursus baru
                                </div>
                            </div>
                            <div class="stat-icon courses">
                                <i class="fas fa-book"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-xl-3">
                    <div class="stat-card">
                        <div class="d-flex align-items-start justify-content-between">
                            <div>
                                <div class="stat-label mb-1">Total Pendapatan</div>
                                <div class="stat-value">
                                    <small>Rp</small> <fmt:formatNumber value="${totalRevenue != null ? totalRevenue : 125000000}" pattern="#,###"/>
                                </div>
                                <div class="stat-trend up">
                                    <i class="fas fa-arrow-up me-1"></i> +23% dari bulan lalu
                                </div>
                            </div>
                            <div class="stat-icon revenue">
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-xl-3">
                    <div class="stat-card">
                        <div class="d-flex align-items-start justify-content-between">
                            <div>
                                <div class="stat-label mb-1">Pelajar Aktif</div>
                                <div class="stat-value">${activeStudents != null ? activeStudents : 890}</div>
                                <div class="stat-trend up">
                                    <i class="fas fa-arrow-up me-1"></i> +45 bulan ini
                                </div>
                            </div>
                            <div class="stat-icon students">
                                <i class="fas fa-user-graduate"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Pending Items Row -->
            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="stat-card pending-card">
                        <div class="d-flex align-items-center gap-3">
                            <div class="stat-icon" style="background: rgba(245, 158, 11, 0.2); color: #f59e0b;">
                                <i class="fas fa-clock"></i>
                            </div>
                            <div>
                                <div class="stat-value" style="font-size: 1.5rem;">${pendingCourses != null ? pendingCourses : 5}</div>
                                <div class="stat-label">Kursus Pending Review</div>
                            </div>
                            <a href="${pageContext.request.contextPath}/admin/courses?status=PENDING" class="btn btn-sm btn-warning ms-auto">
                                Review
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card pending-card">
                        <div class="d-flex align-items-center gap-3">
                            <div class="stat-icon" style="background: rgba(245, 158, 11, 0.2); color: #f59e0b;">
                                <i class="fas fa-money-check"></i>
                            </div>
                            <div>
                                <div class="stat-value" style="font-size: 1.5rem;">${pendingTransactions != null ? pendingTransactions : 12}</div>
                                <div class="stat-label">Transaksi Pending</div>
                            </div>
                            <a href="${pageContext.request.contextPath}/admin/transactions?status=PENDING" class="btn btn-sm btn-warning ms-auto">
                                Verifikasi
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card pending-card">
                        <div class="d-flex align-items-center gap-3">
                            <div class="stat-icon" style="background: rgba(245, 158, 11, 0.2); color: #f59e0b;">
                                <i class="fas fa-user-clock"></i>
                            </div>
                            <div>
                                <div class="stat-value" style="font-size: 1.5rem;">${pendingWithdrawals != null ? pendingWithdrawals : 3}</div>
                                <div class="stat-label">Penarikan Pending</div>
                            </div>
                            <a href="${pageContext.request.contextPath}/admin/withdrawals" class="btn btn-sm btn-warning ms-auto">
                                Proses
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Charts Row -->
            <div class="row g-4 mb-4">
                <div class="col-lg-8">
                    <div class="chart-card">
                        <div class="chart-header">
                            <h5><i class="fas fa-chart-line text-primary me-2"></i>Registrasi User per Bulan</h5>
                            <select class="form-select form-select-sm" style="width: auto;">
                                <option>2025</option>
                                <option>2024</option>
                            </select>
                        </div>
                        <div class="chart-body">
                            <canvas id="registrationChart" height="300"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="chart-card h-100">
                        <div class="chart-header">
                            <h5><i class="fas fa-chart-pie text-primary me-2"></i>User by Role</h5>
                        </div>
                        <div class="chart-body">
                            <canvas id="roleChart" height="250"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Bottom Row -->
            <div class="row g-4">
                <!-- Recent Users -->
                <div class="col-lg-4">
                    <div class="chart-card h-100">
                        <div class="chart-header">
                            <h5><i class="fas fa-user-plus text-primary me-2"></i>Pengguna Terbaru</h5>
                            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-sm btn-outline-secondary">Lihat Semua</a>
                        </div>
                        <div class="chart-body">
                            <c:choose>
                                <c:when test="${not empty recentUsers}">
                                    <c:forEach var="user" items="${recentUsers}" end="4">
                                        <div class="user-row">
                                            <img src="https://ui-avatars.com/api/?name=${user.name}&background=3b82f6&color=fff" class="user-avatar">
                                            <div class="flex-grow-1">
                                                <div class="fw-semibold">${user.name}</div>
                                                <small class="text-muted">${user.email}</small>
                                            </div>
                                            <span class="badge ${user.role == 'ADMIN' ? 'bg-danger' : user.role == 'LECTURER' ? 'bg-success' : 'bg-primary'}">${user.roleDisplayName}</span>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="user-row">
                                        <img src="https://ui-avatars.com/api/?name=John+Doe&background=3b82f6&color=fff" class="user-avatar">
                                        <div class="flex-grow-1">
                                            <div class="fw-semibold">John Doe</div>
                                            <small class="text-muted">john@example.com</small>
                                        </div>
                                        <span class="badge bg-primary">Pelajar</span>
                                    </div>
                                    <div class="user-row">
                                        <img src="https://ui-avatars.com/api/?name=Jane+Smith&background=10b981&color=fff" class="user-avatar">
                                        <div class="flex-grow-1">
                                            <div class="fw-semibold">Jane Smith</div>
                                            <small class="text-muted">jane@example.com</small>
                                        </div>
                                        <span class="badge bg-success">Pengajar</span>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                
                <!-- Recent Courses -->
                <div class="col-lg-4">
                    <div class="chart-card h-100">
                        <div class="chart-header">
                            <h5><i class="fas fa-book text-primary me-2"></i>Kursus Terbaru</h5>
                            <a href="${pageContext.request.contextPath}/admin/courses" class="btn btn-sm btn-outline-secondary">Lihat Semua</a>
                        </div>
                        <div class="chart-body">
                            <c:choose>
                                <c:when test="${not empty recentCourses}">
                                    <c:forEach var="course" items="${recentCourses}" end="4">
                                        <div class="course-row">
                                            <img src="${not empty course.thumbnail ? course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=60&h=40&fit=crop'}" class="course-thumb">
                                            <div class="flex-grow-1 min-width-0">
                                                <div class="fw-semibold text-truncate">${course.title}</div>
                                                <small class="text-muted">oleh ${course.lecturer.name}</small>
                                            </div>
                                            <span class="badge ${course.status == 'PUBLISHED' ? 'bg-success' : course.status == 'PENDING' ? 'bg-warning' : 'bg-secondary'}">${course.statusDisplayName}</span>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="course-row">
                                        <img src="https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=60&h=40&fit=crop" class="course-thumb">
                                        <div class="flex-grow-1">
                                            <div class="fw-semibold">Belajar Python</div>
                                            <small class="text-muted">oleh Dr. Ahmad</small>
                                        </div>
                                        <span class="badge bg-warning">Pending</span>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                
                <!-- Recent Activity -->
                <div class="col-lg-4">
                    <div class="chart-card h-100">
                        <div class="chart-header">
                            <h5><i class="fas fa-history text-primary me-2"></i>Aktivitas Terbaru</h5>
                        </div>
                        <div class="chart-body">
                            <c:choose>
                                <c:when test="${not empty recentActivities}">
                                    <c:forEach var="activity" items="${recentActivities}" end="4">
                                        <div class="activity-item">
                                            <div class="activity-icon ${activity.type}">
                                                <i class="fas ${activity.icon}"></i>
                                            </div>
                                            <div class="flex-grow-1">
                                                <div class="small">${activity.description}</div>
                                                <div class="activity-time">${activity.timeAgo}</div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="activity-item">
                                        <div class="activity-icon user"><i class="fas fa-user-plus"></i></div>
                                        <div class="flex-grow-1">
                                            <div class="small"><strong>Ahmad</strong> mendaftar sebagai pelajar</div>
                                            <div class="activity-time">5 menit yang lalu</div>
                                        </div>
                                    </div>
                                    <div class="activity-item">
                                        <div class="activity-icon course"><i class="fas fa-book"></i></div>
                                        <div class="flex-grow-1">
                                            <div class="small">Kursus baru <strong>Python Basic</strong> submitted</div>
                                            <div class="activity-time">15 menit yang lalu</div>
                                        </div>
                                    </div>
                                    <div class="activity-item">
                                        <div class="activity-icon payment"><i class="fas fa-credit-card"></i></div>
                                        <div class="flex-grow-1">
                                            <div class="small">Pembayaran Rp 299.000 diterima</div>
                                            <div class="activity-time">1 jam yang lalu</div>
                                        </div>
                                    </div>
                                    <div class="activity-item">
                                        <div class="activity-icon review"><i class="fas fa-star"></i></div>
                                        <div class="flex-grow-1">
                                            <div class="small"><strong>Siti</strong> memberikan rating 5 bintang</div>
                                            <div class="activity-time">2 jam yang lalu</div>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
    
    <script>
        // Registration Chart
        const regCtx = document.getElementById('registrationChart').getContext('2d');
        new Chart(regCtx, {
            type: 'bar',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                datasets: [{
                    label: 'Pelajar',
                    data: [65, 78, 90, 81, 95, 120, 110, 130, 145, 160, 155, 180],
                    backgroundColor: 'rgba(59, 130, 246, 0.8)',
                    borderRadius: 8
                }, {
                    label: 'Pengajar',
                    data: [10, 12, 8, 15, 11, 18, 14, 20, 16, 22, 19, 25],
                    backgroundColor: 'rgba(16, 185, 129, 0.8)',
                    borderRadius: 8
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'top',
                    }
                },
                scales: {
                    y: { beginAtZero: true }
                }
            }
        });
        
        // Role Chart
        const roleCtx = document.getElementById('roleChart').getContext('2d');
        new Chart(roleCtx, {
            type: 'doughnut',
            data: {
                labels: ['Pelajar', 'Pengajar', 'Admin'],
                datasets: [{
                    data: [${totalStudents != null ? totalStudents : 1100}, ${totalLecturers != null ? totalLecturers : 145}, ${totalAdmins != null ? totalAdmins : 5}],
                    backgroundColor: ['#3b82f6', '#10b981', '#ef4444'],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: { padding: 20, usePointStyle: true }
                    }
                },
                cutout: '65%'
            }
        });
    </script>
</body>
</html>
