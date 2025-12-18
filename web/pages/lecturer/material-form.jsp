<%-- 
    Document   : material-form
    Created on : Dec 18, 2025
    Author     : NusaTech
    Description: Add/Edit Material Form with Bootstrap 5
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${material != null ? 'Edit' : 'Tambah'} Materi - NusaTech</title>
    
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
        
        .form-card { background: white; border-radius: 1rem; box-shadow: 0 2px 8px rgba(0,0,0,0.04); margin-bottom: 1.5rem; }
        .form-card-header { padding: 1.25rem 1.5rem; border-bottom: 1px solid #e5e7eb; }
        .form-card-header h5 { font-weight: 700; margin: 0; }
        .form-card-body { padding: 1.5rem; }
        
        .type-selector { display: flex; gap: 1rem; margin-bottom: 1.5rem; }
        .type-card { flex: 1; padding: 1.5rem; border: 2px solid #e5e7eb; border-radius: 1rem; text-align: center; cursor: pointer; transition: all 0.3s; }
        .type-card:hover { border-color: var(--primary); }
        .type-card.active { border-color: var(--primary); background: rgba(139, 21, 56, 0.05); }
        .type-card-icon { width: 60px; height: 60px; border-radius: 1rem; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; margin: 0 auto 0.75rem; }
        .type-card-icon.video { background: rgba(239, 68, 68, 0.1); color: #ef4444; }
        .type-card-icon.text { background: rgba(59, 130, 246, 0.1); color: #3b82f6; }
        .type-card-icon.pdf { background: rgba(245, 158, 11, 0.1); color: #f59e0b; }
        .type-card-title { font-weight: 700; margin-bottom: 0.25rem; }
        .type-card-desc { font-size: 0.8rem; color: #6b7280; }
        
        .file-upload { border: 2px dashed #d1d5db; border-radius: 1rem; padding: 2rem; text-align: center; cursor: pointer; transition: all 0.3s; }
        .file-upload:hover { border-color: var(--primary); background: rgba(139, 21, 56, 0.02); }
        .file-upload.has-file { border-style: solid; border-color: #10b981; background: rgba(16, 185, 129, 0.05); }
        
        .video-preview { background: #1f2937; border-radius: 1rem; overflow: hidden; margin-bottom: 1rem; }
        .video-preview iframe { width: 100%; aspect-ratio: 16/9; border: none; }
        
        .sticky-sidebar { position: sticky; top: 80px; }
        
        @media (max-width: 991.98px) {
            .sidebar { transform: translateX(-100%); transition: transform 0.3s; }
            .sidebar.show { transform: translateX(0); }
            .type-selector { flex-direction: column; }
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
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/lecturer/course/content/${course.courseId}" class="text-decoration-none">${course.title}</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/lecturer/course/content/${course.courseId}" class="text-decoration-none">${section.title}</a></li>
                    <li class="breadcrumb-item active">${material != null ? 'Edit Materi' : 'Tambah Materi'}</li>
                </ol>
            </nav>
            
            <!-- Header -->
            <div class="mb-4">
                <h1 class="h3 fw-bold mb-1">
                    <i class="fas fa-file-alt text-primary me-2"></i>${material != null ? 'Edit Materi' : 'Tambah Materi Baru'}
                </h1>
                <p class="text-muted mb-0">Bab: <strong>${section.title}</strong></p>
            </div>
            
            <!-- Alerts -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show"><i class="fas fa-exclamation-circle me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/lecturer/course/${course.courseId}/section/${section.sectionId}/material/${material != null ? 'update' : 'save'}" method="POST" enctype="multipart/form-data" id="materialForm">
                <c:if test="${material != null}">
                    <input type="hidden" name="materialId" value="${material.materialId}">
                </c:if>
                
                <div class="row g-4">
                    <div class="col-lg-8">
                        <!-- Type Selection (Only for new materials) -->
                        <c:if test="${material == null}">
                            <div class="form-card">
                                <div class="form-card-header">
                                    <h5><i class="fas fa-layer-group text-primary me-2"></i>Tipe Materi</h5>
                                </div>
                                <div class="form-card-body">
                                    <div class="type-selector">
                                        <div class="type-card ${param.type == 'VIDEO' || material.contentType == 'VIDEO' ? 'active' : ''}" onclick="selectType('VIDEO')">
                                            <div class="type-card-icon video"><i class="fas fa-play"></i></div>
                                            <div class="type-card-title">Video</div>
                                            <div class="type-card-desc">YouTube atau upload file</div>
                                        </div>
                                        <div class="type-card ${param.type == 'TEXT' || material.contentType == 'TEXT' ? 'active' : ''}" onclick="selectType('TEXT')">
                                            <div class="type-card-icon text"><i class="fas fa-file-alt"></i></div>
                                            <div class="type-card-title">Teks/Artikel</div>
                                            <div class="type-card-desc">Konten berbasis teks</div>
                                        </div>
                                        <div class="type-card ${param.type == 'PDF' || material.contentType == 'PDF' ? 'active' : ''}" onclick="selectType('PDF')">
                                            <div class="type-card-icon pdf"><i class="fas fa-file-pdf"></i></div>
                                            <div class="type-card-title">PDF/Dokumen</div>
                                            <div class="type-card-desc">Upload file dokumen</div>
                                        </div>
                                    </div>
                                    <input type="hidden" name="contentType" id="contentType" value="${param.type != null ? param.type : (material.contentType != null ? material.contentType : 'VIDEO')}">
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${material != null}">
                            <input type="hidden" name="contentType" id="contentType" value="${material.contentType}">
                        </c:if>
                        
                        <!-- Basic Info -->
                        <div class="form-card">
                            <div class="form-card-header">
                                <h5><i class="fas fa-info-circle text-primary me-2"></i>Informasi Materi</h5>
                            </div>
                            <div class="form-card-body">
                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Judul Materi <span class="text-danger">*</span></label>
                                    <input type="text" name="title" class="form-control" value="${material.title}" required placeholder="Contoh: Pengenalan Variabel">
                                </div>
                                <div class="mb-0">
                                    <label class="form-label fw-semibold">Deskripsi (Opsional)</label>
                                    <textarea name="description" class="form-control" rows="3" placeholder="Deskripsi singkat tentang materi ini...">${material.description}</textarea>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Content Section -->
                        <div class="form-card">
                            <div class="form-card-header">
                                <h5><i class="fas fa-upload text-primary me-2"></i>Konten</h5>
                            </div>
                            <div class="form-card-body">
                                <!-- Video Content -->
                                <div id="videoContent" class="content-section" style="display: none;">
                                    <div class="mb-3">
                                        <label class="form-label fw-semibold">Sumber Video</label>
                                        <div class="d-flex gap-3 mb-3">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="videoSource" id="videoYoutube" value="youtube" checked onchange="toggleVideoSource()">
                                                <label class="form-check-label" for="videoYoutube">YouTube URL</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="videoSource" id="videoUpload" value="upload" onchange="toggleVideoSource()">
                                                <label class="form-check-label" for="videoUpload">Upload File</label>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div id="youtubeInput">
                                        <div class="mb-3">
                                            <label class="form-label fw-semibold">URL YouTube</label>
                                            <input type="url" name="videoUrl" id="videoUrl" class="form-control" value="${material.contentUrl}" placeholder="https://youtube.com/watch?v=...">
                                            <div class="form-text">Paste URL video YouTube Anda</div>
                                        </div>
                                        <div class="video-preview" id="videoPreview" style="display: none;">
                                            <iframe src="" allowfullscreen></iframe>
                                        </div>
                                    </div>
                                    
                                    <div id="uploadVideoInput" style="display: none;">
                                        <div class="file-upload" onclick="document.getElementById('videoFile').click()">
                                            <input type="file" name="videoFile" id="videoFile" accept="video/*" style="display: none;">
                                            <i class="fas fa-cloud-upload-alt fa-3x text-muted mb-3"></i>
                                            <p class="mb-1">Klik atau drag & drop video</p>
                                            <small class="text-muted">MP4, WebM (maks. 500MB)</small>
                                        </div>
                                        <div id="videoFileInfo" class="mt-2" style="display: none;"></div>
                                    </div>
                                </div>
                                
                                <!-- Text Content -->
                                <div id="textContent" class="content-section" style="display: none;">
                                    <label class="form-label fw-semibold">Konten Teks</label>
                                    <textarea name="textContent" id="textEditor" class="form-control" rows="15">${material.content}</textarea>
                                </div>
                                
                                <!-- PDF Content -->
                                <div id="pdfContent" class="content-section" style="display: none;">
                                    <div class="file-upload" onclick="document.getElementById('pdfFile').click()" id="pdfUploadArea">
                                        <input type="file" name="pdfFile" id="pdfFile" accept=".pdf,.doc,.docx,.ppt,.pptx" style="display: none;">
                                        <c:choose>
                                            <c:when test="${not empty material.contentUrl && material.contentType == 'PDF'}">
                                                <i class="fas fa-file-pdf fa-3x text-success mb-3"></i>
                                                <p class="mb-1 text-success fw-semibold">File sudah diupload</p>
                                                <small class="text-muted">Klik untuk mengganti file</small>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-cloud-upload-alt fa-3x text-muted mb-3"></i>
                                                <p class="mb-1">Klik atau drag & drop dokumen</p>
                                                <small class="text-muted">PDF, DOC, DOCX, PPT, PPTX (maks. 50MB)</small>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div id="pdfFileInfo" class="mt-2" style="display: none;"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Sidebar -->
                    <div class="col-lg-4">
                        <div class="sticky-sidebar">
                            <div class="form-card">
                                <div class="form-card-header">
                                    <h5><i class="fas fa-cog text-primary me-2"></i>Pengaturan</h5>
                                </div>
                                <div class="form-card-body">
                                    <div class="mb-3">
                                        <label class="form-label fw-semibold">Durasi (menit)</label>
                                        <input type="number" name="duration" class="form-control" value="${material.duration != null ? material.duration : 0}" min="0" placeholder="0">
                                        <div class="form-text">Perkiraan waktu untuk menyelesaikan</div>
                                    </div>
                                    
                                    <div class="mb-4">
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" name="isFree" id="isFree" value="true" ${material.free ? 'checked' : ''}>
                                            <label class="form-check-label" for="isFree">
                                                <strong>Free Preview</strong>
                                                <br><small class="text-muted">Dapat diakses tanpa pembelian</small>
                                            </label>
                                        </div>
                                    </div>
                                    
                                    <hr>
                                    
                                    <div class="d-grid gap-2">
                                        <button type="submit" class="btn btn-primary btn-lg">
                                            <i class="fas fa-save me-2"></i>${material != null ? 'Simpan Perubahan' : 'Simpan Materi'}
                                        </button>
                                        <a href="${pageContext.request.contextPath}/lecturer/course/content/${course.courseId}" class="btn btn-outline-secondary">Batal</a>
                                    </div>
                                    
                                    <!-- Preview Toggle -->
                                    <hr>
                                    <button type="button" class="btn btn-outline-primary w-100" onclick="previewMaterial()">
                                        <i class="fas fa-eye me-2"></i>Preview
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </main>
    </div>
    
    <!-- Preview Modal -->
    <div class="modal fade" id="previewModal" tabindex="-1">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Preview Materi</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="previewContent">
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/6/tinymce.min.js"></script>
    
    <script>
        // Initialize based on content type
        document.addEventListener('DOMContentLoaded', function() {
            const type = document.getElementById('contentType').value;
            showContentSection(type);
            
            // Initialize TinyMCE
            tinymce.init({
                selector: '#textEditor',
                height: 400,
                plugins: 'lists link image code table',
                toolbar: 'undo redo | formatselect | bold italic | alignleft aligncenter alignright | bullist numlist | link image | code',
                menubar: false,
                branding: false
            });
        });
        
        // Type selection
        function selectType(type) {
            document.querySelectorAll('.type-card').forEach(card => card.classList.remove('active'));
            event.currentTarget.classList.add('active');
            document.getElementById('contentType').value = type;
            showContentSection(type);
        }
        
        // Show content section based on type
        function showContentSection(type) {
            document.querySelectorAll('.content-section').forEach(section => section.style.display = 'none');
            
            if (type === 'VIDEO') {
                document.getElementById('videoContent').style.display = 'block';
            } else if (type === 'TEXT') {
                document.getElementById('textContent').style.display = 'block';
            } else if (type === 'PDF') {
                document.getElementById('pdfContent').style.display = 'block';
            }
        }
        
        // Toggle video source
        function toggleVideoSource() {
            const isYoutube = document.getElementById('videoYoutube').checked;
            document.getElementById('youtubeInput').style.display = isYoutube ? 'block' : 'none';
            document.getElementById('uploadVideoInput').style.display = isYoutube ? 'none' : 'block';
        }
        
        // YouTube URL preview
        document.getElementById('videoUrl').addEventListener('input', function(e) {
            const url = e.target.value;
            const videoId = extractYouTubeId(url);
            const preview = document.getElementById('videoPreview');
            
            if (videoId) {
                preview.querySelector('iframe').src = 'https://www.youtube.com/embed/' + videoId;
                preview.style.display = 'block';
            } else {
                preview.style.display = 'none';
            }
        });
        
        function extractYouTubeId(url) {
            const regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
            const match = url.match(regExp);
            return (match && match[2].length === 11) ? match[2] : null;
        }
        
        // File upload info
        document.getElementById('videoFile').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                document.getElementById('videoFileInfo').innerHTML = '<div class="alert alert-success mb-0"><i class="fas fa-check-circle me-2"></i>File: ' + file.name + ' (' + (file.size / 1024 / 1024).toFixed(2) + ' MB)</div>';
                document.getElementById('videoFileInfo').style.display = 'block';
            }
        });
        
        document.getElementById('pdfFile').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                document.getElementById('pdfUploadArea').classList.add('has-file');
                document.getElementById('pdfFileInfo').innerHTML = '<div class="alert alert-success mb-0"><i class="fas fa-check-circle me-2"></i>File: ' + file.name + ' (' + (file.size / 1024 / 1024).toFixed(2) + ' MB)</div>';
                document.getElementById('pdfFileInfo').style.display = 'block';
            }
        });
        
        // Preview material
        function previewMaterial() {
            const type = document.getElementById('contentType').value;
            const previewContent = document.getElementById('previewContent');
            
            if (type === 'VIDEO') {
                const videoUrl = document.getElementById('videoUrl').value;
                const videoId = extractYouTubeId(videoUrl);
                if (videoId) {
                    previewContent.innerHTML = '<div class="ratio ratio-16x9"><iframe src="https://www.youtube.com/embed/' + videoId + '" allowfullscreen></iframe></div>';
                } else {
                    previewContent.innerHTML = '<p class="text-muted text-center">Masukkan URL YouTube yang valid untuk preview</p>';
                }
            } else if (type === 'TEXT') {
                const content = tinymce.get('textEditor').getContent();
                previewContent.innerHTML = content || '<p class="text-muted text-center">Belum ada konten</p>';
            } else {
                previewContent.innerHTML = '<p class="text-muted text-center">Preview tidak tersedia untuk tipe ini</p>';
            }
            
            new bootstrap.Modal(document.getElementById('previewModal')).show();
        }
    </script>
</body>
</html>
