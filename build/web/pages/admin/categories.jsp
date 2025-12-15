<%-- 
    Document   : categories
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Admin Category Management Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manajemen Kategori - Admin NusaTech</title>
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
                <a href="${pageContext.request.contextPath}/admin/users" class="sidebar-item">
                    <i class="fas fa-users"></i> Pengguna
                </a>
                <a href="${pageContext.request.contextPath}/admin/courses" class="sidebar-item">
                    <i class="fas fa-book"></i> Kursus
                </a>
                <a href="${pageContext.request.contextPath}/admin/categories" class="sidebar-item active">
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
                    <h1 class="page-title">Manajemen Kategori</h1>
                    <p class="page-subtitle">Kelola kategori kursus</p>
                </div>
                <button onclick="showAddCategoryModal()" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Tambah Kategori
                </button>
            </div>
            
            <!-- Categories Grid -->
            <div class="grid grid-3">
                <c:forEach var="category" items="${categories}">
                    <div class="card" style="padding: 1.5rem;">
                        <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 1rem;">
                            <div class="category-card-icon" style="width: 56px; height: 56px; font-size: 1.25rem; background: ${category.color}20; color: ${category.color};">
                                <i class="${category.icon}"></i>
                            </div>
                            <div style="display: flex; gap: 0.25rem;">
                                <button onclick="editCategory(${category.categoryId})" class="btn btn-sm btn-ghost" title="Edit">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button onclick="deleteCategory(${category.categoryId})" class="btn btn-sm btn-ghost" style="color: var(--error);" title="Hapus">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </div>
                        <h3 style="font-size: 1.125rem; margin-bottom: 0.25rem;">${category.name}</h3>
                        <p style="font-size: 0.875rem; color: var(--gray-500); margin-bottom: 1rem; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                            ${category.description}
                        </p>
                        <div style="display: flex; justify-content: space-between; align-items: center; padding-top: 1rem; border-top: 1px solid var(--gray-100);">
                            <span style="font-size: 0.875rem; color: var(--gray-600);">
                                <i class="fas fa-book"></i> ${category.courseCount} Kursus
                            </span>
                            <span class="badge badge-${category.active ? 'success' : 'warning'}">
                                ${category.active ? 'Aktif' : 'Nonaktif'}
                            </span>
                        </div>
                    </div>
                </c:forEach>
                
                <c:if test="${empty categories}">
                    <div class="empty-state" style="grid-column: 1 / -1;">
                        <div class="empty-state-icon">
                            <i class="fas fa-folder"></i>
                        </div>
                        <h3 class="empty-state-title">Belum Ada Kategori</h3>
                        <p class="empty-state-description">Tambahkan kategori pertama untuk mengelompokkan kursus.</p>
                        <button onclick="showAddCategoryModal()" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Tambah Kategori
                        </button>
                    </div>
                </c:if>
            </div>
        </main>
    </div>
    
    <!-- Add Category Modal -->
    <div class="modal-backdrop" id="addCategoryModal" onclick="if(event.target===this) closeModal('addCategoryModal')">
        <div class="modal" onclick="event.stopPropagation()">
            <div class="modal-header">
                <h3 class="modal-title">Tambah Kategori Baru</h3>
                <button class="modal-close" onclick="closeModal('addCategoryModal')">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/category/add" method="POST">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="form-label">Nama Kategori</label>
                        <input type="text" name="name" class="form-input" required placeholder="Contoh: Web Development">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Slug</label>
                        <input type="text" name="slug" class="form-input" required placeholder="Contoh: web-development">
                        <small class="form-hint">URL-friendly name, gunakan huruf kecil dan strip</small>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Deskripsi</label>
                        <textarea name="description" class="form-input" rows="3" placeholder="Deskripsi singkat kategori..."></textarea>
                    </div>
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                        <div class="form-group">
                            <label class="form-label">Icon (Font Awesome)</label>
                            <input type="text" name="icon" class="form-input" placeholder="fa-globe">
                            <small class="form-hint">Contoh: fa-globe, fa-mobile-alt</small>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Warna</label>
                            <input type="color" name="color" class="form-input" value="#8B1538" style="height: 44px;">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Urutan Tampilan</label>
                        <input type="number" name="displayOrder" class="form-input" value="0" min="0">
                    </div>
                    <div class="form-group">
                        <label class="form-check">
                            <input type="checkbox" name="isActive" checked>
                            <span>Aktif</span>
                        </label>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-ghost" onclick="closeModal('addCategoryModal')">Batal</button>
                    <button type="submit" class="btn btn-primary">Simpan</button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        function showAddCategoryModal() {
            document.getElementById('addCategoryModal').classList.add('show');
        }
        
        function closeModal(modalId) {
            document.getElementById(modalId).classList.remove('show');
        }
        
        function editCategory(categoryId) {
            window.location.href = '${pageContext.request.contextPath}/admin/category/edit/' + categoryId;
        }
        
        function deleteCategory(categoryId) {
            if (confirm('Hapus kategori ini? Semua kursus dalam kategori ini tidak akan memiliki kategori.')) {
                window.location.href = '${pageContext.request.contextPath}/admin/category/delete/' + categoryId;
            }
        }
        
        // Auto-generate slug from name
        document.querySelector('input[name="name"]').addEventListener('input', function() {
            const slug = this.value
                .toLowerCase()
                .replace(/[^a-z0-9]+/g, '-')
                .replace(/(^-|-$)/g, '');
            document.querySelector('input[name="slug"]').value = slug;
        });
    </script>
</body>
</html>
