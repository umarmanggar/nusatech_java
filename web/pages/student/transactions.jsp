<%-- 
    Document   : transactions
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Student Transactions History Page with Bootstrap 5
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Riwayat Transaksi - NusaTech</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #8B1538;
            --primary-dark: #6d1029;
            --secondary: #D4A84B;
        }
        
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8f9fa;
        }
        
        .btn-primary { background-color: var(--primary); border-color: var(--primary); }
        .btn-primary:hover { background-color: var(--primary-dark); border-color: var(--primary-dark); }
        .btn-outline-primary { color: var(--primary); border-color: var(--primary); }
        .btn-outline-primary:hover { background-color: var(--primary); border-color: var(--primary); }
        .text-primary { color: var(--primary) !important; }
        
        /* Layout */
        .dashboard-wrapper {
            display: flex;
            min-height: 100vh;
            padding-top: 56px;
        }
        
        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 2rem;
        }
        
        @media (max-width: 991.98px) {
            .main-content { margin-left: 0; }
        }
        
        /* Page Header */
        .page-title {
            font-size: 1.75rem;
            font-weight: 800;
            color: #1f2937;
            margin-bottom: 0.25rem;
        }
        
        .page-subtitle {
            color: #6b7280;
        }
        
        /* Stats Cards */
        .stat-card {
            background: white;
            border-radius: 1rem;
            padding: 1.25rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }
        
        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 0.75rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
        }
        
        .stat-icon.primary { background: rgba(139, 21, 56, 0.1); color: var(--primary); }
        .stat-icon.success { background: rgba(16, 185, 129, 0.1); color: #10b981; }
        .stat-icon.warning { background: rgba(245, 158, 11, 0.1); color: #f59e0b; }
        .stat-icon.danger { background: rgba(239, 68, 68, 0.1); color: #ef4444; }
        
        .stat-value {
            font-size: 1.5rem;
            font-weight: 800;
            color: #1f2937;
        }
        
        .stat-label {
            font-size: 0.8rem;
            color: #6b7280;
        }
        
        /* Filter Bar */
        .filter-bar {
            background: white;
            border-radius: 1rem;
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }
        
        /* Table Card */
        .table-card {
            background: white;
            border-radius: 1rem;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }
        
        .table-card .table {
            margin-bottom: 0;
        }
        
        .table thead th {
            background: #f9fafb;
            border-bottom: 2px solid #e5e7eb;
            font-weight: 600;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #6b7280;
            padding: 1rem;
        }
        
        .table tbody td {
            padding: 1rem;
            vertical-align: middle;
            border-bottom: 1px solid #f3f4f6;
        }
        
        .table tbody tr:hover {
            background: #f9fafb;
        }
        
        .transaction-code {
            font-family: monospace;
            font-weight: 600;
            color: var(--primary);
        }
        
        .transaction-date {
            font-size: 0.85rem;
            color: #6b7280;
        }
        
        .transaction-amount {
            font-weight: 700;
            color: #1f2937;
        }
        
        /* Status Badges */
        .badge-pending {
            background: rgba(245, 158, 11, 0.1);
            color: #d97706;
        }
        
        .badge-paid {
            background: rgba(16, 185, 129, 0.1);
            color: #059669;
        }
        
        .badge-failed {
            background: rgba(239, 68, 68, 0.1);
            color: #dc2626;
        }
        
        .badge-expired {
            background: rgba(107, 114, 128, 0.1);
            color: #6b7280;
        }
        
        /* Payment Method Icons */
        .payment-method {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.85rem;
        }
        
        .payment-method i {
            font-size: 1.25rem;
        }
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
        }
        
        .empty-state-icon {
            width: 100px;
            height: 100px;
            background: rgba(139, 21, 56, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 2.5rem;
            color: var(--primary);
        }
        
        /* Pagination */
        .page-link {
            color: var(--primary);
            border-radius: 0.5rem !important;
            margin: 0 0.15rem;
        }
        
        .page-item.active .page-link {
            background-color: var(--primary);
            border-color: var(--primary);
        }
        
        /* Mobile Table */
        @media (max-width: 767.98px) {
            .table-responsive {
                border-radius: 1rem;
            }
            
            .table thead {
                display: none;
            }
            
            .table tbody tr {
                display: block;
                padding: 1rem;
                border-bottom: 1px solid #e5e7eb;
            }
            
            .table tbody td {
                display: flex;
                justify-content: space-between;
                padding: 0.5rem 0;
                border-bottom: none;
            }
            
            .table tbody td::before {
                content: attr(data-label);
                font-weight: 600;
                color: #6b7280;
                font-size: 0.8rem;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <jsp:include page="/pages/common/navbar-dashboard.jsp"/>
    
    <div class="dashboard-wrapper">
        <!-- Sidebar -->
        <jsp:include page="/pages/common/sidebar-student.jsp"/>
        
        <!-- Main Content -->
        <main class="main-content">
            <!-- Mobile Sidebar Toggle -->
            <button class="btn btn-outline-secondary d-lg-none mb-3" onclick="toggleSidebar()">
                <i class="fas fa-bars me-2"></i> Menu
            </button>
            
            <!-- Page Header -->
            <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
                <div>
                    <h1 class="page-title">
                        <i class="fas fa-receipt" style="color: var(--primary);"></i> Riwayat Transaksi
                    </h1>
                    <p class="page-subtitle mb-0">Pantau semua transaksi pembelian kursus Anda</p>
                </div>
                <a href="${pageContext.request.contextPath}/courses" class="btn btn-primary">
                    <i class="fas fa-shopping-cart me-2"></i> Beli Kursus
                </a>
            </div>
            
            <!-- Stats Row -->
            <div class="row g-3 mb-4">
                <div class="col-6 col-md-3">
                    <div class="stat-card">
                        <div class="stat-icon primary">
                            <i class="fas fa-file-invoice"></i>
                        </div>
                        <div>
                            <div class="stat-value">${totalTransactions != null ? totalTransactions : 0}</div>
                            <div class="stat-label">Total Transaksi</div>
                        </div>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="stat-card">
                        <div class="stat-icon success">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div>
                            <div class="stat-value">${totalPaid != null ? totalPaid : 0}</div>
                            <div class="stat-label">Berhasil</div>
                        </div>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="stat-card">
                        <div class="stat-icon warning">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div>
                            <div class="stat-value">${totalPending != null ? totalPending : 0}</div>
                            <div class="stat-label">Menunggu</div>
                        </div>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="stat-card">
                        <div class="stat-icon primary">
                            <i class="fas fa-wallet"></i>
                        </div>
                        <div>
                            <div class="stat-value">
                                <small>Rp</small> <fmt:formatNumber value="${totalSpent != null ? totalSpent : 0}" pattern="#,###"/>
                            </div>
                            <div class="stat-label">Total Pembelian</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Filter Bar -->
            <div class="filter-bar">
                <form class="row g-3 align-items-center" action="${pageContext.request.contextPath}/student/transactions" method="GET">
                    <div class="col-md-4">
                        <div class="input-group">
                            <span class="input-group-text bg-white"><i class="fas fa-search text-muted"></i></span>
                            <input type="text" name="search" class="form-control" placeholder="Cari kode transaksi..." value="${param.search}">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <select name="status" class="form-select">
                            <option value="">Semua Status</option>
                            <option value="PENDING" ${param.status == 'PENDING' ? 'selected' : ''}>Menunggu Pembayaran</option>
                            <option value="PAID" ${param.status == 'PAID' ? 'selected' : ''}>Berhasil</option>
                            <option value="FAILED" ${param.status == 'FAILED' ? 'selected' : ''}>Gagal</option>
                            <option value="EXPIRED" ${param.status == 'EXPIRED' ? 'selected' : ''}>Kedaluwarsa</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select name="period" class="form-select">
                            <option value="">Semua Waktu</option>
                            <option value="7" ${param.period == '7' ? 'selected' : ''}>7 Hari Terakhir</option>
                            <option value="30" ${param.period == '30' ? 'selected' : ''}>30 Hari Terakhir</option>
                            <option value="90" ${param.period == '90' ? 'selected' : ''}>3 Bulan Terakhir</option>
                            <option value="365" ${param.period == '365' ? 'selected' : ''}>1 Tahun Terakhir</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="fas fa-filter me-2"></i> Filter
                        </button>
                    </div>
                </form>
            </div>
            
            <c:choose>
                <c:when test="${not empty transactions}">
                    <!-- Transactions Table -->
                    <div class="table-card">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Kode Transaksi</th>
                                        <th>Tanggal</th>
                                        <th>Kursus</th>
                                        <th>Metode Pembayaran</th>
                                        <th>Total</th>
                                        <th>Status</th>
                                        <th>Aksi</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="transaction" items="${transactions}">
                                        <tr>
                                            <td data-label="Kode">
                                                <span class="transaction-code">${transaction.transactionCode}</span>
                                            </td>
                                            <td data-label="Tanggal">
                                                <div class="transaction-date">
                                                    <fmt:formatDate value="${transaction.createdAt}" pattern="dd MMM yyyy"/>
                                                    <br>
                                                    <small class="text-muted">
                                                        <fmt:formatDate value="${transaction.createdAt}" pattern="HH:mm"/>
                                                    </small>
                                                </div>
                                            </td>
                                            <td data-label="Kursus">
                                                <c:choose>
                                                    <c:when test="${not empty transaction.items}">
                                                        <c:forEach var="item" items="${transaction.items}" varStatus="status">
                                                            ${item.course.title}<c:if test="${!status.last}">, </c:if>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">-</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td data-label="Metode">
                                                <div class="payment-method">
                                                    <c:choose>
                                                        <c:when test="${transaction.paymentMethod == 'BANK_TRANSFER'}">
                                                            <i class="fas fa-university text-primary"></i>
                                                            <span>Transfer Bank</span>
                                                        </c:when>
                                                        <c:when test="${transaction.paymentMethod == 'EWALLET'}">
                                                            <i class="fas fa-wallet text-success"></i>
                                                            <span>E-Wallet</span>
                                                        </c:when>
                                                        <c:when test="${transaction.paymentMethod == 'CREDIT_CARD'}">
                                                            <i class="fas fa-credit-card text-info"></i>
                                                            <span>Kartu Kredit</span>
                                                        </c:when>
                                                        <c:when test="${transaction.paymentMethod == 'BALANCE'}">
                                                            <i class="fas fa-coins text-warning"></i>
                                                            <span>Saldo</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fas fa-money-bill text-secondary"></i>
                                                            <span>${transaction.paymentMethod}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </td>
                                            <td data-label="Total">
                                                <span class="transaction-amount">
                                                    Rp <fmt:formatNumber value="${transaction.totalAmount}" pattern="#,###"/>
                                                </span>
                                            </td>
                                            <td data-label="Status">
                                                <c:choose>
                                                    <c:when test="${transaction.paymentStatus == 'PENDING'}">
                                                        <span class="badge badge-pending">
                                                            <i class="fas fa-clock me-1"></i> Menunggu
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${transaction.paymentStatus == 'PAID'}">
                                                        <span class="badge badge-paid">
                                                            <i class="fas fa-check-circle me-1"></i> Berhasil
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${transaction.paymentStatus == 'FAILED'}">
                                                        <span class="badge badge-failed">
                                                            <i class="fas fa-times-circle me-1"></i> Gagal
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${transaction.paymentStatus == 'EXPIRED'}">
                                                        <span class="badge badge-expired">
                                                            <i class="fas fa-ban me-1"></i> Kedaluwarsa
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">${transaction.paymentStatus}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td data-label="Aksi">
                                                <div class="d-flex gap-1">
                                                    <a href="${pageContext.request.contextPath}/checkout/detail/${transaction.transactionCode}" 
                                                       class="btn btn-sm btn-outline-primary" title="Detail">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <c:if test="${transaction.paymentStatus == 'PENDING'}">
                                                        <a href="${pageContext.request.contextPath}/checkout/pay/${transaction.transactionCode}" 
                                                           class="btn btn-sm btn-primary" title="Bayar Sekarang">
                                                            <i class="fas fa-credit-card"></i>
                                                        </a>
                                                    </c:if>
                                                    <c:if test="${transaction.paymentStatus == 'PAID'}">
                                                        <a href="${pageContext.request.contextPath}/checkout/invoice/${transaction.transactionCode}" 
                                                           class="btn btn-sm btn-outline-secondary" title="Unduh Invoice" target="_blank">
                                                            <i class="fas fa-download"></i>
                                                        </a>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        
                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <div class="p-3 border-top">
                                <nav>
                                    <ul class="pagination justify-content-center mb-0">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="${pageContext.request.contextPath}/student/transactions?page=${currentPage - 1}${not empty param.status ? '&status='.concat(param.status) : ''}">
                                                    <i class="fas fa-chevron-left"></i>
                                                </a>
                                            </li>
                                        </c:if>
                                        
                                        <c:forEach begin="1" end="${totalPages}" var="page">
                                            <c:if test="${page <= 5 || page == totalPages || (page >= currentPage - 1 && page <= currentPage + 1)}">
                                                <li class="page-item ${page == currentPage ? 'active' : ''}">
                                                    <a class="page-link" href="${pageContext.request.contextPath}/student/transactions?page=${page}${not empty param.status ? '&status='.concat(param.status) : ''}">
                                                        ${page}
                                                    </a>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                        
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="${pageContext.request.contextPath}/student/transactions?page=${currentPage + 1}${not empty param.status ? '&status='.concat(param.status) : ''}">
                                                    <i class="fas fa-chevron-right"></i>
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </div>
                        </c:if>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Empty State -->
                    <div class="table-card">
                        <div class="empty-state">
                            <div class="empty-state-icon">
                                <i class="fas fa-receipt"></i>
                            </div>
                            <h4 class="fw-bold mb-2">Belum Ada Transaksi</h4>
                            <p class="text-muted mb-4 mx-auto" style="max-width: 400px;">
                                <c:choose>
                                    <c:when test="${not empty param.status || not empty param.search}">
                                        Tidak ada transaksi yang sesuai dengan filter Anda. Coba ubah kriteria pencarian.
                                    </c:when>
                                    <c:otherwise>
                                        Anda belum memiliki transaksi. Mulai belajar dengan membeli kursus pertama Anda!
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <c:choose>
                                <c:when test="${not empty param.status || not empty param.search}">
                                    <a href="${pageContext.request.contextPath}/student/transactions" class="btn btn-outline-primary me-2">
                                        <i class="fas fa-undo me-2"></i> Reset Filter
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/courses" class="btn btn-primary">
                                        <i class="fas fa-shopping-cart me-2"></i> Jelajahi Kursus
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
