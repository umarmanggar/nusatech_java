<%-- 
    Document   : login
    Created on : Dec 10, 2025, 4:38:54 PM
    Author     : user
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Masuk - NusaTech</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <div class="auth-page">
        <!-- Visual Side -->
        <div class="auth-visual">
            <div class="hero-shapes">
                <div class="hero-shape hero-shape-1"></div>
                <div class="hero-shape hero-shape-2"></div>
            </div>
            <div class="auth-visual-content">
                <img src="${pageContext.request.contextPath}/assets/image/logo.png" alt="NusaTech" class="auth-visual-logo">
                <h2 class="auth-visual-title">Selamat Datang Kembali!</h2>
                <p class="auth-visual-description">
                    Lanjutkan perjalanan belajar coding Anda dan raih impian karir di bidang teknologi.
                </p>
            </div>
        </div>
        
        <!-- Form Side -->
        <div class="auth-content">
            <div class="auth-form">
                <a href="${pageContext.request.contextPath}/" style="display: inline-flex; align-items: center; gap: 0.5rem; color: var(--gray-500); margin-bottom: 2rem;">
                    <i class="fas fa-arrow-left"></i> Kembali ke Beranda
                </a>
                
                <h1 class="auth-title">Masuk ke Akun</h1>
                <p class="auth-subtitle">Masukkan email dan password Anda</p>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-error">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>${error}</span>
                    </div>
                </c:if>
                
                <c:if test="${param.logout == 'success'}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i>
                        <span>Anda telah berhasil keluar.</span>
                    </div>
                </c:if>
                
                <c:if test="${param.registered == 'success'}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i>
                        <span>Registrasi berhasil! Silakan masuk.</span>
                    </div>
                </c:if>
                
                <form action="${pageContext.request.contextPath}/login" method="POST">
                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-input" 
                               placeholder="nama@email.com" value="${email}" required>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" class="form-input" 
                               placeholder="Masukkan password" required>
                    </div>
                    
                    <div class="form-group" style="display: flex; justify-content: space-between; align-items: center;">
                        <label class="form-check">
                            <input type="checkbox" name="remember">
                            <span>Ingat saya</span>
                        </label>
                        <a href="${pageContext.request.contextPath}/forgot-password" style="color: var(--primary); font-weight: 500;">
                            Lupa password?
                        </a>
                    </div>
                    
                    <button type="submit" class="btn btn-primary btn-lg w-100">
                        <i class="fas fa-sign-in-alt"></i> Masuk
                    </button>
                </form>
                
                <p class="auth-footer">
                    Belum punya akun? <a href="${pageContext.request.contextPath}/register">Daftar sekarang</a>
                </p>
            </div>
        </div>
    </div>
</body>
</html>
