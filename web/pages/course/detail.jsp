<%-- 
    Document   : detail
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Course Detail Page with Bootstrap 5
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${course.title} - NusaTech</title>
    <meta name="description" content="${course.shortDescription}">
    
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
        }
        
        .btn-primary {
            background-color: var(--primary);
            border-color: var(--primary);
        }
        .btn-primary:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
        }
        .btn-outline-primary {
            color: var(--primary);
            border-color: var(--primary);
        }
        .btn-outline-primary:hover {
            background-color: var(--primary);
            border-color: var(--primary);
        }
        .btn-secondary {
            background-color: var(--secondary);
            border-color: var(--secondary);
            color: #1f2937;
        }
        .btn-secondary:hover {
            background-color: #c69a3e;
            border-color: #c69a3e;
            color: #1f2937;
        }
        
        .text-primary { color: var(--primary) !important; }
        .bg-primary { background-color: var(--primary) !important; }
        
        /* Hero Section */
        .course-hero {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            padding-top: 100px;
            padding-bottom: 4rem;
            color: white;
        }
        
        .breadcrumb-item a {
            color: rgba(255,255,255,0.7);
            text-decoration: none;
        }
        .breadcrumb-item.active {
            color: rgba(255,255,255,0.9);
        }
        .breadcrumb-item + .breadcrumb-item::before {
            color: rgba(255,255,255,0.5);
        }
        
        .course-meta-badge {
            background: rgba(255,255,255,0.15);
            padding: 0.25rem 0.75rem;
            border-radius: 0.5rem;
            font-size: 0.85rem;
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
        }
        
        /* Sticky Sidebar */
        .course-sidebar {
            position: sticky;
            top: 80px;
        }
        
        .course-sidebar-card {
            background: white;
            border-radius: 1rem;
            overflow: hidden;
            box-shadow: 0 4px 24px rgba(0,0,0,0.15);
        }
        
        .course-preview-img {
            width: 100%;
            aspect-ratio: 16/9;
            object-fit: cover;
        }
        
        .course-sidebar-body {
            padding: 1.5rem;
        }
        
        .price-display {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1.25rem;
        }
        .price-current {
            font-size: 2rem;
            font-weight: 800;
            color: #1f2937;
        }
        .price-original {
            font-size: 1.1rem;
            color: #9ca3af;
            text-decoration: line-through;
        }
        .price-discount {
            background: #fee2e2;
            color: #dc2626;
            font-size: 0.8rem;
            font-weight: 700;
            padding: 0.25rem 0.5rem;
            border-radius: 0.25rem;
        }
        .price-free {
            font-size: 2rem;
            font-weight: 800;
            color: #10b981;
        }
        
        .feature-list {
            border-top: 1px solid #e5e7eb;
            padding-top: 1.25rem;
            margin-top: 1.25rem;
        }
        .feature-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.5rem 0;
            font-size: 0.9rem;
            color: #4b5563;
        }
        .feature-item i {
            width: 20px;
            color: var(--primary);
        }
        
        /* Content Sections */
        .content-card {
            background: white;
            border-radius: 1rem;
            padding: 2rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        
        .content-title {
            font-size: 1.35rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        .content-title i {
            color: var(--secondary);
        }
        
        /* Learning Points */
        .learning-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
        }
        @media (max-width: 767.98px) {
            .learning-grid {
                grid-template-columns: 1fr;
            }
        }
        .learning-item {
            display: flex;
            gap: 0.75rem;
        }
        .learning-item i {
            color: #10b981;
            margin-top: 4px;
            flex-shrink: 0;
        }
        
        /* Tabs */
        .nav-tabs .nav-link {
            color: #6b7280;
            font-weight: 600;
            border: none;
            padding: 1rem 1.5rem;
            position: relative;
        }
        .nav-tabs .nav-link:hover {
            color: var(--primary);
            border: none;
        }
        .nav-tabs .nav-link.active {
            color: var(--primary);
            background: none;
            border: none;
        }
        .nav-tabs .nav-link.active::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 1rem;
            right: 1rem;
            height: 3px;
            background: var(--primary);
            border-radius: 3px 3px 0 0;
        }
        
        /* Curriculum Accordion */
        .curriculum-accordion .accordion-button {
            font-weight: 600;
            background-color: #f9fafb;
            padding: 1rem 1.25rem;
        }
        .curriculum-accordion .accordion-button:not(.collapsed) {
            background-color: rgba(139, 21, 56, 0.05);
            color: var(--primary);
        }
        .curriculum-accordion .accordion-button:focus {
            box-shadow: none;
            border-color: rgba(139, 21, 56, 0.2);
        }
        .curriculum-accordion .accordion-button::after {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16' fill='%238B1538'%3e%3cpath fill-rule='evenodd' d='M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z'/%3e%3c/svg%3e");
        }
        
        .material-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0.85rem 0;
            border-bottom: 1px solid #f3f4f6;
        }
        .material-item:last-child {
            border-bottom: none;
        }
        .material-item i.fa-play-circle { color: var(--primary); }
        .material-item i.fa-file-alt { color: #3b82f6; }
        .material-item i.fa-question-circle { color: #f59e0b; }
        .material-item i.fa-code { color: #8b5cf6; }
        
        /* Instructor */
        .instructor-avatar {
            width: 100px;
            height: 100px;
            border-radius: 1rem;
            object-fit: cover;
        }
        
        /* Reviews */
        .rating-summary {
            display: flex;
            gap: 2rem;
            padding: 1.5rem;
            background: #f9fafb;
            border-radius: 1rem;
        }
        .rating-big {
            text-align: center;
            min-width: 100px;
        }
        .rating-number {
            font-size: 3rem;
            font-weight: 800;
            line-height: 1;
        }
        .rating-bars {
            flex: 1;
        }
        .rating-bar-row {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.35rem;
        }
        
        .review-item {
            padding: 1.5rem 0;
            border-bottom: 1px solid #f3f4f6;
        }
        .review-item:last-child {
            border-bottom: none;
        }
        .review-avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
        }
        
        /* Related Courses */
        .related-course-card {
            border: none;
            border-radius: 1rem;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            transition: all 0.3s;
        }
        .related-course-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.12);
        }
        .related-course-img {
            height: 140px;
            object-fit: cover;
        }
        
        /* Mobile Sticky Buy Bar */
        @media (max-width: 991.98px) {
            .mobile-buy-bar {
                position: fixed;
                bottom: 0;
                left: 0;
                right: 0;
                background: white;
                padding: 1rem;
                box-shadow: 0 -4px 16px rgba(0,0,0,0.1);
                z-index: 1030;
                display: flex;
                align-items: center;
                justify-content: space-between;
                gap: 1rem;
            }
            body {
                padding-bottom: 80px;
            }
        }
        @media (min-width: 992px) {
            .mobile-buy-bar {
                display: none;
            }
        }
        
        .progress {
            height: 6px;
            background-color: #e5e7eb;
        }
        .progress-bar {
            background-color: var(--primary);
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <jsp:include page="/pages/common/navbar.jsp"/>
    
    <!-- Course Hero -->
    <section class="course-hero">
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    <!-- Breadcrumb -->
                    <nav aria-label="breadcrumb" class="mb-3">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Beranda</a></li>
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/courses">Kursus</a></li>
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/courses?category=${course.category.slug}">${course.category.name}</a></li>
                            <li class="breadcrumb-item active">${course.title}</li>
                        </ol>
                    </nav>
                    
                    <!-- Category Badge -->
                    <span class="badge mb-3" style="background: var(--secondary); color: #1f2937;">
                        ${course.category.name}
                    </span>
                    
                    <!-- Title -->
                    <h1 class="display-5 fw-bold mb-3">${course.title}</h1>
                    
                    <!-- Description -->
                    <p class="lead mb-4 opacity-90">${course.shortDescription}</p>
                    
                    <!-- Meta Info -->
                    <div class="d-flex flex-wrap gap-3 mb-4">
                        <span class="course-meta-badge">
                            <i class="fas fa-star text-warning"></i>
                            <strong><fmt:formatNumber value="${course.avgRating}" maxFractionDigits="1"/></strong>
                            (${course.totalReviews} ulasan)
                        </span>
                        <span class="course-meta-badge">
                            <i class="fas fa-users"></i>
                            ${course.totalStudents} pelajar
                        </span>
                        <span class="course-meta-badge">
                            <i class="fas fa-signal"></i>
                            ${course.levelDisplayName}
                        </span>
                        <span class="course-meta-badge">
                            <i class="fas fa-language"></i>
                            ${course.language}
                        </span>
                        <span class="course-meta-badge">
                            <i class="fas fa-calendar-alt"></i>
                            Update <fmt:formatDate value="${course.updatedAt}" pattern="MMM yyyy"/>
                        </span>
                    </div>
                    
                    <!-- Instructor -->
                    <div class="d-flex align-items-center gap-3">
                        <img src="https://ui-avatars.com/api/?name=${course.lecturer.name}&background=ffffff&color=8B1538&size=56" 
                             alt="${course.lecturer.name}" 
                             class="rounded-circle" style="width: 56px; height: 56px; border: 3px solid rgba(255,255,255,0.3);">
                        <div>
                            <small class="opacity-75">Dibuat oleh</small>
                            <p class="fw-bold mb-0 fs-5">${course.lecturer.name}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Main Content -->
    <section class="py-5" style="background: #f8f9fa;">
        <div class="container">
            <div class="row g-4">
                <!-- Main Content Column -->
                <div class="col-lg-8">
                    <!-- Tabs Navigation -->
                    <ul class="nav nav-tabs bg-white rounded-top" id="courseTab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="about-tab" data-bs-toggle="tab" data-bs-target="#about" type="button">
                                <i class="fas fa-info-circle me-2"></i>Tentang
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="curriculum-tab" data-bs-toggle="tab" data-bs-target="#curriculum" type="button">
                                <i class="fas fa-list-ol me-2"></i>Kurikulum
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="instructor-tab" data-bs-toggle="tab" data-bs-target="#instructor" type="button">
                                <i class="fas fa-chalkboard-teacher me-2"></i>Pengajar
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="reviews-tab" data-bs-toggle="tab" data-bs-target="#reviews" type="button">
                                <i class="fas fa-star me-2"></i>Ulasan
                            </button>
                        </li>
                    </ul>
                    
                    <!-- Tab Content -->
                    <div class="tab-content bg-white rounded-bottom p-4 shadow-sm" id="courseTabContent">
                        <!-- About Tab -->
                        <div class="tab-pane fade show active" id="about" role="tabpanel">
                            <!-- What You'll Learn -->
                            <div class="mb-4 pb-4 border-bottom">
                                <h4 class="content-title">
                                    <i class="fas fa-lightbulb"></i> Yang Akan Anda Pelajari
                                </h4>
                                <div class="learning-grid">
                                    <c:choose>
                                        <c:when test="${not empty course.objectives}">
                                            <c:forTokens items="${course.objectives}" delims="|" var="objective">
                                                <div class="learning-item">
                                                    <i class="fas fa-check"></i>
                                                    <span>${objective}</span>
                                                </div>
                                            </c:forTokens>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="learning-item"><i class="fas fa-check"></i><span>Memahami konsep dasar dan fundamental</span></div>
                                            <div class="learning-item"><i class="fas fa-check"></i><span>Praktik langsung dengan studi kasus</span></div>
                                            <div class="learning-item"><i class="fas fa-check"></i><span>Membangun proyek nyata dari awal hingga selesai</span></div>
                                            <div class="learning-item"><i class="fas fa-check"></i><span>Best practices dan tips profesional</span></div>
                                            <div class="learning-item"><i class="fas fa-check"></i><span>Debugging dan problem solving</span></div>
                                            <div class="learning-item"><i class="fas fa-check"></i><span>Deployment ke production</span></div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            
                            <!-- Requirements -->
                            <div class="mb-4 pb-4 border-bottom">
                                <h4 class="content-title">
                                    <i class="fas fa-clipboard-list"></i> Persyaratan
                                </h4>
                                <ul class="mb-0">
                                    <c:choose>
                                        <c:when test="${not empty course.requirements}">
                                            <c:forTokens items="${course.requirements}" delims="|" var="req">
                                                <li class="mb-2">${req}</li>
                                            </c:forTokens>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="mb-2">Laptop/komputer dengan koneksi internet</li>
                                            <li class="mb-2">Semangat belajar dan berlatih</li>
                                            <li class="mb-2">Tidak diperlukan pengalaman sebelumnya</li>
                                        </c:otherwise>
                                    </c:choose>
                                </ul>
                            </div>
                            
                            <!-- Description -->
                            <div>
                                <h4 class="content-title">
                                    <i class="fas fa-file-alt"></i> Deskripsi Kursus
                                </h4>
                                <div class="text-muted" style="line-height: 1.8;">
                                    ${not empty course.description ? course.description : '<p>Kursus ini akan membantu Anda mempelajari materi secara komprehensif dengan berbagai studi kasus praktis. Anda akan dipandu langkah demi langkah dari konsep dasar hingga implementasi lanjutan.</p><p>Setelah menyelesaikan kursus ini, Anda akan memiliki pemahaman yang mendalam dan siap untuk mengaplikasikan pengetahuan dalam proyek nyata.</p>'}
                                </div>
                            </div>
                        </div>
                        
                        <!-- Curriculum Tab -->
                        <div class="tab-pane fade" id="curriculum" role="tabpanel">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h4 class="content-title mb-0">
                                    <i class="fas fa-list-ol"></i> Kurikulum Kursus
                                </h4>
                                <span class="text-muted">
                                    ${course.totalSections > 0 ? course.totalSections : '5'} Bab • 
                                    ${course.totalMaterials > 0 ? course.totalMaterials : '20'} Materi • 
                                    ${course.durationHours > 0 ? course.durationHours : '10'}+ jam
                                </span>
                            </div>
                            
                            <div class="accordion curriculum-accordion" id="curriculumAccordion">
                                <c:choose>
                                    <c:when test="${not empty sections}">
                                        <c:forEach var="section" items="${sections}" varStatus="status">
                                            <div class="accordion-item">
                                                <h2 class="accordion-header">
                                                    <button class="accordion-button ${status.index > 0 ? 'collapsed' : ''}" type="button" 
                                                            data-bs-toggle="collapse" data-bs-target="#section${section.sectionId}">
                                                        <span class="me-auto">
                                                            <strong>Bab ${status.index + 1}:</strong> ${section.title}
                                                        </span>
                                                        <small class="text-muted me-3">${section.materials.size()} materi</small>
                                                    </button>
                                                </h2>
                                                <div id="section${section.sectionId}" class="accordion-collapse collapse ${status.index == 0 ? 'show' : ''}"
                                                     data-bs-parent="#curriculumAccordion">
                                                    <div class="accordion-body">
                                                        <c:forEach var="material" items="${section.materials}">
                                                            <div class="material-item">
                                                                <div class="d-flex align-items-center gap-3">
                                                                    <c:choose>
                                                                        <c:when test="${material.contentType == 'VIDEO'}">
                                                                            <i class="fas fa-play-circle"></i>
                                                                        </c:when>
                                                                        <c:when test="${material.contentType == 'QUIZ'}">
                                                                            <i class="fas fa-question-circle"></i>
                                                                        </c:when>
                                                                        <c:when test="${material.contentType == 'CODE'}">
                                                                            <i class="fas fa-code"></i>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <i class="fas fa-file-alt"></i>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                    <span>${material.title}</span>
                                                                </div>
                                                                <small class="text-muted">${material.duration > 0 ? material.duration : '10'}:00</small>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Sample Curriculum -->
                                        <div class="accordion-item">
                                            <h2 class="accordion-header">
                                                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#section1">
                                                    <span class="me-auto"><strong>Bab 1:</strong> Pengenalan</span>
                                                    <small class="text-muted me-3">4 materi • 45 menit</small>
                                                </button>
                                            </h2>
                                            <div id="section1" class="accordion-collapse collapse show" data-bs-parent="#curriculumAccordion">
                                                <div class="accordion-body">
                                                    <div class="material-item">
                                                        <div class="d-flex align-items-center gap-3">
                                                            <i class="fas fa-play-circle"></i>
                                                            <span>1.1 Pendahuluan</span>
                                                        </div>
                                                        <small class="text-muted">10:00</small>
                                                    </div>
                                                    <div class="material-item">
                                                        <div class="d-flex align-items-center gap-3">
                                                            <i class="fas fa-play-circle"></i>
                                                            <span>1.2 Instalasi & Setup</span>
                                                        </div>
                                                        <small class="text-muted">15:00</small>
                                                    </div>
                                                    <div class="material-item">
                                                        <div class="d-flex align-items-center gap-3">
                                                            <i class="fas fa-file-alt"></i>
                                                            <span>1.3 Konsep Dasar</span>
                                                        </div>
                                                        <small class="text-muted">10:00</small>
                                                    </div>
                                                    <div class="material-item">
                                                        <div class="d-flex align-items-center gap-3">
                                                            <i class="fas fa-question-circle"></i>
                                                            <span>1.4 Quiz Bab 1</span>
                                                        </div>
                                                        <small class="text-muted">10 soal</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="accordion-item">
                                            <h2 class="accordion-header">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#section2">
                                                    <span class="me-auto"><strong>Bab 2:</strong> Materi Dasar</span>
                                                    <small class="text-muted me-3">6 materi • 1.5 jam</small>
                                                </button>
                                            </h2>
                                            <div id="section2" class="accordion-collapse collapse" data-bs-parent="#curriculumAccordion">
                                                <div class="accordion-body">
                                                    <div class="material-item">
                                                        <div class="d-flex align-items-center gap-3">
                                                            <i class="fas fa-play-circle"></i>
                                                            <span>2.1 Konsep Fundamental</span>
                                                        </div>
                                                        <small class="text-muted">20:00</small>
                                                    </div>
                                                    <div class="material-item">
                                                        <div class="d-flex align-items-center gap-3">
                                                            <i class="fas fa-code"></i>
                                                            <span>2.2 Latihan Praktik</span>
                                                        </div>
                                                        <small class="text-muted">30:00</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="accordion-item">
                                            <h2 class="accordion-header">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#section3">
                                                    <span class="me-auto"><strong>Bab 3:</strong> Materi Lanjutan</span>
                                                    <small class="text-muted me-3">5 materi • 2 jam</small>
                                                </button>
                                            </h2>
                                            <div id="section3" class="accordion-collapse collapse" data-bs-parent="#curriculumAccordion">
                                                <div class="accordion-body">
                                                    <div class="material-item">
                                                        <div class="d-flex align-items-center gap-3">
                                                            <i class="fas fa-play-circle"></i>
                                                            <span>3.1 Konsep Lanjutan</span>
                                                        </div>
                                                        <small class="text-muted">25:00</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <!-- Instructor Tab -->
                        <div class="tab-pane fade" id="instructor" role="tabpanel">
                            <h4 class="content-title">
                                <i class="fas fa-chalkboard-teacher"></i> Tentang Pengajar
                            </h4>
                            
                            <div class="d-flex gap-4 align-items-start">
                                <img src="https://ui-avatars.com/api/?name=${course.lecturer.name}&background=8B1538&color=fff&size=100" 
                                     alt="${course.lecturer.name}" class="instructor-avatar">
                                <div>
                                    <h4 class="mb-1">${course.lecturer.name}</h4>
                                    <p class="text-primary fw-semibold mb-3">${course.category.name} Expert</p>
                                    
                                    <div class="d-flex flex-wrap gap-4 mb-3">
                                        <span class="text-muted"><i class="fas fa-star text-warning me-1"></i> 4.8 Rating</span>
                                        <span class="text-muted"><i class="fas fa-users me-1"></i> 1,000+ Pelajar</span>
                                        <span class="text-muted"><i class="fas fa-play-circle me-1"></i> 5 Kursus</span>
                                    </div>
                                    
                                    <p class="text-muted" style="line-height: 1.7;">
                                        Pengajar profesional dengan pengalaman lebih dari 5 tahun di industri teknologi. 
                                        Berdedikasi untuk berbagi pengetahuan dan membantu generasi muda Indonesia berkembang di bidang teknologi.
                                        Telah melatih ribuan pelajar dan profesional di berbagai perusahaan ternama.
                                    </p>
                                    
                                    <div class="d-flex gap-2 mt-3">
                                        <a href="#" class="btn btn-sm btn-outline-secondary"><i class="fab fa-linkedin"></i></a>
                                        <a href="#" class="btn btn-sm btn-outline-secondary"><i class="fab fa-twitter"></i></a>
                                        <a href="#" class="btn btn-sm btn-outline-secondary"><i class="fab fa-github"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Reviews Tab -->
                        <div class="tab-pane fade" id="reviews" role="tabpanel">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h4 class="content-title mb-0">
                                    <i class="fas fa-star"></i> Ulasan Pelajar
                                </h4>
                                <span class="text-muted">${course.totalReviews} ulasan</span>
                            </div>
                            
                            <!-- Rating Summary -->
                            <div class="rating-summary mb-4">
                                <div class="rating-big">
                                    <div class="rating-number"><fmt:formatNumber value="${course.avgRating}" maxFractionDigits="1"/></div>
                                    <div class="text-warning mb-1">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star-half-alt"></i>
                                    </div>
                                    <small class="text-muted">Rating Kursus</small>
                                </div>
                                <div class="rating-bars">
                                    <c:forEach begin="1" end="5" var="star">
                                        <c:set var="starNum" value="${6 - star}"/>
                                        <div class="rating-bar-row">
                                            <div class="progress flex-grow-1">
                                                <div class="progress-bar" style="width: ${starNum == 5 ? '70' : starNum == 4 ? '20' : starNum == 3 ? '7' : starNum == 2 ? '2' : '1'}%;"></div>
                                            </div>
                                            <small class="text-muted" style="width: 50px;">
                                                <i class="fas fa-star text-warning"></i> ${starNum}
                                            </small>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            
                            <!-- Reviews List -->
                            <c:choose>
                                <c:when test="${not empty reviews}">
                                    <c:forEach var="review" items="${reviews}">
                                        <div class="review-item">
                                            <div class="d-flex gap-3 mb-2">
                                                <img src="https://ui-avatars.com/api/?name=${review.student.name}&background=3B82F6&color=fff" 
                                                     class="review-avatar" alt="${review.student.name}">
                                                <div class="flex-grow-1">
                                                    <div class="d-flex justify-content-between">
                                                        <strong>${review.student.name}</strong>
                                                        <small class="text-muted"><fmt:formatDate value="${review.createdAt}" pattern="dd MMM yyyy"/></small>
                                                    </div>
                                                    <div class="text-warning">
                                                        <c:forEach begin="1" end="5" var="i">
                                                            <i class="fas ${i <= review.rating ? 'fa-star' : 'far fa-star'}"></i>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                            </div>
                                            <p class="text-muted mb-0">${review.comment}</p>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <!-- Sample Reviews -->
                                    <div class="review-item">
                                        <div class="d-flex gap-3 mb-2">
                                            <img src="https://ui-avatars.com/api/?name=Ahmad+Rizki&background=3B82F6&color=fff" class="review-avatar">
                                            <div class="flex-grow-1">
                                                <div class="d-flex justify-content-between">
                                                    <strong>Ahmad Rizki</strong>
                                                    <small class="text-muted">2 minggu lalu</small>
                                                </div>
                                                <div class="text-warning">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <p class="text-muted mb-0">
                                            Kursus yang sangat bagus! Materi disampaikan dengan jelas dan mudah dipahami. 
                                            Pengajar sangat responsif dalam menjawab pertanyaan di forum. Sangat recommended!
                                        </p>
                                    </div>
                                    <div class="review-item">
                                        <div class="d-flex gap-3 mb-2">
                                            <img src="https://ui-avatars.com/api/?name=Siti+Nurhaliza&background=10B981&color=fff" class="review-avatar">
                                            <div class="flex-grow-1">
                                                <div class="d-flex justify-content-between">
                                                    <strong>Siti Nurhaliza</strong>
                                                    <small class="text-muted">1 bulan lalu</small>
                                                </div>
                                                <div class="text-warning">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <p class="text-muted mb-0">
                                            Materi lengkap dan terstruktur dengan baik. Cocok untuk pemula yang ingin belajar dari nol.
                                        </p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                
                <!-- Sidebar Column -->
                <div class="col-lg-4">
                    <div class="course-sidebar d-none d-lg-block">
                        <div class="course-sidebar-card">
                            <!-- Preview Image/Video -->
                            <c:choose>
                                <c:when test="${not empty course.previewVideo}">
                                    <video class="course-preview-img" controls poster="${course.thumbnail}">
                                        <source src="${course.previewVideo}" type="video/mp4">
                                    </video>
                                </c:when>
                                <c:otherwise>
                                    <img src="${not empty course.thumbnail && !course.thumbnail.equals('default-course.png') ? course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400&h=225&fit=crop'}" 
                                         alt="${course.title}" class="course-preview-img">
                                </c:otherwise>
                            </c:choose>
                            
                            <div class="course-sidebar-body">
                                <!-- Price -->
                                <div class="price-display">
                                    <c:choose>
                                        <c:when test="${course.free}">
                                            <span class="price-free">Gratis</span>
                                        </c:when>
                                        <c:when test="${course.hasDiscount()}">
                                            <span class="price-current">Rp <fmt:formatNumber value="${course.discountPrice}" pattern="#,###"/></span>
                                            <span class="price-original">Rp <fmt:formatNumber value="${course.price}" pattern="#,###"/></span>
                                            <span class="price-discount">-${course.discountPercentage}%</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="price-current">Rp <fmt:formatNumber value="${course.price}" pattern="#,###"/></span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <!-- Action Buttons -->
                                <c:choose>
                                    <c:when test="${isEnrolled}">
                                        <a href="${pageContext.request.contextPath}/learn/${course.slug}" class="btn btn-primary btn-lg w-100 mb-3">
                                            <i class="fas fa-play me-2"></i> Lanjutkan Belajar
                                        </a>
                                        <div class="progress mb-2">
                                            <div class="progress-bar" style="width: ${enrollment.progressInt}%"></div>
                                        </div>
                                        <p class="text-center text-muted small">Progress: ${enrollment.progressInt}%</p>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${course.free}">
                                                <form action="${pageContext.request.contextPath}/student/enroll" method="POST">
                                                    <input type="hidden" name="courseId" value="${course.courseId}">
                                                    <button type="submit" class="btn btn-primary btn-lg w-100 mb-3">
                                                        <i class="fas fa-play me-2"></i> Mulai Belajar Gratis
                                                    </button>
                                                </form>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/checkout?courseId=${course.courseId}" class="btn btn-primary btn-lg w-100 mb-2">
                                                    <i class="fas fa-shopping-cart me-2"></i> Beli Sekarang
                                                </a>
                                                <form action="${pageContext.request.contextPath}/cart/add" method="POST" class="mb-3">
                                                    <input type="hidden" name="courseId" value="${course.courseId}">
                                                    <button type="submit" class="btn btn-outline-primary btn-lg w-100">
                                                        <i class="fas fa-cart-plus me-2"></i> Tambah ke Keranjang
                                                    </button>
                                                </form>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                                
                                <!-- Wishlist -->
                                <c:if test="${!isEnrolled}">
                                    <button onclick="addToWishlist(${course.courseId})" class="btn btn-link text-muted w-100">
                                        <i class="far fa-heart me-2"></i> Tambahkan ke Wishlist
                                    </button>
                                </c:if>
                                
                                <!-- Features -->
                                <div class="feature-list">
                                    <div class="feature-item">
                                        <i class="fas fa-clock"></i>
                                        <span>${course.durationHours > 0 ? course.durationHours : '10'}+ jam konten video</span>
                                    </div>
                                    <div class="feature-item">
                                        <i class="fas fa-book"></i>
                                        <span>${course.totalMaterials > 0 ? course.totalMaterials : '20'}+ materi pembelajaran</span>
                                    </div>
                                    <div class="feature-item">
                                        <i class="fas fa-layer-group"></i>
                                        <span>${course.totalSections > 0 ? course.totalSections : '5'}+ bab/section</span>
                                    </div>
                                    <div class="feature-item">
                                        <i class="fas fa-tasks"></i>
                                        <span>Quiz & latihan praktis</span>
                                    </div>
                                    <div class="feature-item">
                                        <i class="fas fa-certificate"></i>
                                        <span>Sertifikat penyelesaian</span>
                                    </div>
                                    <div class="feature-item">
                                        <i class="fas fa-infinity"></i>
                                        <span>Akses selamanya</span>
                                    </div>
                                    <div class="feature-item">
                                        <i class="fas fa-mobile-alt"></i>
                                        <span>Akses di semua perangkat</span>
                                    </div>
                                    <div class="feature-item">
                                        <i class="fas fa-comments"></i>
                                        <span>Forum diskusi</span>
                                    </div>
                                </div>
                                
                                <p class="text-center text-muted small mt-3 mb-0">
                                    <i class="fas fa-shield-alt text-success me-1"></i>
                                    Garansi uang kembali 30 hari
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Related Courses -->
    <c:if test="${not empty relatedCourses}">
        <section class="py-5 bg-white">
            <div class="container">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h3 class="fw-bold mb-1">Kursus Terkait</h3>
                        <p class="text-muted mb-0">Kursus lain yang mungkin Anda minati</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/courses?category=${course.category.slug}" class="btn btn-outline-primary">
                        Lihat Semua <i class="fas fa-arrow-right ms-2"></i>
                    </a>
                </div>
                
                <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
                    <c:forEach var="relCourse" items="${relatedCourses}" end="3">
                        <div class="col">
                            <div class="card related-course-card h-100">
                                <img src="${not empty relCourse.thumbnail && !relCourse.thumbnail.equals('default-course.png') ? relCourse.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400&h=225&fit=crop'}" 
                                     class="card-img-top related-course-img" alt="${relCourse.title}">
                                <div class="card-body">
                                    <small class="text-primary fw-semibold">${relCourse.category.name}</small>
                                    <h6 class="card-title mt-1 mb-2">
                                        <a href="${pageContext.request.contextPath}/course/${relCourse.slug}" class="text-decoration-none text-dark">
                                            ${relCourse.title}
                                        </a>
                                    </h6>
                                    <div class="d-flex align-items-center gap-2 mb-2">
                                        <small class="text-muted"><i class="fas fa-users me-1"></i> ${relCourse.totalStudents}</small>
                                        <small class="text-warning"><i class="fas fa-star me-1"></i> <fmt:formatNumber value="${relCourse.avgRating}" maxFractionDigits="1"/></small>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <c:choose>
                                            <c:when test="${relCourse.free}">
                                                <span class="fw-bold text-success">Gratis</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="fw-bold" style="color: var(--primary);">Rp <fmt:formatNumber value="${relCourse.price}" pattern="#,###"/></span>
                                            </c:otherwise>
                                        </c:choose>
                                        <a href="${pageContext.request.contextPath}/course/${relCourse.slug}" class="btn btn-sm btn-outline-primary">Detail</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
    </c:if>
    
    <!-- Mobile Buy Bar -->
    <div class="mobile-buy-bar">
        <div>
            <c:choose>
                <c:when test="${course.free}">
                    <span class="fw-bold text-success fs-5">Gratis</span>
                </c:when>
                <c:when test="${course.hasDiscount()}">
                    <span class="fw-bold fs-5" style="color: var(--primary);">Rp <fmt:formatNumber value="${course.discountPrice}" pattern="#,###"/></span>
                    <small class="text-muted text-decoration-line-through ms-1">Rp <fmt:formatNumber value="${course.price}" pattern="#,###"/></small>
                </c:when>
                <c:otherwise>
                    <span class="fw-bold fs-5" style="color: var(--primary);">Rp <fmt:formatNumber value="${course.price}" pattern="#,###"/></span>
                </c:otherwise>
            </c:choose>
        </div>
        <c:choose>
            <c:when test="${isEnrolled}">
                <a href="${pageContext.request.contextPath}/learn/${course.slug}" class="btn btn-primary">
                    <i class="fas fa-play me-1"></i> Lanjutkan
                </a>
            </c:when>
            <c:when test="${course.free}">
                <form action="${pageContext.request.contextPath}/student/enroll" method="POST" class="d-inline">
                    <input type="hidden" name="courseId" value="${course.courseId}">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-play me-1"></i> Mulai Gratis
                    </button>
                </form>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/checkout?courseId=${course.courseId}" class="btn btn-primary">
                    <i class="fas fa-shopping-cart me-1"></i> Beli Sekarang
                </a>
            </c:otherwise>
        </c:choose>
    </div>
    
    <!-- Footer -->
    <jsp:include page="/pages/common/footer.jsp"/>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function addToWishlist(courseId) {
            <c:if test="${empty sessionScope.user}">
                window.location.href = '${pageContext.request.contextPath}/login?redirect=' + encodeURIComponent(window.location.href);
                return;
            </c:if>
            
            fetch('${pageContext.request.contextPath}/wishlist/add', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'courseId=' + courseId
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Berhasil ditambahkan ke wishlist!');
                } else {
                    alert(data.message || 'Gagal menambahkan ke wishlist');
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
        }
    </script>
</body>
</html>
