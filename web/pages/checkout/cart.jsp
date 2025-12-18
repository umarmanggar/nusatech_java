<%-- 
    Document   : cart
    Created on : Dec 18, 2025
    Author     : NusaTech
    Description: Shopping Cart Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Keranjang Belanja - NusaTech</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #8B1538;
            --primary-dark: #6d1029;
            --secondary: #D4A84B;
            --success: #10b981;
            --danger: #ef4444;
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
        .btn-outline-primary { color: var(--primary); border-color: var(--primary); }
        .btn-outline-primary:hover { background-color: var(--primary); border-color: var(--primary); }
        .text-primary { color: var(--primary) !important; }
        
        /* Page Header */
        .page-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }
        
        .page-header h1 {
            font-weight: 800;
            margin-bottom: 0.5rem;
        }
        
        /* Cart Section */
        .cart-section {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            overflow: hidden;
        }
        
        .cart-header {
            background: #f8f9fa;
            padding: 1rem 1.5rem;
            border-bottom: 1px solid #e5e7eb;
            font-weight: 600;
            color: #374151;
        }
        
        /* Cart Item */
        .cart-item {
            display: flex;
            gap: 1rem;
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid #f3f4f6;
            transition: background 0.2s;
        }
        
        .cart-item:hover {
            background: #fafafa;
        }
        
        .cart-item:last-child {
            border-bottom: none;
        }
        
        .cart-item-thumbnail {
            width: 120px;
            height: 80px;
            border-radius: 0.5rem;
            object-fit: cover;
            flex-shrink: 0;
        }
        
        .cart-item-info {
            flex: 1;
            min-width: 0;
        }
        
        .cart-item-title {
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 0.25rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .cart-item-title a {
            color: inherit;
            text-decoration: none;
        }
        
        .cart-item-title a:hover {
            color: var(--primary);
        }
        
        .cart-item-instructor {
            font-size: 0.85rem;
            color: #6b7280;
            margin-bottom: 0.5rem;
        }
        
        .cart-item-meta {
            display: flex;
            align-items: center;
            gap: 1rem;
            font-size: 0.8rem;
            color: #9ca3af;
        }
        
        .cart-item-meta span {
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }
        
        .cart-item-rating {
            color: #fbbf24;
        }
        
        .cart-item-price {
            text-align: right;
            flex-shrink: 0;
        }
        
        .price-current {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--primary);
        }
        
        .price-original {
            font-size: 0.85rem;
            color: #9ca3af;
            text-decoration: line-through;
        }
        
        .price-discount {
            display: inline-block;
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
            padding: 0.15rem 0.5rem;
            border-radius: 999px;
            font-size: 0.75rem;
            font-weight: 600;
            margin-top: 0.25rem;
        }
        
        .cart-item-actions {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: flex-end;
        }
        
        .btn-remove {
            background: none;
            border: none;
            color: #9ca3af;
            padding: 0.5rem;
            cursor: pointer;
            transition: color 0.2s;
        }
        
        .btn-remove:hover {
            color: var(--danger);
        }
        
        .btn-wishlist {
            background: none;
            border: none;
            color: #9ca3af;
            font-size: 0.8rem;
            padding: 0.25rem 0.5rem;
            cursor: pointer;
            transition: color 0.2s;
        }
        
        .btn-wishlist:hover {
            color: var(--primary);
        }
        
        /* Empty Cart */
        .empty-cart {
            text-align: center;
            padding: 4rem 2rem;
        }
        
        .empty-cart-icon {
            width: 120px;
            height: 120px;
            background: #f1f5f9;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
        }
        
        .empty-cart-icon i {
            font-size: 3rem;
            color: #9ca3af;
        }
        
        /* Order Summary */
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
        
        /* Promo Code */
        .promo-section {
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid #e5e7eb;
        }
        
        .promo-input-group {
            display: flex;
            gap: 0.5rem;
        }
        
        .promo-input {
            flex: 1;
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            padding: 0.65rem 1rem;
            font-size: 0.9rem;
        }
        
        .promo-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(139, 21, 56, 0.1);
        }
        
        .btn-apply-promo {
            padding: 0.65rem 1rem;
            white-space: nowrap;
        }
        
        .promo-applied {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: rgba(16, 185, 129, 0.1);
            border: 1px solid rgba(16, 185, 129, 0.3);
            border-radius: 0.5rem;
            padding: 0.75rem 1rem;
            margin-top: 0.75rem;
        }
        
        .promo-applied-code {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--success);
            font-weight: 600;
        }
        
        .promo-applied-code i {
            font-size: 1.1rem;
        }
        
        .btn-remove-promo {
            background: none;
            border: none;
            color: #6b7280;
            cursor: pointer;
        }
        
        .btn-remove-promo:hover {
            color: var(--danger);
        }
        
        .promo-error {
            color: var(--danger);
            font-size: 0.85rem;
            margin-top: 0.5rem;
        }
        
        /* Checkout Button */
        .btn-checkout {
            width: 100%;
            padding: 1rem;
            font-size: 1.1rem;
            font-weight: 600;
            margin-top: 1rem;
        }
        
        /* Recommendations */
        .recommendations {
            margin-top: 3rem;
        }
        
        .section-title {
            font-weight: 700;
            font-size: 1.25rem;
            margin-bottom: 1.5rem;
            color: #1f2937;
        }
        
        .course-card {
            background: white;
            border-radius: 1rem;
            overflow: hidden;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            transition: all 0.3s;
            height: 100%;
        }
        
        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        
        .course-card-img {
            width: 100%;
            height: 140px;
            object-fit: cover;
        }
        
        .course-card-body {
            padding: 1rem;
        }
        
        .course-card-title {
            font-weight: 600;
            font-size: 0.95rem;
            color: #1f2937;
            margin-bottom: 0.5rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .course-card-price {
            font-weight: 700;
            color: var(--primary);
        }
        
        /* Responsive */
        @media (max-width: 991.98px) {
            .order-summary {
                position: static;
                margin-top: 2rem;
            }
        }
        
        @media (max-width: 767.98px) {
            .cart-item {
                flex-wrap: wrap;
            }
            
            .cart-item-thumbnail {
                width: 100px;
                height: 70px;
            }
            
            .cart-item-price {
                text-align: left;
                margin-top: 0.5rem;
            }
            
            .cart-item-actions {
                flex-direction: row;
                width: 100%;
                margin-top: 0.75rem;
                padding-top: 0.75rem;
                border-top: 1px solid #f3f4f6;
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
                <a href="${pageContext.request.contextPath}/course" class="btn btn-sm btn-outline-secondary">
                    <i class="fas fa-arrow-left me-1"></i> Lanjut Belanja
                </a>
            </div>
        </div>
    </nav>
    
    <!-- Page Header -->
    <section class="page-header">
        <div class="container">
            <h1><i class="fas fa-shopping-cart me-3"></i>Keranjang Belanja</h1>
            <p class="mb-0 opacity-75">
                <c:choose>
                    <c:when test="${not empty cartItems}">
                        ${cartItems.size()} kursus dalam keranjang
                    </c:when>
                    <c:otherwise>
                        Keranjang Anda kosong
                    </c:otherwise>
                </c:choose>
            </p>
        </div>
    </section>
    
    <main class="container pb-5">
        <c:choose>
            <c:when test="${not empty cartItems}">
                <div class="row">
                    <!-- Cart Items -->
                    <div class="col-lg-8">
                        <div class="cart-section">
                            <div class="cart-header">
                                <div class="row">
                                    <div class="col-md-7">Kursus</div>
                                    <div class="col-md-3 text-md-end">Harga</div>
                                    <div class="col-md-2"></div>
                                </div>
                            </div>
                            
                            <div class="cart-items" id="cartItems">
                                <c:forEach var="item" items="${cartItems}">
                                    <div class="cart-item" data-item-id="${item.cartItemId}">
                                        <img src="${not empty item.course.thumbnail ? item.course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=120&h=80&fit=crop'}" 
                                             alt="${item.course.title}" class="cart-item-thumbnail">
                                        
                                        <div class="cart-item-info">
                                            <h6 class="cart-item-title">
                                                <a href="${pageContext.request.contextPath}/course/${item.course.slug}">${item.course.title}</a>
                                            </h6>
                                            <p class="cart-item-instructor">
                                                <i class="fas fa-user-tie me-1"></i> ${item.course.instructor.fullName}
                                            </p>
                                            <div class="cart-item-meta">
                                                <span class="cart-item-rating">
                                                    <i class="fas fa-star"></i>
                                                    <fmt:formatNumber value="${item.course.rating}" maxFractionDigits="1"/>
                                                    <span class="text-muted">(${item.course.reviewCount})</span>
                                                </span>
                                                <span>
                                                    <i class="fas fa-clock"></i>
                                                    ${item.course.totalDuration} jam
                                                </span>
                                                <span>
                                                    <i class="fas fa-signal"></i>
                                                    ${item.course.level}
                                                </span>
                                            </div>
                                        </div>
                                        
                                        <div class="cart-item-price">
                                            <c:choose>
                                                <c:when test="${item.course.discountPrice != null && item.course.discountPrice < item.course.price}">
                                                    <div class="price-current">
                                                        <fmt:formatNumber value="${item.course.discountPrice}" type="currency" currencySymbol="Rp " maxFractionDigits="0"/>
                                                    </div>
                                                    <div class="price-original">
                                                        <fmt:formatNumber value="${item.course.price}" type="currency" currencySymbol="Rp " maxFractionDigits="0"/>
                                                    </div>
                                                    <c:set var="discountPercent" value="${((item.course.price - item.course.discountPrice) / item.course.price) * 100}"/>
                                                    <span class="price-discount">
                                                        -<fmt:formatNumber value="${discountPercent}" maxFractionDigits="0"/>%
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="price-current">
                                                        <fmt:formatNumber value="${item.course.price}" type="currency" currencySymbol="Rp " maxFractionDigits="0"/>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        
                                        <div class="cart-item-actions">
                                            <button class="btn-remove" onclick="removeItem(${item.cartItemId})" title="Hapus dari keranjang">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                            <button class="btn-wishlist" onclick="moveToWishlist(${item.cartItemId}, ${item.course.courseId})">
                                                <i class="far fa-heart me-1"></i> Simpan
                                            </button>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        
                        <!-- Clear Cart -->
                        <div class="mt-3 text-end">
                            <button class="btn btn-sm btn-outline-danger" onclick="clearCart()">
                                <i class="fas fa-trash me-1"></i> Kosongkan Keranjang
                            </button>
                        </div>
                    </div>
                    
                    <!-- Order Summary -->
                    <div class="col-lg-4">
                        <div class="order-summary">
                            <div class="summary-header">
                                <h5><i class="fas fa-receipt me-2"></i>Ringkasan Pesanan</h5>
                            </div>
                            <div class="summary-body">
                                <div class="summary-row">
                                    <span>Subtotal (${cartItems.size()} kursus)</span>
                                    <span id="subtotal">
                                        <fmt:formatNumber value="${subtotal}" type="currency" currencySymbol="Rp " maxFractionDigits="0"/>
                                    </span>
                                </div>
                                
                                <c:if test="${originalTotal > subtotal}">
                                    <div class="summary-row discount">
                                        <span>Diskon Kursus</span>
                                        <span id="courseDiscount">
                                            -<fmt:formatNumber value="${originalTotal - subtotal}" type="currency" currencySymbol="Rp " maxFractionDigits="0"/>
                                        </span>
                                    </div>
                                </c:if>
                                
                                <div class="summary-row discount" id="promoDiscountRow" style="${empty appliedPromo ? 'display:none' : ''}">
                                    <span>Kode Promo</span>
                                    <span id="promoDiscount">
                                        <c:if test="${not empty appliedPromo}">
                                            -<fmt:formatNumber value="${promoDiscount}" type="currency" currencySymbol="Rp " maxFractionDigits="0"/>
                                        </c:if>
                                    </span>
                                </div>
                                
                                <div class="summary-divider"></div>
                                
                                <div class="summary-total">
                                    <span>Total</span>
                                    <span id="totalPrice">
                                        <fmt:formatNumber value="${total}" type="currency" currencySymbol="Rp " maxFractionDigits="0"/>
                                    </span>
                                </div>
                                
                                <!-- Promo Code Section -->
                                <div class="promo-section">
                                    <label class="form-label fw-medium mb-2">Kode Promo</label>
                                    <div class="promo-input-group" id="promoInputGroup" style="${not empty appliedPromo ? 'display:none' : ''}">
                                        <input type="text" class="promo-input" id="promoCode" placeholder="Masukkan kode promo">
                                        <button class="btn btn-outline-primary btn-apply-promo" onclick="applyPromo()">
                                            Terapkan
                                        </button>
                                    </div>
                                    
                                    <div class="promo-applied" id="promoApplied" style="${empty appliedPromo ? 'display:none' : ''}">
                                        <div class="promo-applied-code">
                                            <i class="fas fa-check-circle"></i>
                                            <span id="appliedPromoCode">${appliedPromo.code}</span>
                                        </div>
                                        <button class="btn-remove-promo" onclick="removePromo()">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </div>
                                    
                                    <div class="promo-error" id="promoError" style="display:none"></div>
                                </div>
                                
                                <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary btn-checkout">
                                    <i class="fas fa-lock me-2"></i> Checkout Sekarang
                                </a>
                                
                                <p class="text-center text-muted small mt-3 mb-0">
                                    <i class="fas fa-shield-alt me-1"></i> Pembayaran aman & terenkripsi
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Recommendations -->
                <c:if test="${not empty recommendations}">
                    <section class="recommendations">
                        <h3 class="section-title">
                            <i class="fas fa-lightbulb text-warning me-2"></i>
                            Mungkin Anda Juga Suka
                        </h3>
                        <div class="row g-4">
                            <c:forEach var="course" items="${recommendations}" end="3">
                                <div class="col-md-6 col-lg-3">
                                    <div class="course-card">
                                        <img src="${not empty course.thumbnail ? course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=300&h=140&fit=crop'}" 
                                             alt="${course.title}" class="course-card-img">
                                        <div class="course-card-body">
                                            <h6 class="course-card-title">${course.title}</h6>
                                            <div class="d-flex justify-content-between align-items-center">
                                                <span class="course-card-price">
                                                    <fmt:formatNumber value="${course.discountPrice != null ? course.discountPrice : course.price}" 
                                                                      type="currency" currencySymbol="Rp " maxFractionDigits="0"/>
                                                </span>
                                                <button class="btn btn-sm btn-outline-primary" onclick="addToCart(${course.courseId})">
                                                    <i class="fas fa-plus"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </section>
                </c:if>
            </c:when>
            <c:otherwise>
                <!-- Empty Cart State -->
                <div class="cart-section">
                    <div class="empty-cart">
                        <div class="empty-cart-icon">
                            <i class="fas fa-shopping-cart"></i>
                        </div>
                        <h4 class="fw-bold mb-2">Keranjang Anda Kosong</h4>
                        <p class="text-muted mb-4">Jelajahi kursus-kursus menarik dan tambahkan ke keranjang!</p>
                        <a href="${pageContext.request.contextPath}/course" class="btn btn-primary btn-lg">
                            <i class="fas fa-search me-2"></i> Jelajahi Kursus
                        </a>
                    </div>
                </div>
                
                <!-- Popular Courses -->
                <c:if test="${not empty popularCourses}">
                    <section class="recommendations">
                        <h3 class="section-title">
                            <i class="fas fa-fire text-danger me-2"></i>
                            Kursus Populer
                        </h3>
                        <div class="row g-4">
                            <c:forEach var="course" items="${popularCourses}" end="3">
                                <div class="col-md-6 col-lg-3">
                                    <div class="course-card">
                                        <img src="${not empty course.thumbnail ? course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=300&h=140&fit=crop'}" 
                                             alt="${course.title}" class="course-card-img">
                                        <div class="course-card-body">
                                            <h6 class="course-card-title">${course.title}</h6>
                                            <div class="d-flex justify-content-between align-items-center">
                                                <span class="course-card-price">
                                                    <fmt:formatNumber value="${course.discountPrice != null ? course.discountPrice : course.price}" 
                                                                      type="currency" currencySymbol="Rp " maxFractionDigits="0"/>
                                                </span>
                                                <button class="btn btn-sm btn-outline-primary" onclick="addToCart(${course.courseId})">
                                                    <i class="fas fa-cart-plus"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </section>
                </c:if>
            </c:otherwise>
        </c:choose>
    </main>
    
    <!-- Toast Notification -->
    <div class="toast-container position-fixed bottom-0 end-0 p-3">
        <div id="cartToast" class="toast" role="alert">
            <div class="toast-header">
                <i class="fas fa-check-circle text-success me-2"></i>
                <strong class="me-auto">Berhasil</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
            </div>
            <div class="toast-body" id="toastMessage"></div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const toast = new bootstrap.Toast(document.getElementById('cartToast'));
        
        function showToast(message, isError = false) {
            const toastEl = document.getElementById('cartToast');
            const icon = toastEl.querySelector('.toast-header i');
            
            if (isError) {
                icon.className = 'fas fa-exclamation-circle text-danger me-2';
            } else {
                icon.className = 'fas fa-check-circle text-success me-2';
            }
            
            document.getElementById('toastMessage').textContent = message;
            toast.show();
        }
        
        // Remove item from cart
        function removeItem(cartItemId) {
            if (!confirm('Hapus kursus ini dari keranjang?')) return;
            
            fetch('${pageContext.request.contextPath}/cart/remove/' + cartItemId, {
                method: 'POST'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    document.querySelector(`[data-item-id="${cartItemId}"]`).remove();
                    updateSummary(data);
                    showToast('Kursus berhasil dihapus dari keranjang');
                    
                    if (data.cartCount === 0) {
                        location.reload();
                    }
                }
            });
        }
        
        // Move to wishlist
        function moveToWishlist(cartItemId, courseId) {
            fetch('${pageContext.request.contextPath}/wishlist/add', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'courseId=' + courseId
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    removeItem(cartItemId);
                    showToast('Kursus dipindahkan ke wishlist');
                }
            });
        }
        
        // Clear cart
        function clearCart() {
            if (!confirm('Kosongkan semua item dari keranjang?')) return;
            
            fetch('${pageContext.request.contextPath}/cart/clear', {
                method: 'POST'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    location.reload();
                }
            });
        }
        
        // Apply promo code
        function applyPromo() {
            const code = document.getElementById('promoCode').value.trim();
            if (!code) {
                document.getElementById('promoError').textContent = 'Masukkan kode promo';
                document.getElementById('promoError').style.display = 'block';
                return;
            }
            
            fetch('${pageContext.request.contextPath}/cart/apply-promo', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'code=' + encodeURIComponent(code)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    document.getElementById('promoError').style.display = 'none';
                    document.getElementById('promoInputGroup').style.display = 'none';
                    document.getElementById('promoApplied').style.display = 'flex';
                    document.getElementById('appliedPromoCode').textContent = code;
                    document.getElementById('promoDiscountRow').style.display = 'flex';
                    document.getElementById('promoDiscount').textContent = '-Rp ' + data.discount.toLocaleString('id-ID');
                    document.getElementById('totalPrice').textContent = 'Rp ' + data.total.toLocaleString('id-ID');
                    showToast('Kode promo berhasil diterapkan!');
                } else {
                    document.getElementById('promoError').textContent = data.message;
                    document.getElementById('promoError').style.display = 'block';
                }
            });
        }
        
        // Remove promo
        function removePromo() {
            fetch('${pageContext.request.contextPath}/cart/remove-promo', {
                method: 'POST'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    document.getElementById('promoApplied').style.display = 'none';
                    document.getElementById('promoInputGroup').style.display = 'flex';
                    document.getElementById('promoCode').value = '';
                    document.getElementById('promoDiscountRow').style.display = 'none';
                    document.getElementById('totalPrice').textContent = 'Rp ' + data.total.toLocaleString('id-ID');
                    showToast('Kode promo dihapus');
                }
            });
        }
        
        // Add to cart
        function addToCart(courseId) {
            fetch('${pageContext.request.contextPath}/cart/add', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'courseId=' + courseId
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    location.reload();
                } else {
                    showToast(data.message, true);
                }
            });
        }
        
        // Update summary
        function updateSummary(data) {
            if (data.subtotal !== undefined) {
                document.getElementById('subtotal').textContent = 'Rp ' + data.subtotal.toLocaleString('id-ID');
            }
            if (data.total !== undefined) {
                document.getElementById('totalPrice').textContent = 'Rp ' + data.total.toLocaleString('id-ID');
            }
        }
    </script>
</body>
</html>
