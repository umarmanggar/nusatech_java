<%-- 
    Document   : register
    Created on : Dec 10, 2025, 4:39:05 PM
    Author     : user
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daftar - NusaTech</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        .role-selector { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-bottom: 1.5rem; }
        .role-option { position: relative; }
        .role-option input { position: absolute; opacity: 0; }
        .role-option label { display: flex; flex-direction: column; align-items: center; gap: 0.75rem; padding: 1.5rem; border: 2px solid var(--gray-200); border-radius: var(--radius-xl); cursor: pointer; transition: 0.2s; text-align: center; }
        .role-option label:hover { border-color: var(--primary); background: rgba(139,21,56,0.02); }
        .role-option input:checked + label { border-color: var(--primary); background: rgba(139,21,56,0.05); }
        .role-option .role-icon { width: 56px; height: 56px; display: flex; align-items: center; justify-content: center; background: var(--gray-100); border-radius: var(--radius-lg); font-size: 1.5rem; color: var(--gray-500); transition: 0.2s; }
        .role-option input:checked + label .role-icon { background: var(--primary); color: var(--white); }
        .role-option .role-title { font-weight: 700; color: var(--gray-800); }
        .role-option .role-desc { font-size: 0.8125rem; color: var(--gray-500); }
    </style>
</head>
<body>
    <div class="auth-page">
        <div class="auth-visual">
            <div class="hero-shapes"><div class="hero-shape hero-shape-1"></div><div class="hero-shape hero-shape-2"></div></div>
            <div class="auth-visual-content">
                <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="NusaTech" class="auth-visual-logo">
                <h2 class="auth-visual-title">Mulai Perjalanan Anda</h2>
                <p class="auth-visual-description">Bergabunglah dengan ribuan pelajar dan pengajar untuk membangun masa depan Indonesia.</p>
            </div>
        </div>
        <div class="auth-content">
            <div class="auth-form">
                <a href="${pageContext.request.contextPath}/" style="display: inline-flex; align-items: center; gap: 0.5rem; color: var(--gray-500); margin-bottom: 2rem;"><i class="fas fa-arrow-left"></i> Kembali ke Beranda</a>
                <h1 class="auth-title">Buat Akun Baru</h1>
                <p class="auth-subtitle">Isi data diri Anda untuk mendaftar</p>
                <c:if test="${not empty error}"><div class="alert alert-error"><i class="fas fa-exclamation-circle"></i><span>${error}</span></div></c:if>
                <form action="${pageContext.request.contextPath}/register" method="POST">
                    <div class="role-selector">
                        <div class="role-option">
                            <input type="radio" name="role" id="roleStudent" value="STUDENT" ${selectedRole == 'STUDENT' || empty selectedRole ? 'checked' : ''}>
                            <label for="roleStudent"><div class="role-icon"><i class="fas fa-user-graduate"></i></div><span class="role-title">Pelajar</span><span class="role-desc">Saya ingin belajar</span></label>
                        </div>
                        <div class="role-option">
                            <input type="radio" name="role" id="roleLecturer" value="LECTURER" ${selectedRole == 'LECTURER' ? 'checked' : ''}>
                            <label for="roleLecturer"><div class="role-icon"><i class="fas fa-chalkboard-teacher"></i></div><span class="role-title">Pengajar</span><span class="role-desc">Saya ingin mengajar</span></label>
                        </div>
                    </div>
                    <div class="form-group"><label class="form-label">Nama Lengkap</label><input type="text" name="name" class="form-input" placeholder="Masukkan nama lengkap" value="${name}" required></div>
                    <div class="form-group"><label class="form-label">Email</label><input type="email" name="email" class="form-input" placeholder="nama@email.com" value="${email}" required></div>
                    <div class="form-group"><label class="form-label">Nomor Telepon (Opsional)</label><input type="tel" name="phone" class="form-input" placeholder="08xxxxxxxxxx" value="${phone}"></div>
                    <div class="form-group"><label class="form-label">Password</label><input type="password" name="password" class="form-input" placeholder="Min. 8 karakter" required><small style="color: var(--gray-500);">Min. 8 karakter dengan huruf dan angka</small></div>
                    <div class="form-group"><label class="form-label">Konfirmasi Password</label><input type="password" name="confirmPassword" class="form-input" placeholder="Ulangi password" required></div>
                    <div class="form-group"><label class="form-check"><input type="checkbox" name="agree" required><span>Saya setuju dengan <a href="#" style="color: var(--primary);">Syarat & Ketentuan</a></span></label></div>
                    <button type="submit" class="btn btn-primary btn-lg w-100"><i class="fas fa-user-plus"></i> Daftar Sekarang</button>
                </form>
                <p class="auth-footer">Sudah punya akun? <a href="${pageContext.request.contextPath}/login">Masuk di sini</a></p>
            </div>
        </div>
    </div>
</body>
</html>
