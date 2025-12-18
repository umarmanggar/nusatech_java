<%-- 
    Document   : sidebar-student
    Created on : Dec 10, 2025
    Author     : NusaTech
    Description: Student Dashboard Sidebar with Bootstrap 5
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .sidebar {
        width: 280px;
        min-height: calc(100vh - 56px);
        background: white;
        border-right: 1px solid #e5e7eb;
        position: fixed;
        top: 56px;
        left: 0;
        z-index: 1020;
        transition: transform 0.3s ease;
    }
    
    .sidebar-header {
        padding: 1.5rem;
        border-bottom: 1px solid #e5e7eb;
    }
    
    .sidebar-brand {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        text-decoration: none;
    }
    
    .sidebar-brand img {
        width: 36px;
        height: 36px;
        max-width: 36px;
        max-height: 36px;
        object-fit: contain;
    }
    
    .sidebar-brand-text {
        font-size: 1.25rem;
        font-weight: 800;
        color: #8B1538;
    }
    
    .sidebar-brand-text span {
        color: #D4A84B;
    }
    
    .sidebar-user {
        padding: 1.25rem;
        background: linear-gradient(135deg, #8B1538 0%, #6d1029 100%);
        margin: 1rem;
        border-radius: 1rem;
        color: white;
    }
    
    .sidebar-user-avatar {
        width: 48px;
        height: 48px;
        border-radius: 50%;
        border: 3px solid rgba(255,255,255,0.3);
    }
    
    .sidebar-user-name {
        font-weight: 600;
        font-size: 1rem;
        margin-bottom: 0.15rem;
    }
    
    .sidebar-user-role {
        font-size: 0.75rem;
        opacity: 0.8;
    }
    
    .sidebar-menu {
        padding: 0.5rem 1rem;
    }
    
    .sidebar-menu-label {
        font-size: 0.7rem;
        font-weight: 600;
        color: #9ca3af;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        padding: 1rem 1rem 0.5rem;
    }
    
    .sidebar-item {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        padding: 0.85rem 1rem;
        border-radius: 0.75rem;
        color: #4b5563;
        text-decoration: none;
        font-weight: 500;
        transition: all 0.2s;
        margin-bottom: 0.25rem;
    }
    
    .sidebar-item:hover {
        background: rgba(139, 21, 56, 0.08);
        color: #8B1538;
    }
    
    .sidebar-item.active {
        background: rgba(139, 21, 56, 0.12);
        color: #8B1538;
        font-weight: 600;
    }
    
    .sidebar-item i {
        width: 20px;
        text-align: center;
        font-size: 1rem;
    }
    
    .sidebar-item .badge {
        margin-left: auto;
        font-size: 0.7rem;
        padding: 0.25rem 0.5rem;
    }
    
    .sidebar-item-danger {
        color: #dc2626 !important;
    }
    .sidebar-item-danger:hover {
        background: rgba(220, 38, 38, 0.08) !important;
        color: #dc2626 !important;
    }
    
    .sidebar-divider {
        height: 1px;
        background: #e5e7eb;
        margin: 0.75rem 1rem;
    }
    
    .sidebar-footer {
        padding: 1rem;
        border-top: 1px solid #e5e7eb;
        margin-top: auto;
    }
    
    /* Mobile Sidebar Toggle */
    @media (max-width: 991.98px) {
        .sidebar {
            transform: translateX(-100%);
        }
        .sidebar.show {
            transform: translateX(0);
        }
        .sidebar-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.5);
            z-index: 1019;
        }
        .sidebar-overlay.show {
            display: block;
        }
    }
</style>

<!-- Mobile Sidebar Overlay -->
<div class="sidebar-overlay" id="sidebarOverlay" onclick="toggleSidebar()"></div>

