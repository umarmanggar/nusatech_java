<%-- 
    Document   : earnings
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Lecturer Earnings Page with Bootstrap 5 and Chart.js
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
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root { --primary: #8B1538; --primary-dark: #6d1029; --secondary: #D4A84B; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #f8f9fa; }
        .btn-primary { background-color: var(--primary); border-color: var(--primary); }
        .btn-primary:hover { background-color: var(--primary-dark); border-color: var(--primary-dark); }
        .btn-outline-primary { color: var(--primary); border-color: var(--primary); }
        .btn-outline-primary:hover { background-color: var(--primary); border-color: var(--primary); }
        .text-primary { color: var(--primary) !important; }
        .form-control:focus, .form-select:focus { border-color: var(--primary); box-shadow: 0 0 0 0.2rem rgba(139, 21, 56, 0.15); }
        
        .dashboard-wrapper { display: flex; min-height: 100vh; padding-top: 56px; }
        .main-content { flex: 1; margin-left: 280px; padding: 2rem; }
        @media (max-width: 991.98px) { .main-content { margin-left: 0; } }
        
        .sidebar { width: 280px; min-height: calc(100vh - 56px); background: white; border-right: 1px solid #e5e7eb; position: fixed; top: 56px; left: 0; z-index: 1020; }
        .sidebar-user { padding: 1.5rem; background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%); color: white; }
        .sidebar-menu { padding: 1rem; }
        .sidebar-item { display: flex; align-items: center; gap: 0.75rem; padding: 0.85rem 1rem; border-radius: 0.75rem; color: #4b5563; text-decoration: none; font-weight: 500; margin-bottom: 0.25rem; transition: all 0.2s; }
        .sidebar-item:hover { background: rgba(139, 21, 56, 0.08); color: var(--primary); }
        .sidebar-item.active { background: rgba(139, 21, 56, 0.12); color: var(--primary); font-weight: 600; }
        .sidebar-item i { width: 20px; text-align: center; }
        .sidebar-divider { height: 1px; background: #e5e7eb; margin: 1rem 0; }
        
        .balance-card {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            border-radius: 1.5rem;
            padding: 2rem;
            position: relative;
            overflow: hidden;
        }
        .balance-card::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 100%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
        }
        .balance-label { opacity: 0.8; font-size: 0.9rem; }
        .balance-value { font-size: 2.5rem; font-weight: 800; }
        
        .stat-card { background: white; border-radius: 1rem; padding: 1.5rem; box-shadow: 0 2px 8px rgba(0,0,0,0.04); height: 100%; }
        .stat-icon { width: 48px; height: 48px; border-radius: 0.75rem; display: flex; align-items: center; justify-content: center; font-size: 1.25rem; }
        .stat-icon.success { background: rgba(16, 185, 129, 0.1); color: #10b981; }
        .stat-icon.warning { background: rgba(245, 158, 11, 0.1); color: #f59e0b; }
        .stat-icon.info { background: rgba(59, 130, 246, 0.1); color: #3b82f6; }
        .stat-value { font-size: 1.5rem; font-weight: 800; color: #1f2937; }
        .stat-label { font-size: 0.8rem; color: #6b7280; }
        
        .chart-card { background: white; border-radius: 1rem; box-shadow: 0 2px 8px rgba(0,0,0,0.04); overflow: hidden; }
        .chart-header { padding: 1.25rem 1.5rem; border-bottom: 1px solid #e5e7eb; display: flex; justify-content: space-between; align-items: center; }
        .chart-header h5 { font-weight: 700; margin: 0; }
        .chart-body { padding: 1.5rem; }
        
        .earning-item { display: flex; align-items: center; gap: 1rem; padding: 1rem 0; border-bottom: 1px solid #f3f4f6; }
        .earning-item:last-child { border-bottom: none; }
        .earning-course-img { width: 50px; height: 50px; border-radius: 0.5rem; object-fit: cover; }
        
        .transaction-badge { font-size: 0.75rem; font-weight: 600; padding: 0.35rem 0.75rem; border-radius: 1rem; }
        
        @media (max-width: 991.98px) {
            .sidebar { transform: translateX(-100%); transition: transform 0.3s; }
            .sidebar.show { transform: translateX(0); }
            .balance-value { font-size: 1.75rem; }
        }
    </style>
</head>
<body>
    <jsp:include page="/pages/common/navbar-dashboard.jsp"/>
    
    <div class="dashboard-wrapper">
        <!-- Sidebar -->
        <aside class="sidebar" id="sidebar">
            <div class="sidebar-user">
                <div class="d-flex align-items-center gap-3">
                    <img src="https://ui-avatars.com/api/?name=${sessionScope.user.name}&background=ffffff&color=8B1538" class="rounded-circle" style="width: 48px; height: 48px;">
                    <div>
                        <div class="fw-semibold">${sessionScope.user.name}</div>
                        <small class="opacity-75"><i class="fas fa-chalkboard-teacher me-1"></i> Pengajar</small>
                    </div>
                </div>
            </div>
            <nav class="sidebar-menu">
                <a href="${pageContext.request.contextPath}/lecturer/dashboard" class="sidebar-item"><i class="fas fa-home"></i> Dashboard</a>
                <a href="${pageContext.request.contextPath}/lecturer/courses" class="sidebar-item"><i class="fas fa-book"></i> Kursus Saya</a>
                <a href="${pageContext.request.contextPath}/lecturer/course/create" class="sidebar-item"><i class="fas fa-plus-circle"></i> Buat Kursus</a>
                <a href="${pageContext.request.contextPath}/lecturer/students" class="sidebar-item"><i class="fas fa-users"></i> Pelajar</a>
                <a href="${pageContext.request.contextPath}/lecturer/earnings" class="sidebar-item active"><i class="fas fa-wallet"></i> Pendapatan</a>
                <div class="sidebar-divider"></div>
                <a href="${pageContext.request.contextPath}/lecturer/profile" class="sidebar-item"><i class="fas fa-user-circle"></i> Profil</a>
                <a href="${pageContext.request.contextPath}/logout" class="sidebar-item text-danger"><i class="fas fa-sign-out-alt"></i> Keluar</a>
            </nav>
        </aside>
        
        <!-- Main Content -->
        <main class="main-content">
            <button class="btn btn-outline-secondary d-lg-none mb-3" onclick="document.getElementById('sidebar').classList.toggle('show')">
                <i class="fas fa-bars me-2"></i> Menu
            </button>
            
            <!-- Header -->
            <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
                <div>
                    <h1 class="h3 fw-bold mb-1"><i class="fas fa-wallet text-primary me-2"></i>Pendapatan</h1>
                    <p class="text-muted mb-0">Pantau penghasilan dari kursus Anda</p>
                </div>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#withdrawModal">
                    <i class="fas fa-money-bill-wave me-2"></i> Tarik Saldo
                </button>
            </div>
            
            <!-- Alerts -->
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show"><i class="fas fa-check-circle me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show"><i class="fas fa-exclamation-circle me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
            </c:if>
            
            <!-- Balance Card -->
            <div class="row g-4 mb-4">
                <div class="col-lg-5">
                    <div class="balance-card">
                        <div class="balance-label mb-2"><i class="fas fa-wallet me-2"></i>Saldo Tersedia</div>
                        <div class="balance-value">
                            Rp <fmt:formatNumber value="${sessionScope.user.balance != null ? sessionScope.user.balance : 0}" pattern="#,###"/>
                        </div>
                        <p class="mt-3 mb-0 small opacity-75">
                            <i class="fas fa-info-circle me-1"></i> Minimum penarikan Rp 50.000
                        </p>
                    </div>
                </div>
                <div class="col-lg-7">
                    <div class="row g-3 h-100">
                        <div class="col-md-4">
                            <div class="stat-card">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="stat-icon success"><i class="fas fa-arrow-down"></i></div>
                                    <div>
                                        <div class="stat-label">Total Pendapatan</div>
                                        <div class="stat-value text-success">Rp <fmt:formatNumber value="${totalEarnings != null ? totalEarnings : 0}" pattern="#,###"/></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="stat-card">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="stat-icon warning"><i class="fas fa-arrow-up"></i></div>
                                    <div>
                                        <div class="stat-label">Total Ditarik</div>
                                        <div class="stat-value text-warning">Rp <fmt:formatNumber value="${totalWithdrawn != null ? totalWithdrawn : 0}" pattern="#,###"/></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="stat-card">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="stat-icon info"><i class="fas fa-clock"></i></div>
                                    <div>
                                        <div class="stat-label">Proses Penarikan</div>
                                        <div class="stat-value text-info">Rp <fmt:formatNumber value="${pendingWithdrawal != null ? pendingWithdrawal : 0}" pattern="#,###"/></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Charts Row -->
            <div class="row g-4 mb-4">
                <div class="col-lg-8">
                    <div class="chart-card">
                        <div class="chart-header">
                            <h5><i class="fas fa-chart-line text-primary me-2"></i>Statistik Pendapatan</h5>
                            <select class="form-select form-select-sm" style="width: auto;" id="chartPeriod" onchange="updateChart()">
                                <option value="7">7 Hari Terakhir</option>
                                <option value="30" selected>30 Hari Terakhir</option>
                                <option value="90">3 Bulan Terakhir</option>
                                <option value="365">1 Tahun Terakhir</option>
                            </select>
                        </div>
                        <div class="chart-body">
                            <canvas id="earningsChart" height="300"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="chart-card h-100">
                        <div class="chart-header">
                            <h5><i class="fas fa-chart-pie text-primary me-2"></i>Pendapatan per Kursus</h5>
                        </div>
                        <div class="chart-body">
                            <c:choose>
                                <c:when test="${not empty courseEarnings}">
                                    <c:forEach var="earning" items="${courseEarnings}" end="4">
                                        <div class="earning-item">
                                            <img src="${earning.thumbnail != null ? earning.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=50&h=50&fit=crop'}" 
                                                 alt="${earning.title}" class="earning-course-img">
                                            <div class="flex-grow-1">
                                                <h6 class="mb-1 fw-semibold" style="font-size: 0.9rem;">${earning.title}</h6>
                                                <small class="text-muted">${earning.totalSales} penjualan</small>
                                            </div>
                                            <span class="fw-bold text-success">Rp <fmt:formatNumber value="${earning.totalAmount}" pattern="#,###"/></span>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center py-4 text-muted">
                                        <i class="fas fa-coins fa-3x mb-3 opacity-50"></i>
                                        <p>Belum ada pendapatan</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Transaction History -->
            <div class="chart-card">
                <div class="chart-header">
                    <h5><i class="fas fa-history text-primary me-2"></i>Riwayat Transaksi</h5>
                    <div class="d-flex gap-2">
                        <select class="form-select form-select-sm" style="width: auto;" id="transactionFilter" onchange="filterTransactions()">
                            <option value="">Semua Tipe</option>
                            <option value="EARNING">Pendapatan</option>
                            <option value="WITHDRAWAL">Penarikan</option>
                        </select>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Tanggal</th>
                                <th>Deskripsi</th>
                                <th>Tipe</th>
                                <th class="text-end">Jumlah</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty transactions}">
                                    <c:forEach var="tx" items="${transactions}">
                                        <tr class="transaction-row" data-type="${tx.type}">
                                            <td><fmt:formatDate value="${tx.createdAt}" pattern="dd MMM yyyy HH:mm"/></td>
                                            <td>${tx.description}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${tx.type == 'EARNING'}">
                                                        <span class="transaction-badge bg-success-subtle text-success">Pendapatan</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="transaction-badge bg-warning-subtle text-warning">Penarikan</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-end fw-bold ${tx.type == 'EARNING' ? 'text-success' : 'text-warning'}">
                                                ${tx.type == 'EARNING' ? '+' : '-'} Rp <fmt:formatNumber value="${tx.amount}" pattern="#,###"/>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${tx.status == 'COMPLETED'}">
                                                        <span class="transaction-badge bg-success-subtle text-success">Selesai</span>
                                                    </c:when>
                                                    <c:when test="${tx.status == 'PENDING'}">
                                                        <span class="transaction-badge bg-warning-subtle text-warning">Pending</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="transaction-badge bg-danger-subtle text-danger">Gagal</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <!-- Sample transactions -->
                                    <tr class="transaction-row" data-type="EARNING">
                                        <td>15 Des 2025</td>
                                        <td>Penjualan kursus: Belajar Python</td>
                                        <td><span class="transaction-badge bg-success-subtle text-success">Pendapatan</span></td>
                                        <td class="text-end fw-bold text-success">+ Rp 199.000</td>
                                        <td><span class="transaction-badge bg-success-subtle text-success">Selesai</span></td>
                                    </tr>
                                    <tr class="transaction-row" data-type="EARNING">
                                        <td>14 Des 2025</td>
                                        <td>Penjualan kursus: Web Development</td>
                                        <td><span class="transaction-badge bg-success-subtle text-success">Pendapatan</span></td>
                                        <td class="text-end fw-bold text-success">+ Rp 299.000</td>
                                        <td><span class="transaction-badge bg-success-subtle text-success">Selesai</span></td>
                                    </tr>
                                    <tr class="transaction-row" data-type="WITHDRAWAL">
                                        <td>10 Des 2025</td>
                                        <td>Penarikan ke BCA ****1234</td>
                                        <td><span class="transaction-badge bg-warning-subtle text-warning">Penarikan</span></td>
                                        <td class="text-end fw-bold text-warning">- Rp 500.000</td>
                                        <td><span class="transaction-badge bg-success-subtle text-success">Selesai</span></td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
                
                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <div class="p-3 border-top">
                        <nav>
                            <ul class="pagination justify-content-center mb-0">
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="?page=${i}">${i}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </nav>
                    </div>
                </c:if>
            </div>
        </main>
    </div>
    
    <!-- Withdraw Modal -->
    <div class="modal fade" id="withdrawModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/lecturer/withdraw" method="POST">
                    <div class="modal-header border-0">
                        <h5 class="modal-title"><i class="fas fa-money-bill-wave text-primary me-2"></i>Tarik Saldo</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle me-2"></i>
                            Saldo tersedia: <strong>Rp <fmt:formatNumber value="${sessionScope.user.balance != null ? sessionScope.user.balance : 0}" pattern="#,###"/></strong>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Jumlah Penarikan <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text">Rp</span>
                                <input type="number" name="amount" class="form-control" required min="50000" max="${sessionScope.user.balance}" placeholder="50.000">
                            </div>
                            <div class="form-text">Minimum penarikan Rp 50.000</div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Bank Tujuan <span class="text-danger">*</span></label>
                            <select name="bank" class="form-select" required>
                                <option value="">Pilih Bank</option>
                                <option value="BCA">BCA</option>
                                <option value="BNI">BNI</option>
                                <option value="BRI">BRI</option>
                                <option value="Mandiri">Mandiri</option>
                                <option value="CIMB">CIMB Niaga</option>
                                <option value="Permata">Permata</option>
                                <option value="Dana">Dana</option>
                                <option value="OVO">OVO</option>
                                <option value="GoPay">GoPay</option>
                            </select>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Nomor Rekening <span class="text-danger">*</span></label>
                            <input type="text" name="accountNumber" class="form-control" required placeholder="Masukkan nomor rekening">
                        </div>
                        
                        <div class="mb-0">
                            <label class="form-label fw-semibold">Nama Pemilik Rekening <span class="text-danger">*</span></label>
                            <input type="text" name="accountName" class="form-control" required placeholder="Nama sesuai buku tabungan" value="${sessionScope.user.name}">
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-paper-plane me-2"></i>Ajukan Penarikan
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
    
    <script>
        // Earnings Chart
        const ctx = document.getElementById('earningsChart').getContext('2d');
        const earningsChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['1', '5', '10', '15', '20', '25', '30'],
                datasets: [{
                    label: 'Pendapatan (Rp)',
                    data: [150000, 280000, 420000, 350000, 580000, 720000, 890000],
                    backgroundColor: 'rgba(139, 21, 56, 0.8)',
                    borderColor: '#8B1538',
                    borderWidth: 1,
                    borderRadius: 8
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return 'Rp ' + value.toLocaleString('id-ID');
                            }
                        }
                    }
                }
            }
        });
        
        // Update chart based on period
        function updateChart() {
            const period = document.getElementById('chartPeriod').value;
            // In real implementation, fetch data based on period
            console.log('Chart period:', period);
        }
        
        // Filter transactions
        function filterTransactions() {
            const filter = document.getElementById('transactionFilter').value;
            const rows = document.querySelectorAll('.transaction-row');
            
            rows.forEach(row => {
                if (!filter || row.dataset.type === filter) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }
    </script>
</body>
</html>
