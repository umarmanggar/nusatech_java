<%-- 
    Document   : course-content
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Course Content Management (Sections & Materials)
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
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        .section-card {
            background: var(--white);
            border-radius: var(--radius-xl);
            margin-bottom: 1rem;
            border: 1px solid var(--gray-200);
        }
        .section-header {
            padding: 1rem 1.5rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: var(--gray-50);
            border-radius: var(--radius-xl) var(--radius-xl) 0 0;
            cursor: pointer;
        }
        .section-header:hover {
            background: var(--gray-100);
        }
        .section-title {
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        .section-title i { color: var(--primary); }
        .section-content {
            padding: 0;
            border-top: 1px solid var(--gray-200);
        }
        .material-item {
            padding: 1rem 1.5rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid var(--gray-100);
        }
        .material-item:last-child { border-bottom: none; }
        .material-item:hover { background: var(--gray-50); }
        .material-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        .material-icon {
            width: 40px;
            height: 40px;
            border-radius: var(--radius-md);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
        }
        .material-icon.video { background: #fee2e2; color: #dc2626; }
        .material-icon.text { background: #e0f2fe; color: #0284c7; }
        .material-icon.pdf { background: #fef3c7; color: #d97706; }
        .material-icon.quiz { background: #dcfce7; color: #16a34a; }
        .add-material-btn {
            padding: 1rem 1.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            color: var(--primary);
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .add-material-btn:hover {
            background: var(--primary-light);
        }
    </style>
</head>
<body>
    <jsp:include page="/pages/common/navbar-dashboard.jsp"/>
    
    <div class="dashboard-layout">
        <aside class="sidebar">
            <div class="sidebar-menu">
                <a href="${pageContext.request.contextPath}/lecturer/dashboard" class="sidebar-item">
                    <i class="fas fa-home"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/lecturer/courses" class="sidebar-item active">
                    <i class="fas fa-book"></i> Kursus Saya
                </a>
                <a href="${pageContext.request.contextPath}/lecturer/course/create" class="sidebar-item">
                    <i class="fas fa-plus-circle"></i> Buat Kursus
                </a>
                <a href="${pageContext.request.contextPath}/lecturer/students" class="sidebar-item">
                    <i class="fas fa-users"></i> Pelajar
                </a>
                <a href="${pageContext.request.contextPath}/lecturer/earnings" class="sidebar-item">
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
            <div class="page-header">
                <nav style="margin-bottom: 1rem;">
                    <a href="${pageContext.request.contextPath}/lecturer/courses" style="color: var(--primary); text-decoration: none;">
                        <i class="fas fa-arrow-left"></i> Kembali ke Kursus Saya
                    </a>
                </nav>
                <div style="display: flex; justify-content: space-between; align-items: flex-start; flex-wrap: wrap; gap: 1rem;">
                    <div>
                        <h1 class="page-title">
                            <i class="fas fa-list" style="color: var(--primary);"></i> Kelola Materi
                        </h1>
                        <p class="page-subtitle">${course.title}</p>
                    </div>
                    <div style="display: flex; gap: 0.5rem;">
                        <a href="${pageContext.request.contextPath}/lecturer/course/edit/${course.courseId}" class="btn btn-outline">
                            <i class="fas fa-edit"></i> Edit Info
                        </a>
                        <button class="btn btn-primary" data-modal="addSectionModal">
                            <i class="fas fa-plus"></i> Tambah Bab
                        </button>
                    </div>
                </div>
            </div>
            
            <!-- Course Stats -->
            <div class="grid grid-4" style="margin-bottom: 2rem;">
                <div class="stat-card">
                    <div class="stat-card-icon primary"><i class="fas fa-book-open"></i></div>
                    <div class="stat-card-value">${sections != null ? sections.size() : 0}</div>
                    <div class="stat-card-label">Total Bab</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-icon info"><i class="fas fa-file-alt"></i></div>
                    <div class="stat-card-value">${course.totalMaterials}</div>
                    <div class="stat-card-label">Total Materi</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-icon success"><i class="fas fa-clock"></i></div>
                    <div class="stat-card-value">${course.durationHours != null ? course.durationHours : 0} jam</div>
                    <div class="stat-card-label">Durasi</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-icon warning">
                        <i class="fas fa-${course.status == 'PUBLISHED' ? 'check-circle' : course.status == 'PENDING' ? 'clock' : 'pencil-alt'}"></i>
                    </div>
                    <div class="stat-card-value" style="font-size: 1rem;">${course.statusDisplayName}</div>
                    <div class="stat-card-label">Status</div>
                </div>
            </div>
            
            <!-- Sections List -->
            <c:choose>
                <c:when test="${not empty sections}">
                    <c:forEach var="section" items="${sections}" varStatus="sectionIdx">
                        <div class="section-card">
                            <div class="section-header" onclick="toggleSection(this)">
                                <div class="section-title">
                                    <i class="fas fa-folder"></i>
                                    <span>Bab ${sectionIdx.index + 1}: ${section.title}</span>
                                    <span class="badge badge-info" style="font-size: 0.75rem;">${section.materialCount} materi</span>
                                    <c:if test="${section.preview}">
                                        <span class="badge badge-success" style="font-size: 0.75rem;">Preview</span>
                                    </c:if>
                                </div>
                                <div style="display: flex; align-items: center; gap: 0.5rem;">
                                    <button class="btn btn-sm btn-outline" onclick="event.stopPropagation(); editSection(${section.sectionId}, '${section.title}', '${section.description}', ${section.displayOrder}, ${section.preview})">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline" style="color: var(--error);" onclick="event.stopPropagation(); deleteSection(${section.sectionId})">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                    <i class="fas fa-chevron-down" style="transition: transform 0.2s;"></i>
                                </div>
                            </div>
                            <div class="section-content">
                                <c:forEach var="material" items="${section.materials}" varStatus="matIdx">
                                    <div class="material-item">
                                        <div class="material-info">
                                            <div class="material-icon ${material.contentType.name().toLowerCase()}">
                                                <i class="fas ${material.contentTypeIcon}"></i>
                                            </div>
                                            <div>
                                                <h4 style="font-size: 0.9375rem; margin-bottom: 0.25rem;">${material.title}</h4>
                                                <div style="font-size: 0.8125rem; color: var(--gray-500);">
                                                    <span>${material.contentTypeDisplayName}</span>
                                                    <c:if test="${material.videoDuration > 0}">
                                                        <span style="margin-left: 0.5rem;">
                                                            <i class="fas fa-clock"></i> ${material.formattedDuration}
                                                        </span>
                                                    </c:if>
                                                    <c:if test="${material.preview}">
                                                        <span class="badge badge-success" style="font-size: 0.625rem; margin-left: 0.5rem;">Preview</span>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                        <div style="display: flex; gap: 0.5rem;">
                                            <button class="btn btn-sm btn-outline" onclick="editMaterial(${material.materialId})">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <button class="btn btn-sm btn-outline" style="color: var(--error);" onclick="deleteMaterial(${material.materialId})">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </div>
                                </c:forEach>
                                <div class="add-material-btn" onclick="showAddMaterialModal(${section.sectionId})">
                                    <i class="fas fa-plus"></i> Tambah Materi
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-state-icon">
                            <i class="fas fa-list"></i>
                        </div>
                        <h3 class="empty-state-title">Belum Ada Bab</h3>
                        <p class="empty-state-description">
                            Mulai tambahkan bab untuk menyusun materi kursus Anda.
                        </p>
                        <button class="btn btn-primary btn-lg" data-modal="addSectionModal">
                            <i class="fas fa-plus"></i> Tambah Bab Pertama
                        </button>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
    
    <!-- Add Section Modal -->
    <div class="modal" id="addSectionModal">
        <div class="modal-backdrop" onclick="closeModal('addSectionModal')"></div>
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="sectionModalTitle">Tambah Bab Baru</h3>
                <button class="modal-close" onclick="closeModal('addSectionModal')">&times;</button>
            </div>
            <form id="sectionForm" action="${pageContext.request.contextPath}/lecturer/section/create" method="post">
                <input type="hidden" name="courseId" value="${course.courseId}">
                <input type="hidden" name="sectionId" id="sectionId">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="form-label">Judul Bab <span class="text-danger">*</span></label>
                        <input type="text" name="title" id="sectionTitle" class="form-control" required placeholder="Contoh: Pengenalan Python">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Deskripsi</label>
                        <textarea name="description" id="sectionDescription" class="form-control" rows="3" placeholder="Deskripsi singkat tentang bab ini..."></textarea>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Urutan Tampil</label>
                        <input type="number" name="displayOrder" id="sectionDisplayOrder" class="form-control" value="${sections != null ? sections.size() + 1 : 1}" min="1">
                    </div>
                    <div class="form-group">
                        <label style="display: flex; align-items: center; gap: 0.5rem; cursor: pointer;">
                            <input type="checkbox" name="isPreview" id="sectionIsPreview" value="true">
                            <span>Tandai sebagai Preview (dapat dilihat tanpa mendaftar)</span>
                        </label>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline" onclick="closeModal('addSectionModal')">Batal</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Simpan
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- Add Material Modal -->
    <div class="modal" id="addMaterialModal">
        <div class="modal-backdrop" onclick="closeModal('addMaterialModal')"></div>
        <div class="modal-content" style="max-width: 600px;">
            <div class="modal-header">
                <h3 id="materialModalTitle">Tambah Materi Baru</h3>
                <button class="modal-close" onclick="closeModal('addMaterialModal')">&times;</button>
            </div>
            <form id="materialForm" action="${pageContext.request.contextPath}/lecturer/material/create" method="post">
                <input type="hidden" name="sectionId" id="materialSectionId">
                <input type="hidden" name="materialId" id="materialId">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="form-label">Judul Materi <span class="text-danger">*</span></label>
                        <input type="text" name="title" id="materialTitle" class="form-control" required placeholder="Contoh: Apa itu Python?">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Tipe Konten <span class="text-danger">*</span></label>
                        <select name="contentType" id="materialContentType" class="form-control" required onchange="toggleMaterialFields()">
                            <option value="VIDEO">Video</option>
                            <option value="TEXT">Artikel/Teks</option>
                            <option value="PDF">PDF</option>
                            <option value="QUIZ">Kuis</option>
                        </select>
                    </div>
                    <div class="form-group" id="videoUrlGroup">
                        <label class="form-label">URL Video</label>
                        <input type="url" name="videoUrl" id="materialVideoUrl" class="form-control" placeholder="https://youtube.com/watch?v=...">
                        <small class="form-hint">Dukung YouTube, Vimeo, atau URL video langsung</small>
                    </div>
                    <div class="form-group" id="videoDurationGroup">
                        <label class="form-label">Durasi (detik)</label>
                        <input type="number" name="videoDuration" id="materialVideoDuration" class="form-control" min="0" placeholder="300">
                    </div>
                    <div class="form-group" id="contentGroup" style="display: none;">
                        <label class="form-label">Konten</label>
                        <textarea name="content" id="materialContent" class="form-control" rows="6" placeholder="Tulis konten materi di sini..."></textarea>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Urutan Tampil</label>
                        <input type="number" name="displayOrder" id="materialDisplayOrder" class="form-control" value="1" min="1">
                    </div>
                    <div class="grid grid-2">
                        <div class="form-group">
                            <label style="display: flex; align-items: center; gap: 0.5rem; cursor: pointer;">
                                <input type="checkbox" name="isPreview" id="materialIsPreview" value="true">
                                <span>Preview Gratis</span>
                            </label>
                        </div>
                        <div class="form-group">
                            <label style="display: flex; align-items: center; gap: 0.5rem; cursor: pointer;">
                                <input type="checkbox" name="isMandatory" id="materialIsMandatory" value="true" checked>
                                <span>Wajib Diselesaikan</span>
                            </label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline" onclick="closeModal('addMaterialModal')">Batal</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Simpan
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- Delete Confirmation Form -->
    <form id="deleteSectionForm" action="${pageContext.request.contextPath}/lecturer/section/delete" method="post" style="display: none;">
        <input type="hidden" name="sectionId" id="deleteSectionId">
    </form>
    <form id="deleteMaterialForm" action="${pageContext.request.contextPath}/lecturer/material/delete" method="post" style="display: none;">
        <input type="hidden" name="materialId" id="deleteMaterialId">
    </form>
    
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
        
        // Toggle section content
        function toggleSection(header) {
            const content = header.nextElementSibling;
            const icon = header.querySelector('.fa-chevron-down');
            
            if (content.style.display === 'none') {
                content.style.display = 'block';
                icon.style.transform = 'rotate(0deg)';
            } else {
                content.style.display = 'none';
                icon.style.transform = 'rotate(-90deg)';
            }
        }
        
        // Section functions
        function editSection(id, title, description, order, isPreview) {
            document.getElementById('sectionModalTitle').textContent = 'Edit Bab';
            document.getElementById('sectionForm').action = '${pageContext.request.contextPath}/lecturer/section/update';
            document.getElementById('sectionId').value = id;
            document.getElementById('sectionTitle').value = title;
            document.getElementById('sectionDescription').value = description || '';
            document.getElementById('sectionDisplayOrder').value = order;
            document.getElementById('sectionIsPreview').checked = isPreview;
            document.getElementById('addSectionModal').classList.add('active');
        }
        
        function deleteSection(id) {
            if (confirm('Apakah Anda yakin ingin menghapus bab ini? Semua materi di dalamnya juga akan dihapus.')) {
                document.getElementById('deleteSectionId').value = id;
                document.getElementById('deleteSectionForm').submit();
            }
        }
        
        // Material functions
        function showAddMaterialModal(sectionId) {
            document.getElementById('materialModalTitle').textContent = 'Tambah Materi Baru';
            document.getElementById('materialForm').action = '${pageContext.request.contextPath}/lecturer/material/create';
            document.getElementById('materialSectionId').value = sectionId;
            document.getElementById('materialId').value = '';
            document.getElementById('materialTitle').value = '';
            document.getElementById('materialContentType').value = 'VIDEO';
            document.getElementById('materialVideoUrl').value = '';
            document.getElementById('materialVideoDuration').value = '';
            document.getElementById('materialContent').value = '';
            document.getElementById('materialDisplayOrder').value = '1';
            document.getElementById('materialIsPreview').checked = false;
            document.getElementById('materialIsMandatory').checked = true;
            toggleMaterialFields();
            document.getElementById('addMaterialModal').classList.add('active');
        }
        
        function editMaterial(id) {
            // TODO: Fetch material data and populate form
            document.getElementById('materialModalTitle').textContent = 'Edit Materi';
            document.getElementById('materialForm').action = '${pageContext.request.contextPath}/lecturer/material/update';
            document.getElementById('materialId').value = id;
            document.getElementById('addMaterialModal').classList.add('active');
        }
        
        function deleteMaterial(id) {
            if (confirm('Apakah Anda yakin ingin menghapus materi ini?')) {
                document.getElementById('deleteMaterialId').value = id;
                document.getElementById('deleteMaterialForm').submit();
            }
        }
        
        function toggleMaterialFields() {
            const contentType = document.getElementById('materialContentType').value;
            const videoUrlGroup = document.getElementById('videoUrlGroup');
            const videoDurationGroup = document.getElementById('videoDurationGroup');
            const contentGroup = document.getElementById('contentGroup');
            
            if (contentType === 'VIDEO') {
                videoUrlGroup.style.display = 'block';
                videoDurationGroup.style.display = 'block';
                contentGroup.style.display = 'none';
            } else if (contentType === 'TEXT' || contentType === 'PDF') {
                videoUrlGroup.style.display = 'none';
                videoDurationGroup.style.display = 'none';
                contentGroup.style.display = 'block';
            } else {
                videoUrlGroup.style.display = 'none';
                videoDurationGroup.style.display = 'none';
                contentGroup.style.display = 'none';
            }
        }
        
        // Reset section modal when opening for new section
        document.querySelector('[data-modal="addSectionModal"]')?.addEventListener('click', function() {
            document.getElementById('sectionModalTitle').textContent = 'Tambah Bab Baru';
            document.getElementById('sectionForm').action = '${pageContext.request.contextPath}/lecturer/section/create';
            document.getElementById('sectionId').value = '';
            document.getElementById('sectionTitle').value = '';
            document.getElementById('sectionDescription').value = '';
            document.getElementById('sectionIsPreview').checked = false;
        });
    </script>
</body>
</html>
