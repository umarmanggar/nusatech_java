<%-- 
    Document   : my-learning
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Student My Learning Page with Bootstrap 5
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
        .bg-primary { background-color: var(--primary) !important; }
        
        /* Layout */
        .dashboard-wrapper {
            display: flex;
            min-height: 100vh;
            padding-top: 56px;
        }
        
        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 2rem;
        }
        
        @media (max-width: 991.98px) {
            .main-content {
                margin-left: 0;
            }
        }
        
        /* Page Header */
        .page-header {
            margin-bottom: 2rem;
        }
        
        .page-title {
            font-size: 1.75rem;
            font-weight: 800;
            color: #1f2937;
            margin-bottom: 0.25rem;
        }
        
        .page-subtitle {
            color: #6b7280;
        }
        
        /* Stats Cards */
        .stat-card {
            background: white;
            border-radius: 1rem;
            padding: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }
        
        .stat-icon {
            width: 56px;
            height: 56px;
            border-radius: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }
        
        .stat-icon.primary { background: rgba(139, 21, 56, 0.1); color: var(--primary); }
        .stat-icon.success { background: rgba(16, 185, 129, 0.1); color: #10b981; }
        .stat-icon.warning { background: rgba(245, 158, 11, 0.1); color: #f59e0b; }
        
        .stat-value {
            font-size: 1.75rem;
            font-weight: 800;
            color: #1f2937;
        }
        
        .stat-label {
            font-size: 0.875rem;
            color: #6b7280;
        }
        
        /* Nav Tabs Custom */
        .nav-tabs-custom {
            border: none;
            background: white;
            border-radius: 1rem;
            padding: 0.5rem;
            margin-bottom: 1.5rem;
        }
        
        .nav-tabs-custom .nav-link {
            border: none;
            border-radius: 0.75rem;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            color: #6b7280;
            transition: all 0.2s;
        }
        
        .nav-tabs-custom .nav-link:hover {
            color: var(--primary);
            background: rgba(139, 21, 56, 0.05);
        }
        
        .nav-tabs-custom .nav-link.active {
            background: var(--primary);
            color: white;
        }
        
        /* Course Learning Card */
        .learning-card {
            background: white;
            border-radius: 1rem;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            margin-bottom: 1rem;
            transition: all 0.3s;
        }
        
        .learning-card:hover {
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
        }
        
        .learning-card-body {
            display: flex;
            align-items: center;
            padding: 1.25rem;
            gap: 1.5rem;
        }
        
        @media (max-width: 767.98px) {
            .learning-card-body {
                flex-direction: column;
                text-align: center;
            }
        }
        
        .learning-card-img {
            width: 180px;
            height: 100px;
            border-radius: 0.75rem;
            overflow: hidden;
            flex-shrink: 0;
        }
        
        .learning-card-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .learning-card-content {
            flex: 1;
            min-width: 0;
        }
        
        .learning-card-status {
            font-size: 0.75rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            margin-bottom: 0.5rem;
        }
        
        .learning-card-status.active {
            color: var(--primary);
        }
        
        .learning-card-status.completed {
            color: #10b981;
        }
        
        .learning-card-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 0.5rem;
            display: -webkit-box;
            -webkit-line-clamp: 1;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .learning-card-instructor {
            font-size: 0.875rem;
            color: #6b7280;
            margin-bottom: 0.75rem;
        }
        
        .learning-card-progress {
            max-width: 300px;
        }
        
        .progress {
            height: 8px;
            background-color: #e5e7eb;
            border-radius: 1rem;
        }
        
        .progress-bar {
            background-color: var(--primary);
            border-radius: 1rem;
        }
        
        .progress-bar.bg-success {
            background-color: #10b981 !important;
        }
        
        .learning-card-actions {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            min-width: 150px;
        }
        
        .learning-card-meta {
            font-size: 0.75rem;
            color: #9ca3af;
            text-align: center;
        }
        
        /* Filter Bar */
        .filter-bar {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
        }
        
        .search-input {
            max-width: 300px;
        }
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 1rem;
        }
        
        .empty-state-icon {
            width: 100px;
            height: 100px;
            background: rgba(139, 21, 56, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 2.5rem;
            color: var(--primary);
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <jsp:include page="/pages/common/navbar-dashboard.jsp"/>
    
    <div class="dashboard-wrapper">
        <!-- Sidebar -->
        <jsp:include page="/pages/common/sidebar-student.jsp"/>
        
        <!-- Main Content -->
        <main class="main-content">
            <!-- Mobile Sidebar Toggle -->
            <button class="btn btn-outline-secondary d-lg-none mb-3" onclick="toggleSidebar()">
                <i class="fas fa-bars me-2"></i> Menu
            </button>
            
            <!-- Page Header -->
            <div class="page-header">
                <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
                    <div>
                        <h1 class="page-title">Kursus Saya</h1>
                        <p class="page-subtitle mb-0">Pantau progress belajar Anda</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/courses" class="btn btn-primary">
                        <i class="fas fa-plus me-2"></i> Jelajahi Kursus
                    </a>
                </div>
            </div>
            
            <!-- Stats Row -->
            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="stat-card">
                        <div class="stat-icon primary">
                            <i class="fas fa-book-open"></i>
                        </div>
                        <div>
                            <div class="stat-value">${totalEnrolled != null ? totalEnrolled : 0}</div>
                            <div class="stat-label">Total Kursus</div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card">
                        <div class="stat-icon warning">
                            <i class="fas fa-spinner"></i>
                        </div>
                        <div>
                            <div class="stat-value">${totalActive != null ? totalActive : 0}</div>
                            <div class="stat-label">Sedang Belajar</div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card">
                        <div class="stat-icon success">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div>
                            <div class="stat-value">${totalCompleted != null ? totalCompleted : 0}</div>
                            <div class="stat-label">Selesai</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Filter Bar -->
            <div class="filter-bar">
                <div class="input-group search-input">
                    <span class="input-group-text bg-white"><i class="fas fa-search text-muted"></i></span>
                    <input type="text" class="form-control" id="searchCourse" placeholder="Cari kursus..." onkeyup="filterCourses()">
                </div>
                <select class="form-select" style="width: auto;" onchange="sortCourses(this.value)">
                    <option value="recent">Terakhir Diakses</option>
                    <option value="progress">Progress Tertinggi</option>
                    <option value="name">Nama A-Z</option>
                </select>
            </div>
            
            <!-- Tabs -->
            <ul class="nav nav-tabs-custom" id="courseTab" role="tablist">
                <li class="nav-item" role="presentation">
                    <a class="nav-link ${empty filter ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/student/my-learning">
                        <i class="fas fa-layer-group me-2"></i>Semua
                        <span class="badge bg-secondary ms-2">${totalEnrolled != null ? totalEnrolled : 0}</span>
                    </a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link ${filter == 'active' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/student/my-learning?filter=active">
                        <i class="fas fa-play-circle me-2"></i>Sedang Belajar
                        <span class="badge bg-warning text-dark ms-2">${totalActive != null ? totalActive : 0}</span>
                    </a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link ${filter == 'completed' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/student/my-learning?filter=completed">
                        <i class="fas fa-check-circle me-2"></i>Selesai
                        <span class="badge bg-success ms-2">${totalCompleted != null ? totalCompleted : 0}</span>
                    </a>
                </li>
            </ul>
            
            <!-- Courses List -->
            <c:choose>
                <c:when test="${not empty enrollments}">
                    <div id="coursesList">
                        <c:forEach var="enrollment" items="${enrollments}">
                            <div class="learning-card" data-title="${enrollment.course.title}">
                                <div class="learning-card-body">
                                    <div class="learning-card-img">
                                        <img src="${not empty enrollment.course.thumbnail && !enrollment.course.thumbnail.equals('default-course.png') ? enrollment.course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400&h=225&fit=crop'}" 
                                             alt="${enrollment.course.title}">
                                    </div>
                                    <div class="learning-card-content">
                                        <span class="learning-card-status ${enrollment.status == 'COMPLETED' ? 'completed' : 'active'}">
                                            <c:choose>
                                                <c:when test="${enrollment.status == 'COMPLETED'}">
                                                    <i class="fas fa-check-circle"></i> Selesai
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-play-circle"></i> Sedang Dipelajari
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                        <h3 class="learning-card-title">${enrollment.course.title}</h3>
                                        <div class="learning-card-instructor">
                                            <i class="fas fa-chalkboard-teacher me-1"></i>
                                            <c:if test="${not empty enrollment.course.lecturer}">
                                                ${enrollment.course.lecturer.name}
                                            </c:if>
                                        </div>
                                        <div class="learning-card-progress">
                                            <div class="d-flex justify-content-between align-items-center mb-1">
                                                <small class="text-muted">Progress</small>
                                                <small class="fw-bold ${enrollment.status == 'COMPLETED' ? 'text-success' : ''}">${enrollment.progressInt}%</small>
                                            </div>
                                            <div class="progress">
                                                <div class="progress-bar ${enrollment.status == 'COMPLETED' ? 'bg-success' : ''}" 
                                                     style="width: ${enrollment.progressInt}%"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="learning-card-actions">
                                        <c:choose>
                                            <c:when test="${enrollment.status == 'COMPLETED'}">
                                                <a href="${pageContext.request.contextPath}/learn/${enrollment.course.slug}" class="btn btn-outline-primary">
                                                    <i class="fas fa-redo me-1"></i> Ulangi
                                                </a>
                                                <c:if test="${enrollment.certificateIssued}">
                                                    <a href="${pageContext.request.contextPath}/student/certificates" class="btn btn-warning">
                                                        <i class="fas fa-certificate me-1"></i> Sertifikat
                                                    </a>
                                                </c:if>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/learn/${enrollment.course.slug}" class="btn btn-primary">
                                                    <i class="fas fa-play me-1"></i> Lanjutkan
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="learning-card-meta">
                                            <c:if test="${not empty enrollment.lastAccessedAt}">
                                                <i class="far fa-clock me-1"></i>
                                                <fmt:formatDate value="${enrollment.lastAccessedAt}" pattern="dd MMM yyyy"/>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Empty State -->
                    <div class="empty-state">
                        <div class="empty-state-icon">
                            <i class="fas fa-book-open"></i>
                        </div>
                        <h4 class="fw-bold mb-2">
                            <c:choose>
                                <c:when test="${filter == 'completed'}">Belum Ada Kursus yang Selesai</c:when>
                                <c:when test="${filter == 'active'}">Tidak Ada Kursus Aktif</c:when>
                                <c:otherwise>Belum Ada Kursus</c:otherwise>
                            </c:choose>
                        </h4>
                        <p class="text-muted mb-4">
                            <c:choose>
                                <c:when test="${filter == 'completed'}">Selesaikan kursus untuk mendapatkan sertifikat!</c:when>
                                <c:when test="${filter == 'active'}">Mulai belajar kursus baru sekarang.</c:when>
                                <c:otherwise>Mulai perjalanan belajar Anda dengan mengikuti kursus pertama.</c:otherwise>
                            </c:choose>
                        </p>
                        <a href="${pageContext.request.contextPath}/courses" class="btn btn-primary btn-lg">
                            <i class="fas fa-search me-2"></i> Jelajahi Kursus
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function filterCourses() {
            const searchValue = document.getElementById('searchCourse').value.toLowerCase();
            const cards = document.querySelectorAll('.learning-card');
            
            cards.forEach(card => {
                const title = card.dataset.title.toLowerCase();
                if (title.includes(searchValue)) {
                    card.style.display = '';
                } else {
                    card.style.display = 'none';
                }
            });
        }
        
        function sortCourses(value) {
            // Implement sorting logic based on value
            const url = new URL(window.location);
            url.searchParams.set('sort', value);
            window.location = url;
        }
    </script>
</body>
</html>
