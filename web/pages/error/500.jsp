<%-- 
    Document   : 500
    Created on : Dec 18, 2025
    Author     : NusaTech
    Description: 500 Internal Server Error Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 - Kesalahan Server | NusaTech</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #8B1538;
            --primary-dark: #6d1029;
            --secondary: #D4A84B;
            --danger: #ef4444;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: linear-gradient(135deg, #fef2f2 0%, #fee2e2 100%);
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
            color: var(--danger);
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
            box-shadow: 0 10px 40px rgba(239, 68, 68, 0.2);
            animation: shake 0.5s ease-in-out infinite;
        }
        
        @keyframes shake {
            0%, 100% { transform: translate(-50%, -50%) rotate(0deg); }
            25% { transform: translate(-50%, -50%) rotate(-3deg); }
            75% { transform: translate(-50%, -50%) rotate(3deg); }
        }
        
        .error-icon i {
            font-size: 4rem;
            color: var(--danger);
        }
        
        /* Gears Animation */
        .gears {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 200px;
            height: 200px;
        }
        
        .gear {
            position: absolute;
            fill: var(--danger);
            opacity: 0.3;
        }
        
        .gear-1 {
            width: 80px;
            height: 80px;
            top: 0;
            left: 0;
            animation: rotate 4s linear infinite;
        }
        
        .gear-2 {
            width: 60px;
            height: 60px;
            top: 50px;
            right: 20px;
            animation: rotate-reverse 3s linear infinite;
        }
        
        .gear-3 {
            width: 50px;
            height: 50px;
            bottom: 20px;
            left: 30px;
            animation: rotate 5s linear infinite;
        }
        
        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
        
        @keyframes rotate-reverse {
            from { transform: rotate(360deg); }
            to { transform: rotate(0deg); }
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
        
        /* Status Info */
        .status-info {
            margin-top: 2rem;
            padding: 1.5rem;
            background: white;
            border-radius: 1rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }
        
        .status-info-title {
            font-weight: 600;
            color: #374151;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }
        
        .status-list {
            list-style: none;
            padding: 0;
            margin: 0;
            text-align: left;
        }
        
        .status-list li {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.5rem 0;
            color: #6b7280;
            font-size: 0.9rem;
        }
        
        .status-list li i {
            color: var(--danger);
        }
        
        /* Help Section */
        .help-section {
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(239, 68, 68, 0.2);
        }
        
        .help-text {
            color: #6b7280;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }
        
        .help-link {
            color: var(--primary);
            font-weight: 600;
            text-decoration: none;
        }
        
        .help-link:hover {
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
                <div class="error-code">500</div>
                <div class="error-icon">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
            </div>
            
            <!-- Text -->
            <h1 class="error-title">Oops! Terjadi Kesalahan Server</h1>
            <p class="error-message">
                Maaf, server kami sedang mengalami masalah teknis. 
                Tim kami sudah diberitahu dan sedang bekerja untuk memperbaikinya.
                Silakan coba lagi dalam beberapa saat.
            </p>
            
            <!-- Actions -->
            <div class="error-actions">
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                    <i class="fas fa-home me-2"></i> Kembali ke Beranda
                </a>
                <button onclick="location.reload()" class="btn btn-outline-primary">
                    <i class="fas fa-redo me-2"></i> Coba Lagi
                </button>
            </div>
            
            <!-- Status Info -->
            <div class="status-info">
                <h6 class="status-info-title">
                    <i class="fas fa-info-circle"></i>
                    Apa yang bisa Anda lakukan:
                </h6>
                <ul class="status-list">
                    <li>
                        <i class="fas fa-sync-alt"></i>
                        Refresh halaman atau coba lagi dalam beberapa menit
                    </li>
                    <li>
                        <i class="fas fa-wifi"></i>
                        Periksa koneksi internet Anda
                    </li>
                    <li>
                        <i class="fas fa-broom"></i>
                        Bersihkan cache dan cookies browser Anda
                    </li>
                    <li>
                        <i class="fas fa-headset"></i>
                        Hubungi tim support jika masalah berlanjut
                    </li>
                </ul>
            </div>
            
            <!-- Help Section -->
            <div class="help-section">
                <p class="help-text">Butuh bantuan?</p>
                <a href="mailto:support@nusatech.id" class="help-link">
                    <i class="fas fa-envelope me-1"></i> support@nusatech.id
                </a>
                <span class="mx-2 text-muted">|</span>
                <a href="https://wa.me/6281234567890" class="help-link" target="_blank">
                    <i class="fab fa-whatsapp me-1"></i> WhatsApp
                </a>
            </div>
            
            <!-- Error Reference (for debugging) -->
            <c:if test="${not empty requestScope['javax.servlet.error.message']}">
                <div class="mt-4">
                    <small class="text-muted">
                        Error Ref: ${requestScope['javax.servlet.error.request_uri']}
                    </small>
                </div>
            </c:if>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
