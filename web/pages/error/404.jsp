<%-- 
    Document   : 404
    Created on : Dec 18, 2025
    Author     : NusaTech
    Description: 404 Not Found Error Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Halaman Tidak Ditemukan | NusaTech</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #8B1538;
            --primary-dark: #6d1029;
            --secondary: #D4A84B;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
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
            color: var(--primary);
            opacity: 0.1;
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
            box-shadow: 0 10px 40px rgba(139, 21, 56, 0.15);
            animation: float 3s ease-in-out infinite;
        }
        
        @keyframes float {
            0%, 100% { transform: translate(-50%, -50%) translateY(0); }
            50% { transform: translate(-50%, -50%) translateY(-15px); }
        }
        
        .error-icon i {
            font-size: 4rem;
            color: var(--primary);
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
        
        /* Search Bar */
        .search-box {
            max-width: 400px;
            margin: 2rem auto 0;
        }
        
        .search-box .form-control {
            border-radius: 0.5rem 0 0 0.5rem;
            border-color: #e5e7eb;
            padding: 0.75rem 1rem;
        }
        
        .search-box .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(139, 21, 56, 0.1);
        }
        
        .search-box .btn {
            border-radius: 0 0.5rem 0.5rem 0;
            padding: 0.75rem 1.25rem;
        }
        
        /* Suggestions */
        .suggestions {
            margin-top: 3rem;
            padding-top: 2rem;
            border-top: 1px solid #e5e7eb;
        }
        
        .suggestions-title {
            font-weight: 600;
            color: #6b7280;
            margin-bottom: 1rem;
        }
        
        .suggestions-links {
            display: flex;
            justify-content: center;
            gap: 1.5rem;
            flex-wrap: wrap;
        }
        
        .suggestions-links a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.2s;
        }
        
        .suggestions-links a:hover {
            color: var(--primary-dark);
            text-decoration: underline;
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
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-content">
            <!-- Illustration -->
            <div class="error-illustration">
                <div class="error-code">404</div>
                <div class="error-icon">
                    <i class="fas fa-search"></i>
                </div>
            </div>
            
            <!-- Text -->
            <h1 class="error-title">Oops! Halaman Tidak Ditemukan</h1>
            <p class="error-message">
                Maaf, halaman yang Anda cari tidak ada atau mungkin telah dipindahkan. 
                Pastikan URL sudah benar atau gunakan menu navigasi untuk menemukan halaman yang Anda cari.
            </p>
            
            <!-- Actions -->
            <div class="error-actions">
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                    <i class="fas fa-home me-2"></i> Kembali ke Beranda
                </a>
                <button onclick="history.back()" class="btn btn-outline-primary">
                    <i class="fas fa-arrow-left me-2"></i> Halaman Sebelumnya
                </button>
            </div>
            
            <!-- Search -->
            <div class="search-box">
                <form action="${pageContext.request.contextPath}/course/search" method="GET">
                    <div class="input-group">
                        <input type="text" class="form-control" name="q" placeholder="Cari kursus...">
                        <button class="btn btn-primary" type="submit">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </form>
            </div>
            
            <!-- Suggestions -->
            <div class="suggestions">
                <p class="suggestions-title">Mungkin Anda mencari:</p>
                <div class="suggestions-links">
                    <a href="${pageContext.request.contextPath}/course">
                        <i class="fas fa-book"></i> Kursus
                    </a>
                    <a href="${pageContext.request.contextPath}/category">
                        <i class="fas fa-th-large"></i> Kategori
                    </a>
                    <a href="${pageContext.request.contextPath}/auth/login">
                        <i class="fas fa-sign-in-alt"></i> Login
                    </a>
                    <a href="${pageContext.request.contextPath}/auth/register">
                        <i class="fas fa-user-plus"></i> Daftar
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
