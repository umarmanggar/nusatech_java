<%-- 
    Document   : navbar
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Public Navbar Component
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar" id="navbar">
    <div class="navbar-container">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand">
            <img src="${pageContext.request.contextPath}/assets/image/logo.png" alt="NusaTech Logo" onerror="this.style.display='none'">
            <span class="navbar-brand-text">NUSA<span>TECH</span></span>
        </a>
        
        <div class="navbar-menu" id="navbarMenu">
            <ul class="navbar-nav">
                <li><a href="${pageContext.request.contextPath}/" class="nav-link ${pageContext.request.servletPath == '/' || pageContext.request.servletPath == '/index.jsp' ? 'active' : ''}">Beranda</a></li>
                <li><a href="${pageContext.request.contextPath}/courses" class="nav-link ${pageContext.request.servletPath.contains('course') ? 'active' : ''}">Kursus</a></li>
                <li><a href="${pageContext.request.contextPath}/categories" class="nav-link ${pageContext.request.servletPath.contains('categor') ? 'active' : ''}">Kategori</a></li>
                <li><a href="${pageContext.request.contextPath}/about" class="nav-link ${pageContext.request.servletPath.contains('about') ? 'active' : ''}">Tentang</a></li>
            </ul>
            
            <div class="navbar-search">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Cari kursus..." id="searchInput" 
                       onkeypress="if(event.key==='Enter')window.location='${pageContext.request.contextPath}/search?q='+this.value">
            </div>
        </div>
        
        <div class="navbar-actions">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <!-- Logged in user -->
                    <a href="${pageContext.request.contextPath}/wishlist" class="btn btn-ghost btn-icon" title="Wishlist">
                        <i class="fas fa-heart"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/cart" class="btn btn-ghost btn-icon" title="Keranjang">
                        <i class="fas fa-shopping-cart"></i>
                    </a>
                    
                    <!-- User Dropdown -->
                    <div class="user-dropdown" id="userDropdownContainer">
                        <div class="user-dropdown-toggle" onclick="toggleUserDropdown(event)">
                            <img src="https://ui-avatars.com/api/?name=${sessionScope.user.name}&background=8B1538&color=fff" 
                                 alt="${sessionScope.user.name}">
                            <span style="font-weight: 500; color: var(--gray-700);">${sessionScope.user.name}</span>
                            <i class="fas fa-chevron-down" style="font-size: 0.75rem; color: var(--gray-500);"></i>
                        </div>
                        <div class="user-dropdown-menu" id="userDropdownMenu">
                            <c:if test="${sessionScope.user.role == 'STUDENT'}">
                                <a href="${pageContext.request.contextPath}/student/my-learning" class="user-dropdown-item">
                                    <i class="fas fa-book-open"></i> Belajar Saya
                                </a>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/${sessionScope.user.role.name().toLowerCase()}/dashboard" class="user-dropdown-item">
                                <i class="fas fa-tachometer-alt"></i> Dashboard
                            </a>
                            <a href="${pageContext.request.contextPath}/${sessionScope.user.role.name().toLowerCase()}/profile" class="user-dropdown-item">
                                <i class="fas fa-user"></i> Profil
                            </a>
                            <c:if test="${sessionScope.user.role == 'STUDENT'}">
                                <a href="${pageContext.request.contextPath}/student/certificates" class="user-dropdown-item">
                                    <i class="fas fa-certificate"></i> Sertifikat
                                </a>
                            </c:if>
                            <c:if test="${sessionScope.user.role == 'LECTURER'}">
                                <a href="${pageContext.request.contextPath}/lecturer/earnings" class="user-dropdown-item">
                                    <i class="fas fa-wallet"></i> Pendapatan
                                </a>
                            </c:if>
                            <div class="user-dropdown-divider"></div>
                            <a href="${pageContext.request.contextPath}/logout" class="user-dropdown-item danger">
                                <i class="fas fa-sign-out-alt"></i> Keluar
                            </a>
                        </div>
                    </div>
                    
                    <script>
                    function toggleUserDropdown(event) {
                        event.stopPropagation();
                        var menu = document.getElementById('userDropdownMenu');
                        menu.classList.toggle('show');
                    }
                    
                    // Close dropdown when clicking outside
                    document.addEventListener('click', function(event) {
                        var dropdown = document.getElementById('userDropdownContainer');
                        var menu = document.getElementById('userDropdownMenu');
                        if (dropdown && menu && !dropdown.contains(event.target)) {
                            menu.classList.remove('show');
                        }
                    });
                    </script>
                </c:when>
                <c:otherwise>
                    <!-- Guest user -->
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-ghost">Masuk</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">Daftar</a>
                </c:otherwise>
            </c:choose>
            
            <button class="navbar-toggle" id="navbarToggle" onclick="document.getElementById('navbarMenu').classList.toggle('active')">
                <i class="fas fa-bars"></i>
            </button>
        </div>
    </div>
</nav>
