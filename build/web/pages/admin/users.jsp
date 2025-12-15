<%-- 
    Document   : users
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Admin User Management Page
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
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <jsp:include page="/pages/common/navbar-dashboard.jsp"/>
    
    <div class="dashboard-layout">
        <!-- Admin Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-menu">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-item">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/admin/users" class="sidebar-item active">
                    <i class="fas fa-users"></i> Pengguna
                </a>
                <a href="${pageContext.request.contextPath}/admin/courses" class="sidebar-item">
                    <i class="fas fa-book"></i> Kursus
                </a>
                <a href="${pageContext.request.contextPath}/admin/categories" class="sidebar-item">
                    <i class="fas fa-folder"></i> Kategori
                </a>
                <a href="${pageContext.request.contextPath}/admin/transactions" class="sidebar-item">
                    <i class="fas fa-credit-card"></i> Transaksi
                </a>
                <a href="${pageContext.request.contextPath}/admin/reports" class="sidebar-item">
                    <i class="fas fa-chart-bar"></i> Laporan
                </a>
                <div class="sidebar-divider"></div>
                <a href="${pageContext.request.contextPath}/admin/settings" class="sidebar-item">
                    <i class="fas fa-cog"></i> Pengaturan
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="sidebar-item" style="color: var(--error);">
                    <i class="fas fa-sign-out-alt"></i> Keluar
                </a>
            </div>
        </aside>
        
        <!-- Main Content -->
        <main class="main-content">
            <div class="page-header" style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h1 class="page-title">Manajemen Pengguna</h1>
                    <p class="page-subtitle">Kelola semua pengguna platform</p>
                </div>
                <button onclick="showAddUserModal()" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Tambah Pengguna
                </button>
            </div>
            
            <!-- Stats Cards -->
            <div class="stats-grid" style="grid-template-columns: repeat(3, 1fr); margin-bottom: 2rem;">
                <div class="stat-card">
                    <div class="stat-card-icon primary"><i class="fas fa-user-graduate"></i></div>
                    <div class="stat-card-value">${users.stream().filter(u -> u.role.name() == 'STUDENT').count()}</div>
                    <div class="stat-card-label">Total Pelajar</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-icon success"><i class="fas fa-chalkboard-teacher"></i></div>
                    <div class="stat-card-value">${users.stream().filter(u -> u.role.name() == 'LECTURER').count()}</div>
                    <div class="stat-card-label">Total Pengajar</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-icon warning"><i class="fas fa-user-shield"></i></div>
                    <div class="stat-card-value">${users.stream().filter(u -> u.role.name() == 'ADMIN').count()}</div>
                    <div class="stat-card-label">Total Admin</div>
                </div>
            </div>
            
            <!-- Filter & Search -->
            <div style="display: flex; gap: 1rem; margin-bottom: 1.5rem; flex-wrap: wrap;">
                <div class="navbar-search" style="flex: 1; max-width: 400px;">
                    <i class="fas fa-search"></i>
                    <input type="text" id="searchUser" placeholder="Cari pengguna..." style="width: 100%;" onkeyup="filterUsers()">
                </div>
                <select id="filterRole" class="form-input" style="width: auto;" onchange="filterUsers()">
                    <option value="">Semua Role</option>
                    <option value="STUDENT">Pelajar</option>
                    <option value="LECTURER">Pengajar</option>
                    <option value="ADMIN">Admin</option>
                </select>
                <select id="filterStatus" class="form-input" style="width: auto;" onchange="filterUsers()">
                    <option value="">Semua Status</option>
                    <option value="active">Aktif</option>
                    <option value="inactive">Nonaktif</option>
                </select>
            </div>
            
            <!-- Users Table -->
            <div class="table-container">
                <table class="data-table" id="usersTable">
                    <thead>
                        <tr>
                            <th>Pengguna</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th>Tanggal Daftar</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr data-role="${user.role}" data-status="${user.active ? 'active' : 'inactive'}">
                                <td>
                                    <div style="display: flex; align-items: center; gap: 0.75rem;">
                                        <img src="https://ui-avatars.com/api/?name=${user.name}&background=8B1538&color=fff" 
                                             style="width: 40px; height: 40px; border-radius: 50%;">
                                        <div>
                                            <strong>${user.name}</strong>
                                            <c:if test="${user.phone != null}">
                                                <br><small style="color: var(--gray-500);">${user.phone}</small>
                                            </c:if>
                                        </div>
                                    </div>
                                </td>
                                <td>${user.email}</td>
                                <td>
                                    <span class="badge badge-${user.role == 'ADMIN' ? 'error' : user.role == 'LECTURER' ? 'success' : 'primary'}">
                                        ${user.roleDisplayName}
                                    </span>
                                </td>
                                <td>
                                    <span class="badge badge-${user.active ? 'success' : 'warning'}">
                                        ${user.active ? 'Aktif' : 'Nonaktif'}
                                    </span>
                                </td>
                                <td>
                                    <fmt:formatDate value="${user.createdAt}" pattern="dd MMM yyyy"/>
                                </td>
                                <td>
                                    <div style="display: flex; gap: 0.5rem;">
                                        <button onclick="viewUser(${user.userId})" class="btn btn-sm btn-ghost" title="Lihat Detail">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button onclick="editUser(${user.userId})" class="btn btn-sm btn-ghost" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <c:if test="${user.role != 'ADMIN'}">
                                            <button onclick="toggleUserStatus(${user.userId}, ${user.active})" 
                                                    class="btn btn-sm btn-ghost" 
                                                    title="${user.active ? 'Nonaktifkan' : 'Aktifkan'}"
                                                    style="color: ${user.active ? 'var(--warning)' : 'var(--success)'}">
                                                <i class="fas fa-${user.active ? 'ban' : 'check-circle'}"></i>
                                            </button>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty users}">
                            <tr>
                                <td colspan="6" style="text-align: center; padding: 3rem;">
                                    <i class="fas fa-users" style="font-size: 3rem; color: var(--gray-300); margin-bottom: 1rem;"></i>
                                    <p style="color: var(--gray-500);">Belum ada pengguna</p>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
    
    <!-- Add User Modal -->
    <div class="modal-backdrop" id="addUserModal" onclick="if(event.target===this) closeModal('addUserModal')">
        <div class="modal" onclick="event.stopPropagation()">
            <div class="modal-header">
                <h3 class="modal-title">Tambah Pengguna Baru</h3>
                <button class="modal-close" onclick="closeModal('addUserModal')">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/user/add" method="POST">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="form-label">Nama Lengkap</label>
                        <input type="text" name="name" class="form-input" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-input" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" class="form-input" required minlength="8">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Role</label>
                        <select name="role" class="form-input" required>
                            <option value="STUDENT">Pelajar</option>
                            <option value="LECTURER">Pengajar</option>
                            <option value="ADMIN">Admin</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Nomor Telepon</label>
                        <input type="tel" name="phone" class="form-input">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-ghost" onclick="closeModal('addUserModal')">Batal</button>
                    <button type="submit" class="btn btn-primary">Simpan</button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        function showAddUserModal() {
            document.getElementById('addUserModal').classList.add('show');
        }
        
        function closeModal(modalId) {
            document.getElementById(modalId).classList.remove('show');
        }
        
        function filterUsers() {
            const searchTerm = document.getElementById('searchUser').value.toLowerCase();
            const roleFilter = document.getElementById('filterRole').value;
            const statusFilter = document.getElementById('filterStatus').value;
            
            document.querySelectorAll('#usersTable tbody tr').forEach(row => {
                const text = row.textContent.toLowerCase();
                const role = row.dataset.role;
                const status = row.dataset.status;
                
                const matchesSearch = text.includes(searchTerm);
                const matchesRole = !roleFilter || role === roleFilter;
                const matchesStatus = !statusFilter || status === statusFilter;
                
                row.style.display = matchesSearch && matchesRole && matchesStatus ? '' : 'none';
            });
        }
        
        function viewUser(userId) {
            window.location.href = '${pageContext.request.contextPath}/admin/user/' + userId;
        }
        
        function editUser(userId) {
            window.location.href = '${pageContext.request.contextPath}/admin/user/edit/' + userId;
        }
        
        function toggleUserStatus(userId, currentStatus) {
            if (confirm(currentStatus ? 'Nonaktifkan pengguna ini?' : 'Aktifkan pengguna ini?')) {
                window.location.href = '${pageContext.request.contextPath}/admin/user/toggle/' + userId;
            }
        }
    </script>
</body>
</html>
