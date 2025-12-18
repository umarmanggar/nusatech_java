<%-- 
    Document   : dashboard
    Created on : Dec 10, 2025
    Author     : NusaTech
    Description: Lecturer Dashboard with Bootstrap 5 and Chart.js
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
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #8B1538;
            --primary-dark: #6d1029;
            --secondary: #D4A84B;
        }
        
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8f9fa;
        }
        
        .btn-primary { background-color: var(--primary); border-color: var(--primary); }
        .btn-primary:hover { background-color: var(--primary-dark); border-color: var(--primary-dark); }
        .btn-outline-primary { color: var(--primary); border-color: var(--primary); }
        .btn-outline-primary:hover { background-color: var(--primary); border-color: var(--primary); }
        .text-primary { color: var(--primary) !important; }
        
        /* Layout */
        .dashboard-wrapper { display: flex; min-height: 100vh; padding-top: 56px; }
        .main-content { flex: 1; margin-left: 280px; padding: 2rem; }
        @media (max-width: 991.98px) { .main-content { margin-left: 0; } }
        
        /* Sidebar */
        .sidebar {
            width: 280px;
            min-height: calc(100vh - 56px);
            background: white;
            border-right: 1px solid #e5e7eb;
            position: fixed;
            top: 56px;
            left: 0;
            z-index: 1020;
        }
        
        .sidebar-user {
            padding: 1.5rem;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
        }
        
        .sidebar-menu { padding: 1rem; }
        
        .sidebar-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.85rem 1rem;
            border-radius: 0.75rem;
            color: #4b5563;
            text-decoration: none;
            font-weight: 500;
            margin-bottom: 0.25rem;
            transition: all 0.2s;
        }
        
        .sidebar-item:hover { background: rgba(139, 21, 56, 0.08); color: var(--primary); }
        .sidebar-item.active { background: rgba(139, 21, 56, 0.12); color: var(--primary); font-weight: 600; }
        .sidebar-item i { width: 20px; text-align: center; }
        .sidebar-divider { height: 1px; background: #e5e7eb; margin: 1rem 0; }
        
        /* Stats Cards */
        .stat-card {
            background: white;
            border-radius: 1rem;
            padding: 1.5rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            height: 100%;
        }
        
        .stat-card-icon {
            width: 56px;
            height: 56px;
            border-radius: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }
        
        .stat-card-icon.primary { background: rgba(139, 21, 56, 0.1); color: var(--primary); }
        .stat-card-icon.success { background: rgba(16, 185, 129, 0.1); color: #10b981; }
        .stat-card-icon.warning { background: rgba(245, 158, 11, 0.1); color: #f59e0b; }
        .stat-card-icon.info { background: rgba(59, 130, 246, 0.1); color: #3b82f6; }
        
        .stat-card-value { font-size: 1.75rem; font-weight: 800; color: #1f2937; }
        .stat-card-label { font-size: 0.875rem; color: #6b7280; margin-top: 0.25rem; }
        .stat-card-trend { font-size: 0.8rem; margin-top: 0.5rem; }
        .stat-card-trend.up { color: #10b981; }
        .stat-card-trend.down { color: #ef4444; }
        
        /* Chart Card */
        .chart-card {
            background: white;
            border-radius: 1rem;
            padding: 1.5rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }
        
        .chart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }
        
        .chart-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: #1f2937;
        }
        
        /* Course Card */
        .course-card {
            border: none;
            border-radius: 1rem;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            transition: all 0.3s;
        }
        
        .course-card:hover { transform: translateY(-4px); box-shadow: 0 8px 20px rgba(0,0,0,0.08); }
        
        .course-card-img {
            height: 140px;
            overflow: hidden;
            position: relative;
        }
        
        .course-card-img img { width: 100%; height: 100%; object-fit: cover; }
        
        .course-badge {
            position: absolute;
            top: 10px;
            left: 10px;
            font-size: 0.7rem;
            font-weight: 600;
            padding: 0.3rem 0.6rem;
            border-radius: 0.5rem;
        }
        
        /* Review Card */
        .review-card {
            background: white;
            border-radius: 1rem;
            padding: 1.25rem;
            margin-bottom: 1rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }
        
        .review-avatar {
            width: 44px;
            height: 44px;
            border-radius: 50%;
        }
        
        .rating-stars { color: #f59e0b; font-size: 0.85rem; }
        
        @media (max-width: 991.98px) {
            .sidebar { transform: translateX(-100%); transition: transform 0.3s; }
            .sidebar.show { transform: translateX(0); }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <jsp:include page="/pages/common/navbar-dashboard.jsp"/>
    
    <div class="dashboard-wrapper">
        <!-- Sidebar -->
        <aside class="sidebar" id="sidebar">
            <div class="sidebar-user">
                <div class="d-flex align-items-center gap-3">
                    <img src="https://ui-avatars.com/api/?name=${sessionScope.user.name}&background=ffffff&color=8B1538" 
                         alt="${sessionScope.user.name}" class="rounded-circle" style="width: 48px; height: 48px;">
                    <div>
                        <div class="fw-semibold">${sessionScope.user.name}</div>
                        <small class="opacity-75"><i class="fas fa-chalkboard-teacher me-1"></i> Pengajar</small>
                    </div>
                </div>
            </div>
            
            <nav class="sidebar-menu">
                <a href="${pageContext.request.contextPath}/lecturer/dashboard" class="sidebar-item active">
                    <i class="fas fa-home"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/lecturer/courses" class="sidebar-item">
                    <i class="fas fa-book"></i> Kursus Saya
                </a>
                <a href="${pageContext.request.contextPath}/lecturer/course/create" class="sidebar-item">
                    <i class="fas fa-plus-circle"></i> Buat Kursus
                </a>
                <a href="${pageContext.request.contextPath}/lecturer/students" class="sidebar-item">
                    <i class="fas fa-users"></i> Pelajar
                </a>
                <a href="${pageContext.request.contextPath}/lecturer/earnings" class="sidebar-item">
                    <i class="fas fa-wallet"></i> Pendapatan
                </a>
                
                <div class="sidebar-divider"></div>
                
                <a href="${pageContext.request.contextPath}/lecturer/profile" class="sidebar-item">
                    <i class="fas fa-user-circle"></i> Profil
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="sidebar-item text-danger">
                    <i class="fas fa-sign-out-alt"></i> Keluar
                </a>
            </nav>
        </aside>
        
        <!-- Main Content -->
        <main class="main-content">
            <!-- Mobile Toggle -->
            <button class="btn btn-outline-secondary d-lg-none mb-3" onclick="document.getElementById('sidebar').classList.toggle('show')">
                <i class="fas fa-bars me-2"></i> Menu
            </button>
            
            <!-- Page Header -->
            <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
                <div>
                    <h1 class="h3 fw-bold mb-1">Dashboard Pengajar</h1>
                    <p class="text-muted mb-0">Selamat datang kembali, ${sessionScope.user.name}! 👋</p>
                </div>
                <a href="${pageContext.request.contextPath}/lecturer/course/create" class="btn btn-primary">
                    <i class="fas fa-plus me-2"></i> Buat Kursus Baru
                </a>
            </div>
            
            <!-- Stats Row -->
            <div class="row g-4 mb-4">
                <div class="col-sm-6 col-xl-3">
                    <div class="stat-card">
                        <div class="stat-card-icon primary">
                            <i class="fas fa-book"></i>
                        </div>
                        <div class="stat-card-value">${totalCourses != null ? totalCourses : 0}</div>
                        <div class="stat-card-label">Total Kursus</div>
                        <div class="stat-card-trend up">
                            <i class="fas fa-arrow-up me-1"></i> ${publishedCourses != null ? publishedCourses : 0} dipublikasikan
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-xl-3">
                    <div class="stat-card">
                        <div class="stat-card-icon success">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-card-value">${totalStudents != null ? totalStudents : 0}</div>
                        <div class="stat-card-label">Total Pelajar</div>
                        <div class="stat-card-trend up">
                            <i class="fas fa-arrow-up me-1"></i> +${newStudentsThisMonth != null ? newStudentsThisMonth : 0} bulan ini
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-xl-3">
                    <div class="stat-card">
                        <div class="stat-card-icon warning">
                            <i class="fas fa-wallet"></i>
                        </div>
                        <div class="stat-card-value">
                            <small>Rp</small> <fmt:formatNumber value="${totalEarnings != null ? totalEarnings : 0}" pattern="#,###"/>
                        </div>
                        <div class="stat-card-label">Total Pendapatan</div>
                        <div class="stat-card-trend up">
                            <i class="fas fa-arrow-up me-1"></i> +15% dari bulan lalu
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-xl-3">
                    <div class="stat-card">
                        <div class="stat-card-icon info">
                            <i class="fas fa-star"></i>
                        </div>
                        <div class="stat-card-value">
                            <fmt:formatNumber value="${avgRating != null ? avgRating : 4.8}" maxFractionDigits="1"/>
                        </div>
                        <div class="stat-card-label">Rating Rata-rata</div>
                        <div class="stat-card-trend">
                            <i class="fas fa-star text-warning me-1"></i> ${totalReviews != null ? totalReviews : 0} ulasan
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Charts Row -->
            <div class="row g-4 mb-4">
                <div class="col-lg-8">
                    <div class="chart-card">
                        <div class="chart-header">
                            <h5 class="chart-title"><i class="fas fa-chart-line text-primary me-2"></i>Pendapatan</h5>
                            <select class="form-select form-select-sm" style="width: auto;" id="earningsChartPeriod">
                                <option value="7">7 Hari</option>
                                <option value="30" selected>30 Hari</option>
                                <option value="90">3 Bulan</option>
                            </select>
                        </div>
                        <canvas id="earningsChart" height="280"></canvas>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="chart-card">
                        <div class="chart-header">
                            <h5 class="chart-title"><i class="fas fa-chart-pie text-primary me-2"></i>Status Kursus</h5>
                        </div>
                        <canvas id="coursesChart" height="280"></canvas>
                    </div>
                </div>
            </div>
            
            <!-- Bottom Row -->
            <div class="row g-4">
                <!-- Popular Courses -->
                <div class="col-lg-7">
                    <div class="chart-card">
                        <div class="chart-header">
                            <h5 class="chart-title"><i class="fas fa-fire text-danger me-2"></i>Kursus Terpopuler</h5>
                            <a href="${pageContext.request.contextPath}/lecturer/courses" class="btn btn-sm btn-outline-primary">
                                Lihat Semua
                            </a>
                        </div>
                        
                        <c:choose>
                            <c:when test="${not empty popularCourses}">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Kursus</th>
                                                <th class="text-center">Pelajar</th>
                                                <th class="text-center">Rating</th>
                                                <th class="text-end">Pendapatan</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="course" items="${popularCourses}" end="4">
                                                <tr>
                                                    <td>
                                                        <div class="d-flex align-items-center gap-2">
                                                            <img src="${not empty course.thumbnail ? course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=50&h=50&fit=crop'}" 
                                                                 alt="${course.title}" class="rounded" style="width: 40px; height: 40px; object-fit: cover;">
                                                            <div>
                                                                <div class="fw-semibold text-truncate" style="max-width: 200px;">${course.title}</div>
                                                                <small class="text-muted">${course.category.name}</small>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="text-center">
                                                        <span class="badge bg-light text-dark">${course.totalStudents}</span>
                                                    </td>
                                                    <td class="text-center">
                                                        <span class="text-warning"><i class="fas fa-star"></i></span>
                                                        <fmt:formatNumber value="${course.avgRating}" maxFractionDigits="1"/>
                                                    </td>
                                                    <td class="text-end fw-semibold text-success">
                                                        Rp <fmt:formatNumber value="${course.price * course.totalStudents}" pattern="#,###"/>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-4 text-muted">
                                    <i class="fas fa-book fa-3x mb-3 opacity-50"></i>
                                    <p>Belum ada kursus</p>
                                    <a href="${pageContext.request.contextPath}/lecturer/course/create" class="btn btn-primary btn-sm">
                                        <i class="fas fa-plus me-1"></i> Buat Kursus
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                
                <!-- Recent Reviews -->
                <div class="col-lg-5">
                    <div class="chart-card">
                        <div class="chart-header">
                            <h5 class="chart-title"><i class="fas fa-comments text-info me-2"></i>Ulasan Terbaru</h5>
                        </div>
                        
                        <c:choose>
                            <c:when test="${not empty recentReviews}">
                                <c:forEach var="review" items="${recentReviews}" end="3">
                                    <div class="review-card">
                                        <div class="d-flex gap-3">
                                            <img src="https://ui-avatars.com/api/?name=${review.student.name}&background=3b82f6&color=fff" 
                                                 alt="${review.student.name}" class="review-avatar">
                                            <div class="flex-grow-1">
                                                <div class="d-flex justify-content-between align-items-start">
                                                    <div>
                                                        <h6 class="mb-0 fw-semibold">${review.student.name}</h6>
                                                        <small class="text-muted">${review.course.title}</small>
                                                    </div>
                                                    <div class="rating-stars">
                                                        <c:forEach begin="1" end="5" var="i">
                                                            <i class="fas ${i <= review.rating ? 'fa-star' : 'far fa-star'}"></i>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                                <p class="text-muted small mt-2 mb-0">"${review.comment}"</p>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <!-- Sample Reviews -->
                                <div class="review-card">
                                    <div class="d-flex gap-3">
                                        <img src="https://ui-avatars.com/api/?name=Ahmad+Rizki&background=3b82f6&color=fff" class="review-avatar">
                                        <div class="flex-grow-1">
                                            <div class="d-flex justify-content-between align-items-start">
                                                <div>
                                                    <h6 class="mb-0 fw-semibold">Ahmad Rizki</h6>
                                                    <small class="text-muted">Sample Course</small>
                                                </div>
                                                <div class="rating-stars">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                </div>
                                            </div>
                                            <p class="text-muted small mt-2 mb-0">"Kursus yang sangat bagus dan mudah dipahami!"</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="text-center py-2">
                                    <small class="text-muted">Belum ada ulasan lainnya</small>
                                </div>
                            </c:otherwise>
                        </c:choose>
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
        // Earnings Chart
        const earningsCtx = document.getElementById('earningsChart').getContext('2d');
        new Chart(earningsCtx, {
            type: 'line',
            data: {
                labels: ['1', '5', '10', '15', '20', '25', '30'],
                datasets: [{
                    label: 'Pendapatan (Rp)',
                    data: [150000, 280000, 420000, 350000, 580000, 720000, 890000],
                    borderColor: '#8B1538',
                    backgroundColor: 'rgba(139, 21, 56, 0.1)',
                    fill: true,
                    tension: 0.4,
                    pointBackgroundColor: '#8B1538',
                    pointBorderColor: '#fff',
                    pointBorderWidth: 2
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return 'Rp ' + value.toLocaleString('id-ID');
                            }
                        }
                    }
                }
            }
        });
        
        // Courses Pie Chart
        const coursesCtx = document.getElementById('coursesChart').getContext('2d');
        new Chart(coursesCtx, {
            type: 'doughnut',
            data: {
                labels: ['Published', 'Pending', 'Draft'],
                datasets: [{
                    data: [${publishedCourses != null ? publishedCourses : 3}, ${pendingCourses != null ? pendingCourses : 1}, ${draftCourses != null ? draftCourses : 2}],
                    backgroundColor: ['#10b981', '#f59e0b', '#6b7280'],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            padding: 20,
                            usePointStyle: true
                        }
                    }
                },
                cutout: '60%'
            }
        });
    </script>
</body>
</html>
