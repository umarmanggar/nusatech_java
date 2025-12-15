<%-- 
    Document   : sidebar-student
    Created on : Dec 10, 2025, 4:40:09 PM
    Author     : user
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<aside class="sidebar">
    <div class="sidebar-menu">
        <a href="${pageContext.request.contextPath}/student/dashboard" class="sidebar-item ${pageContext.request.servletPath.contains('dashboard') ? 'active' : ''}"><i class="fas fa-home"></i> Dashboard</a>
        <a href="${pageContext.request.contextPath}/my-learning" class="sidebar-item ${pageContext.request.servletPath.contains('learning') ? 'active' : ''}"><i class="fas fa-book-open"></i> Belajar Saya</a>
        <a href="${pageContext.request.contextPath}/wishlist" class="sidebar-item ${pageContext.request.servletPath.contains('wishlist') ? 'active' : ''}"><i class="fas fa-heart"></i> Wishlist</a>
        <a href="${pageContext.request.contextPath}/cart" class="sidebar-item ${pageContext.request.servletPath.contains('cart') ? 'active' : ''}"><i class="fas fa-shopping-cart"></i> Keranjang</a>
        <a href="${pageContext.request.contextPath}/student/certificates" class="sidebar-item ${pageContext.request.servletPath.contains('certificates') ? 'active' : ''}"><i class="fas fa-certificate"></i> Sertifikat</a>
        <hr style="margin: 1rem 0; border: none; border-top: 1px solid var(--gray-200);">
        <a href="${pageContext.request.contextPath}/student/profile" class="sidebar-item ${pageContext.request.servletPath.contains('profile') ? 'active' : ''}"><i class="fas fa-user"></i> Profil</a>
        <a href="${pageContext.request.contextPath}/student/settings" class="sidebar-item"><i class="fas fa-cog"></i> Pengaturan</a>
        <a href="${pageContext.request.contextPath}/logout" class="sidebar-item" style="color: var(--error);"><i class="fas fa-sign-out-alt"></i> Keluar</a>
    </div>
</aside>
