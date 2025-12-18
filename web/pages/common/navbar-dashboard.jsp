<%-- 
    Document   : navbar-dashboard
    Created on : Dec 10, 2025, 4:39:50 PM
    Author     : user
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    .navbar-dashboard-logo {
        height: 36px;
        width: 36px;
        max-width: 36px;
        max-height: 36px;
        object-fit: contain;
    }
    .user-dropdown-dashboard {
        position: relative;
    }
    .user-dropdown-menu-dashboard {
        display: none;
        position: absolute;
        right: 0;
        top: calc(100% + 8px);
        background: white;
        border-radius: 0.75rem;
        box-shadow: 0 10px 40px rgba(0,0,0,0.15);
        padding: 0.5rem;
        min-width: 220px;
        z-index: 9999;
    }
    .user-dropdown-menu-dashboard.show {
        display: block;
    }
    .user-dropdown-menu-dashboard a {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        padding: 0.75rem 1rem;
        border-radius: 0.5rem;
        color: #374151;
        text-decoration: none;
        transition: background 0.2s;
    }
    .user-dropdown-menu-dashboard a:hover {
        background: #f3f4f6;
    }
    .user-dropdown-menu-dashboard a.danger {
        color: #ef4444;
    }
    .user-dropdown-menu-dashboard a.danger:hover {
        background: #fef2f2;
    }
    .user-dropdown-menu-dashboard hr {
        margin: 0.5rem 0;
        border: none;
        border-top: 1px solid #e5e7eb;
    }
</style>
<nav class="navbar">
    <div class="navbar-container">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand">
            <img src="${pageContext.request.contextPath}/assets/image/logo.png" alt="NusaTech" class="navbar-dashboard-logo">
            <span class="navbar-brand-text">NUSA<span>TECH</span></span>
        </a>
        <div class="navbar-menu">
            <ul class="navbar-nav">
                <li><a href="${pageContext.request.contextPath}/" class="nav-link">Beranda</a></li>
                <li><a href="${pageContext.request.contextPath}/courses" class="nav-link">Kursus</a></li>
                <li><a href="${pageContext.request.contextPath}/student/my-learning" class="nav-link">Belajar Saya</a></li>
            </ul>
            <div class="navbar-search">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Cari kursus..." id="searchInput" onkeypress="if(event.key==='Enter')window.location='${pageContext.request.contextPath}/search?q='+this.value">
            </div>
        </div>
        <div class="navbar-actions">
            <a href="${pageContext.request.contextPath}/cart" class="btn btn-ghost btn-icon"><i class="fas fa-heart"></i></a>
            <a href="${pageContext.request.contextPath}/cart" class="btn btn-ghost btn-icon"><i class="fas fa-shopping-cart"></i></a>
            <div class="user-dropdown-dashboard" id="userDropdownContainer">
                <button class="btn btn-ghost" id="userDropdownToggle" onclick="toggleDashboardDropdown(event)" style="display: flex; align-items: center; gap: 0.5rem;">
                    <img src="https://ui-avatars.com/api/?name=${sessionScope.user.name}&background=8B1538&color=fff" style="width: 32px; height: 32px; border-radius: 50%;">
                    <span>${sessionScope.user.name}</span>
                    <i class="fas fa-chevron-down" style="font-size: 0.75rem;"></i>
                </button>
                <div class="user-dropdown-menu-dashboard" id="userDropdownMenu">
                    <a href="${pageContext.request.contextPath}/${sessionScope.user.role.name().toLowerCase()}/profile">
                        <i class="fas fa-user"></i> Profil
                    </a>
                    <a href="${pageContext.request.contextPath}/${sessionScope.user.role.name().toLowerCase()}/dashboard">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </a>
                    <hr>
                    <a href="${pageContext.request.contextPath}/logout" class="danger">
                        <i class="fas fa-sign-out-alt"></i> Keluar
                    </a>
                </div>
            </div>
        </div>
    </div>
</nav>
<script>
function toggleDashboardDropdown(event) {
    event.stopPropagation();
    var menu = document.getElementById('userDropdownMenu');
    menu.classList.toggle('show');
}

// Close dropdown when clicking outside
document.addEventListener('click', function(event) {
    var container = document.getElementById('userDropdownContainer');
    var menu = document.getElementById('userDropdownMenu');
    if (container && menu && !container.contains(event.target)) {
        menu.classList.remove('show');
    }
});
</script>
