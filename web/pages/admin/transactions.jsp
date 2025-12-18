<%-- 
    Document   : transactions
    Created on : Dec 18, 2025
    Author     : NusaTech
    Description: Admin Transaction Management with Bootstrap 5
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manajemen Transaksi - Admin NusaTech</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root { --primary: #8B1538; --admin: #1f2937; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #f8f9fa; }
        .btn-primary { background-color: var(--admin); border-color: var(--admin); }
        .btn-primary:hover { background-color: #374151; border-color: #374151; }
        .form-control:focus, .form-select:focus { border-color: var(--admin); box-shadow: 0 0 0 0.2rem rgba(31, 41, 55, 0.15); }
        
        .dashboard-wrapper { display: flex; min-height: 100vh; padding-top: 56px; }
        .main-content { flex: 1; margin-left: 280px; padding: 2rem; }
        @media (max-width: 991.98px) { .main-content { margin-left: 0; } }
        
        .stat-card { background: white; border-radius: 1rem; padding: 1.5rem; box-shadow: 0 2px 8px rgba(0,0,0,0.04); }
        .stat-icon { width: 56px; height: 56px; border-radius: 1rem; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; }
        .stat-value { font-size: 1.5rem; font-weight: 800; color: #1f2937; }
        .stat-label { font-size: 0.8rem; color: #6b7280; }
        
        .table-card { background: white; border-radius: 1rem; box-shadow: 0 2px 8px rgba(0,0,0,0.04); overflow: hidden; }
        .table-header { padding: 1.25rem 1.5rem; border-bottom: 1px solid #e5e7eb; }
        
        .status-badge { font-size: 0.75rem; padding: 0.35rem 0.75rem; border-radius: 1rem; font-weight: 600; }
        
        .action-btn { width: 32px; height: 32px; padding: 0; display: inline-flex; align-items: center; justify-content: center; border-radius: 0.5rem; }
        
        .user-avatar { width: 36px; height: 36px; border-radius: 50%; }
        
        .page-link { color: var(--admin); }
        .page-item.active .page-link { background-color: var(--admin); border-color: var(--admin); }
        
        .payment-proof { max-width: 100%; max-height: 300px; border-radius: 0.5rem; }
        
        .transaction-item { padding: 0.75rem 0; border-bottom: 1px solid #f3f4f6; }
        .transaction-item:last-child { border-bottom: none; }
    </style>
</head>
<body>
    <jsp:include page="/pages/common/navbar-dashboard.jsp"/>
    
    <div class="dashboard-wrapper">
        <jsp:include page="/pages/common/sidebar-admin.jsp"/>
        
        <main class="main-content">
            <button class="btn btn-outline-secondary d-lg-none mb-3" onclick="document.getElementById('adminSidebar').classList.toggle('show')">
                <i class="fas fa-bars me-2"></i> Menu
            </button>
            
            <!-- Header -->
            <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
                <div>
                    <h1 class="h3 fw-bold mb-1"><i class="fas fa-credit-card me-2" style="color: var(--admin);"></i>Manajemen Transaksi</h1>
                    <p class="text-muted mb-0">Kelola semua transaksi pembayaran</p>
                </div>
                <button class="btn btn-outline-secondary">
                    <i class="fas fa-download me-2"></i> Export CSV
                </button>
            </div>
            
            <!-- Stats -->
            <div class="row g-4 mb-4">
                <div class="col-sm-6 col-xl-3">
                    <div class="stat-card">
                        <div class="d-flex align-items-center gap-3">
                            <div class="stat-icon" style="background: rgba(16, 185, 129, 0.1); color: #10b981;">
                                <i class="fas fa-check-circle"></i>
                            </div>
                            <div>
                                <div class="stat-value text-success">
                                    <small>Rp</small> <fmt:formatNumber value="${totalPaid != null ? totalPaid : 125000000}" pattern="#,###"/>
                                </div>
                                <div class="stat-label">Total Dibayar</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-xl-3">
                    <div class="stat-card">
                        <div class="d-flex align-items-center gap-3">
                            <div class="stat-icon" style="background: rgba(245, 158, 11, 0.1); color: #f59e0b;">
                                <i class="fas fa-clock"></i>
                            </div>
                            <div>
                                <div class="stat-value text-warning">
                                    <small>Rp</small> <fmt:formatNumber value="${totalPending != null ? totalPending : 15000000}" pattern="#,###"/>
                                </div>
                                <div class="stat-label">Pending Verifikasi</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-xl-3">
                    <div class="stat-card">
                        <div class="d-flex align-items-center gap-3">
                            <div class="stat-icon" style="background: rgba(239, 68, 68, 0.1); color: #ef4444;">
                                <i class="fas fa-times-circle"></i>
                            </div>
                            <div>
                                <div class="stat-value text-danger">
                                    <small>Rp</small> <fmt:formatNumber value="${totalFailed != null ? totalFailed : 5000000}" pattern="#,###"/>
                                </div>
                                <div class="stat-label">Gagal/Expired</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-xl-3">
                    <div class="stat-card">
                        <div class="d-flex align-items-center gap-3">
                            <div class="stat-icon" style="background: rgba(59, 130, 246, 0.1); color: #3b82f6;">
                                <i class="fas fa-receipt"></i>
                            </div>
                            <div>
                                <div class="stat-value">${totalTransactions != null ? totalTransactions : 523}</div>
                                <div class="stat-label">Total Transaksi</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Table Card -->
            <div class="table-card">
                <div class="table-header">
                    <div class="row g-3 align-items-center">
                        <div class="col-md-3">
                            <div class="input-group">
                                <span class="input-group-text bg-white"><i class="fas fa-search text-muted"></i></span>
                                <input type="text" class="form-control" id="searchTransaction" placeholder="Cari kode transaksi..." onkeyup="filterTransactions()">
                            </div>
                        </div>
                        <div class="col-md-2">
                            <select class="form-select" id="filterStatus" onchange="filterTransactions()">
                                <option value="">Semua Status</option>
                                <option value="PAID" ${param.status == 'PAID' ? 'selected' : ''}>Paid</option>
                                <option value="PENDING" ${param.status == 'PENDING' ? 'selected' : ''}>Pending</option>
                                <option value="FAILED" ${param.status == 'FAILED' ? 'selected' : ''}>Failed</option>
                                <option value="EXPIRED" ${param.status == 'EXPIRED' ? 'selected' : ''}>Expired</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <select class="form-select" id="filterMethod" onchange="filterTransactions()">
                                <option value="">Semua Metode</option>
                                <option value="BANK_TRANSFER">Bank Transfer</option>
                                <option value="VIRTUAL_ACCOUNT">Virtual Account</option>
                                <option value="E_WALLET">E-Wallet</option>
                                <option value="BALANCE">Balance</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <div class="input-group">
                                <input type="date" class="form-control" id="dateFrom" onchange="filterTransactions()">
                                <span class="input-group-text">-</span>
                                <input type="date" class="form-control" id="dateTo" onchange="filterTransactions()">
                            </div>
                        </div>
                        <div class="col-md-2 text-end">
                            <span class="text-muted">Total: <strong id="transactionCount">${transactions != null ? transactions.size() : 0}</strong></span>
                        </div>
                    </div>
                </div>
                
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0" id="transactionsTable">
                        <thead class="table-light">
                            <tr>
                                <th>Kode Transaksi</th>
                                <th>Pelanggan</th>
                                <th>Item</th>
                                <th>Metode</th>
                                <th class="text-end">Total</th>
                                <th>Status</th>
                                <th>Tanggal</th>
                                <th style="width: 100px;">Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="tx" items="${transactions}">
                                <tr data-status="${tx.paymentStatus}" data-method="${tx.paymentMethod}">
                                    <td>
                                        <span class="fw-semibold font-monospace">${tx.transactionCode}</span>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center gap-2">
                                            <img src="https://ui-avatars.com/api/?name=${tx.user.name}&background=3b82f6&color=fff&size=36" class="user-avatar">
                                            <div>
                                                <div class="fw-semibold small">${tx.user.name}</div>
                                                <small class="text-muted">${tx.user.email}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty tx.items}">
                                                <span class="small">${tx.items.size()} item</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="small text-muted">-</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><span class="badge bg-light text-dark">${tx.paymentMethodDisplayName}</span></td>
                                    <td class="text-end fw-semibold">Rp <fmt:formatNumber value="${tx.totalAmount}" pattern="#,###"/></td>
                                    <td>
                                        <span class="status-badge ${tx.paymentStatus == 'PAID' ? 'bg-success-subtle text-success' : tx.paymentStatus == 'PENDING' ? 'bg-warning-subtle text-warning' : 'bg-danger-subtle text-danger'}">
                                            <i class="fas fa-circle me-1" style="font-size: 0.5rem;"></i>
                                            ${tx.paymentStatusDisplayName}
                                        </span>
                                    </td>
                                    <td><small><fmt:formatDate value="${tx.createdAt}" pattern="dd MMM yyyy HH:mm"/></small></td>
                                    <td>
                                        <div class="d-flex gap-1">
                                            <button class="btn btn-sm action-btn btn-outline-secondary" onclick="viewTransaction('${tx.transactionCode}')" title="Detail">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <c:if test="${tx.paymentStatus == 'PENDING' && tx.paymentMethod == 'BANK_TRANSFER'}">
                                                <button class="btn btn-sm action-btn btn-outline-success" onclick="verifyTransaction(${tx.transactionId}, '${tx.transactionCode}')" title="Verifikasi">
                                                    <i class="fas fa-check"></i>
                                                </button>
                                                <button class="btn btn-sm action-btn btn-outline-danger" onclick="rejectTransaction(${tx.transactionId})" title="Tolak">
                                                    <i class="fas fa-times"></i>
                                                </button>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty transactions}">
                                <!-- Sample data -->
                                <tr data-status="PENDING" data-method="BANK_TRANSFER">
                                    <td><span class="fw-semibold font-monospace">TRX-20251218-001</span></td>
                                    <td>
                                        <div class="d-flex align-items-center gap-2">
                                            <img src="https://ui-avatars.com/api/?name=Ahmad+Rizki&background=3b82f6&color=fff&size=36" class="user-avatar">
                                            <div>
                                                <div class="fw-semibold small">Ahmad Rizki</div>
                                                <small class="text-muted">ahmad@email.com</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td><span class="small">2 item</span></td>
                                    <td><span class="badge bg-light text-dark">Bank Transfer</span></td>
                                    <td class="text-end fw-semibold">Rp 499.000</td>
                                    <td><span class="status-badge bg-warning-subtle text-warning"><i class="fas fa-circle me-1" style="font-size: 0.5rem;"></i>Pending</span></td>
                                    <td><small>18 Des 2025 10:30</small></td>
                                    <td>
                                        <div class="d-flex gap-1">
                                            <button class="btn btn-sm action-btn btn-outline-secondary" onclick="viewTransaction('TRX-20251218-001')" title="Detail"><i class="fas fa-eye"></i></button>
                                            <button class="btn btn-sm action-btn btn-outline-success" onclick="verifyTransaction(1, 'TRX-20251218-001')" title="Verifikasi"><i class="fas fa-check"></i></button>
                                            <button class="btn btn-sm action-btn btn-outline-danger" onclick="rejectTransaction(1)" title="Tolak"><i class="fas fa-times"></i></button>
                                        </div>
                                    </td>
                                </tr>
                                <tr data-status="PAID" data-method="E_WALLET">
                                    <td><span class="fw-semibold font-monospace">TRX-20251217-045</span></td>
                                    <td>
                                        <div class="d-flex align-items-center gap-2">
                                            <img src="https://ui-avatars.com/api/?name=Siti+Aminah&background=10b981&color=fff&size=36" class="user-avatar">
                                            <div>
                                                <div class="fw-semibold small">Siti Aminah</div>
                                                <small class="text-muted">siti@email.com</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td><span class="small">1 item</span></td>
                                    <td><span class="badge bg-light text-dark">GoPay</span></td>
                                    <td class="text-end fw-semibold">Rp 199.000</td>
                                    <td><span class="status-badge bg-success-subtle text-success"><i class="fas fa-circle me-1" style="font-size: 0.5rem;"></i>Paid</span></td>
                                    <td><small>17 Des 2025 14:22</small></td>
                                    <td>
                                        <div class="d-flex gap-1">
                                            <button class="btn btn-sm action-btn btn-outline-secondary" onclick="viewTransaction('TRX-20251217-045')" title="Detail"><i class="fas fa-eye"></i></button>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
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
                                        <a class="page-link" href="?page=${currentPage - 1}&status=${param.status}"><i class="fas fa-chevron-left"></i></a>
                                    </li>
                                </c:if>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="?page=${i}&status=${param.status}">${i}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentPage + 1}&status=${param.status}"><i class="fas fa-chevron-right"></i></a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                </c:if>
            </div>
        </main>
    </div>
    
    <!-- Transaction Detail Modal -->
    <div class="modal fade" id="detailModal" tabindex="-1">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-0">
                    <h5 class="modal-title"><i class="fas fa-receipt me-2" style="color: var(--admin);"></i>Detail Transaksi</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="detailBody">
                    <div class="text-center py-4">
                        <div class="spinner-border" role="status"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Verify Modal -->
    <div class="modal fade" id="verifyModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/admin/transaction/verify" method="POST" id="verifyForm">
                    <input type="hidden" name="transactionId" id="verifyTransactionId">
                    <div class="modal-header border-0">
                        <h5 class="modal-title text-success"><i class="fas fa-check-circle me-2"></i>Verifikasi Pembayaran</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <p>Verifikasi pembayaran untuk transaksi <strong id="verifyCode"></strong>?</p>
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle me-2"></i>
                            Pastikan Anda sudah memeriksa bukti pembayaran sebelum memverifikasi.
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Catatan (Opsional)</label>
                            <textarea name="note" class="form-control" rows="2" placeholder="Catatan verifikasi..."></textarea>
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                        <button type="submit" class="btn btn-success"><i class="fas fa-check me-2"></i>Verifikasi</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Reject Modal -->
    <div class="modal fade" id="rejectModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/admin/transaction/reject" method="POST" id="rejectForm">
                    <input type="hidden" name="transactionId" id="rejectTransactionId">
                    <div class="modal-header border-0">
                        <h5 class="modal-title text-danger"><i class="fas fa-times-circle me-2"></i>Tolak Pembayaran</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Alasan Penolakan <span class="text-danger">*</span></label>
                            <textarea name="reason" class="form-control" rows="3" required placeholder="Jelaskan alasan penolakan..."></textarea>
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                        <button type="submit" class="btn btn-danger"><i class="fas fa-times me-2"></i>Tolak</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function filterTransactions() {
            const search = document.getElementById('searchTransaction').value.toLowerCase();
            const status = document.getElementById('filterStatus').value;
            const method = document.getElementById('filterMethod').value;
            let count = 0;
            
            document.querySelectorAll('#transactionsTable tbody tr').forEach(row => {
                if (!row.dataset.status) return;
                const text = row.textContent.toLowerCase();
                const matchSearch = text.includes(search);
                const matchStatus = !status || row.dataset.status === status;
                const matchMethod = !method || row.dataset.method === method;
                const show = matchSearch && matchStatus && matchMethod;
                row.style.display = show ? '' : 'none';
                if (show) count++;
            });
            
            document.getElementById('transactionCount').textContent = count;
        }
        
        function viewTransaction(code) {
            const modal = new bootstrap.Modal(document.getElementById('detailModal'));
            const body = document.getElementById('detailBody');
            body.innerHTML = '<div class="text-center py-4"><div class="spinner-border" role="status"></div></div>';
            modal.show();
            
            // Fetch transaction details (mock)
            setTimeout(() => {
                body.innerHTML = `
                    <div class="row g-4">
                        <div class="col-md-6">
                            <h6 class="fw-bold mb-3">Informasi Transaksi</h6>
                            <table class="table table-sm">
                                <tr><td class="text-muted">Kode</td><td class="fw-semibold font-monospace">${code}</td></tr>
                                <tr><td class="text-muted">Tanggal</td><td>18 Des 2025, 10:30</td></tr>
                                <tr><td class="text-muted">Status</td><td><span class="badge bg-warning">Pending</span></td></tr>
                                <tr><td class="text-muted">Metode</td><td>Bank Transfer - BCA</td></tr>
                            </table>
                            
                            <h6 class="fw-bold mb-3 mt-4">Pelanggan</h6>
                            <div class="d-flex align-items-center gap-3">
                                <img src="https://ui-avatars.com/api/?name=Ahmad&background=3b82f6&color=fff" class="rounded-circle" style="width: 50px; height: 50px;">
                                <div>
                                    <div class="fw-semibold">Ahmad Rizki</div>
                                    <small class="text-muted">ahmad@email.com</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <h6 class="fw-bold mb-3">Item Pembelian</h6>
                            <div class="transaction-item d-flex justify-content-between">
                                <div>
                                    <div class="fw-semibold">Belajar Python dari Nol</div>
                                    <small class="text-muted">Kursus</small>
                                </div>
                                <span class="fw-semibold">Rp 299.000</span>
                            </div>
                            <div class="transaction-item d-flex justify-content-between">
                                <div>
                                    <div class="fw-semibold">Web Development Modern</div>
                                    <small class="text-muted">Kursus</small>
                                </div>
                                <span class="fw-semibold">Rp 200.000</span>
                            </div>
                            <div class="transaction-item d-flex justify-content-between bg-light p-2 rounded">
                                <span class="fw-bold">Total</span>
                                <span class="fw-bold text-success">Rp 499.000</span>
                            </div>
                            
                            <h6 class="fw-bold mb-3 mt-4">Bukti Pembayaran</h6>
                            <img src="https://via.placeholder.com/300x200?text=Bukti+Transfer" class="payment-proof" alt="Bukti Pembayaran">
                        </div>
                    </div>
                `;
            }, 500);
        }
        
        function verifyTransaction(id, code) {
            document.getElementById('verifyTransactionId').value = id;
            document.getElementById('verifyCode').textContent = code;
            new bootstrap.Modal(document.getElementById('verifyModal')).show();
        }
        
        function rejectTransaction(id) {
            document.getElementById('rejectTransactionId').value = id;
            new bootstrap.Modal(document.getElementById('rejectModal')).show();
        }
    </script>
</body>
</html>
