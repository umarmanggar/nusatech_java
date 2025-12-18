<%-- 
    Document   : sidebar-admin
    Created on : Dec 18, 2025
    Author     : NusaTech
    Description: Admin Sidebar Navigation Component
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .admin-sidebar {
        width: 280px;
        min-height: calc(100vh - 56px);
        background: white;
        border-right: 1px solid #e5e7eb;
        position: fixed;
        top: 56px;
        left: 0;
        z-index: 1020;
        overflow-y: auto;
    }
    
    .admin-sidebar-header {
        padding: 1.5rem;
        background: linear-gradient(135deg, #1f2937 0%, #111827 100%);
        color: white;
    }
    
    .admin-sidebar-menu { padding: 1rem; }
    
    .admin-sidebar-label {
        font-size: 0.7rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        color: #9ca3af;
        padding: 0.75rem 1rem 0.5rem;
        margin-top: 0.5rem;
    }
    
    .admin-sidebar-item {
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
        position: relative;
    }
    
    .admin-sidebar-item:hover {
        background: rgba(31, 41, 55, 0.08);
        color: #1f2937;
    }
    
    .admin-sidebar-item.active {
        background: rgba(31, 41, 55, 0.12);
        color: #1f2937;
        font-weight: 600;
    }
    
    .admin-sidebar-item.active::before {
        content: '';
        position: absolute;
        left: 0;
        top: 50%;
        transform: translateY(-50%);
        width: 4px;
        height: 24px;
        background: #1f2937;
        border-radius: 0 4px 4px 0;
    }
    
    .admin-sidebar-item i { width: 20px; text-align: center; }
    
    .admin-sidebar-badge {
        margin-left: auto;
        font-size: 0.7rem;
        padding: 0.2rem 0.5rem;
        border-radius: 1rem;
        font-weight: 600;
    }
    
    .admin-sidebar-divider {
        height: 1px;
        background: #e5e7eb;
        margin: 1rem 0;
    }
    
    @media (max-width: 991.98px) {
        .admin-sidebar {
            transform: translateX(-100%);
            transition: transform 0.3s;
        }
        .admin-sidebar.show {
            transform: translateX(0);
        }
    }
</style>

<aside class="admin-sidebar" id="adminSidebar">
    <div class="admin-sidebar-header">
        <div class="d-flex align-items-center gap-3">
            <div class="bg-white bg-opacity-25 rounded-circle p-2">
                <i class="fas fa-shield-alt text-white"></i>
            </div>
            <div>
                <div class="fw-semibold">Admin Panel</div>
                <small class="opacity-75">${sessionScope.user.name}</small>
            </div>
        </div>
    </div>
    
    <nav class="admin-sidebar-menu">
        <div class="admin-sidebar-label">Menu Utama</div>
        
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="admin-sidebar-item ${pageContext.request.servletPath.contains('/admin/dashboard') ? 'active' : ''}">
            <i class="fas fa-tachometer-alt"></i> Dashboard
        </a>
        
        <div class="admin-sidebar-label">Manajemen</div>
        
        <a href="${pageContext.request.contextPath}/admin/users" class="admin-sidebar-item ${pageContext.request.servletPath.contains('/admin/users') ? 'active' : ''}">
            <i class="fas fa-users"></i> Pengguna
            <c:if test="${pendingLecturers != null && pendingLecturers > 0}">
                <span class="admin-sidebar-badge bg-warning text-dark">${pendingLecturers}</span>
            </c:if>
        </a>
        
        <a href="${pageContext.request.contextPath}/admin/courses" class="admin-sidebar-item ${pageContext.request.servletPath.contains('/admin/courses') ? 'active' : ''}">
            <i class="fas fa-book"></i> Kursus
            <c:if test="${pendingCourses != null && pendingCourses > 0}">
                <span class="admin-sidebar-badge bg-danger text-white">${pendingCourses}</span>
            </c:if>
        </a>
        
        <a href="${pageContext.request.contextPath}/admin/categories" class="admin-sidebar-item ${pageContext.request.servletPath.contains('/admin/categories') ? 'active' : ''}">
            <i class="fas fa-folder"></i> Kategori
        </a>
        
        <a href="${pageContext.request.contextPath}/admin/transactions" class="admin-sidebar-item ${pageContext.request.servletPath.contains('/admin/transactions') ? 'active' : ''}">
            <i class="fas fa-credit-card"></i> Transaksi
            <c:if test="${pendingTransactions != null && pendingTransactions > 0}">
                <span class="admin-sidebar-badge bg-info text-white">${pendingTransactions}</span>
            </c:if>
        </a>
        
        <div class="admin-sidebar-label">Laporan</div>
        
        <a href="${pageContext.request.contextPath}/admin/reports" class="admin-sidebar-item ${pageContext.request.servletPath.contains('/admin/reports') ? 'active' : ''}">
            <i class="fas fa-chart-bar"></i> Analitik
        </a>
        
        <a href="${pageContext.request.contextPath}/admin/reviews" class="admin-sidebar-item ${pageContext.request.servletPath.contains('/admin/reviews') ? 'active' : ''}">
            <i class="fas fa-star"></i> Ulasan
        </a>
        
        <div class="admin-sidebar-divider"></div>
        
        <a href="${pageContext.request.contextPath}/admin/settings" class="admin-sidebar-item ${pageContext.request.servletPath.contains('/admin/settings') ? 'active' : ''}">
            <i class="fas fa-cog"></i> Pengaturan
        </a>
        
        <a href="${pageContext.request.contextPath}/logout" class="admin-sidebar-item text-danger">
            <i class="fas fa-sign-out-alt"></i> Keluar
        </a>
    </nav>
</aside>
