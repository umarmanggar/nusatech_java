<%-- 
    Document   : categories
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Admin Category Management with Bootstrap 5, Icon & Color Picker
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
        
        .category-card { background: white; border-radius: 1rem; box-shadow: 0 2px 8px rgba(0,0,0,0.04); padding: 1.5rem; transition: all 0.3s; cursor: grab; height: 100%; }
        .category-card:hover { transform: translateY(-4px); box-shadow: 0 8px 20px rgba(0,0,0,0.08); }
        .category-card.dragging { opacity: 0.5; }
        .category-icon { width: 64px; height: 64px; border-radius: 1rem; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; margin-bottom: 1rem; }
        .category-title { font-size: 1.125rem; font-weight: 700; margin-bottom: 0.25rem; }
        .category-desc { font-size: 0.875rem; color: #6b7280; margin-bottom: 1rem; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
        .category-meta { display: flex; justify-content: space-between; align-items: center; padding-top: 1rem; border-top: 1px solid #f3f4f6; }
        
        .icon-picker { display: grid; grid-template-columns: repeat(8, 1fr); gap: 0.5rem; max-height: 200px; overflow-y: auto; padding: 0.5rem; background: #f8f9fa; border-radius: 0.5rem; }
        .icon-picker-item { width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; border-radius: 0.5rem; cursor: pointer; transition: all 0.2s; }
        .icon-picker-item:hover { background: #e5e7eb; }
        .icon-picker-item.selected { background: var(--admin); color: white; }
        
        .color-picker { display: flex; flex-wrap: wrap; gap: 0.5rem; }
        .color-picker-item { width: 36px; height: 36px; border-radius: 50%; cursor: pointer; border: 3px solid transparent; transition: all 0.2s; }
        .color-picker-item:hover { transform: scale(1.1); }
        .color-picker-item.selected { border-color: var(--admin); }
        
        .empty-state { text-align: center; padding: 4rem 2rem; background: white; border-radius: 1rem; }
        .empty-state-icon { width: 100px; height: 100px; background: rgba(31, 41, 55, 0.1); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; font-size: 2.5rem; color: var(--admin); }
        
        .status-badge { font-size: 0.75rem; padding: 0.35rem 0.75rem; border-radius: 1rem; font-weight: 600; }
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
                    <h1 class="h3 fw-bold mb-1"><i class="fas fa-folder me-2" style="color: var(--admin);"></i>Manajemen Kategori</h1>
                    <p class="text-muted mb-0">Kelola kategori kursus - seret untuk mengubah urutan</p>
                </div>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#categoryModal" onclick="resetModal()">
                    <i class="fas fa-plus me-2"></i> Tambah Kategori
                </button>
            </div>
            
            <!-- Alerts -->
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show"><i class="fas fa-check-circle me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show"><i class="fas fa-exclamation-circle me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
            </c:if>
            
            <c:choose>
                <c:when test="${not empty categories}">
                    <div class="row row-cols-1 row-cols-md-2 row-cols-xl-3 g-4" id="categoriesContainer">
                        <c:forEach var="category" items="${categories}">
                            <div class="col" data-category-id="${category.categoryId}" draggable="true">
                                <div class="category-card">
                                    <div class="d-flex justify-content-between align-items-start mb-3">
                                        <div class="category-icon" style="background: ${category.color}20; color: ${category.color};">
                                            <i class="${not empty category.icon ? category.icon : 'fas fa-folder'}"></i>
                                        </div>
                                        <div class="dropdown">
                                            <button class="btn btn-sm btn-link text-muted" data-bs-toggle="dropdown">
                                                <i class="fas fa-ellipsis-v"></i>
                                            </button>
                                            <ul class="dropdown-menu dropdown-menu-end">
                                                <li><a class="dropdown-item" href="#" onclick="editCategory(${category.categoryId}, '${category.name}', '${category.slug}', '${category.description}', '${category.icon}', '${category.color}', ${category.active})"><i class="fas fa-edit me-2"></i>Edit</a></li>
                                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/category/toggle/${category.categoryId}"><i class="fas ${category.active ? 'fa-eye-slash' : 'fa-eye'} me-2"></i>${category.active ? 'Nonaktifkan' : 'Aktifkan'}</a></li>
                                                <li><hr class="dropdown-divider"></li>
                                                <li><a class="dropdown-item text-danger" href="#" onclick="deleteCategory(${category.categoryId}, '${category.name}')"><i class="fas fa-trash me-2"></i>Hapus</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <h5 class="category-title">${category.name}</h5>
                                    <p class="category-desc">${category.description}</p>
                                    <div class="category-meta">
                                        <span class="text-muted small"><i class="fas fa-book me-1"></i> ${category.courseCount} Kursus</span>
                                        <span class="status-badge ${category.active ? 'bg-success-subtle text-success' : 'bg-warning-subtle text-warning'}">
                                            ${category.active ? 'Aktif' : 'Nonaktif'}
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-state-icon"><i class="fas fa-folder-open"></i></div>
                        <h4 class="fw-bold mb-2">Belum Ada Kategori</h4>
                        <p class="text-muted mb-4">Tambahkan kategori pertama untuk mengelompokkan kursus.</p>
                        <button class="btn btn-primary btn-lg" data-bs-toggle="modal" data-bs-target="#categoryModal">
                            <i class="fas fa-plus me-2"></i> Tambah Kategori
                        </button>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
    
    <!-- Category Modal -->
    <div class="modal fade" id="categoryModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/admin/categories/save" method="POST" id="categoryForm">
                    <input type="hidden" name="categoryId" id="categoryId">
                    <div class="modal-header border-0">
                        <h5 class="modal-title"><i class="fas fa-folder me-2" style="color: var(--admin);"></i><span id="modalTitle">Tambah Kategori</span></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row g-4">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Nama Kategori <span class="text-danger">*</span></label>
                                    <input type="text" name="name" id="categoryName" class="form-control" required placeholder="Contoh: Web Development">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Slug <span class="text-danger">*</span></label>
                                    <input type="text" name="slug" id="categorySlug" class="form-control" required placeholder="web-development">
                                    <div class="form-text">URL-friendly, huruf kecil dengan strip</div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Deskripsi</label>
                                    <textarea name="description" id="categoryDescription" class="form-control" rows="3" placeholder="Deskripsi singkat kategori..."></textarea>
                                </div>
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" name="isActive" id="categoryActive" value="true" checked>
                                    <label class="form-check-label" for="categoryActive">Aktif</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Pilih Icon</label>
                                    <input type="hidden" name="icon" id="categoryIcon" value="fas fa-folder">
                                    <div class="icon-picker">
                                        <div class="icon-picker-item selected" data-icon="fas fa-folder"><i class="fas fa-folder"></i></div>
                                        <div class="icon-picker-item" data-icon="fas fa-code"><i class="fas fa-code"></i></div>
                                        <div class="icon-picker-item" data-icon="fas fa-laptop-code"><i class="fas fa-laptop-code"></i></div>
                                        <div class="icon-picker-item" data-icon="fas fa-mobile-alt"><i class="fas fa-mobile-alt"></i></div>
                                        <div class="icon-picker-item" data-icon="fas fa-database"><i class="fas fa-database"></i></div>
                                        <div class="icon-picker-item" data-icon="fas fa-cloud"><i class="fas fa-cloud"></i></div>
                                        <div class="icon-picker-item" data-icon="fas fa-server"><i class="fas fa-server"></i></div>
                                        <div class="icon-picker-item" data-icon="fas fa-robot"><i class="fas fa-robot"></i></div>
                                        <div class="icon-picker-item" data-icon="fas fa-brain"><i class="fas fa-brain"></i></div>
                                        <div class="icon-picker-item" data-icon="fas fa-chart-line"><i class="fas fa-chart-line"></i></div>
                                        <div class="icon-picker-item" data-icon="fas fa-palette"><i class="fas fa-palette"></i></div>
                                        <div class="icon-picker-item" data-icon="fas fa-camera"><i class="fas fa-camera"></i></div>
                                        <div class="icon-picker-item" data-icon="fas fa-video"><i class="fas fa-video"></i></div>
                                        <div class="icon-picker-item" data-icon="fas fa-music"><i class="fas fa-music"></i></div>
                                        <div class="icon-picker-item" data-icon="fas fa-pen-fancy"><i class="fas fa-pen-fancy"></i></div>
                                        <div class="icon-picker-item" data-icon="fas fa-bullhorn"><i class="fas fa-bullhorn"></i></div>
                                        <div class="icon-picker-item" data-icon="fas fa-briefcase"><i class="fas fa-briefcase"></i></div>
                                        <div class="icon-picker-item" data-icon="fas fa-calculator"><i class="fas fa-calculator"></i></div>
                                        <div class="icon-picker-item" data-icon="fas fa-language"><i class="fas fa-language"></i></div>
                                        <div class="icon-picker-item" data-icon="fas fa-globe"><i class="fas fa-globe"></i></div>
                                        <div class="icon-picker-item" data-icon="fas fa-graduation-cap"><i class="fas fa-graduation-cap"></i></div>
                                        <div class="icon-picker-item" data-icon="fas fa-atom"><i class="fas fa-atom"></i></div>
                                        <div class="icon-picker-item" data-icon="fas fa-heartbeat"><i class="fas fa-heartbeat"></i></div>
                                        <div class="icon-picker-item" data-icon="fas fa-dumbbell"><i class="fas fa-dumbbell"></i></div>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Pilih Warna</label>
                                    <input type="hidden" name="color" id="categoryColor" value="#8B1538">
                                    <div class="color-picker">
                                        <div class="color-picker-item selected" data-color="#8B1538" style="background: #8B1538;"></div>
                                        <div class="color-picker-item" data-color="#3b82f6" style="background: #3b82f6;"></div>
                                        <div class="color-picker-item" data-color="#10b981" style="background: #10b981;"></div>
                                        <div class="color-picker-item" data-color="#f59e0b" style="background: #f59e0b;"></div>
                                        <div class="color-picker-item" data-color="#ef4444" style="background: #ef4444;"></div>
                                        <div class="color-picker-item" data-color="#8b5cf6" style="background: #8b5cf6;"></div>
                                        <div class="color-picker-item" data-color="#ec4899" style="background: #ec4899;"></div>
                                        <div class="color-picker-item" data-color="#06b6d4" style="background: #06b6d4;"></div>
                                        <div class="color-picker-item" data-color="#84cc16" style="background: #84cc16;"></div>
                                        <div class="color-picker-item" data-color="#6366f1" style="background: #6366f1;"></div>
                                    </div>
                                </div>
                                
                                <!-- Preview -->
                                <div class="mt-4">
                                    <label class="form-label fw-semibold">Preview</label>
                                    <div class="d-flex align-items-center gap-3 p-3 bg-light rounded">
                                        <div id="previewIcon" class="category-icon" style="background: #8B153820; color: #8B1538; width: 50px; height: 50px; margin: 0;">
                                            <i class="fas fa-folder"></i>
                                        </div>
                                        <div>
                                            <div class="fw-bold" id="previewName">Nama Kategori</div>
                                            <small class="text-muted" id="previewSlug">/category/slug</small>
                                        </div>
                                    </div>
                                </div>
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
    
    <!-- Delete Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-0">
                    <h5 class="modal-title text-danger"><i class="fas fa-exclamation-triangle me-2"></i>Hapus Kategori</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Apakah Anda yakin ingin menghapus kategori "<strong id="deleteCategoryName"></strong>"?</p>
                    <p class="text-muted small mb-0">Kursus dalam kategori ini akan menjadi tidak terkategori.</p>
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
    <script src="https://cdn.jsdelivr.net/npm/sortablejs@1.15.0/Sortable.min.js"></script>
    
    <script>
        // Drag and drop reorder
        const container = document.getElementById('categoriesContainer');
        if (container) {
            new Sortable(container, {
                animation: 150,
                ghostClass: 'dragging',
                onEnd: function(evt) {
                    const order = Array.from(container.querySelectorAll('[data-category-id]'))
                        .map(el => el.dataset.categoryId);
                    
                    fetch('${pageContext.request.contextPath}/admin/categories/reorder', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ order: order })
                    });
                }
            });
        }
        
        // Icon picker
        document.querySelectorAll('.icon-picker-item').forEach(item => {
            item.addEventListener('click', function() {
                document.querySelectorAll('.icon-picker-item').forEach(i => i.classList.remove('selected'));
                this.classList.add('selected');
                document.getElementById('categoryIcon').value = this.dataset.icon;
                updatePreview();
            });
        });
        
        // Color picker
        document.querySelectorAll('.color-picker-item').forEach(item => {
            item.addEventListener('click', function() {
                document.querySelectorAll('.color-picker-item').forEach(i => i.classList.remove('selected'));
                this.classList.add('selected');
                document.getElementById('categoryColor').value = this.dataset.color;
                updatePreview();
            });
        });
        
        // Auto-generate slug
        document.getElementById('categoryName').addEventListener('input', function() {
            const slug = this.value.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '');
            document.getElementById('categorySlug').value = slug;
            updatePreview();
        });
        
        // Update preview
        function updatePreview() {
            const name = document.getElementById('categoryName').value || 'Nama Kategori';
            const slug = document.getElementById('categorySlug').value || 'slug';
            const icon = document.getElementById('categoryIcon').value;
            const color = document.getElementById('categoryColor').value;
            
            document.getElementById('previewName').textContent = name;
            document.getElementById('previewSlug').textContent = '/category/' + slug;
            document.getElementById('previewIcon').style.background = color + '20';
            document.getElementById('previewIcon').style.color = color;
            document.getElementById('previewIcon').innerHTML = '<i class="' + icon + '"></i>';
        }
        
        // Reset modal
        function resetModal() {
            document.getElementById('modalTitle').textContent = 'Tambah Kategori';
            document.getElementById('categoryId').value = '';
            document.getElementById('categoryName').value = '';
            document.getElementById('categorySlug').value = '';
            document.getElementById('categoryDescription').value = '';
            document.getElementById('categoryActive').checked = true;
            
            // Reset icon selection
            document.querySelectorAll('.icon-picker-item').forEach(i => i.classList.remove('selected'));
            document.querySelector('.icon-picker-item[data-icon="fas fa-folder"]').classList.add('selected');
            document.getElementById('categoryIcon').value = 'fas fa-folder';
            
            // Reset color selection
            document.querySelectorAll('.color-picker-item').forEach(i => i.classList.remove('selected'));
            document.querySelector('.color-picker-item[data-color="#8B1538"]').classList.add('selected');
            document.getElementById('categoryColor').value = '#8B1538';
            
            updatePreview();
        }
        
        // Edit category
        function editCategory(id, name, slug, description, icon, color, isActive) {
            document.getElementById('modalTitle').textContent = 'Edit Kategori';
            document.getElementById('categoryId').value = id;
            document.getElementById('categoryName').value = name;
            document.getElementById('categorySlug').value = slug;
            document.getElementById('categoryDescription').value = description || '';
            document.getElementById('categoryActive').checked = isActive;
            
            // Set icon
            document.querySelectorAll('.icon-picker-item').forEach(i => i.classList.remove('selected'));
            const iconItem = document.querySelector('.icon-picker-item[data-icon="' + icon + '"]');
            if (iconItem) iconItem.classList.add('selected');
            document.getElementById('categoryIcon').value = icon || 'fas fa-folder';
            
            // Set color
            document.querySelectorAll('.color-picker-item').forEach(i => i.classList.remove('selected'));
            const colorItem = document.querySelector('.color-picker-item[data-color="' + color + '"]');
            if (colorItem) colorItem.classList.add('selected');
            document.getElementById('categoryColor').value = color || '#8B1538';
            
            updatePreview();
            new bootstrap.Modal(document.getElementById('categoryModal')).show();
        }
        
        // Delete category
        function deleteCategory(id, name) {
            document.getElementById('deleteCategoryName').textContent = name;
            document.getElementById('deleteForm').action = '${pageContext.request.contextPath}/admin/category/delete/' + id;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
    </script>
</body>
</html>