<!-- Sidebar -->
<aside class="sidebar" id="sidebar">
    <!-- User Card -->
    <div class="sidebar-user">
        <div class="d-flex align-items-center gap-3">
            <img src="https://ui-avatars.com/api/?name=${sessionScope.user.name}&background=ffffff&color=8B1538" 
                 alt="${sessionScope.user.name}" class="sidebar-user-avatar">
            <div>
                <div class="sidebar-user-name">${sessionScope.user.name}</div>
                <div class="sidebar-user-role">
                    <i class="fas fa-graduation-cap me-1"></i> Pelajar
                </div>
            </div>
        </div>
    </div>
    
    <!-- Menu -->
    <nav class="sidebar-menu">
        <div class="sidebar-menu-label">Menu Utama</div>
        
        <a href="${pageContext.request.contextPath}/student/dashboard" 
           class="sidebar-item ${pageContext.request.servletPath.contains('dashboard') ? 'active' : ''}">
            <i class="fas fa-home"></i>
            <span>Dashboard</span>
        </a>
        
        <a href="${pageContext.request.contextPath}/student/my-learning" 
           class="sidebar-item ${pageContext.request.servletPath.contains('learning') ? 'active' : ''}">
            <i class="fas fa-book-open"></i>
            <span>Kursus Saya</span>
            <c:if test="${activeCoursesCount > 0}">
                <span class="badge bg-primary">${activeCoursesCount}</span>
            </c:if>
        </a>
        
        <a href="${pageContext.request.contextPath}/student/wishlist" 
           class="sidebar-item ${pageContext.request.servletPath.contains('wishlist') ? 'active' : ''}">
            <i class="fas fa-heart"></i>
            <span>Wishlist</span>
            <c:if test="${wishlistCount > 0}">
                <span class="badge bg-danger">${wishlistCount}</span>
            </c:if>
        </a>
        
        <a href="${pageContext.request.contextPath}/student/certificates" 
           class="sidebar-item ${pageContext.request.servletPath.contains('certificate') ? 'active' : ''}">
            <i class="fas fa-certificate"></i>
            <span>Sertifikat</span>
            <c:if test="${certificatesCount > 0}">
                <span class="badge bg-warning text-dark">${certificatesCount}</span>
            </c:if>
        </a>
        
        <div class="sidebar-divider"></div>
        <div class="sidebar-menu-label">Transaksi</div>
        
        <a href="${pageContext.request.contextPath}/cart" 
           class="sidebar-item ${pageContext.request.servletPath.contains('cart') ? 'active' : ''}">
            <i class="fas fa-shopping-cart"></i>
            <span>Keranjang</span>
            <c:if test="${cartCount > 0}">
                <span class="badge bg-primary">${cartCount}</span>
            </c:if>
        </a>
        
        <a href="${pageContext.request.contextPath}/student/transactions" 
           class="sidebar-item ${pageContext.request.servletPath.contains('transaction') ? 'active' : ''}">
            <i class="fas fa-receipt"></i>
            <span>Riwayat Transaksi</span>
        </a>
        
        <div class="sidebar-divider"></div>
        <div class="sidebar-menu-label">Akun</div>
        
        <a href="${pageContext.request.contextPath}/student/profile" 
           class="sidebar-item ${pageContext.request.servletPath.contains('profile') ? 'active' : ''}">
            <i class="fas fa-user-circle"></i>
            <span>Profil Saya</span>
        </a>
        
        <a href="${pageContext.request.contextPath}/student/settings" 
           class="sidebar-item ${pageContext.request.servletPath.contains('settings') ? 'active' : ''}">
            <i class="fas fa-cog"></i>
            <span>Pengaturan</span>
        </a>
        
        <div class="sidebar-divider"></div>
        
        <a href="${pageContext.request.contextPath}/logout" class="sidebar-item sidebar-item-danger">
            <i class="fas fa-sign-out-alt"></i>
            <span>Keluar</span>
        </a>
    </nav>
    
    <!-- Footer -->
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/courses" class="btn btn-primary w-100">
            <i class="fas fa-plus me-2"></i> Jelajahi Kursus
        </a>
    </div>
</aside>

<script>
    function toggleSidebar() {
        document.getElementById('sidebar').classList.toggle('show');
        document.getElementById('sidebarOverlay').classList.toggle('show');
        document.body.classList.toggle('overflow-hidden');
    }
</script>
