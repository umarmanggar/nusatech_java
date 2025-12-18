<%-- 
    Document   : success
    Created on : Dec 18, 2025
    Author     : NusaTech
    Description: Payment Success Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pembayaran Berhasil - NusaTech</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #8B1538;
            --primary-dark: #6d1029;
            --secondary: #D4A84B;
            --success: #10b981;
        }
        
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8f9fa;
            min-height: 100vh;
        }
        
        .navbar {
            background: white;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        }
        
        .navbar-brand {
            font-weight: 800;
            color: var(--primary) !important;
        }
        
        .btn-primary { background-color: var(--primary); border-color: var(--primary); }
        .btn-primary:hover { background-color: var(--primary-dark); border-color: var(--primary-dark); }
        .btn-outline-primary { color: var(--primary); border-color: var(--primary); }
        .btn-outline-primary:hover { background-color: var(--primary); border-color: var(--primary); color: white; }
        .text-primary { color: var(--primary) !important; }
        
        /* Progress Steps */
        .checkout-progress {
            background: white;
            padding: 1.5rem 0;
            border-bottom: 1px solid #e5e7eb;
            margin-bottom: 2rem;
        }
        
        .progress-steps {
            display: flex;
            justify-content: center;
            gap: 2rem;
        }
        
        .progress-step {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            color: #9ca3af;
        }
        
        .progress-step.completed {
            color: var(--success);
        }
        
        .step-number {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: #e5e7eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 0.9rem;
        }
        
        .progress-step.completed .step-number {
            background: var(--success);
            color: white;
        }
        
        .step-connector {
            width: 60px;
            height: 2px;
            background: #e5e7eb;
            margin: 0 -1rem;
        }
        
        .step-connector.completed {
            background: var(--success);
        }
        
        /* Success Card */
        .success-card {
            background: white;
            border-radius: 1.5rem;
            box-shadow: 0 4px 24px rgba(0,0,0,0.08);
            overflow: hidden;
            max-width: 700px;
            margin: 0 auto;
        }
        
        .success-header {
            background: linear-gradient(135deg, var(--success) 0%, #059669 100%);
            color: white;
            padding: 3rem 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .success-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 60%);
            animation: pulse 3s infinite;
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 0.5; }
            50% { transform: scale(1.1); opacity: 0.3; }
        }
        
        .success-icon {
            width: 100px;
            height: 100px;
            background: white;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
            position: relative;
            z-index: 1;
            animation: bounceIn 0.6s ease-out;
        }
        
        @keyframes bounceIn {
            0% { transform: scale(0); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }
        
        .success-icon i {
            font-size: 3rem;
            color: var(--success);
        }
        
        .success-header h2 {
            font-weight: 800;
            margin-bottom: 0.5rem;
            position: relative;
            z-index: 1;
        }
        
        .success-header p {
            opacity: 0.9;
            position: relative;
            z-index: 1;
            margin-bottom: 0;
        }
        
        /* Success Body */
        .success-body {
            padding: 2rem;
        }
        
        /* Transaction Details */
        .transaction-details {
            background: #f9fafb;
            border-radius: 1rem;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .transaction-title {
            font-weight: 700;
            font-size: 1rem;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .transaction-row {
            display: flex;
            justify-content: space-between;
            padding: 0.75rem 0;
            border-bottom: 1px solid #e5e7eb;
        }
        
        .transaction-row:last-child {
            border-bottom: none;
        }
        
        .transaction-label {
            color: #6b7280;
            font-size: 0.9rem;
        }
        
        .transaction-value {
            font-weight: 600;
            color: #1f2937;
            font-size: 0.9rem;
        }
        
        .transaction-value.highlight {
            color: var(--success);
        }
        
        /* Purchased Courses */
        .courses-section {
            margin-bottom: 2rem;
        }
        
        .courses-title {
            font-weight: 700;
            font-size: 1rem;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .course-item {
            display: flex;
            gap: 1rem;
            padding: 1rem;
            background: #f9fafb;
            border-radius: 0.75rem;
            margin-bottom: 0.75rem;
            transition: all 0.3s;
        }
        
        .course-item:hover {
            background: #f1f5f9;
        }
        
        .course-item:last-child {
            margin-bottom: 0;
        }
        
        .course-thumbnail {
            width: 100px;
            height: 70px;
            border-radius: 0.5rem;
            object-fit: cover;
        }
        
        .course-info {
            flex: 1;
        }
        
        .course-title {
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 0.25rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .course-instructor {
            font-size: 0.8rem;
            color: #6b7280;
        }
        
        .course-action {
            display: flex;
            align-items: center;
        }
        
        .btn-start-learning {
            padding: 0.5rem 1rem;
            font-size: 0.85rem;
            white-space: nowrap;
        }
        
        /* Action Buttons */
        .action-buttons {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }
        
        .btn-main-action {
            padding: 1rem 2rem;
            font-size: 1.1rem;
            font-weight: 600;
        }
        
        .secondary-actions {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 0.5rem;
        }
        
        .btn-secondary-action {
            font-size: 0.9rem;
        }
        
        /* Receipt Download */
        .receipt-section {
            text-align: center;
            padding-top: 1.5rem;
            border-top: 1px solid #e5e7eb;
            margin-top: 1.5rem;
        }
        
        .receipt-section p {
            color: #6b7280;
            font-size: 0.9rem;
            margin-bottom: 0.75rem;
        }
        
        /* Confetti Animation */
        .confetti {
            position: fixed;
            width: 10px;
            height: 10px;
            top: -10px;
            opacity: 0;
            animation: confetti-fall 3s ease-in-out forwards;
        }
        
        @keyframes confetti-fall {
            0% {
                opacity: 1;
                top: -10px;
                transform: translateX(0) rotate(0);
            }
            100% {
                opacity: 0;
                top: 100vh;
                transform: translateX(var(--drift)) rotate(720deg);
            }
        }
        
        /* What's Next Section */
        .whats-next {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            padding: 2rem;
            margin-top: 2rem;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .whats-next-title {
            font-weight: 700;
            font-size: 1.25rem;
            margin-bottom: 1.5rem;
            text-align: center;
        }
        
        .next-steps {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1.5rem;
        }
        
        .next-step {
            text-align: center;
        }
        
        .next-step-icon {
            width: 60px;
            height: 60px;
            background: rgba(139, 21, 56, 0.1);
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
        }
        
        .next-step-icon i {
            font-size: 1.5rem;
            color: var(--primary);
        }
        
        .next-step h6 {
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        
        .next-step p {
            font-size: 0.85rem;
            color: #6b7280;
            margin-bottom: 0;
        }
        
        /* Responsive */
        @media (max-width: 767.98px) {
            .progress-steps {
                gap: 1rem;
            }
            
            .step-connector {
                width: 30px;
            }
            
            .success-header {
                padding: 2rem 1.5rem;
            }
            
            .success-icon {
                width: 80px;
                height: 80px;
            }
            
            .success-icon i {
                font-size: 2.5rem;
            }
            
            .course-item {
                flex-direction: column;
            }
            
            .course-thumbnail {
                width: 100%;
                height: 120px;
            }
            
            .course-action {
                margin-top: 0.75rem;
            }
            
            .btn-start-learning {
                width: 100%;
            }
            
            .next-steps {
                grid-template-columns: 1fr;
                gap: 1rem;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg sticky-top">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-graduation-cap me-2"></i>NusaTech
            </a>
        </div>
    </nav>
    
    <!-- Progress Steps -->
    <div class="checkout-progress">
        <div class="container">
            <div class="progress-steps">
                <div class="progress-step completed">
                    <div class="step-number"><i class="fas fa-check"></i></div>
                    <span class="step-label d-none d-md-inline">Keranjang</span>
                </div>
                <div class="step-connector completed"></div>
                <div class="progress-step completed">
                    <div class="step-number"><i class="fas fa-check"></i></div>
                    <span class="step-label d-none d-md-inline">Checkout</span>
                </div>
                <div class="step-connector completed"></div>
                <div class="progress-step completed">
                    <div class="step-number"><i class="fas fa-check"></i></div>
                    <span class="step-label d-none d-md-inline">Pembayaran</span>
                </div>
                <div class="step-connector completed"></div>
                <div class="progress-step completed">
                    <div class="step-number"><i class="fas fa-check"></i></div>
                    <span class="step-label d-none d-md-inline">Selesai</span>
                </div>
            </div>
        </div>
    </div>
    
    <main class="container pb-5">
        <!-- Success Card -->
        <div class="success-card">
            <div class="success-header">
                <div class="success-icon">
                    <i class="fas fa-check"></i>
                </div>
                <h2>Pembayaran Berhasil!</h2>
                <p>Terima kasih atas pembelian Anda. Selamat belajar!</p>
            </div>
            
            <div class="success-body">
                <!-- Transaction Details -->
                <div class="transaction-details">
                    <h6 class="transaction-title">
                        <i class="fas fa-receipt text-primary"></i>
                        Detail Transaksi
                    </h6>
                    <div class="transaction-row">
                        <span class="transaction-label">No. Transaksi</span>
                        <span class="transaction-value">${transaction.transactionCode}</span>
                    </div>
                    <div class="transaction-row">
                        <span class="transaction-label">Tanggal</span>
                        <span class="transaction-value">
                            <fmt:formatDate value="${transaction.paidAt}" pattern="dd MMMM yyyy, HH:mm"/>
                        </span>
                    </div>
                    <div class="transaction-row">
                        <span class="transaction-label">Metode Pembayaran</span>
                        <span class="transaction-value">
                            <c:choose>
                                <c:when test="${transaction.paymentMethod == 'bca'}">Bank BCA</c:when>
                                <c:when test="${transaction.paymentMethod == 'bni'}">Bank BNI</c:when>
                                <c:when test="${transaction.paymentMethod == 'bri'}">Bank BRI</c:when>
                                <c:when test="${transaction.paymentMethod == 'mandiri'}">Bank Mandiri</c:when>
                                <c:when test="${transaction.paymentMethod == 'gopay'}">GoPay</c:when>
                                <c:when test="${transaction.paymentMethod == 'ovo'}">OVO</c:when>
                                <c:when test="${transaction.paymentMethod == 'dana'}">DANA</c:when>
                                <c:when test="${transaction.paymentMethod == 'shopeepay'}">ShopeePay</c:when>
                                <c:when test="${transaction.paymentMethod == 'qris'}">QRIS</c:when>
                                <c:otherwise>${transaction.paymentMethod}</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="transaction-row">
                        <span class="transaction-label">Total Pembayaran</span>
                        <span class="transaction-value highlight">
                            <fmt:formatNumber value="${transaction.totalAmount}" type="currency" currencySymbol="Rp " maxFractionDigits="0"/>
                        </span>
                    </div>
                    <div class="transaction-row">
                        <span class="transaction-label">Status</span>
                        <span class="transaction-value">
                            <span class="badge bg-success">
                                <i class="fas fa-check-circle me-1"></i> Berhasil
                            </span>
                        </span>
                    </div>
                </div>
                
                <!-- Purchased Courses -->
                <div class="courses-section">
                    <h6 class="courses-title">
                        <i class="fas fa-graduation-cap text-primary"></i>
                        Kursus yang Dibeli
                    </h6>
                    <c:forEach var="item" items="${transactionItems}">
                        <div class="course-item">
                            <img src="${not empty item.course.thumbnail ? item.course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=100&h=70&fit=crop'}" 
                                 alt="${item.course.title}" class="course-thumbnail">
                            <div class="course-info">
                                <div class="course-title">${item.course.title}</div>
                                <div class="course-instructor">
                                    <i class="fas fa-user-tie me-1"></i> ${item.course.instructor.fullName}
                                </div>
                            </div>
                            <div class="course-action">
                                <a href="${pageContext.request.contextPath}/learn/${item.course.slug}" class="btn btn-primary btn-start-learning">
                                    <i class="fas fa-play me-1"></i> Mulai
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <!-- Action Buttons -->
                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/student/my-learning" class="btn btn-primary btn-main-action">
                        <i class="fas fa-book-reader me-2"></i> Ke Kursus Saya
                    </a>
                    <div class="secondary-actions">
                        <a href="${pageContext.request.contextPath}/course" class="btn btn-outline-primary btn-secondary-action">
                            <i class="fas fa-search me-1"></i> Cari Kursus Lain
                        </a>
                        <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary btn-secondary-action">
                            <i class="fas fa-home me-1"></i> Ke Beranda
                        </a>
                    </div>
                </div>
                
                <!-- Receipt Download -->
                <div class="receipt-section">
                    <p>Bukti pembayaran telah dikirim ke email Anda.</p>
                    <button class="btn btn-sm btn-outline-primary" onclick="downloadReceipt()">
                        <i class="fas fa-download me-1"></i> Download Bukti Pembayaran
                    </button>
                </div>
            </div>
        </div>
        
        <!-- What's Next -->
        <div class="whats-next">
            <h5 class="whats-next-title">
                <i class="fas fa-lightbulb text-warning me-2"></i>
                Langkah Selanjutnya
            </h5>
            <div class="next-steps">
                <div class="next-step">
                    <div class="next-step-icon">
                        <i class="fas fa-play-circle"></i>
                    </div>
                    <h6>Mulai Belajar</h6>
                    <p>Akses kursus Anda dan mulai perjalanan belajar</p>
                </div>
                <div class="next-step">
                    <div class="next-step-icon">
                        <i class="fas fa-tasks"></i>
                    </div>
                    <h6>Selesaikan Materi</h6>
                    <p>Tonton video, baca materi, dan kerjakan quiz</p>
                </div>
                <div class="next-step">
                    <div class="next-step-icon">
                        <i class="fas fa-certificate"></i>
                    </div>
                    <h6>Dapatkan Sertifikat</h6>
                    <p>Selesaikan kursus dan dapatkan sertifikat Anda</p>
                </div>
            </div>
        </div>
    </main>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Confetti animation
        function createConfetti() {
            const colors = ['#8B1538', '#D4A84B', '#10b981', '#3b82f6', '#f59e0b', '#ef4444'];
            const confettiCount = 50;
            
            for (let i = 0; i < confettiCount; i++) {
                const confetti = document.createElement('div');
                confetti.className = 'confetti';
                confetti.style.left = Math.random() * 100 + 'vw';
                confetti.style.backgroundColor = colors[Math.floor(Math.random() * colors.length)];
                confetti.style.setProperty('--drift', (Math.random() * 200 - 100) + 'px');
                confetti.style.animationDelay = Math.random() * 2 + 's';
                confetti.style.animationDuration = (Math.random() * 2 + 2) + 's';
                document.body.appendChild(confetti);
                
                // Remove confetti after animation
                setTimeout(() => confetti.remove(), 5000);
            }
        }
        
        // Trigger confetti on page load
        window.addEventListener('load', createConfetti);
        
        // Download receipt
        function downloadReceipt() {
            // In a real implementation, this would generate a PDF receipt
            window.open('${pageContext.request.contextPath}/checkout/receipt/${transaction.transactionCode}', '_blank');
        }
        
        // Share purchase
        function sharePurchase() {
            if (navigator.share) {
                navigator.share({
                    title: 'Saya baru saja membeli kursus di NusaTech!',
                    text: 'Bergabunglah dengan saya untuk belajar bersama di NusaTech.',
                    url: '${pageContext.request.contextPath}/'
                });
            } else {
                // Fallback - copy link
                navigator.clipboard.writeText(window.location.origin + '${pageContext.request.contextPath}/');
                alert('Link berhasil disalin!');
            }
        }
    </script>
</body>
</html>
