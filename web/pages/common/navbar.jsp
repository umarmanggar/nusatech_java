<%-- 
    Document   : navbar
    Created on : Dec 10, 2025, 4:39:28 PM
    Author     : user
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar" id="navbar">
    <div class="navbar-container">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand">
            <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="NusaTech Logo">
            <span class="navbar-brand-text">NUSA<span>TECH</span></span>
        </a>
        <div class="navbar-menu" id="navbarMenu">
            <ul class="navbar-nav">
                <li><a href="${pageContext.request.contextPath}/" class="nav-link">Beranda</a></li>
                <li><a href="${pageContext.request.contextPath}/courses" class="nav-link">Kursus</a></li>
                <li><a href="${pageContext.request.contextPath}/categories" class="nav-link">Kategori</a></li>
                <li><a href="${pageContext.request.contextPath}/about" class="nav-link">Tentang</a></li>
            </ul>
            <div class="navbar-search">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Cari kursus..." onkeypress="if(event.key==='Enter')window.location='${pageContext.request.contextPath}/search?q='+this.value">
            </div>
        </div>
        <div class="navbar-actions">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/my-learning" class="btn btn-ghost"><i class="fas fa-book-open"></i> Belajar</a>
                    <a href="${pageContext.request.contextPath}/${sessionScope.user.role.name().toLowerCase()}/dashboard" class="btn btn-primary">Dashboard</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-ghost">Masuk</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">Daftar</a>
                </c:otherwise>
            </c:choose>
            <button class="navbar-toggle" onclick="document.getElementById('navbarMenu').classList.toggle('active')"><i class="fas fa-bars"></i></button>
        </div>
    </div>
</nav>
<script>
window.addEventListener('scroll', function() {
    document.getElementById('navbar').classList.toggle('scrolled', window.scrollY > 50);
});
</script>
