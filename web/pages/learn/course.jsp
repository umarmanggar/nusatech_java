<%-- 
    Document   : course
    Created on : Dec 18, 2025
    Author     : NusaTech
    Description: Main Learning Interface with Sidebar Navigation
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${course.title} - Belajar di NusaTech</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #8B1538;
            --primary-dark: #6d1029;
            --secondary: #D4A84B;
            --sidebar-width: 360px;
        }
        
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8f9fa;
            overflow-x: hidden;
        }
        
        /* Learning Header */
        .learn-header {
            background: white;
            border-bottom: 1px solid #e5e7eb;
            padding: 0.75rem 1rem;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1030;
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .learn-header-logo {
            font-weight: 800;
            color: var(--primary);
            text-decoration: none;
            font-size: 1.25rem;
        }
        
        .learn-header-title {
            flex: 1;
            font-weight: 600;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        .progress-circle {
            width: 40px;
            height: 40px;
            position: relative;
        }
        
        .progress-circle svg {
            transform: rotate(-90deg);
        }
        
        .progress-circle-text {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 0.7rem;
            font-weight: 700;
        }
        
        /* Main Layout */
        .learn-wrapper {
            display: flex;
            min-height: 100vh;
            padding-top: 60px;
        }
        
        /* Sidebar */
        .learn-sidebar {
            width: var(--sidebar-width);
            background: white;
            border-right: 1px solid #e5e7eb;
            position: fixed;
            top: 60px;
            left: 0;
            bottom: 0;
            overflow-y: auto;
            z-index: 1020;
            transition: transform 0.3s ease;
        }
        
        .learn-sidebar.collapsed {
            transform: translateX(-100%);
        }
        
        .sidebar-header {
            padding: 1.25rem;
            border-bottom: 1px solid #e5e7eb;
            background: #f8f9fa;
        }
        
        .sidebar-progress {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }
        
        .sidebar-progress-bar {
            flex: 1;
            height: 8px;
            background: #e5e7eb;
            border-radius: 4px;
            overflow: hidden;
        }
        
        .sidebar-progress-fill {
            height: 100%;
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            border-radius: 4px;
            transition: width 0.3s ease;
        }
        
        .sidebar-stats {
            display: flex;
            gap: 1.5rem;
            font-size: 0.8rem;
            color: #6b7280;
        }
        
        /* Section Accordion */
        .section-accordion {
            border: none;
        }
        
        .section-item {
            border: none;
            border-bottom: 1px solid #e5e7eb;
        }
        
        .section-header {
            padding: 0;
            background: none;
            border: none;
        }
        
        .section-header-btn {
            width: 100%;
            padding: 1rem 1.25rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            background: none;
            border: none;
            text-align: left;
            font-weight: 600;
            color: #1f2937;
            cursor: pointer;
            transition: background 0.2s;
        }
        
        .section-header-btn:hover {
            background: #f3f4f6;
        }
        
        .section-header-btn .section-icon {
            width: 24px;
            height: 24px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.7rem;
            flex-shrink: 0;
        }
        
        .section-header-btn .section-icon.completed {
            background: #10b981;
            color: white;
        }
        
        .section-header-btn .section-icon.in-progress {
            background: var(--primary);
            color: white;
        }
        
        .section-header-btn .section-icon.not-started {
            background: #e5e7eb;
            color: #6b7280;
        }
        
        .section-header-btn .section-title {
            flex: 1;
            font-size: 0.9rem;
        }
        
        .section-header-btn .section-meta {
            font-size: 0.75rem;
            color: #9ca3af;
            font-weight: 400;
        }
        
        .section-header-btn .chevron {
            transition: transform 0.2s;
        }
        
        .section-header-btn:not(.collapsed) .chevron {
            transform: rotate(180deg);
        }
        
        /* Material Items */
        .material-list {
            padding: 0.5rem 0;
            background: #fafafa;
        }
        
        .material-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem 1.25rem 0.75rem 3rem;
            text-decoration: none;
            color: #4b5563;
            transition: all 0.2s;
            position: relative;
        }
        
        .material-item:hover {
            background: #f3f4f6;
            color: #1f2937;
        }
        
        .material-item.active {
            background: rgba(139, 21, 56, 0.08);
            color: var(--primary);
            font-weight: 600;
        }
        
        .material-item.active::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 3px;
            background: var(--primary);
        }
        
        .material-item .material-icon {
            width: 28px;
            height: 28px;
            border-radius: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.75rem;
            flex-shrink: 0;
        }
        
        .material-icon.video { background: rgba(239, 68, 68, 0.1); color: #ef4444; }
        .material-icon.text { background: rgba(59, 130, 246, 0.1); color: #3b82f6; }
        .material-icon.pdf { background: rgba(245, 158, 11, 0.1); color: #f59e0b; }
        .material-icon.quiz { background: rgba(139, 21, 56, 0.1); color: var(--primary); }
        
        .material-item .material-info {
            flex: 1;
            min-width: 0;
        }
        
        .material-item .material-title {
            font-size: 0.85rem;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        .material-item .material-meta {
            font-size: 0.7rem;
            color: #9ca3af;
        }
        
        .material-item .material-status {
            width: 18px;
            height: 18px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.6rem;
            flex-shrink: 0;
        }
        
        .material-status.completed { background: #10b981; color: white; }
        .material-status.not-completed { border: 2px solid #d1d5db; }
        
        /* Main Content */
        .learn-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            transition: margin-left 0.3s ease;
            display: flex;
            flex-direction: column;
            min-height: calc(100vh - 60px);
        }
        
        .learn-content.expanded {
            margin-left: 0;
        }
        
        .content-wrapper {
            flex: 1;
            padding: 2rem;
            max-width: 1000px;
            margin: 0 auto;
            width: 100%;
        }
        
        /* Bottom Navigation */
        .learn-nav {
            background: white;
            border-top: 1px solid #e5e7eb;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1rem;
        }
        
        .btn-primary { background-color: var(--primary); border-color: var(--primary); }
        .btn-primary:hover { background-color: var(--primary-dark); border-color: var(--primary-dark); }
        .btn-outline-primary { color: var(--primary); border-color: var(--primary); }
        .btn-outline-primary:hover { background-color: var(--primary); border-color: var(--primary); }
        
        /* Sidebar Toggle */
        .sidebar-toggle {
            position: fixed;
            left: var(--sidebar-width);
            top: 50%;
            transform: translateY(-50%);
            z-index: 1025;
            width: 24px;
            height: 48px;
            background: white;
            border: 1px solid #e5e7eb;
            border-left: none;
            border-radius: 0 8px 8px 0;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: left 0.3s ease;
            box-shadow: 2px 0 8px rgba(0,0,0,0.05);
        }
        
        .sidebar-toggle.collapsed {
            left: 0;
        }
        
        .sidebar-toggle i {
            transition: transform 0.3s;
        }
        
        .sidebar-toggle.collapsed i {
            transform: rotate(180deg);
        }
        
        /* Mobile Overlay */
        .sidebar-overlay {
            position: fixed;
            top: 60px;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.5);
            z-index: 1015;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s;
        }
        
        .sidebar-overlay.show {
            opacity: 1;
            visibility: visible;
        }
        
        /* Responsive */
        @media (max-width: 991.98px) {
            .learn-sidebar {
                transform: translateX(-100%);
            }
            
            .learn-sidebar.show {
                transform: translateX(0);
            }
            
            .learn-content {
                margin-left: 0;
            }
            
            .sidebar-toggle {
                display: none;
            }
            
            .mobile-menu-btn {
                display: flex !important;
            }
        }
        
        @media (min-width: 992px) {
            .mobile-menu-btn {
                display: none !important;
            }
        }
    </style>
</head>
<body>
    <!-- Learning Header -->
    <header class="learn-header">
        <button class="btn btn-sm btn-outline-secondary mobile-menu-btn d-flex align-items-center justify-content-center" style="width: 36px; height: 36px;" onclick="toggleSidebar()">
            <i class="fas fa-bars"></i>
        </button>
        
        <a href="${pageContext.request.contextPath}/" class="learn-header-logo">
            <i class="fas fa-graduation-cap me-1"></i> NusaTech
        </a>
        
        <span class="learn-header-title d-none d-md-block">${course.title}</span>
        
        <div class="d-flex align-items-center gap-3">
            <!-- Progress Circle -->
            <div class="progress-circle d-none d-sm-block">
                <svg width="40" height="40">
                    <circle cx="20" cy="20" r="17" fill="none" stroke="#e5e7eb" stroke-width="3"/>
                    <circle cx="20" cy="20" r="17" fill="none" stroke="#10b981" stroke-width="3" 
                            stroke-dasharray="${enrollment.progressPercentage * 1.07} 107" stroke-linecap="round"/>
                </svg>
                <span class="progress-circle-text">${enrollment.progressPercentage}%</span>
            </div>
            
            <a href="${pageContext.request.contextPath}/course/${course.slug}" class="btn btn-sm btn-outline-secondary">
                <i class="fas fa-times"></i>
            </a>
        </div>
    </header>
    
    <!-- Main Layout -->
    <div class="learn-wrapper">
        <!-- Sidebar Overlay (Mobile) -->
        <div class="sidebar-overlay" id="sidebarOverlay" onclick="toggleSidebar()"></div>
        
        <!-- Learning Sidebar -->
        <aside class="learn-sidebar" id="learnSidebar">
            <div class="sidebar-header">
                <div class="sidebar-progress">
                    <div class="sidebar-progress-bar">
                        <div class="sidebar-progress-fill" style="width: ${enrollment.progressPercentage}%"></div>
                    </div>
                    <span class="fw-bold">${enrollment.progressPercentage}%</span>
                </div>
                <div class="sidebar-stats">
                    <span><i class="fas fa-check-circle text-success me-1"></i> ${completedMaterials}/${totalMaterials} materi</span>
                    <span><i class="fas fa-clock text-muted me-1"></i> ${course.durationHours} jam</span>
                </div>
            </div>
            
            <!-- Sections Accordion -->
            <div class="accordion section-accordion" id="sectionsAccordion">
                <c:forEach var="section" items="${sections}" varStatus="sectionStatus">
                    <div class="accordion-item section-item">
                        <h2 class="accordion-header section-header">
                            <button class="section-header-btn ${sectionStatus.index == 0 ? '' : 'collapsed'}" 
                                    type="button" data-bs-toggle="collapse" 
                                    data-bs-target="#section${section.sectionId}">
                                <span class="section-icon ${section.completedCount == section.materialCount ? 'completed' : section.completedCount > 0 ? 'in-progress' : 'not-started'}">
                                    <c:choose>
                                        <c:when test="${section.completedCount == section.materialCount}">
                                            <i class="fas fa-check"></i>
                                        </c:when>
                                        <c:otherwise>
                                            ${sectionStatus.index + 1}
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                                <span class="section-title">${section.title}</span>
                                <span class="section-meta">${section.completedCount}/${section.materialCount}</span>
                                <i class="fas fa-chevron-down chevron"></i>
                            </button>
                        </h2>
                        <div id="section${section.sectionId}" class="accordion-collapse collapse ${sectionStatus.index == 0 ? 'show' : ''}" data-bs-parent="#sectionsAccordion">
                            <div class="material-list">
                                <c:forEach var="material" items="${section.materials}">
                                    <a href="${pageContext.request.contextPath}/learn/${course.slug}/material/${material.materialId}" 
                                       class="material-item ${currentMaterial.materialId == material.materialId ? 'active' : ''}">
                                        <span class="material-icon ${material.contentType.toString().toLowerCase()}">
                                            <c:choose>
                                                <c:when test="${material.contentType == 'VIDEO'}"><i class="fas fa-play"></i></c:when>
                                                <c:when test="${material.contentType == 'TEXT'}"><i class="fas fa-file-alt"></i></c:when>
                                                <c:when test="${material.contentType == 'PDF'}"><i class="fas fa-file-pdf"></i></c:when>
                                                <c:when test="${material.contentType == 'QUIZ'}"><i class="fas fa-question"></i></c:when>
                                                <c:otherwise><i class="fas fa-file"></i></c:otherwise>
                                            </c:choose>
                                        </span>
                                        <span class="material-info">
                                            <span class="material-title">${material.title}</span>
                                            <span class="material-meta">
                                                <c:if test="${material.duration > 0}">${material.duration} menit</c:if>
                                                <c:if test="${material.contentType == 'QUIZ'}">Quiz</c:if>
                                            </span>
                                        </span>
                                        <span class="material-status ${material.isCompleted ? 'completed' : 'not-completed'}">
                                            <c:if test="${material.isCompleted}"><i class="fas fa-check"></i></c:if>
                                        </span>
                                    </a>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </aside>
        
        <!-- Sidebar Toggle Button (Desktop) -->
        <button class="sidebar-toggle" id="sidebarToggle" onclick="toggleSidebarDesktop()">
            <i class="fas fa-chevron-left"></i>
        </button>
        
        <!-- Main Content -->
        <main class="learn-content" id="learnContent">
            <div class="content-wrapper">
                <!-- Content loaded from material.jsp or displayed here -->
                <c:choose>
                    <c:when test="${not empty currentMaterial}">
                        <jsp:include page="material.jsp"/>
                    </c:when>
                    <c:otherwise>
                        <!-- Welcome/Overview -->
                        <div class="text-center py-5">
                            <div class="mb-4">
                                <img src="${not empty course.thumbnail ? course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400&h=225&fit=crop'}" 
                                     alt="${course.title}" class="rounded-3 shadow" style="max-width: 400px; width: 100%;">
                            </div>
                            <h2 class="fw-bold mb-3">Selamat Datang di Kursus!</h2>
                            <p class="text-muted mb-4">Pilih materi dari sidebar untuk mulai belajar</p>
                            <c:if test="${not empty firstMaterial}">
                                <a href="${pageContext.request.contextPath}/learn/${course.slug}/material/${firstMaterial.materialId}" class="btn btn-primary btn-lg">
                                    <i class="fas fa-play me-2"></i> Mulai Belajar
                                </a>
                            </c:if>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <!-- Bottom Navigation -->
            <nav class="learn-nav">
                <c:choose>
                    <c:when test="${not empty previousMaterial}">
                        <a href="${pageContext.request.contextPath}/learn/${course.slug}/material/${previousMaterial.materialId}" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left me-2"></i>
                            <span class="d-none d-sm-inline">Sebelumnya</span>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <span></span>
                    </c:otherwise>
                </c:choose>
                
                <c:if test="${not empty currentMaterial && !currentMaterial.isCompleted}">
                    <form action="${pageContext.request.contextPath}/learn/${course.slug}/material/${currentMaterial.materialId}/complete" method="POST" class="d-inline">
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-check me-2"></i>
                            <span class="d-none d-sm-inline">Tandai Selesai</span>
                        </button>
                    </form>
                </c:if>
                
                <c:choose>
                    <c:when test="${not empty nextMaterial}">
                        <a href="${pageContext.request.contextPath}/learn/${course.slug}/material/${nextMaterial.materialId}" class="btn btn-primary">
                            <span class="d-none d-sm-inline">Selanjutnya</span>
                            <i class="fas fa-arrow-right ms-2"></i>
                        </a>
                    </c:when>
                    <c:when test="${enrollment.progressPercentage == 100}">
                        <a href="${pageContext.request.contextPath}/student/certificates" class="btn btn-success">
                            <i class="fas fa-certificate me-2"></i>
                            <span class="d-none d-sm-inline">Lihat Sertifikat</span>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <span></span>
                    </c:otherwise>
                </c:choose>
            </nav>
        </main>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Mobile sidebar toggle
        function toggleSidebar() {
            const sidebar = document.getElementById('learnSidebar');
            const overlay = document.getElementById('sidebarOverlay');
            sidebar.classList.toggle('show');
            overlay.classList.toggle('show');
        }
        
        // Desktop sidebar toggle
        function toggleSidebarDesktop() {
            const sidebar = document.getElementById('learnSidebar');
            const content = document.getElementById('learnContent');
            const toggle = document.getElementById('sidebarToggle');
            
            sidebar.classList.toggle('collapsed');
            content.classList.toggle('expanded');
            toggle.classList.toggle('collapsed');
        }
        
        // Save progress on video time update (if video player exists)
        document.addEventListener('DOMContentLoaded', function() {
            const video = document.querySelector('video');
            if (video) {
                let lastSavedTime = 0;
                video.addEventListener('timeupdate', function() {
                    // Save every 10 seconds
                    if (Math.floor(video.currentTime) - lastSavedTime >= 10) {
                        lastSavedTime = Math.floor(video.currentTime);
                        saveProgress(lastSavedTime);
                    }
                });
            }
        });
        
        function saveProgress(position) {
            fetch('${pageContext.request.contextPath}/learn/${course.slug}/material/${currentMaterial.materialId}/progress', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ position: position })
            });
        }
    </script>
</body>
</html>
