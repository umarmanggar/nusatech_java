<%-- 
    Document   : earnings
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Lecturer Earnings Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pendapatan - NusaTech</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <jsp:include page="/pages/common/navbar-dashboard.jsp"/>
    
    <div class="dashboard-layout">
        <aside class="sidebar">
            <div class="sidebar-menu">
                <a href="${pageContext.request.contextPath}/lecturer/dashboard" class="sidebar-item">
                    <i class="fas fa-home"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/lecturer/courses" class="sidebar-item">
                    <i class="fas fa-book"></i> Kursus Saya
                </a>
                <a href="${pageContext.request.contextPath}/lecturer/course/create" class="sidebar-item">
                    <i class="fas fa-plus-circle"></i> Buat Kursus
                </a>
                <a href="${pageContext.request.contextPath}/lecturer/students" class="sidebar-item">
                    <i class="fas fa-users"></i> Pelajar
                </a>
                <a href="${pageContext.request.contextPath}/lecturer/earnings" class="sidebar-item active">
                    <i class="fas fa-wallet"></i> Pendapatan
                </a>
                <hr style="margin: 1rem 0; border: none; border-top: 1px solid var(--gray-200);">
                <a href="${pageContext.request.contextPath}/lecturer/profile" class="sidebar-item">
                    <i class="fas fa-user"></i> Profil
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="sidebar-item" style="color: var(--error);">
                    <i class="fas fa-sign-out-alt"></i> Keluar
                </a>
            </div>
        </aside>
        
        <main class="main-content">
            <div class="page-header" style="display: flex; justify-content: space-between; align-items: flex-start; flex-wrap: wrap; gap: 1rem;">
                <div>
                    <h1 class="page-title">
                        <i class="fas fa-wallet" style="color: var(--secondary);"></i> Pendapatan
                    </h1>
                    <p class="page-subtitle">Pantau penghasilan dari kursus Anda</p>
                </div>
                <button class="btn btn-primary" data-modal="withdrawModal">
                    <i class="fas fa-money-bill-wave"></i> Tarik Saldo
                </button>
            </div>
            
            <!-- Balance Cards -->
            <div class="grid grid-4" style="margin-bottom: 2rem;">
                <div class="stat-card" style="background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%); color: white;">
                    <div class="stat-card-icon" style="background: rgba(255,255,255,0.2); color: white;">
                        <i class="fas fa-wallet"></i>
                    </div>
                    <div class="stat-card-value" style="color: white;">
                        Rp <fmt:formatNumber value="${sessionScope.user.balance != null ? sessionScope.user.balance : 0}" pattern="#,###"/>
                    </div>
                    <div class="stat-card-label" style="color: rgba(255,255,255,0.8);">Saldo Tersedia</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-icon success"><i class="fas fa-arrow-down"></i></div>
                    <div class="stat-card-value">
                        Rp <fmt:formatNumber value="${totalEarnings != null ? totalEarnings : 0}" pattern="#,###"/>
                    </div>
                    <div class="stat-card-label">Total Pendapatan</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-icon warning"><i class="fas fa-arrow-up"></i></div>
                    <div class="stat-card-value">
                        Rp <fmt:formatNumber value="${totalWithdrawn != null ? totalWithdrawn : 0}" pattern="#,###"/>
                    </div>
                    <div class="stat-card-label">Total Ditarik</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-icon info"><i class="fas fa-clock"></i></div>
                    <div class="stat-card-value">
                        Rp <fmt:formatNumber value="${pendingWithdrawal != null ? pendingWithdrawal : 0}" pattern="#,###"/>
                    </div>
                    <div class="stat-card-label">Proses Penarikan</div>
                </div>
            </div>
            
            <!-- Earning Statistics Chart Placeholder -->
            <div class="card" style="margin-bottom: 2rem;">
                <div class="card-header">
                    <h3><i class="fas fa-chart-line"></i> Statistik Pendapatan</h3>
                    <select class="form-control" style="width: auto;" onchange="changeChartPeriod(this.value)">
                        <option value="7">7 Hari Terakhir</option>
                        <option value="30" selected>30 Hari Terakhir</option>
                        <option value="90">3 Bulan Terakhir</option>
                        <option value="365">1 Tahun Terakhir</option>
                    </select>
                </div>
                <div class="card-body">
                    <div style="height: 300px; display: flex; align-items: center; justify-content: center; background: var(--gray-50); border-radius: var(--radius-lg);">
                        <div style="text-align: center; color: var(--gray-400);">
                            <i class="fas fa-chart-area" style="font-size: 3rem; margin-bottom: 1rem;"></i>
                            <p>Grafik pendapatan akan ditampilkan di sini</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Course Earnings Breakdown -->
            <div class="grid grid-2" style="margin-bottom: 2rem;">
                <div class="card">
                    <div class="card-header">
                        <h3><i class="fas fa-chart-pie"></i> Pendapatan per Kursus</h3>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty courseEarnings}">
                                <c:forEach var="earning" items="${courseEarnings}">
                                    <div style="display: flex; align-items: center; justify-content: space-between; padding: 0.75rem 0; border-bottom: 1px solid var(--gray-100);">
                                        <div style="display: flex; align-items: center; gap: 0.75rem;">
                                            <img src="${earning.thumbnail != null ? earning.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=50&h=50&fit=crop'}" 
                                                 alt="${earning.title}" 
                                                 style="width: 40px; height: 40px; border-radius: var(--radius-sm); object-fit: cover;">
                                            <div>
                                                <h4 style="font-size: 0.875rem; margin-bottom: 0.25rem;">${earning.title}</h4>
                                                <span style="font-size: 0.75rem; color: var(--gray-500);">${earning.totalSales} penjualan</span>
                                            </div>
                                        </div>
                                        <span style="font-weight: 600; color: var(--success);">
                                            Rp <fmt:formatNumber value="${earning.totalAmount}" pattern="#,###"/>
                                        </span>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div style="text-align: center; padding: 2rem; color: var(--gray-400);">
                                    <i class="fas fa-coins" style="font-size: 2rem; margin-bottom: 0.5rem;"></i>
                                    <p>Belum ada pendapatan</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-header">
                        <h3><i class="fas fa-calendar"></i> Pendapatan Bulanan</h3>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty monthlyEarnings}">
                                <c:forEach var="monthly" items="${monthlyEarnings}">
                                    <div style="display: flex; align-items: center; justify-content: space-between; padding: 0.75rem 0; border-bottom: 1px solid var(--gray-100);">
                                        <span style="font-weight: 500;">${monthly.month}</span>
                                        <span style="font-weight: 600; color: var(--success);">
                                            Rp <fmt:formatNumber value="${monthly.amount}" pattern="#,###"/>
                                        </span>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <!-- Sample monthly data -->
                                <div style="display: flex; align-items: center; justify-content: space-between; padding: 0.75rem 0; border-bottom: 1px solid var(--gray-100);">
                                    <span style="font-weight: 500;">Desember 2025</span>
                                    <span style="font-weight: 600; color: var(--success);">Rp 0</span>
                                </div>
                                <div style="display: flex; align-items: center; justify-content: space-between; padding: 0.75rem 0; border-bottom: 1px solid var(--gray-100);">
                                    <span style="font-weight: 500;">November 2025</span>
                                    <span style="font-weight: 600; color: var(--success);">Rp 0</span>
                                </div>
                                <div style="display: flex; align-items: center; justify-content: space-between; padding: 0.75rem 0; border-bottom: 1px solid var(--gray-100);">
                                    <span style="font-weight: 500;">Oktober 2025</span>
                                    <span style="font-weight: 600; color: var(--success);">Rp 0</span>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            
            <!-- Transaction History -->
            <div class="card">
                <div class="card-header">
                    <h3><i class="fas fa-history"></i> Riwayat Transaksi</h3>
                    <div style="display: flex; gap: 0.5rem;">
                        <select class="form-control" style="width: auto;" id="transactionFilter">
                            <option value="">Semua Tipe</option>
                            <option value="earning">Pendapatan</option>
                            <option value="withdrawal">Penarikan</option>
                        </select>
                    </div>
                </div>
                <div style="overflow-x: auto;">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Tanggal</th>
                                <th>Deskripsi</th>
                                <th>Tipe</th>
                                <th style="text-align: right;">Jumlah</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty transactions}">
                                    <c:forEach var="tx" items="${transactions}">
                                        <tr>
                                            <td><fmt:formatDate value="${tx.createdAt}" pattern="dd MMM yyyy HH:mm"/></td>
                                            <td>${tx.description}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${tx.type == 'EARNING'}">
                                                        <span class="badge badge-success">Pendapatan</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-warning">Penarikan</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="text-align: right; font-weight: 600; color: ${tx.type == 'EARNING' ? 'var(--success)' : 'var(--warning)'};">
                                                ${tx.type == 'EARNING' ? '+' : '-'} Rp <fmt:formatNumber value="${tx.amount}" pattern="#,###"/>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${tx.status == 'COMPLETED'}">
                                                        <span class="badge badge-success">Selesai</span>
                                                    </c:when>
                                                    <c:when test="${tx.status == 'PENDING'}">
                                                        <span class="badge badge-warning">Pending</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-error">Gagal</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <!-- Sample transactions for demo -->
                                    <tr>
                                        <td colspan="5" style="text-align: center; padding: 2rem; color: var(--gray-400);">
                                            <i class="fas fa-receipt" style="font-size: 2rem; margin-bottom: 0.5rem;"></i>
                                            <p>Belum ada riwayat transaksi</p>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
    
    <!-- Withdraw Modal -->
    <div class="modal" id="withdrawModal">
        <div class="modal-backdrop" onclick="closeModal('withdrawModal')"></div>
        <div class="modal-content">
            <div class="modal-header">
                <h3>Tarik Saldo</h3>
                <button class="modal-close" onclick="closeModal('withdrawModal')">&times;</button>
            </div>
            <form action="${pageContext.request.contextPath}/lecturer/withdraw" method="post">
                <div class="modal-body">
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle"></i>
                        Saldo tersedia: <strong>Rp <fmt:formatNumber value="${sessionScope.user.balance != null ? sessionScope.user.balance : 0}" pattern="#,###"/></strong>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Jumlah Penarikan <span class="text-danger">*</span></label>
                        <input type="number" name="amount" class="form-control" required 
                               min="50000" max="${sessionScope.user.balance}"
                               placeholder="Minimal Rp 50.000">
                        <small class="form-hint">Minimum penarikan Rp 50.000</small>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Bank Tujuan <span class="text-danger">*</span></label>
                        <select name="bank" class="form-control" required>
                            <option value="">Pilih Bank</option>
                            <option value="BCA">BCA</option>
                            <option value="BNI">BNI</option>
                            <option value="BRI">BRI</option>
                            <option value="Mandiri">Mandiri</option>
                            <option value="CIMB">CIMB Niaga</option>
                            <option value="Permata">Permata</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Nomor Rekening <span class="text-danger">*</span></label>
                        <input type="text" name="accountNumber" class="form-control" required 
                               placeholder="Masukkan nomor rekening">
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Nama Pemilik Rekening <span class="text-danger">*</span></label>
                        <input type="text" name="accountName" class="form-control" required 
                               placeholder="Nama sesuai buku tabungan">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline" onclick="closeModal('withdrawModal')">Batal</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-paper-plane"></i> Ajukan Penarikan
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        // Modal functions
        document.querySelectorAll('[data-modal]').forEach(button => {
            button.addEventListener('click', function() {
                const modalId = this.getAttribute('data-modal');
                document.getElementById(modalId).classList.add('active');
            });
        });
        
        function closeModal(modalId) {
            document.getElementById(modalId).classList.remove('active');
        }
        
        function changeChartPeriod(days) {
            // Placeholder for chart period change
            console.log('Chart period changed to', days, 'days');
        }
    </script>
</body>
</html>
