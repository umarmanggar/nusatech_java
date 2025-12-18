<%-- 
    Document   : 403
    Created on : Dec 18, 2025
    Author     : NusaTech
    Description: 403 Forbidden Error Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>403 - Akses Ditolak | NusaTech</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #8B1538;
            --primary-dark: #6d1029;
            --secondary: #D4A84B;
            --warning: #f59e0b;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: linear-gradient(135deg, #fffbeb 0%, #fef3c7 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        .btn-primary { 
            background-color: var(--primary); 
            border-color: var(--primary); 
        }
        .btn-primary:hover { 
            background-color: var(--primary-dark); 
            border-color: var(--primary-dark); 
        }
        .btn-outline-primary { 
            color: var(--primary); 
            border-color: var(--primary); 
        }
        .btn-outline-primary:hover { 
            background-color: var(--primary); 
            border-color: var(--primary); 
        }
        .text-primary { color: var(--primary) !important; }
        
        /* Error Container */
        .error-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        
        .error-content {
            text-align: center;
            max-width: 600px;
        }
        
        /* Illustration */
        .error-illustration {
            position: relative;
            margin-bottom: 2rem;
        }
        
        .error-code {
            font-size: 12rem;
            font-weight: 800;
            color: var(--warning);
            opacity: 0.15;
            line-height: 1;
            position: relative;
        }
        
        .error-icon {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 150px;
            height: 150px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 10px 40px rgba(245, 158, 11, 0.2);
            animation: pulse-warning 2s ease-in-out infinite;
        }
        
        @keyframes pulse-warning {
            0%, 100% { 
                transform: translate(-50%, -50%) scale(1);
                box-shadow: 0 10px 40px rgba(245, 158, 11, 0.2);
            }
            50% { 
                transform: translate(-50%, -50%) scale(1.05);
                box-shadow: 0 15px 50px rgba(245, 158, 11, 0.3);
            }
        }
        
        .error-icon i {
            font-size: 4rem;
            color: var(--warning);
        }
        
        /* Shield Animation */
        .shield-container {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 200px;
            height: 200px;
        }
        
        .shield-ring {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            border: 3px solid var(--warning);
            border-radius: 50%;
            opacity: 0;
            animation: ring-expand 2s ease-out infinite;
        }
        
        .shield-ring:nth-child(1) { animation-delay: 0s; }
        .shield-ring:nth-child(2) { animation-delay: 0.5s; }
        .shield-ring:nth-child(3) { animation-delay: 1s; }
        
        @keyframes ring-expand {
            0% {
                width: 150px;
                height: 150px;
                opacity: 0.5;
            }
            100% {
                width: 250px;
                height: 250px;
                opacity: 0;
            }
        }
        
        /* Text */
        .error-title {
            font-size: 2rem;
            font-weight: 800;
            color: #1f2937;
            margin-bottom: 1rem;
        }
        
        .error-message {
            font-size: 1.1rem;
            color: #6b7280;
            margin-bottom: 2rem;
            line-height: 1.7;
        }
        
        /* Actions */
        .error-actions {
            display: flex;
            justify-content: center;
            gap: 1rem;
            flex-wrap: wrap;
        }
        
        .error-actions .btn {
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            border-radius: 0.5rem;
        }
        
        /* Access Info */
        .access-info {
            margin-top: 2rem;
            padding: 1.5rem;
            background: white;
            border-radius: 1rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border-left: 4px solid var(--warning);
        }
        
        .access-info-title {
            font-weight: 600;
            color: #374151;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .access-info-title i {
            color: var(--warning);
        }
        
        .access-info-text {
            color: #6b7280;
            font-size: 0.95rem;
            line-height: 1.7;
            margin-bottom: 0;
        }
        
        /* User Status */
        .user-status {
            margin-top: 2rem;
            display: flex;
            justify-content: center;
            gap: 2rem;
            flex-wrap: wrap;
        }
        
        .status-card {
            background: white;
            padding: 1.5rem 2rem;
            border-radius: 1rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            text-align: center;
            min-width: 150px;
        }
        
        .status-card i {
            font-size: 2rem;
            color: var(--primary);
            margin-bottom: 0.5rem;
        }
        
        .status-card h6 {
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.25rem;
        }
        
        .status-card p {
            color: #9ca3af;
            font-size: 0.85rem;
            margin-bottom: 0;
        }
        
        /* Login Prompt */
        .login-prompt {
            margin-top: 2rem;
            padding: 1.5rem;
            background: rgba(139, 21, 56, 0.05);
            border-radius: 1rem;
            border: 1px dashed var(--primary);
        }
        
        .login-prompt p {
            color: #374151;
            margin-bottom: 1rem;
        }
        
        /* Responsive */
        @media (max-width: 575.98px) {
            .error-code {
                font-size: 8rem;
            }
            
            .error-icon {
                width: 100px;
                height: 100px;
            }
            
            .error-icon i {
                font-size: 2.5rem;
            }
            
            .error-title {
                font-size: 1.5rem;
            }
            
            .user-status {
                flex-direction: column;
                align-items: center;
            }
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-content">
            <!-- Illustration -->
            <div class="error-illustration">
                <div class="error-code">403</div>
                <div class="shield-container">
                    <div class="shield-ring"></div>
                    <div class="shield-ring"></div>
                    <div class="shield-ring"></div>
                </div>
                <div class="error-icon">
                    <i class="fas fa-lock"></i>
                </div>
            </div>
            
            <!-- Text -->
            <h1 class="error-title">Akses Ditolak</h1>
            <p class="error-message">
                Maaf, Anda tidak memiliki izin untuk mengakses halaman ini.
                Halaman ini mungkin memerlukan hak akses khusus atau login terlebih dahulu.
            </p>
            
            <!-- Actions -->
            <div class="error-actions">
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                    <i class="fas fa-home me-2"></i> Kembali ke Beranda
                </a>
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-outline-primary">
                            <i class="fas fa-sign-in-alt me-2"></i> Login
                        </a>
                    </c:when>
                    <c:otherwise>
                        <button onclick="history.back()" class="btn btn-outline-primary">
                            <i class="fas fa-arrow-left me-2"></i> Kembali
                        </button>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <!-- Access Info -->
            <div class="access-info">
                <h6 class="access-info-title">
                    <i class="fas fa-shield-alt"></i>
                    Mengapa saya melihat halaman ini?
                </h6>
                <p class="access-info-text">
                    <c:choose>
                        <c:when test="${empty sessionScope.user}">
                            Anda belum login. Beberapa halaman memerlukan autentikasi untuk diakses.
                            Silakan login terlebih dahulu untuk melanjutkan.
                        </c:when>
                        <c:otherwise>
                            Akun Anda tidak memiliki hak akses untuk halaman ini.
                            Jika Anda merasa ini adalah kesalahan, silakan hubungi administrator.
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
            
            <!-- User Status (if logged in) -->
            <c:if test="${not empty sessionScope.user}">
                <div class="user-status">
                    <div class="status-card">
                        <i class="fas fa-user-circle"></i>
                        <h6>${sessionScope.user.fullName}</h6>
                        <p>${sessionScope.user.email}</p>
                    </div>
                    <div class="status-card">
                        <i class="fas fa-id-badge"></i>
                        <h6>Role</h6>
                        <p>
                            <c:choose>
                                <c:when test="${sessionScope.user.role == 'ADMIN'}">Administrator</c:when>
                                <c:when test="${sessionScope.user.role == 'LECTURER'}">Instructor</c:when>
                                <c:when test="${sessionScope.user.role == 'STUDENT'}">Student</c:when>
                                <c:otherwise>${sessionScope.user.role}</c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>
            </c:if>
            
            <!-- Login Prompt (if not logged in) -->
            <c:if test="${empty sessionScope.user}">
                <div class="login-prompt">
                    <p><i class="fas fa-user-lock me-2"></i> Sudah punya akun?</p>
                    <a href="${pageContext.request.contextPath}/auth/login?redirect=${pageContext.request.requestURI}" class="btn btn-primary">
                        <i class="fas fa-sign-in-alt me-2"></i> Login Sekarang
                    </a>
                    <p class="mt-3 mb-0 text-muted small">
                        Belum punya akun? 
                        <a href="${pageContext.request.contextPath}/auth/register" class="text-primary">Daftar gratis</a>
                    </p>
                </div>
            </c:if>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
