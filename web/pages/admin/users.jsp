<%-- 
    Document   : users
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Admin User Management with Bootstrap 5
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manajemen Pengguna - Admin NusaTech</title>
    
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
        
        .stat-card { background: white; border-radius: 1rem; padding: 1.25rem; box-shadow: 0 2px 8px rgba(0,0,0,0.04); }
        .stat-icon { width: 48px; height: 48px; border-radius: 0.75rem; display: flex; align-items: center; justify-content: center; font-size: 1.25rem; }
        
        .table-card { background: white; border-radius: 1rem; box-shadow: 0 2px 8px rgba(0,0,0,0.04); overflow: hidden; }
        .table-header { padding: 1.25rem 1.5rem; border-bottom: 1px solid #e5e7eb; }
        
        .user-avatar { width: 40px; height: 40px; border-radius: 50%; }
        
        .status-badge { font-size: 0.75rem; padding: 0.35rem 0.75rem; border-radius: 1rem; font-weight: 600; }
        
        .action-btn { width: 32px; height: 32px; padding: 0; display: inline-flex; align-items: center; justify-content: center; border-radius: 0.5rem; }
        
        .page-link { color: var(--admin); }
        .page-item.active .page-link { background-color: var(--admin); border-color: var(--admin); }
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
                    <h1 class="h3 fw-bold mb-1"><i class="fas fa-users me-2" style="color: var(--admin);"></i>Manajemen Pengguna</h1>
                    <p class="text-muted mb-0">Kelola semua pengguna platform</p>
                </div>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
                    <i class="fas fa-plus me-2"></i> Tambah Pengguna
                </button>
            </div>
            
            <!-- Stats -->
            <div class="row g-3 mb-4">
                <div class="col-6 col-lg-3">
                    <div class="stat-card d-flex align-items-center gap-3">
                        <div class="stat-icon" style="background: rgba(59, 130, 246, 0.1); color: #3b82f6;">
                            <i class="fas fa-user-graduate"></i>
                        </div>
                        <div>
                            <div class="fs-4 fw-bold">${totalStudents != null ? totalStudents : 0}</div>
                            <div class="text-muted small">Pelajar</div>
                        </div>
                    </div>
                </div>
                <div class="col-6 col-lg-3">
                    <div class="stat-card d-flex align-items-center gap-3">
                        <div class="stat-icon" style="background: rgba(16, 185, 129, 0.1); color: #10b981;">
                            <i class="fas fa-chalkboard-teacher"></i>
                        </div>
                        <div>
                            <div class="fs-4 fw-bold">${totalLecturers != null ? totalLecturers : 0}</div>
                            <div class="text-muted small">Pengajar</div>
                        </div>
                    </div>
                </div>
                <div class="col-6 col-lg-3">
                    <div class="stat-card d-flex align-items-center gap-3">
                        <div class="stat-icon" style="background: rgba(239, 68, 68, 0.1); color: #ef4444;">
                            <i class="fas fa-user-shield"></i>
                        </div>
                        <div>
                            <div class="fs-4 fw-bold">${totalAdmins != null ? totalAdmins : 0}</div>
                            <div class="text-muted small">Admin</div>
                        </div>
                    </div>
                </div>
                <div class="col-6 col-lg-3">
                    <div class="stat-card d-flex align-items-center gap-3">
                        <div class="stat-icon" style="background: rgba(245, 158, 11, 0.1); color: #f59e0b;">
                            <i class="fas fa-user-plus"></i>
                        </div>
                        <div>
                            <div class="fs-4 fw-bold">${newThisMonth != null ? newThisMonth : 0}</div>
                            <div class="text-muted small">Baru Bulan Ini</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Table Card -->
            <div class="table-card">
                <div class="table-header">
                    <div class="row g-3 align-items-center">
                        <div class="col-md-4">
                            <div class="input-group">
                                <span class="input-group-text bg-white"><i class="fas fa-search text-muted"></i></span>
                                <input type="text" class="form-control" id="searchUser" placeholder="Cari pengguna..." onkeyup="filterUsers()">
                            </div>
                        </div>
                        <div class="col-md-2">
                            <select class="form-select" id="filterRole" onchange="filterUsers()">
                                <option value="">Semua Role</option>
                                <option value="STUDENT" ${param.role == 'STUDENT' ? 'selected' : ''}>Pelajar</option>
                                <option value="LECTURER" ${param.role == 'LECTURER' ? 'selected' : ''}>Pengajar</option>
                                <option value="ADMIN" ${param.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <select class="form-select" id="filterStatus" onchange="filterUsers()">
                                <option value="">Semua Status</option>
                                <option value="active">Aktif</option>
                                <option value="inactive">Nonaktif</option>
                            </select>
                        </div>
                        <div class="col-md-4 text-end">
                            <span class="text-muted">Total: <strong id="userCount">${users != null ? users.size() : 0}</strong> pengguna</span>
                        </div>
                    </div>
                </div>
                
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0" id="usersTable">
                        <thead class="table-light">
                            <tr>
                                <th style="width: 40px;"><input type="checkbox" class="form-check-input" id="selectAll"></th>
                                <th>Pengguna</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Status</th>
                                <th>Tanggal Daftar</th>
                                <th style="width: 120px;">Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr data-role="${user.role}" data-status="${user.active ? 'active' : 'inactive'}">
                                    <td><input type="checkbox" class="form-check-input user-check" value="${user.userId}"></td>
                                    <td>
                                        <div class="d-flex align-items-center gap-2">
                                            <img src="https://ui-avatars.com/api/?name=${user.name}&background=${user.role == 'ADMIN' ? 'ef4444' : user.role == 'LECTURER' ? '10b981' : '3b82f6'}&color=fff" class="user-avatar">
                                            <div>
                                                <div class="fw-semibold">${user.name}</div>
                                                <c:if test="${not empty user.phone}">
                                                    <small class="text-muted">${user.phone}</small>
                                                </c:if>
                                            </div>
                                        </div>
                                    </td>
                                    <td>${user.email}</td>
                                    <td>
                                        <span class="status-badge ${user.role == 'ADMIN' ? 'bg-danger-subtle text-danger' : user.role == 'LECTURER' ? 'bg-success-subtle text-success' : 'bg-primary-subtle text-primary'}">
                                            ${user.roleDisplayName}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="status-badge ${user.active ? 'bg-success-subtle text-success' : 'bg-warning-subtle text-warning'}">
                                            <i class="fas fa-circle me-1" style="font-size: 0.5rem;"></i>
                                            ${user.active ? 'Aktif' : 'Nonaktif'}
                                        </span>
                                    </td>
                                    <td><fmt:formatDate value="${user.createdAt}" pattern="dd MMM yyyy"/></td>
                                    <td>
                                        <div class="d-flex gap-1">
                                            <button class="btn btn-sm action-btn btn-outline-secondary" onclick="viewUser(${user.userId})" title="Detail">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <button class="btn btn-sm action-btn btn-outline-primary" onclick="editUser(${user.userId})" title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <c:if test="${user.role != 'ADMIN'}">
                                                <button class="btn btn-sm action-btn ${user.active ? 'btn-outline-warning' : 'btn-outline-success'}" 
                                                        onclick="toggleStatus(${user.userId}, ${user.active})" 
                                                        title="${user.active ? 'Nonaktifkan' : 'Aktifkan'}">
                                                    <i class="fas ${user.active ? 'fa-ban' : 'fa-check'}"></i>
                                                </button>
                                            </c:if>
                                            <c:if test="${user.role != 'ADMIN'}">
                                                <button class="btn btn-sm action-btn btn-outline-danger" onclick="deleteUser(${user.userId}, '${user.name}')" title="Hapus">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty users}">
                                <tr>
                                    <td colspan="7" class="text-center py-5">
                                        <i class="fas fa-users fa-3x text-muted mb-3"></i>
                                        <p class="text-muted mb-0">Belum ada pengguna</p>
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
                                        <a class="page-link" href="?page=${currentPage - 1}&role=${param.role}&status=${param.status}">
                                            <i class="fas fa-chevron-left"></i>
                                        </a>
                                    </li>
                                </c:if>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="?page=${i}&role=${param.role}&status=${param.status}">${i}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentPage + 1}&role=${param.role}&status=${param.status}">
                                            <i class="fas fa-chevron-right"></i>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                </c:if>
            </div>
        </main>
    </div>
    
    <!-- Add User Modal -->
    <div class="modal fade" id="addUserModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/admin/user/add" method="POST">
                    <div class="modal-header border-0">
                        <h5 class="modal-title"><i class="fas fa-user-plus me-2" style="color: var(--admin);"></i>Tambah Pengguna</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Nama Lengkap <span class="text-danger">*</span></label>
                            <input type="text" name="name" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Email <span class="text-danger">*</span></label>
                            <input type="email" name="email" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Password <span class="text-danger">*</span></label>
                            <input type="password" name="password" class="form-control" required minlength="8">
                            <div class="form-text">Minimal 8 karakter</div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Role <span class="text-danger">*</span></label>
                                <select name="role" class="form-select" required>
                                    <option value="STUDENT">Pelajar</option>
                                    <option value="LECTURER">Pengajar</option>
                                    <option value="ADMIN">Admin</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Telepon</label>
                                <input type="tel" name="phone" class="form-control">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                        <button type="submit" class="btn btn-primary"><i class="fas fa-save me-2"></i>Simpan</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Edit User Modal -->
    <div class="modal fade" id="editUserModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/admin/user/update" method="POST" id="editUserForm">
                    <input type="hidden" name="userId" id="editUserId">
                    <div class="modal-header border-0">
                        <h5 class="modal-title"><i class="fas fa-user-edit me-2" style="color: var(--admin);"></i>Edit Pengguna</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body" id="editUserBody">
                        <div class="text-center py-4">
                            <div class="spinner-border" role="status"></div>
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                        <button type="submit" class="btn btn-primary"><i class="fas fa-save me-2"></i>Update</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- View User Modal -->
    <div class="modal fade" id="viewUserModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-0">
                    <h5 class="modal-title"><i class="fas fa-user me-2" style="color: var(--admin);"></i>Detail Pengguna</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="viewUserBody">
                    <div class="text-center py-4">
                        <div class="spinner-border" role="status"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-0">
                    <h5 class="modal-title text-danger"><i class="fas fa-exclamation-triangle me-2"></i>Hapus Pengguna</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Apakah Anda yakin ingin menghapus pengguna "<strong id="deleteUserName"></strong>"?</p>
                    <p class="text-muted small mb-0">Tindakan ini tidak dapat dibatalkan.</p>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <form id="deleteForm" action="" method="POST" style="display: inline;">
                        <button type="submit" class="btn btn-danger">Ya, Hapus</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Select all checkbox
        document.getElementById('selectAll').addEventListener('change', function() {
            document.querySelectorAll('.user-check').forEach(cb => cb.checked = this.checked);
        });
        
        // Filter users
        function filterUsers() {
            const search = document.getElementById('searchUser').value.toLowerCase();
            const role = document.getElementById('filterRole').value;
            const status = document.getElementById('filterStatus').value;
            let count = 0;
            
            document.querySelectorAll('#usersTable tbody tr').forEach(row => {
                if (!row.dataset.role) return;
                const text = row.textContent.toLowerCase();
                const matchSearch = text.includes(search);
                const matchRole = !role || row.dataset.role === role;
                const matchStatus = !status || row.dataset.status === status;
                const show = matchSearch && matchRole && matchStatus;
                row.style.display = show ? '' : 'none';
                if (show) count++;
            });
            
            document.getElementById('userCount').textContent = count;
        }
        
        // View user
        function viewUser(userId) {
            const modal = new bootstrap.Modal(document.getElementById('viewUserModal'));
            const body = document.getElementById('viewUserBody');
            body.innerHTML = '<div class="text-center py-4"><div class="spinner-border" role="status"></div></div>';
            modal.show();
            
            // Fetch user data (mock)
            setTimeout(() => {
                body.innerHTML = `
                    <div class="text-center mb-4">
                        <img src="https://ui-avatars.com/api/?name=User&background=3b82f6&color=fff&size=80" class="rounded-circle mb-3" style="width: 80px; height: 80px;">
                        <h5 class="fw-bold mb-1">Nama Pengguna</h5>
                        <span class="badge bg-primary">Pelajar</span>
                    </div>
                    <div class="row g-3">
                        <div class="col-6"><strong>Email:</strong><br>user@email.com</div>
                        <div class="col-6"><strong>Telepon:</strong><br>+62 812-xxxx-xxxx</div>
                        <div class="col-6"><strong>Bergabung:</strong><br>10 Des 2025</div>
                        <div class="col-6"><strong>Status:</strong><br><span class="badge bg-success">Aktif</span></div>
                    </div>
                `;
            }, 500);
        }
        
        // Edit user
        function editUser(userId) {
            const modal = new bootstrap.Modal(document.getElementById('editUserModal'));
            const body = document.getElementById('editUserBody');
            document.getElementById('editUserId').value = userId;
            body.innerHTML = '<div class="text-center py-4"><div class="spinner-border" role="status"></div></div>';
            modal.show();
            
            // Fetch and populate form (mock)
            setTimeout(() => {
                body.innerHTML = `
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Nama Lengkap</label>
                        <input type="text" name="name" class="form-control" value="Nama User">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Email</label>
                        <input type="email" name="email" class="form-control" value="user@email.com">
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Role</label>
                            <select name="role" class="form-select">
                                <option value="STUDENT" selected>Pelajar</option>
                                <option value="LECTURER">Pengajar</option>
                                <option value="ADMIN">Admin</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Telepon</label>
                            <input type="tel" name="phone" class="form-control" value="+62812xxxx">
                        </div>
                    </div>
                `;
            }, 500);
        }
        
        // Toggle status
        function toggleStatus(userId, currentStatus) {
            if (confirm(currentStatus ? 'Nonaktifkan pengguna ini?' : 'Aktifkan pengguna ini?')) {
                window.location.href = '${pageContext.request.contextPath}/admin/user/toggle/' + userId;
            }
        }
        
        // Delete user
        function deleteUser(userId, name) {
            document.getElementById('deleteUserName').textContent = name;
            document.getElementById('deleteForm').action = '${pageContext.request.contextPath}/admin/user/delete/' + userId;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
    </script>
</body>
</html>
