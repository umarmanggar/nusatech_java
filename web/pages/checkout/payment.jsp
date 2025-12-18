<%-- 
    Document   : payment
    Created on : Dec 18, 2025
    Author     : NusaTech
    Description: Payment Instructions and Upload Proof Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pembayaran - NusaTech</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #8B1538;
            --primary-dark: #6d1029;
            --secondary: #D4A84B;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
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
        
        .progress-step.active {
            color: var(--primary);
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
        
        .progress-step.active .step-number {
            background: var(--primary);
            color: white;
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
        
        /* Payment Card */
        .payment-card {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            overflow: hidden;
        }
        
        .payment-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        
        .payment-method-icon {
            width: 80px;
            height: 80px;
            background: white;
            border-radius: 1rem;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
        }
        
        .payment-method-icon img {
            max-width: 60px;
            max-height: 40px;
            object-fit: contain;
        }
        
        .payment-header h4 {
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        
        .payment-header .amount {
            font-size: 2rem;
            font-weight: 800;
        }
        
        /* Countdown */
        .countdown-section {
            background: rgba(255,255,255,0.15);
            padding: 1rem;
            border-radius: 0.75rem;
            margin-top: 1.5rem;
        }
        
        .countdown-label {
            font-size: 0.85rem;
            opacity: 0.9;
            margin-bottom: 0.5rem;
        }
        
        .countdown-timer {
            font-size: 1.75rem;
            font-weight: 800;
            font-family: monospace;
        }
        
        .countdown-deadline {
            font-size: 0.8rem;
            opacity: 0.8;
            margin-top: 0.5rem;
        }
        
        /* Payment Body */
        .payment-body {
            padding: 2rem;
        }
        
        /* VA Section */
        .va-section {
            text-align: center;
            padding: 2rem;
            background: #f9fafb;
            border-radius: 0.75rem;
            margin-bottom: 1.5rem;
        }
        
        .va-label {
            font-size: 0.85rem;
            color: #6b7280;
            margin-bottom: 0.5rem;
        }
        
        .va-number {
            font-size: 2rem;
            font-weight: 800;
            font-family: monospace;
            color: #1f2937;
            letter-spacing: 2px;
        }
        
        .btn-copy {
            margin-top: 1rem;
            padding: 0.5rem 1.5rem;
        }
        
        .copy-feedback {
            display: none;
            color: var(--success);
            font-size: 0.85rem;
            margin-top: 0.5rem;
        }
        
        /* QRIS Section */
        .qris-section {
            text-align: center;
            padding: 2rem;
            background: #f9fafb;
            border-radius: 0.75rem;
            margin-bottom: 1.5rem;
        }
        
        .qris-code {
            width: 200px;
            height: 200px;
            background: white;
            border: 2px solid #e5e7eb;
            border-radius: 0.75rem;
            padding: 1rem;
            margin: 0 auto 1rem;
        }
        
        .qris-code img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }
        
        /* Instructions */
        .instructions-section {
            margin-bottom: 2rem;
        }
        
        .instructions-title {
            font-weight: 700;
            font-size: 1.1rem;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .instructions-list {
            padding-left: 0;
            list-style: none;
            counter-reset: step;
        }
        
        .instructions-list li {
            display: flex;
            gap: 1rem;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #f3f4f6;
        }
        
        .instructions-list li:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }
        
        .step-num {
            counter-increment: step;
            width: 28px;
            height: 28px;
            background: var(--primary);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.85rem;
            font-weight: 600;
            flex-shrink: 0;
        }
        
        .step-num::before {
            content: counter(step);
        }
        
        .step-text {
            flex: 1;
            line-height: 1.6;
            color: #374151;
        }
        
        /* Upload Proof Section */
        .upload-section {
            background: #f9fafb;
            border-radius: 0.75rem;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }
        
        .upload-title {
            font-weight: 700;
            font-size: 1rem;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .upload-dropzone {
            border: 2px dashed #d1d5db;
            border-radius: 0.75rem;
            padding: 2rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            background: white;
        }
        
        .upload-dropzone:hover {
            border-color: var(--primary);
            background: rgba(139, 21, 56, 0.02);
        }
        
        .upload-dropzone.dragover {
            border-color: var(--primary);
            background: rgba(139, 21, 56, 0.05);
        }
        
        .upload-dropzone.has-file {
            border-style: solid;
            border-color: var(--success);
        }
        
        .upload-icon {
            width: 60px;
            height: 60px;
            background: #e5e7eb;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
        }
        
        .upload-icon i {
            font-size: 1.5rem;
            color: #6b7280;
        }
        
        .upload-dropzone.has-file .upload-icon {
            background: rgba(16, 185, 129, 0.1);
        }
        
        .upload-dropzone.has-file .upload-icon i {
            color: var(--success);
        }
        
        .upload-text {
            color: #6b7280;
            margin-bottom: 0.5rem;
        }
        
        .upload-text strong {
            color: var(--primary);
        }
        
        .upload-hint {
            font-size: 0.8rem;
            color: #9ca3af;
        }
        
        .upload-preview {
            display: none;
            margin-top: 1rem;
        }
        
        .upload-preview img {
            max-width: 200px;
            max-height: 200px;
            border-radius: 0.5rem;
            border: 1px solid #e5e7eb;
        }
        
        .upload-preview .file-info {
            margin-top: 0.5rem;
            font-size: 0.85rem;
            color: #374151;
        }
        
        /* Status Check Section */
        .status-section {
            text-align: center;
            padding: 1.5rem;
            background: rgba(16, 185, 129, 0.05);
            border-radius: 0.75rem;
            border: 1px solid rgba(16, 185, 129, 0.2);
        }
        
        .status-section p {
            margin-bottom: 1rem;
            color: #374151;
        }
        
        /* Order Summary Sidebar */
        .order-summary {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            position: sticky;
            top: 100px;
        }
        
        .summary-header {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid #e5e7eb;
        }
        
        .summary-header h5 {
            font-weight: 700;
            margin-bottom: 0;
        }
        
        .summary-body {
            padding: 1.5rem;
        }
        
        .order-item {
            display: flex;
            gap: 0.75rem;
            padding: 0.75rem 0;
            border-bottom: 1px solid #f3f4f6;
        }
        
        .order-item:last-child {
            border-bottom: none;
        }
        
        .order-item-thumbnail {
            width: 60px;
            height: 40px;
            border-radius: 0.375rem;
            object-fit: cover;
        }
        
        .order-item-title {
            font-size: 0.85rem;
            font-weight: 500;
            color: #374151;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .summary-divider {
            border-top: 1px dashed #e5e7eb;
            margin: 1rem 0;
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }
        
        .summary-total {
            display: flex;
            justify-content: space-between;
            font-weight: 700;
            font-size: 1.1rem;
            color: var(--primary);
        }
        
        /* Transaction Info */
        .transaction-info {
            background: #f9fafb;
            border-radius: 0.5rem;
            padding: 1rem;
            margin-top: 1rem;
        }
        
        .transaction-info-row {
            display: flex;
            justify-content: space-between;
            font-size: 0.85rem;
            margin-bottom: 0.5rem;
        }
        
        .transaction-info-row:last-child {
            margin-bottom: 0;
        }
        
        .transaction-info-label {
            color: #6b7280;
        }
        
        .transaction-info-value {
            font-weight: 500;
            color: #374151;
        }
        
        /* Help Section */
        .help-section {
            margin-top: 1.5rem;
            padding: 1rem;
            background: rgba(245, 158, 11, 0.1);
            border-radius: 0.75rem;
            border: 1px solid rgba(245, 158, 11, 0.3);
        }
        
        .help-section p {
            font-size: 0.85rem;
            color: #92400e;
            margin-bottom: 0.5rem;
        }
        
        .help-section a {
            font-weight: 600;
            color: var(--primary);
        }
        
        /* Responsive */
        @media (max-width: 991.98px) {
            .order-summary {
                position: static;
                margin-bottom: 2rem;
            }
            
            .progress-steps {
                gap: 1rem;
            }
            
            .step-connector {
                width: 30px;
            }
        }
        
        @media (max-width: 575.98px) {
            .va-number {
                font-size: 1.5rem;
            }
            
            .payment-header .amount {
                font-size: 1.5rem;
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
                <div class="progress-step active">
                    <div class="step-number">3</div>
                    <span class="step-label d-none d-md-inline">Pembayaran</span>
                </div>
                <div class="step-connector"></div>
                <div class="progress-step">
                    <div class="step-number">4</div>
                    <span class="step-label d-none d-md-inline">Selesai</span>
                </div>
            </div>
        </div>
    </div>
    
    <main class="container pb-5">
        <div class="row">
            <!-- Order Summary Sidebar (mobile first) -->
            <div class="col-lg-4 order-lg-2">
                <div class="order-summary">
                    <div class="summary-header">
                        <h5><i class="fas fa-receipt me-2"></i>Detail Pesanan</h5>
                    </div>
                    <div class="summary-body">
                        <c:forEach var="item" items="${orderItems}">
                            <div class="order-item">
                                <img src="${not empty item.course.thumbnail ? item.course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=60&h=40&fit=crop'}" 
                                     alt="${item.course.title}" class="order-item-thumbnail">
                                <div class="order-item-title">${item.course.title}</div>
                            </div>
                        </c:forEach>
                        
                        <div class="summary-divider"></div>
                        
                        <div class="summary-row">
                            <span>Subtotal</span>
                            <span><fmt:formatNumber value="${subtotal}" type="currency" currencySymbol="Rp " maxFractionDigits="0"/></span>
                        </div>
                        
                        <c:if test="${discount > 0}">
                            <div class="summary-row" style="color: var(--success)">
                                <span>Diskon</span>
                                <span>-<fmt:formatNumber value="${discount}" type="currency" currencySymbol="Rp " maxFractionDigits="0"/></span>
                            </div>
                        </c:if>
                        
                        <div class="summary-divider"></div>
                        
                        <div class="summary-total">
                            <span>Total</span>
                            <span><fmt:formatNumber value="${total}" type="currency" currencySymbol="Rp " maxFractionDigits="0"/></span>
                        </div>
                        
                        <div class="transaction-info">
                            <div class="transaction-info-row">
                                <span class="transaction-info-label">No. Transaksi</span>
                                <span class="transaction-info-value">${transaction.transactionCode}</span>
                            </div>
                            <div class="transaction-info-row">
                                <span class="transaction-info-label">Tanggal</span>
                                <span class="transaction-info-value">
                                    <fmt:formatDate value="${transaction.createdAt}" pattern="dd MMM yyyy, HH:mm"/>
                                </span>
                            </div>
                            <div class="transaction-info-row">
                                <span class="transaction-info-label">Status</span>
                                <span class="transaction-info-value">
                                    <span class="badge bg-warning">Menunggu Pembayaran</span>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="help-section">
                    <p><i class="fas fa-headset me-1"></i> Butuh bantuan?</p>
                    <p class="mb-0">
                        Hubungi kami di <a href="mailto:support@nusatech.id">support@nusatech.id</a><br>
                        atau <a href="https://wa.me/6281234567890" target="_blank">WhatsApp</a>
                    </p>
                </div>
            </div>
            
            <!-- Payment Content -->
            <div class="col-lg-8 order-lg-1">
                <div class="payment-card">
                    <div class="payment-header">
                        <div class="payment-method-icon">
                            <c:choose>
                                <c:when test="${paymentMethod == 'bca'}">
                                    <img src="https://upload.wikimedia.org/wikipedia/commons/5/5c/Bank_Central_Asia.svg" alt="BCA">
                                </c:when>
                                <c:when test="${paymentMethod == 'bni'}">
                                    <img src="https://upload.wikimedia.org/wikipedia/id/5/55/BNI_logo.svg" alt="BNI">
                                </c:when>
                                <c:when test="${paymentMethod == 'bri'}">
                                    <img src="https://upload.wikimedia.org/wikipedia/commons/6/68/BANK_BRI_logo.svg" alt="BRI">
                                </c:when>
                                <c:when test="${paymentMethod == 'mandiri'}">
                                    <img src="https://upload.wikimedia.org/wikipedia/commons/a/ad/Bank_Mandiri_logo_2016.svg" alt="Mandiri">
                                </c:when>
                                <c:when test="${paymentMethod == 'gopay'}">
                                    <img src="https://upload.wikimedia.org/wikipedia/commons/8/86/Gopay_logo.svg" alt="GoPay">
                                </c:when>
                                <c:when test="${paymentMethod == 'ovo'}">
                                    <img src="https://upload.wikimedia.org/wikipedia/commons/e/eb/Logo_ovo_purple.svg" alt="OVO">
                                </c:when>
                                <c:when test="${paymentMethod == 'dana'}">
                                    <img src="https://upload.wikimedia.org/wikipedia/commons/7/72/Logo_dana_blue.svg" alt="DANA">
                                </c:when>
                                <c:when test="${paymentMethod == 'shopeepay'}">
                                    <img src="https://upload.wikimedia.org/wikipedia/commons/e/eb/ShopeePay_logo.svg" alt="ShopeePay">
                                </c:when>
                                <c:when test="${paymentMethod == 'qris'}">
                                    <img src="https://upload.wikimedia.org/wikipedia/commons/a/a2/Logo_QRIS.svg" alt="QRIS">
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-credit-card fa-2x text-primary"></i>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <h4>
                            <c:choose>
                                <c:when test="${paymentMethod == 'bca'}">Transfer Bank BCA</c:when>
                                <c:when test="${paymentMethod == 'bni'}">Transfer Bank BNI</c:when>
                                <c:when test="${paymentMethod == 'bri'}">Transfer Bank BRI</c:when>
                                <c:when test="${paymentMethod == 'mandiri'}">Transfer Bank Mandiri</c:when>
                                <c:when test="${paymentMethod == 'gopay'}">GoPay</c:when>
                                <c:when test="${paymentMethod == 'ovo'}">OVO</c:when>
                                <c:when test="${paymentMethod == 'dana'}">DANA</c:when>
                                <c:when test="${paymentMethod == 'shopeepay'}">ShopeePay</c:when>
                                <c:when test="${paymentMethod == 'qris'}">QRIS</c:when>
                                <c:otherwise>Pembayaran</c:otherwise>
                            </c:choose>
                        </h4>
                        <div class="amount">
                            <fmt:formatNumber value="${total}" type="currency" currencySymbol="Rp " maxFractionDigits="0"/>
                        </div>
                        
                        <div class="countdown-section">
                            <div class="countdown-label">Selesaikan pembayaran dalam:</div>
                            <div class="countdown-timer" id="countdown">23:59:59</div>
                            <div class="countdown-deadline">
                                Batas waktu: <fmt:formatDate value="${paymentDeadline}" pattern="dd MMMM yyyy, HH:mm"/>
                            </div>
                        </div>
                    </div>
                    
                    <div class="payment-body">
                        <!-- Bank Transfer - VA Number -->
                        <c:if test="${paymentMethod == 'bca' || paymentMethod == 'bni' || paymentMethod == 'bri' || paymentMethod == 'mandiri'}">
                            <div class="va-section">
                                <div class="va-label">Nomor Virtual Account</div>
                                <div class="va-number" id="vaNumber">${virtualAccountNumber}</div>
                                <button class="btn btn-outline-primary btn-copy" onclick="copyVA()">
                                    <i class="fas fa-copy me-1"></i> Salin Nomor
                                </button>
                                <div class="copy-feedback" id="copyFeedback">
                                    <i class="fas fa-check-circle me-1"></i> Nomor berhasil disalin!
                                </div>
                            </div>
                            
                            <div class="instructions-section">
                                <h6 class="instructions-title">
                                    <i class="fas fa-list-ol text-primary"></i>
                                    Cara Pembayaran
                                </h6>
                                
                                <ul class="nav nav-tabs mb-3" id="paymentInstructionTabs" role="tablist">
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link active" id="atm-tab" data-bs-toggle="tab" data-bs-target="#atm" type="button">ATM</button>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link" id="mbanking-tab" data-bs-toggle="tab" data-bs-target="#mbanking" type="button">Mobile Banking</button>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link" id="ibanking-tab" data-bs-toggle="tab" data-bs-target="#ibanking" type="button">Internet Banking</button>
                                    </li>
                                </ul>
                                
                                <div class="tab-content" id="paymentInstructionTabsContent">
                                    <div class="tab-pane fade show active" id="atm" role="tabpanel">
                                        <ol class="instructions-list">
                                            <li>
                                                <span class="step-num"></span>
                                                <span class="step-text">Masukkan kartu ATM dan PIN Anda</span>
                                            </li>
                                            <li>
                                                <span class="step-num"></span>
                                                <span class="step-text">Pilih menu <strong>Transaksi Lainnya</strong> > <strong>Transfer</strong> > <strong>Virtual Account</strong></span>
                                            </li>
                                            <li>
                                                <span class="step-num"></span>
                                                <span class="step-text">Masukkan nomor Virtual Account: <strong>${virtualAccountNumber}</strong></span>
                                            </li>
                                            <li>
                                                <span class="step-num"></span>
                                                <span class="step-text">Pastikan nama dan jumlah pembayaran sudah benar</span>
                                            </li>
                                            <li>
                                                <span class="step-num"></span>
                                                <span class="step-text">Konfirmasi pembayaran Anda</span>
                                            </li>
                                            <li>
                                                <span class="step-num"></span>
                                                <span class="step-text">Simpan struk sebagai bukti pembayaran</span>
                                            </li>
                                        </ol>
                                    </div>
                                    <div class="tab-pane fade" id="mbanking" role="tabpanel">
                                        <ol class="instructions-list">
                                            <li>
                                                <span class="step-num"></span>
                                                <span class="step-text">Buka aplikasi mobile banking Anda</span>
                                            </li>
                                            <li>
                                                <span class="step-num"></span>
                                                <span class="step-text">Pilih menu <strong>Transfer</strong> > <strong>Virtual Account</strong></span>
                                            </li>
                                            <li>
                                                <span class="step-num"></span>
                                                <span class="step-text">Masukkan nomor Virtual Account: <strong>${virtualAccountNumber}</strong></span>
                                            </li>
                                            <li>
                                                <span class="step-num"></span>
                                                <span class="step-text">Masukkan PIN mobile banking Anda</span>
                                            </li>
                                            <li>
                                                <span class="step-num"></span>
                                                <span class="step-text">Pembayaran selesai, simpan bukti transaksi</span>
                                            </li>
                                        </ol>
                                    </div>
                                    <div class="tab-pane fade" id="ibanking" role="tabpanel">
                                        <ol class="instructions-list">
                                            <li>
                                                <span class="step-num"></span>
                                                <span class="step-text">Login ke internet banking Anda</span>
                                            </li>
                                            <li>
                                                <span class="step-num"></span>
                                                <span class="step-text">Pilih menu <strong>Transfer</strong> > <strong>Virtual Account Billing</strong></span>
                                            </li>
                                            <li>
                                                <span class="step-num"></span>
                                                <span class="step-text">Masukkan nomor Virtual Account: <strong>${virtualAccountNumber}</strong></span>
                                            </li>
                                            <li>
                                                <span class="step-num"></span>
                                                <span class="step-text">Verifikasi dengan token/OTP</span>
                                            </li>
                                            <li>
                                                <span class="step-num"></span>
                                                <span class="step-text">Pembayaran selesai, simpan bukti transaksi</span>
                                            </li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        
                        <!-- E-Wallet / QRIS -->
                        <c:if test="${paymentMethod == 'gopay' || paymentMethod == 'ovo' || paymentMethod == 'dana' || paymentMethod == 'shopeepay' || paymentMethod == 'qris'}">
                            <div class="qris-section">
                                <div class="qris-code">
                                    <img src="${qrCodeUrl}" alt="QR Code" id="qrCode">
                                </div>
                                <p class="text-muted small mb-2">Scan QR code dengan aplikasi ${paymentMethod == 'qris' ? 'e-wallet atau mobile banking' : paymentMethodName}</p>
                                <button class="btn btn-outline-primary btn-sm" onclick="downloadQR()">
                                    <i class="fas fa-download me-1"></i> Download QR
                                </button>
                            </div>
                            
                            <div class="instructions-section">
                                <h6 class="instructions-title">
                                    <i class="fas fa-list-ol text-primary"></i>
                                    Cara Pembayaran
                                </h6>
                                <ol class="instructions-list">
                                    <li>
                                        <span class="step-num"></span>
                                        <span class="step-text">Buka aplikasi ${paymentMethod == 'qris' ? 'e-wallet atau mobile banking' : paymentMethodName} Anda</span>
                                    </li>
                                    <li>
                                        <span class="step-num"></span>
                                        <span class="step-text">Pilih menu <strong>Scan</strong> atau <strong>Bayar</strong></span>
                                    </li>
                                    <li>
                                        <span class="step-num"></span>
                                        <span class="step-text">Scan QR Code yang ditampilkan di atas</span>
                                    </li>
                                    <li>
                                        <span class="step-num"></span>
                                        <span class="step-text">Pastikan jumlah pembayaran sudah benar</span>
                                    </li>
                                    <li>
                                        <span class="step-num"></span>
                                        <span class="step-text">Masukkan PIN dan konfirmasi pembayaran</span>
                                    </li>
                                    <li>
                                        <span class="step-num"></span>
                                        <span class="step-text">Pembayaran selesai! Anda akan diarahkan otomatis</span>
                                    </li>
                                </ol>
                            </div>
                        </c:if>
                        
                        <!-- Upload Proof (for Bank Transfer) -->
                        <c:if test="${paymentMethod == 'bca' || paymentMethod == 'bni' || paymentMethod == 'bri' || paymentMethod == 'mandiri'}">
                            <div class="upload-section">
                                <h6 class="upload-title">
                                    <i class="fas fa-upload text-primary"></i>
                                    Upload Bukti Transfer (Opsional)
                                </h6>
                                <p class="text-muted small mb-3">
                                    Pembayaran akan diverifikasi otomatis. Upload bukti transfer untuk mempercepat proses verifikasi.
                                </p>
                                
                                <form id="uploadForm" enctype="multipart/form-data">
                                    <input type="hidden" name="transactionId" value="${transaction.transactionId}">
                                    <input type="file" id="proofFile" name="proofFile" accept="image/*" style="display:none" onchange="handleFileSelect(this)">
                                    
                                    <div class="upload-dropzone" id="uploadDropzone" onclick="document.getElementById('proofFile').click()">
                                        <div class="upload-icon">
                                            <i class="fas fa-cloud-upload-alt"></i>
                                        </div>
                                        <p class="upload-text">
                                            <strong>Klik untuk upload</strong> atau drag & drop file disini
                                        </p>
                                        <p class="upload-hint">PNG, JPG atau JPEG (Maks. 5MB)</p>
                                        
                                        <div class="upload-preview" id="uploadPreview">
                                            <img src="" alt="Preview" id="previewImage">
                                            <div class="file-info" id="fileInfo"></div>
                                        </div>
                                    </div>
                                    
                                    <button type="submit" class="btn btn-primary w-100 mt-3" id="uploadBtn" style="display:none">
                                        <i class="fas fa-upload me-1"></i> Upload Bukti Transfer
                                    </button>
                                </form>
                            </div>
                        </c:if>
                        
                        <!-- Check Status -->
                        <div class="status-section">
                            <p><i class="fas fa-info-circle me-1"></i> Sudah melakukan pembayaran?</p>
                            <button class="btn btn-primary" onclick="checkPaymentStatus()">
                                <i class="fas fa-sync-alt me-1"></i> Cek Status Pembayaran
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    
    <!-- Status Modal -->
    <div class="modal fade" id="statusModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body text-center py-4">
                    <div id="statusLoading">
                        <div class="spinner-border text-primary mb-3" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                        <p>Mengecek status pembayaran...</p>
                    </div>
                    <div id="statusResult" style="display:none">
                        <div class="status-icon mb-3" id="statusIcon"></div>
                        <h5 id="statusTitle"></h5>
                        <p class="text-muted" id="statusMessage"></p>
                        <button class="btn btn-primary" id="statusAction" style="display:none"></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Copy VA number
        function copyVA() {
            const vaNumber = document.getElementById('vaNumber').textContent;
            navigator.clipboard.writeText(vaNumber).then(() => {
                const feedback = document.getElementById('copyFeedback');
                feedback.style.display = 'block';
                setTimeout(() => feedback.style.display = 'none', 2000);
            });
        }
        
        // Countdown timer
        const deadline = new Date('${paymentDeadlineISO}').getTime();
        
        function updateCountdown() {
            const now = new Date().getTime();
            const distance = deadline - now;
            
            if (distance < 0) {
                document.getElementById('countdown').textContent = '00:00:00';
                document.getElementById('countdown').style.color = '#ef4444';
                alert('Waktu pembayaran telah habis. Silakan buat transaksi baru.');
                window.location = '${pageContext.request.contextPath}/cart';
                return;
            }
            
            const hours = Math.floor(distance / (1000 * 60 * 60));
            const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
            const seconds = Math.floor((distance % (1000 * 60)) / 1000);
            
            document.getElementById('countdown').textContent = 
                String(hours).padStart(2, '0') + ':' + 
                String(minutes).padStart(2, '0') + ':' + 
                String(seconds).padStart(2, '0');
            
            if (distance < 3600000) { // Less than 1 hour
                document.getElementById('countdown').style.color = '#fbbf24';
            }
            if (distance < 600000) { // Less than 10 minutes
                document.getElementById('countdown').style.color = '#ef4444';
            }
        }
        
        setInterval(updateCountdown, 1000);
        updateCountdown();
        
        // File upload
        const dropzone = document.getElementById('uploadDropzone');
        
        if (dropzone) {
            dropzone.addEventListener('dragover', (e) => {
                e.preventDefault();
                dropzone.classList.add('dragover');
            });
            
            dropzone.addEventListener('dragleave', () => {
                dropzone.classList.remove('dragover');
            });
            
            dropzone.addEventListener('drop', (e) => {
                e.preventDefault();
                dropzone.classList.remove('dragover');
                const files = e.dataTransfer.files;
                if (files.length > 0) {
                    document.getElementById('proofFile').files = files;
                    handleFileSelect(document.getElementById('proofFile'));
                }
            });
        }
        
        function handleFileSelect(input) {
            const file = input.files[0];
            if (!file) return;
            
            // Validate file
            const maxSize = 5 * 1024 * 1024; // 5MB
            const allowedTypes = ['image/png', 'image/jpeg', 'image/jpg'];
            
            if (!allowedTypes.includes(file.type)) {
                alert('Format file tidak valid. Gunakan PNG, JPG, atau JPEG.');
                input.value = '';
                return;
            }
            
            if (file.size > maxSize) {
                alert('Ukuran file terlalu besar. Maksimal 5MB.');
                input.value = '';
                return;
            }
            
            // Show preview
            const reader = new FileReader();
            reader.onload = (e) => {
                document.getElementById('previewImage').src = e.target.result;
                document.getElementById('uploadPreview').style.display = 'block';
                document.getElementById('fileInfo').textContent = file.name + ' (' + (file.size / 1024).toFixed(1) + ' KB)';
                document.getElementById('uploadDropzone').classList.add('has-file');
                document.getElementById('uploadBtn').style.display = 'block';
            };
            reader.readAsDataURL(file);
        }
        
        // Upload form
        document.getElementById('uploadForm')?.addEventListener('submit', function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            const btn = document.getElementById('uploadBtn');
            btn.disabled = true;
            btn.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span> Mengupload...';
            
            fetch('${pageContext.request.contextPath}/checkout/upload-proof', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Bukti transfer berhasil diupload. Kami akan memverifikasi pembayaran Anda.');
                    btn.innerHTML = '<i class="fas fa-check me-1"></i> Berhasil Diupload';
                    btn.classList.remove('btn-primary');
                    btn.classList.add('btn-success');
                } else {
                    alert('Gagal mengupload: ' + data.message);
                    btn.disabled = false;
                    btn.innerHTML = '<i class="fas fa-upload me-1"></i> Upload Bukti Transfer';
                }
            })
            .catch(error => {
                alert('Terjadi kesalahan. Silakan coba lagi.');
                btn.disabled = false;
                btn.innerHTML = '<i class="fas fa-upload me-1"></i> Upload Bukti Transfer';
            });
        });
        
        // Check payment status
        function checkPaymentStatus() {
            const modal = new bootstrap.Modal(document.getElementById('statusModal'));
            modal.show();
            
            document.getElementById('statusLoading').style.display = 'block';
            document.getElementById('statusResult').style.display = 'none';
            
            fetch('${pageContext.request.contextPath}/checkout/check-status/${transaction.transactionCode}')
            .then(response => response.json())
            .then(data => {
                document.getElementById('statusLoading').style.display = 'none';
                document.getElementById('statusResult').style.display = 'block';
                
                const statusIcon = document.getElementById('statusIcon');
                const statusTitle = document.getElementById('statusTitle');
                const statusMessage = document.getElementById('statusMessage');
                const statusAction = document.getElementById('statusAction');
                
                if (data.status === 'PAID') {
                    statusIcon.innerHTML = '<i class="fas fa-check-circle text-success" style="font-size:4rem"></i>';
                    statusTitle.textContent = 'Pembayaran Berhasil!';
                    statusMessage.textContent = 'Terima kasih! Pembayaran Anda telah dikonfirmasi.';
                    statusAction.style.display = 'block';
                    statusAction.textContent = 'Mulai Belajar';
                    statusAction.onclick = () => window.location = '${pageContext.request.contextPath}/checkout/success/${transaction.transactionCode}';
                } else if (data.status === 'PENDING') {
                    statusIcon.innerHTML = '<i class="fas fa-clock text-warning" style="font-size:4rem"></i>';
                    statusTitle.textContent = 'Menunggu Pembayaran';
                    statusMessage.textContent = 'Pembayaran belum diterima. Pastikan Anda telah menyelesaikan pembayaran.';
                    statusAction.style.display = 'none';
                } else {
                    statusIcon.innerHTML = '<i class="fas fa-times-circle text-danger" style="font-size:4rem"></i>';
                    statusTitle.textContent = 'Pembayaran Gagal';
                    statusMessage.textContent = data.message || 'Terjadi kesalahan. Silakan coba lagi atau hubungi customer service.';
                    statusAction.style.display = 'block';
                    statusAction.textContent = 'Coba Lagi';
                    statusAction.onclick = () => modal.hide();
                }
            })
            .catch(error => {
                document.getElementById('statusLoading').style.display = 'none';
                document.getElementById('statusResult').style.display = 'block';
                document.getElementById('statusIcon').innerHTML = '<i class="fas fa-exclamation-circle text-danger" style="font-size:4rem"></i>';
                document.getElementById('statusTitle').textContent = 'Terjadi Kesalahan';
                document.getElementById('statusMessage').textContent = 'Tidak dapat mengecek status. Silakan coba lagi.';
            });
        }
        
        // Download QR
        function downloadQR() {
            const link = document.createElement('a');
            link.download = 'qrcode-${transaction.transactionCode}.png';
            link.href = document.getElementById('qrCode').src;
            link.click();
        }
        
        // Auto check payment status every 30 seconds
        setInterval(() => {
            fetch('${pageContext.request.contextPath}/checkout/check-status/${transaction.transactionCode}')
            .then(response => response.json())
            .then(data => {
                if (data.status === 'PAID') {
                    window.location = '${pageContext.request.contextPath}/checkout/success/${transaction.transactionCode}';
                }
            });
        }, 30000);
    </script>
</body>
</html>
