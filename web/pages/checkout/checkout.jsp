<%-- 
    Document   : checkout
    Created on : Dec 18, 2025
    Author     : NusaTech
    Description: Checkout Page with Payment Method Selection
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - NusaTech</title>
    
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
        
        /* Navbar */
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
        .btn-primary:disabled { background-color: #9ca3af; border-color: #9ca3af; }
        .btn-outline-primary { color: var(--primary); border-color: var(--primary); }
        .btn-outline-primary:hover { background-color: var(--primary); border-color: var(--primary); }
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
        
        .step-label {
            font-weight: 500;
            font-size: 0.9rem;
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
        
        /* Section Cards */
        .checkout-section {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            margin-bottom: 1.5rem;
            overflow: hidden;
        }
        
        .section-header {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid #e5e7eb;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .section-header h5 {
            font-weight: 700;
            margin-bottom: 0;
            color: #1f2937;
        }
        
        .section-header .badge {
            font-size: 0.75rem;
        }
        
        .section-body {
            padding: 1.5rem;
        }
        
        /* Order Items */
        .order-item {
            display: flex;
            gap: 1rem;
            padding: 1rem 0;
            border-bottom: 1px solid #f3f4f6;
        }
        
        .order-item:last-child {
            border-bottom: none;
        }
        
        .order-item-thumbnail {
            width: 80px;
            height: 55px;
            border-radius: 0.5rem;
            object-fit: cover;
        }
        
        .order-item-info {
            flex: 1;
        }
        
        .order-item-title {
            font-weight: 600;
            color: #1f2937;
            font-size: 0.95rem;
            margin-bottom: 0.25rem;
        }
        
        .order-item-instructor {
            font-size: 0.8rem;
            color: #6b7280;
        }
        
        .order-item-price {
            font-weight: 700;
            color: var(--primary);
        }
        
        /* Payment Methods */
        .payment-methods {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }
        
        .payment-method-group {
            border: 1px solid #e5e7eb;
            border-radius: 0.75rem;
            overflow: hidden;
        }
        
        .payment-method-group-header {
            background: #f8f9fa;
            padding: 0.75rem 1rem;
            font-weight: 600;
            color: #374151;
            font-size: 0.9rem;
        }
        
        .payment-option {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem 1.25rem;
            border-bottom: 1px solid #f3f4f6;
            cursor: pointer;
            transition: background 0.2s;
        }
        
        .payment-option:last-child {
            border-bottom: none;
        }
        
        .payment-option:hover {
            background: #fafafa;
        }
        
        .payment-option.selected {
            background: rgba(139, 21, 56, 0.05);
            border-left: 3px solid var(--primary);
        }
        
        .payment-option input[type="radio"] {
            display: none;
        }
        
        .payment-radio {
            width: 20px;
            height: 20px;
            border: 2px solid #d1d5db;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }
        
        .payment-option.selected .payment-radio {
            border-color: var(--primary);
        }
        
        .payment-radio::after {
            content: '';
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background: var(--primary);
            display: none;
        }
        
        .payment-option.selected .payment-radio::after {
            display: block;
        }
        
        .payment-logo {
            width: 60px;
            height: 30px;
            object-fit: contain;
        }
        
        .payment-info {
            flex: 1;
        }
        
        .payment-name {
            font-weight: 600;
            color: #1f2937;
            font-size: 0.95rem;
        }
        
        .payment-desc {
            font-size: 0.8rem;
            color: #6b7280;
        }
        
        .payment-fee {
            font-size: 0.85rem;
            color: #9ca3af;
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
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.75rem;
            font-size: 0.95rem;
        }
        
        .summary-row.discount {
            color: var(--success);
        }
        
        .summary-divider {
            border-top: 1px dashed #e5e7eb;
            margin: 1rem 0;
        }
        
        .summary-total {
            display: flex;
            justify-content: space-between;
            font-size: 1.25rem;
            font-weight: 700;
            color: #1f2937;
        }
        
        /* Promo Applied */
        .promo-applied-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
            padding: 0.5rem 0.75rem;
            border-radius: 0.5rem;
            font-size: 0.85rem;
            font-weight: 500;
            margin-bottom: 1rem;
        }
        
        /* Terms */
        .terms-section {
            padding: 1rem 1.5rem;
            background: #f9fafb;
            border-top: 1px solid #e5e7eb;
        }
        
        .form-check-input:checked {
            background-color: var(--primary);
            border-color: var(--primary);
        }
        
        .terms-section a {
            color: var(--primary);
        }
        
        /* Pay Button */
        .btn-pay {
            width: 100%;
            padding: 1rem;
            font-size: 1.1rem;
            font-weight: 600;
        }
        
        /* Security Badge */
        .security-badge {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 1rem;
            background: #f9fafb;
            border-radius: 0 0 1rem 1rem;
            color: #6b7280;
            font-size: 0.85rem;
        }
        
        .security-badge i {
            color: var(--success);
        }
        
        /* Timer Warning */
        .timer-warning {
            background: #fef3c7;
            border: 1px solid #fcd34d;
            border-radius: 0.75rem;
            padding: 1rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1.5rem;
        }
        
        .timer-warning i {
            color: #f59e0b;
            font-size: 1.25rem;
        }
        
        .timer-warning-text {
            flex: 1;
            font-size: 0.9rem;
            color: #92400e;
        }
        
        .timer-countdown {
            font-weight: 700;
            color: #b45309;
            font-size: 1.1rem;
        }
        
        /* Responsive */
        @media (max-width: 991.98px) {
            .order-summary {
                position: static;
                margin-top: 2rem;
            }
            
            .progress-steps {
                gap: 1rem;
            }
            
            .step-connector {
                width: 30px;
            }
            
            .step-label {
                display: none;
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
            <div class="d-flex align-items-center gap-3">
                <a href="${pageContext.request.contextPath}/cart" class="btn btn-sm btn-outline-secondary">
                    <i class="fas fa-arrow-left me-1"></i> Kembali ke Keranjang
                </a>
            </div>
        </div>
    </nav>
    
    <!-- Progress Steps -->
    <div class="checkout-progress">
        <div class="container">
            <div class="progress-steps">
                <div class="progress-step completed">
                    <div class="step-number"><i class="fas fa-check"></i></div>
                    <span class="step-label">Keranjang</span>
                </div>
                <div class="step-connector completed"></div>
                <div class="progress-step active">
                    <div class="step-number">2</div>
                    <span class="step-label">Checkout</span>
                </div>
                <div class="step-connector"></div>
                <div class="progress-step">
                    <div class="step-number">3</div>
                    <span class="step-label">Pembayaran</span>
                </div>
                <div class="step-connector"></div>
                <div class="progress-step">
                    <div class="step-number">4</div>
                    <span class="step-label">Selesai</span>
                </div>
            </div>
        </div>
    </div>
    
    <main class="container pb-5">
        <!-- Timer Warning -->
        <div class="timer-warning">
            <i class="fas fa-clock"></i>
            <div class="timer-warning-text">
                Selesaikan pembayaran dalam waktu <span class="timer-countdown" id="countdown">15:00</span> untuk mengamankan harga promo.
            </div>
        </div>
        
        <form action="${pageContext.request.contextPath}/checkout/process" method="POST" id="checkoutForm">
            <div class="row">
                <!-- Main Content -->
                <div class="col-lg-8">
                    <!-- Order Summary -->
                    <div class="checkout-section">
                        <div class="section-header">
                            <i class="fas fa-shopping-bag text-primary"></i>
                            <h5>Pesanan Anda</h5>
                            <span class="badge bg-primary">${cartItems.size()} Kursus</span>
                        </div>
                        <div class="section-body">
                            <c:forEach var="item" items="${cartItems}">
                                <div class="order-item">
                                    <img src="${not empty item.course.thumbnail ? item.course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=80&h=55&fit=crop'}" 
                                         alt="${item.course.title}" class="order-item-thumbnail">
                                    <div class="order-item-info">
                                        <div class="order-item-title">${item.course.title}</div>
                                        <div class="order-item-instructor">
                                            <i class="fas fa-user-tie me-1"></i> ${item.course.instructor.fullName}
                                        </div>
                                    </div>
                                    <div class="order-item-price">
                                        <fmt:formatNumber value="${item.course.discountPrice != null ? item.course.discountPrice : item.course.price}" 
                                                          type="currency" currencySymbol="Rp " maxFractionDigits="0"/>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    
                    <!-- Payment Method -->
                    <div class="checkout-section">
                        <div class="section-header">
                            <i class="fas fa-credit-card text-primary"></i>
                            <h5>Metode Pembayaran</h5>
                        </div>
                        <div class="section-body">
                            <div class="payment-methods">
                                <!-- Bank Transfer -->
                                <div class="payment-method-group">
                                    <div class="payment-method-group-header">
                                        <i class="fas fa-university me-2"></i> Transfer Bank
                                    </div>
                                    
                                    <label class="payment-option" onclick="selectPayment(this)">
                                        <input type="radio" name="paymentMethod" value="bca" required>
                                        <span class="payment-radio"></span>
                                        <img src="https://upload.wikimedia.org/wikipedia/commons/5/5c/Bank_Central_Asia.svg" alt="BCA" class="payment-logo">
                                        <div class="payment-info">
                                            <div class="payment-name">Bank BCA</div>
                                            <div class="payment-desc">Virtual Account</div>
                                        </div>
                                        <span class="payment-fee">Gratis</span>
                                    </label>
                                    
                                    <label class="payment-option" onclick="selectPayment(this)">
                                        <input type="radio" name="paymentMethod" value="bni">
                                        <span class="payment-radio"></span>
                                        <img src="https://upload.wikimedia.org/wikipedia/id/5/55/BNI_logo.svg" alt="BNI" class="payment-logo">
                                        <div class="payment-info">
                                            <div class="payment-name">Bank BNI</div>
                                            <div class="payment-desc">Virtual Account</div>
                                        </div>
                                        <span class="payment-fee">Gratis</span>
                                    </label>
                                    
                                    <label class="payment-option" onclick="selectPayment(this)">
                                        <input type="radio" name="paymentMethod" value="bri">
                                        <span class="payment-radio"></span>
                                        <img src="https://upload.wikimedia.org/wikipedia/commons/6/68/BANK_BRI_logo.svg" alt="BRI" class="payment-logo">
                                        <div class="payment-info">
                                            <div class="payment-name">Bank BRI</div>
                                            <div class="payment-desc">Virtual Account</div>
                                        </div>
                                        <span class="payment-fee">Gratis</span>
                                    </label>
                                    
                                    <label class="payment-option" onclick="selectPayment(this)">
                                        <input type="radio" name="paymentMethod" value="mandiri">
                                        <span class="payment-radio"></span>
                                        <img src="https://upload.wikimedia.org/wikipedia/commons/a/ad/Bank_Mandiri_logo_2016.svg" alt="Mandiri" class="payment-logo">
                                        <div class="payment-info">
                                            <div class="payment-name">Bank Mandiri</div>
                                            <div class="payment-desc">Virtual Account</div>
                                        </div>
                                        <span class="payment-fee">Gratis</span>
                                    </label>
                                </div>
                                
                                <!-- E-Wallet -->
                                <div class="payment-method-group">
                                    <div class="payment-method-group-header">
                                        <i class="fas fa-wallet me-2"></i> E-Wallet
                                    </div>
                                    
                                    <label class="payment-option" onclick="selectPayment(this)">
                                        <input type="radio" name="paymentMethod" value="gopay">
                                        <span class="payment-radio"></span>
                                        <img src="https://upload.wikimedia.org/wikipedia/commons/8/86/Gopay_logo.svg" alt="GoPay" class="payment-logo">
                                        <div class="payment-info">
                                            <div class="payment-name">GoPay</div>
                                            <div class="payment-desc">Scan QR Code</div>
                                        </div>
                                        <span class="payment-fee">Gratis</span>
                                    </label>
                                    
                                    <label class="payment-option" onclick="selectPayment(this)">
                                        <input type="radio" name="paymentMethod" value="ovo">
                                        <span class="payment-radio"></span>
                                        <img src="https://upload.wikimedia.org/wikipedia/commons/e/eb/Logo_ovo_purple.svg" alt="OVO" class="payment-logo">
                                        <div class="payment-info">
                                            <div class="payment-name">OVO</div>
                                            <div class="payment-desc">Push notification ke app</div>
                                        </div>
                                        <span class="payment-fee">Gratis</span>
                                    </label>
                                    
                                    <label class="payment-option" onclick="selectPayment(this)">
                                        <input type="radio" name="paymentMethod" value="dana">
                                        <span class="payment-radio"></span>
                                        <img src="https://upload.wikimedia.org/wikipedia/commons/7/72/Logo_dana_blue.svg" alt="DANA" class="payment-logo">
                                        <div class="payment-info">
                                            <div class="payment-name">DANA</div>
                                            <div class="payment-desc">Push notification ke app</div>
                                        </div>
                                        <span class="payment-fee">Gratis</span>
                                    </label>
                                    
                                    <label class="payment-option" onclick="selectPayment(this)">
                                        <input type="radio" name="paymentMethod" value="shopeepay">
                                        <span class="payment-radio"></span>
                                        <img src="https://upload.wikimedia.org/wikipedia/commons/e/eb/ShopeePay_logo.svg" alt="ShopeePay" class="payment-logo">
                                        <div class="payment-info">
                                            <div class="payment-name">ShopeePay</div>
                                            <div class="payment-desc">Push notification ke app</div>
                                        </div>
                                        <span class="payment-fee">Gratis</span>
                                    </label>
                                </div>
                                
                                <!-- QRIS -->
                                <div class="payment-method-group">
                                    <div class="payment-method-group-header">
                                        <i class="fas fa-qrcode me-2"></i> QRIS
                                    </div>
                                    
                                    <label class="payment-option" onclick="selectPayment(this)">
                                        <input type="radio" name="paymentMethod" value="qris">
                                        <span class="payment-radio"></span>
                                        <img src="https://upload.wikimedia.org/wikipedia/commons/a/a2/Logo_QRIS.svg" alt="QRIS" class="payment-logo">
                                        <div class="payment-info">
                                            <div class="payment-name">QRIS</div>
                                            <div class="payment-desc">Scan dengan semua e-wallet & mobile banking</div>
                                        </div>
                                        <span class="payment-fee">Gratis</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Order Summary Sidebar -->
                <div class="col-lg-4">
                    <div class="order-summary">
                        <div class="summary-header">
                            <h5><i class="fas fa-receipt me-2"></i>Ringkasan Pembayaran</h5>
                        </div>
                        <div class="summary-body">
                            <c:if test="${not empty appliedPromo}">
                                <div class="promo-applied-badge">
                                    <i class="fas fa-ticket-alt"></i>
                                    Kode Promo: <strong>${appliedPromo.code}</strong>
                                </div>
                            </c:if>
                            
                            <div class="summary-row">
                                <span>Subtotal (${cartItems.size()} kursus)</span>
                                <span><fmt:formatNumber value="${subtotal}" type="currency" currencySymbol="Rp " maxFractionDigits="0"/></span>
                            </div>
                            
                            <c:if test="${originalTotal > subtotal}">
                                <div class="summary-row discount">
                                    <span>Diskon Kursus</span>
                                    <span>-<fmt:formatNumber value="${originalTotal - subtotal}" type="currency" currencySymbol="Rp " maxFractionDigits="0"/></span>
                                </div>
                            </c:if>
                            
                            <c:if test="${not empty appliedPromo}">
                                <div class="summary-row discount">
                                    <span>Promo (${appliedPromo.code})</span>
                                    <span>-<fmt:formatNumber value="${promoDiscount}" type="currency" currencySymbol="Rp " maxFractionDigits="0"/></span>
                                </div>
                            </c:if>
                            
                            <div class="summary-row">
                                <span>Biaya Admin</span>
                                <span id="adminFee">Rp 0</span>
                            </div>
                            
                            <div class="summary-divider"></div>
                            
                            <div class="summary-total">
                                <span>Total Pembayaran</span>
                                <span id="totalPayment">
                                    <fmt:formatNumber value="${total}" type="currency" currencySymbol="Rp " maxFractionDigits="0"/>
                                </span>
                            </div>
                            
                            <input type="hidden" name="total" value="${total}">
                        </div>
                        
                        <!-- Terms -->
                        <div class="terms-section">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="agreeTerms" name="agreeTerms" required>
                                <label class="form-check-label small" for="agreeTerms">
                                    Saya setuju dengan <a href="#" target="_blank">Syarat & Ketentuan</a> dan 
                                    <a href="#" target="_blank">Kebijakan Privasi</a> NusaTech.
                                </label>
                            </div>
                            
                            <button type="submit" class="btn btn-primary btn-pay mt-3" id="payButton" disabled>
                                <i class="fas fa-lock me-2"></i> Bayar Sekarang
                            </button>
                        </div>
                        
                        <div class="security-badge">
                            <i class="fas fa-shield-alt"></i>
                            <span>Pembayaran aman & terenkripsi 256-bit SSL</span>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </main>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Payment selection
        function selectPayment(element) {
            document.querySelectorAll('.payment-option').forEach(opt => {
                opt.classList.remove('selected');
            });
            element.classList.add('selected');
            element.querySelector('input').checked = true;
            updatePayButton();
        }
        
        // Terms checkbox
        document.getElementById('agreeTerms').addEventListener('change', updatePayButton);
        
        function updatePayButton() {
            const paymentSelected = document.querySelector('input[name="paymentMethod"]:checked');
            const termsAgreed = document.getElementById('agreeTerms').checked;
            document.getElementById('payButton').disabled = !(paymentSelected && termsAgreed);
        }
        
        // Countdown timer
        let timeLeft = 15 * 60; // 15 minutes
        const countdownEl = document.getElementById('countdown');
        
        const timer = setInterval(() => {
            const minutes = Math.floor(timeLeft / 60);
            const seconds = timeLeft % 60;
            countdownEl.textContent = `${minutes}:${seconds.toString().padStart(2, '0')}`;
            
            if (timeLeft <= 0) {
                clearInterval(timer);
                countdownEl.textContent = '0:00';
                alert('Waktu checkout habis. Silakan ulangi dari keranjang.');
                window.location = '${pageContext.request.contextPath}/cart';
            }
            
            if (timeLeft <= 60) {
                countdownEl.style.color = '#dc2626';
            }
            
            timeLeft--;
        }, 1000);
        
        // Form submit
        document.getElementById('checkoutForm').addEventListener('submit', function(e) {
            const payButton = document.getElementById('payButton');
            payButton.disabled = true;
            payButton.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span> Memproses...';
        });
    </script>
</body>
</html>
