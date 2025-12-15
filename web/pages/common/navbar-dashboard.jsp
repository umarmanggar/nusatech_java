<%-- 
    Document   : navbar-dashboard
    Created on : Dec 10, 2025, 4:39:50 PM
    Author     : user
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="navbar">
    <div class="navbar-container">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand">
            <img src="${pageContext.request.contextPath}/assets/image/logo.png" alt="NusaTech">
            <span class="navbar-brand-text">NUSA<span>TECH</span></span>
        </a>
        <div class="navbar-menu">
            <ul class="navbar-nav">
                <li><a href="${pageContext.request.contextPath}/" class="nav-link">Beranda</a></li>
                <li><a href="${pageContext.request.contextPath}/courses" class="nav-link">Kursus</a></li>
                <li><a href="${pageContext.request.contextPath}/my-learning" class="nav-link">Belajar Saya</a></li>
            </ul>
            <div class="navbar-search">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Cari kursus..." id="searchInput" onkeypress="if(event.key==='Enter')window.location='${pageContext.request.contextPath}/search?q='+this.value">
            </div>
        </div>
        <div class="navbar-actions">
            <a href="${pageContext.request.contextPath}/wishlist" class="btn btn-ghost btn-icon"><i class="fas fa-heart"></i></a>
            <a href="${pageContext.request.contextPath}/cart" class="btn btn-ghost btn-icon"><i class="fas fa-shopping-cart"></i></a>
            <div style="position: relative;">
                <button class="btn btn-ghost" onclick="document.getElementById('userDropdown').style.display=document.getElementById('userDropdown').style.display==='none'?'block':'none'" style="display: flex; align-items: center; gap: 0.5rem;">
                    <img src="https://ui-avatars.com/api/?name=${sessionScope.user.name}&background=8B1538&color=fff" style="width: 32px; height: 32px; border-radius: 50%;">
                    <span>${sessionScope.user.name}</span>
                    <i class="fas fa-chevron-down"></i>
                </button>
                <div id="userDropdown" style="display: none; position: absolute; right: 0; top: 100%; background: white; border-radius: 0.75rem; box-shadow: 0 10px 40px rgba(0,0,0,0.15); padding: 0.5rem; min-width: 200px; z-index: 100;">
                    <a href="${pageContext.request.contextPath}/${sessionScope.user.role.name().toLowerCase()}/profile" style="display: flex; align-items: center; gap: 0.75rem; padding: 0.75rem; border-radius: 0.5rem; color: var(--gray-700);"><i class="fas fa-user"></i> Profil</a>
                    <a href="${pageContext.request.contextPath}/${sessionScope.user.role.name().toLowerCase()}/dashboard" style="display: flex; align-items: center; gap: 0.75rem; padding: 0.75rem; border-radius: 0.5rem; color: var(--gray-700);"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                    <hr style="margin: 0.5rem 0; border: none; border-top: 1px solid var(--gray-200);">
                    <a href="${pageContext.request.contextPath}/logout" style="display: flex; align-items: center; gap: 0.75rem; padding: 0.75rem; border-radius: 0.5rem; color: var(--error);"><i class="fas fa-sign-out-alt"></i> Keluar</a>
                </div>
            </div>
        </div>
    </div>
</nav>
