<%-- 
    Document   : section-form
    Created on : Dec 18, 2025
    Author     : NusaTech
    Description: Course Sections Management with Drag & Drop
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kelola Materi - ${course.title} - NusaTech</title>
    
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
        
        .course-header { background: white; border-radius: 1rem; padding: 1.5rem; margin-bottom: 1.5rem; box-shadow: 0 2px 8px rgba(0,0,0,0.04); }
        .course-header-img { width: 100px; height: 60px; border-radius: 0.5rem; object-fit: cover; }
        
        .section-card { background: white; border-radius: 1rem; margin-bottom: 1rem; box-shadow: 0 2px 8px rgba(0,0,0,0.04); overflow: hidden; }
        .section-header { padding: 1rem 1.25rem; background: #f8f9fa; cursor: grab; display: flex; align-items: center; gap: 0.75rem; border-bottom: 1px solid #e5e7eb; }
        .section-header:active { cursor: grabbing; }
        .section-drag-handle { color: #9ca3af; font-size: 1.1rem; }
        .section-title { font-weight: 700; flex-grow: 1; margin: 0; }
        .section-body { padding: 1rem 1.25rem; }
        
        .material-item { display: flex; align-items: center; gap: 0.75rem; padding: 0.85rem 1rem; background: #fafafa; border-radius: 0.75rem; margin-bottom: 0.5rem; cursor: grab; transition: all 0.2s; }
        .material-item:hover { background: #f3f4f6; }
        .material-item:active { cursor: grabbing; }
        .material-icon { width: 36px; height: 36px; border-radius: 0.5rem; display: flex; align-items: center; justify-content: center; font-size: 0.9rem; }
        .material-icon.video { background: rgba(239, 68, 68, 0.1); color: #ef4444; }
        .material-icon.text { background: rgba(59, 130, 246, 0.1); color: #3b82f6; }
        .material-icon.pdf { background: rgba(245, 158, 11, 0.1); color: #f59e0b; }
        .material-icon.quiz { background: rgba(139, 21, 56, 0.1); color: var(--primary); }
        .material-info { flex-grow: 1; }
        .material-title { font-weight: 600; font-size: 0.9rem; margin-bottom: 0.15rem; }
        .material-meta { font-size: 0.75rem; color: #6b7280; }
        
        .add-section-btn, .add-material-btn { border: 2px dashed #d1d5db; background: transparent; color: #6b7280; font-weight: 600; }
        .add-section-btn:hover, .add-material-btn:hover { border-color: var(--primary); color: var(--primary); background: rgba(139, 21, 56, 0.02); }
        
        .section-card.dragging { opacity: 0.5; transform: scale(1.02); }
        .material-item.dragging { opacity: 0.5; background: #e5e7eb; }
        .drop-zone { border: 2px dashed var(--primary); background: rgba(139, 21, 56, 0.05); border-radius: 0.75rem; min-height: 50px; }
        
        @media (max-width: 991.98px) {
            .sidebar { transform: translateX(-100%); transition: transform 0.3s; }
            .sidebar.show { transform: translateX(0); }
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
                <a href="${pageContext.request.contextPath}/lecturer/courses" class="sidebar-item active"><i class="fas fa-book"></i> Kursus Saya</a>
                <a href="${pageContext.request.contextPath}/lecturer/course/create" class="sidebar-item"><i class="fas fa-plus-circle"></i> Buat Kursus</a>
                <a href="${pageContext.request.contextPath}/lecturer/students" class="sidebar-item"><i class="fas fa-users"></i> Pelajar</a>
                <a href="${pageContext.request.contextPath}/lecturer/earnings" class="sidebar-item"><i class="fas fa-wallet"></i> Pendapatan</a>
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
            
            <!-- Breadcrumb -->
            <nav aria-label="breadcrumb" class="mb-3">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/lecturer/courses" class="text-decoration-none">Kursus Saya</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/lecturer/course/edit/${course.courseId}" class="text-decoration-none">${course.title}</a></li>
                    <li class="breadcrumb-item active">Kelola Materi</li>
                </ol>
            </nav>
            
            <!-- Course Header -->
            <div class="course-header">
                <div class="d-flex flex-wrap align-items-center gap-3">
                    <img src="${not empty course.thumbnail ? course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=200&h=120&fit=crop'}" 
                         alt="${course.title}" class="course-header-img">
                    <div class="flex-grow-1">
                        <h4 class="fw-bold mb-1">${course.title}</h4>
                        <div class="text-muted small">
                            <span class="me-3"><i class="fas fa-layer-group me-1"></i>${sections != null ? sections.size() : 0} Bab</span>
                            <span class="me-3"><i class="fas fa-file-alt me-1"></i>${totalMaterials != null ? totalMaterials : 0} Materi</span>
                            <span><i class="fas fa-clock me-1"></i>${course.durationHours != null ? course.durationHours : 0} jam</span>
                        </div>
                    </div>
                    <div class="d-flex gap-2">
                        <a href="${pageContext.request.contextPath}/lecturer/course/edit/${course.courseId}" class="btn btn-outline-secondary">
                            <i class="fas fa-edit me-1"></i> Edit Info
                        </a>
                        <a href="${pageContext.request.contextPath}/course/${course.slug}" target="_blank" class="btn btn-outline-primary">
                            <i class="fas fa-eye me-1"></i> Preview
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Alerts -->
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show"><i class="fas fa-check-circle me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show"><i class="fas fa-exclamation-circle me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
            </c:if>
            
            <!-- Info Alert -->
            <div class="alert alert-info d-flex align-items-center mb-4">
                <i class="fas fa-info-circle me-2"></i>
                <span>Seret bab atau materi untuk mengubah urutan. Perubahan akan tersimpan otomatis.</span>
            </div>
            
            <!-- Sections List -->
            <div id="sectionsContainer">
                <c:forEach var="section" items="${sections}" varStatus="status">
                    <div class="section-card" data-section-id="${section.sectionId}" draggable="true">
                        <div class="section-header">
                            <span class="section-drag-handle"><i class="fas fa-grip-vertical"></i></span>
                            <span class="badge bg-secondary me-2">${status.index + 1}</span>
                            <h5 class="section-title">${section.title}</h5>
                            <span class="text-muted small me-2">${section.materials != null ? section.materials.size() : 0} materi</span>
                            <div class="btn-group">
                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="editSection(${section.sectionId}, '${section.title}', '${section.description}')">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button type="button" class="btn btn-sm btn-outline-danger" onclick="deleteSection(${section.sectionId}, '${section.title}')">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </div>
                        <div class="section-body">
                            <div class="materials-list" data-section-id="${section.sectionId}">
                                <c:forEach var="material" items="${section.materials}">
                                    <div class="material-item" data-material-id="${material.materialId}" draggable="true">
                                        <span class="drag-handle text-muted"><i class="fas fa-grip-vertical"></i></span>
                                        <div class="material-icon ${material.contentType.toString().toLowerCase()}">
                                            <c:choose>
                                                <c:when test="${material.contentType == 'VIDEO'}"><i class="fas fa-play"></i></c:when>
                                                <c:when test="${material.contentType == 'TEXT'}"><i class="fas fa-file-alt"></i></c:when>
                                                <c:when test="${material.contentType == 'PDF'}"><i class="fas fa-file-pdf"></i></c:when>
                                                <c:when test="${material.contentType == 'QUIZ'}"><i class="fas fa-question-circle"></i></c:when>
                                                <c:otherwise><i class="fas fa-file"></i></c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="material-info">
                                            <div class="material-title">${material.title}</div>
                                            <div class="material-meta">
                                                ${material.contentType} 
                                                <c:if test="${material.duration > 0}">• ${material.duration} menit</c:if>
                                                <c:if test="${material.isFree}"><span class="badge bg-success ms-1">Free Preview</span></c:if>
                                            </div>
                                        </div>
                                        <div class="btn-group">
                                            <c:choose>
                                                <c:when test="${material.contentType == 'QUIZ'}">
                                                    <a href="${pageContext.request.contextPath}/lecturer/course/${course.courseId}/quiz/${material.materialId}" class="btn btn-sm btn-outline-primary" title="Edit Quiz">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/lecturer/course/${course.courseId}/material/${material.materialId}" class="btn btn-sm btn-outline-primary" title="Edit">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                            <button type="button" class="btn btn-sm btn-outline-danger" onclick="deleteMaterial(${material.materialId}, '${material.title}')" title="Hapus">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            
                            <!-- Add Material Dropdown -->
                            <div class="dropdown mt-3">
                                <button class="btn add-material-btn w-100 dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-plus me-2"></i> Tambah Materi
                                </button>
                                <ul class="dropdown-menu w-100">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/lecturer/course/${course.courseId}/section/${section.sectionId}/material/add?type=VIDEO"><i class="fas fa-play text-danger me-2"></i> Video</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/lecturer/course/${course.courseId}/section/${section.sectionId}/material/add?type=TEXT"><i class="fas fa-file-alt text-primary me-2"></i> Teks/Artikel</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/lecturer/course/${course.courseId}/section/${section.sectionId}/material/add?type=PDF"><i class="fas fa-file-pdf text-warning me-2"></i> PDF/Dokumen</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/lecturer/course/${course.courseId}/section/${section.sectionId}/quiz/add"><i class="fas fa-question-circle text-primary me-2"></i> Quiz</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
            <!-- Add Section Button -->
            <button type="button" class="btn add-section-btn w-100 py-3" data-bs-toggle="modal" data-bs-target="#sectionModal">
                <i class="fas fa-plus me-2"></i> Tambah Bab Baru
            </button>
        </main>
    </div>
    
    <!-- Section Modal -->
    <div class="modal fade" id="sectionModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/lecturer/course/${course.courseId}/section/save" method="POST">
                    <input type="hidden" name="sectionId" id="sectionId" value="">
                    <div class="modal-header border-0">
                        <h5 class="modal-title"><i class="fas fa-layer-group text-primary me-2"></i><span id="sectionModalTitle">Tambah Bab Baru</span></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Judul Bab <span class="text-danger">*</span></label>
                            <input type="text" name="title" id="sectionTitle" class="form-control" required placeholder="Contoh: Pengenalan Python">
                        </div>
                        <div class="mb-0">
                            <label class="form-label fw-semibold">Deskripsi (Opsional)</label>
                            <textarea name="description" id="sectionDescription" class="form-control" rows="3" placeholder="Deskripsi singkat tentang bab ini..."></textarea>
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
    
    <!-- Delete Section Modal -->
    <div class="modal fade" id="deleteSectionModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-0">
                    <h5 class="modal-title text-danger"><i class="fas fa-exclamation-triangle me-2"></i>Hapus Bab</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Apakah Anda yakin ingin menghapus bab "<strong id="deleteSectionTitle"></strong>"?</p>
                    <p class="text-muted small mb-0">Semua materi dalam bab ini juga akan dihapus.</p>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <form id="deleteSectionForm" action="" method="POST" style="display: inline;">
                        <button type="submit" class="btn btn-danger">Ya, Hapus</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Delete Material Modal -->
    <div class="modal fade" id="deleteMaterialModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-0">
                    <h5 class="modal-title text-danger"><i class="fas fa-exclamation-triangle me-2"></i>Hapus Materi</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Apakah Anda yakin ingin menghapus materi "<strong id="deleteMaterialTitle"></strong>"?</p>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <form id="deleteMaterialForm" action="" method="POST" style="display: inline;">
                        <button type="submit" class="btn btn-danger">Ya, Hapus</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sortablejs@1.15.0/Sortable.min.js"></script>
    
    <script>
        // Initialize Sortable for sections
        new Sortable(document.getElementById('sectionsContainer'), {
            animation: 150,
            handle: '.section-drag-handle',
            ghostClass: 'dragging',
            onEnd: function(evt) {
                updateSectionOrder();
            }
        });
        
        // Initialize Sortable for materials in each section
        document.querySelectorAll('.materials-list').forEach(function(list) {
            new Sortable(list, {
                animation: 150,
                handle: '.drag-handle',
                ghostClass: 'dragging',
                group: 'materials',
                onEnd: function(evt) {
                    updateMaterialOrder(evt.to.dataset.sectionId);
                }
            });
        });
        
        // Update section order via AJAX
        function updateSectionOrder() {
            const sections = document.querySelectorAll('.section-card');
            const order = Array.from(sections).map(s => s.dataset.sectionId);
            
            fetch('${pageContext.request.contextPath}/lecturer/course/${course.courseId}/sections/reorder', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ order: order })
            });
        }
        
        // Update material order via AJAX
        function updateMaterialOrder(sectionId) {
            const materials = document.querySelectorAll('[data-section-id="' + sectionId + '"] .material-item');
            const order = Array.from(materials).map(m => m.dataset.materialId);
            
            fetch('${pageContext.request.contextPath}/lecturer/course/${course.courseId}/section/' + sectionId + '/materials/reorder', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ order: order })
            });
        }
        
        // Edit section
        function editSection(sectionId, title, description) {
            document.getElementById('sectionId').value = sectionId;
            document.getElementById('sectionTitle').value = title;
            document.getElementById('sectionDescription').value = description || '';
            document.getElementById('sectionModalTitle').textContent = 'Edit Bab';
            new bootstrap.Modal(document.getElementById('sectionModal')).show();
        }
        
        // Delete section
        function deleteSection(sectionId, title) {
            document.getElementById('deleteSectionTitle').textContent = title;
            document.getElementById('deleteSectionForm').action = '${pageContext.request.contextPath}/lecturer/course/${course.courseId}/section/' + sectionId + '/delete';
            new bootstrap.Modal(document.getElementById('deleteSectionModal')).show();
        }
        
        // Delete material
        function deleteMaterial(materialId, title) {
            document.getElementById('deleteMaterialTitle').textContent = title;
            document.getElementById('deleteMaterialForm').action = '${pageContext.request.contextPath}/lecturer/course/${course.courseId}/material/' + materialId + '/delete';
            new bootstrap.Modal(document.getElementById('deleteMaterialModal')).show();
        }
        
        // Reset modal on close
        document.getElementById('sectionModal').addEventListener('hidden.bs.modal', function() {
            document.getElementById('sectionId').value = '';
            document.getElementById('sectionTitle').value = '';
            document.getElementById('sectionDescription').value = '';
            document.getElementById('sectionModalTitle').textContent = 'Tambah Bab Baru';
        });
    </script>
</body>
</html>
