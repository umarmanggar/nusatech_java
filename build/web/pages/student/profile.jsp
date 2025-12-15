<%-- 
    Document   : profile
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Student Profile Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profil Saya - NusaTech</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <jsp:include page="/pages/common/navbar-dashboard.jsp"/>
    
    <div class="dashboard-layout">
        <jsp:include page="/pages/common/sidebar-student.jsp"/>
        
        <main class="main-content">
            <div class="page-header">
                <h1 class="page-title">Profil Saya</h1>
                <p class="page-subtitle">Kelola informasi profil Anda</p>
            </div>
            
            <!-- Success/Error Messages -->
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    <span>${sessionScope.successMessage}</span>
                </div>
                <c:remove var="successMessage" scope="session"/>
            </c:if>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    <span>${error}</span>
                </div>
            </c:if>
            
            <div style="display: grid; grid-template-columns: 1fr 2fr; gap: 2rem;">
                <!-- Profile Card -->
                <div class="card" style="padding: 2rem; text-align: center;">
                    <div style="position: relative; display: inline-block; margin-bottom: 1.5rem;">
                        <img src="https://ui-avatars.com/api/?name=${user.name}&background=8B1538&color=fff&size=120" 
                             alt="${user.name}" 
                             style="width: 120px; height: 120px; border-radius: 50%; border: 4px solid var(--primary-100);">
                        <button style="position: absolute; bottom: 0; right: 0; width: 36px; height: 36px; border-radius: 50%; background: var(--primary); color: white; border: 3px solid white; display: flex; align-items: center; justify-content: center;">
                            <i class="fas fa-camera" style="font-size: 0.875rem;"></i>
                        </button>
                    </div>
                    <h3 style="font-size: 1.25rem; margin-bottom: 0.25rem;">${user.name}</h3>
                    <p style="color: var(--gray-500); margin-bottom: 1rem;">${user.email}</p>
                    <span class="badge badge-primary">${user.roleDisplayName}</span>
                    
                    <div style="margin-top: 2rem; padding-top: 1.5rem; border-top: 1px solid var(--gray-100);">
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; text-align: center;">
                            <div>
                                <div style="font-size: 1.5rem; font-weight: 700; color: var(--primary);">${totalEnrolled != null ? totalEnrolled : 0}</div>
                                <div style="font-size: 0.875rem; color: var(--gray-500);">Kursus</div>
                            </div>
                            <div>
                                <div style="font-size: 1.5rem; font-weight: 700; color: var(--success);">${totalCompleted != null ? totalCompleted : 0}</div>
                                <div style="font-size: 0.875rem; color: var(--gray-500);">Selesai</div>
                            </div>
                        </div>
                    </div>
                    
                    <div style="margin-top: 1.5rem;">
                        <p style="font-size: 0.875rem; color: var(--gray-500);">
                            <i class="fas fa-calendar-alt"></i> 
                            Bergabung sejak <fmt:formatDate value="${user.createdAt}" pattern="MMMM yyyy"/>
                        </p>
                    </div>
                </div>
                
                <!-- Edit Profile Form -->
                <div class="card" style="padding: 2rem;">
                    <h3 style="font-size: 1.25rem; margin-bottom: 1.5rem;">
                        <i class="fas fa-edit" style="color: var(--primary);"></i> Edit Profil
                    </h3>
                    
                    <form action="${pageContext.request.contextPath}/student/update-profile" method="POST">
                        <div class="form-group">
                            <label class="form-label">Nama Lengkap</label>
                            <input type="text" name="name" class="form-input" value="${user.name}" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-input" value="${user.email}" disabled>
                            <small class="form-hint">Email tidak dapat diubah</small>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Nomor Telepon</label>
                            <input type="tel" name="phone" class="form-input" value="${user.phone}" placeholder="08xxxxxxxxxx">
                        </div>
                        
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Simpan Perubahan
                        </button>
                    </form>
                    
                    <!-- Change Password Section -->
                    <div style="margin-top: 2rem; padding-top: 2rem; border-top: 1px solid var(--gray-200);">
                        <h3 style="font-size: 1.25rem; margin-bottom: 1.5rem;">
                            <i class="fas fa-lock" style="color: var(--warning);"></i> Ganti Password
                        </h3>
                        
                        <form action="${pageContext.request.contextPath}/student/change-password" method="POST">
                            <div class="form-group">
                                <label class="form-label">Password Saat Ini</label>
                                <input type="password" name="currentPassword" class="form-input" required>
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label">Password Baru</label>
                                <input type="password" name="newPassword" class="form-input" required minlength="8">
                                <small class="form-hint">Minimal 8 karakter dengan kombinasi huruf dan angka</small>
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label">Konfirmasi Password Baru</label>
                                <input type="password" name="confirmPassword" class="form-input" required>
                            </div>
                            
                            <button type="submit" class="btn btn-warning">
                                <i class="fas fa-key"></i> Ganti Password
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
