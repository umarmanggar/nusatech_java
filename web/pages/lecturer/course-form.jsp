<%-- 
    Document   : course-form
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Create/Edit Course Form with Bootstrap 5 and TinyMCE
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${course != null ? 'Edit' : 'Buat'} Kursus - NusaTech</title>
    
    <!-- Bootstrap 5 CSS -->
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
        
        .thumbnail-upload { border: 2px dashed #d1d5db; border-radius: 1rem; padding: 2rem; text-align: center; cursor: pointer; transition: all 0.3s; background: #fafafa; }
        .thumbnail-upload:hover { border-color: var(--primary); background: rgba(139, 21, 56, 0.02); }
        .thumbnail-upload.has-image { padding: 0; border: none; }
        .thumbnail-upload img { max-width: 100%; border-radius: 1rem; }
        
        .sticky-sidebar { position: sticky; top: 80px; }
        
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
                <a href="${pageContext.request.contextPath}/lecturer/courses" class="sidebar-item"><i class="fas fa-book"></i> Kursus Saya</a>
                <a href="${pageContext.request.contextPath}/lecturer/course/create" class="sidebar-item active"><i class="fas fa-plus-circle"></i> Buat Kursus</a>
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
                    <li class="breadcrumb-item active">${course != null ? 'Edit Kursus' : 'Buat Kursus Baru'}</li>
                </ol>
            </nav>
            
            <!-- Header -->
            <div class="mb-4">
                <h1 class="h3 fw-bold mb-1">
                    <i class="fas fa-${course != null ? 'edit' : 'plus-circle'} text-primary me-2"></i>
                    ${course != null ? 'Edit Kursus' : 'Buat Kursus Baru'}
                </h1>
                <p class="text-muted mb-0">${course != null ? 'Perbarui informasi kursus Anda' : 'Bagikan pengetahuan Anda dengan membuat kursus baru'}</p>
            </div>
            
            <!-- Alerts -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/lecturer/course/${course != null ? 'update' : 'create'}" method="post" enctype="multipart/form-data" id="courseForm">
                <c:if test="${course != null}">
                    <input type="hidden" name="courseId" value="${course.courseId}">
                </c:if>
                
                <div class="row g-4">
                    <!-- Main Column -->
                    <div class="col-lg-8">
                        <!-- Basic Info -->
                        <div class="form-card">
                            <div class="form-card-header">
                                <h5><i class="fas fa-info-circle text-primary me-2"></i>Informasi Dasar</h5>
                            </div>
                            <div class="form-card-body">
                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Judul Kursus <span class="text-danger">*</span></label>
                                    <input type="text" name="title" class="form-control form-control-lg" value="${course.title}" required placeholder="Contoh: Belajar Python dari Nol" maxlength="100">
                                    <div class="form-text">Judul yang menarik dan deskriptif (maksimal 100 karakter)</div>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label fw-semibold">URL Slug <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text">nusatech.com/course/</span>
                                        <input type="text" name="slug" class="form-control" value="${course.slug}" required placeholder="belajar-python-dari-nol">
                                    </div>
                                    <div class="form-text">URL unik untuk kursus (huruf kecil, gunakan tanda hubung)</div>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Deskripsi Singkat <span class="text-danger">*</span></label>
                                    <textarea name="shortDescription" class="form-control" rows="2" required maxlength="200" placeholder="Ringkasan singkat tentang kursus ini...">${course.shortDescription}</textarea>
                                    <div class="form-text">Tampil di kartu kursus (maksimal 200 karakter)</div>
                                </div>
                                
                                <div class="mb-0">
                                    <label class="form-label fw-semibold">Deskripsi Lengkap <span class="text-danger">*</span></label>
                                    <textarea name="description" id="description" class="form-control" rows="10" required>${course.description}</textarea>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Course Details -->
                        <div class="form-card">
                            <div class="form-card-header">
                                <h5><i class="fas fa-list-check text-primary me-2"></i>Detail Kursus</h5>
                            </div>
                            <div class="form-card-body">
                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Yang Akan Dipelajari</label>
                                    <textarea name="objectives" class="form-control" rows="4" placeholder="Satu poin per baris:&#10;- Memahami dasar-dasar Python&#10;- Mampu membuat program sederhana">${course.objectives}</textarea>
                                    <div class="form-text">Pisahkan dengan baris baru atau gunakan karakter "|"</div>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Persyaratan</label>
                                    <textarea name="requirements" class="form-control" rows="3" placeholder="Persyaratan untuk mengikuti kursus...">${course.requirements}</textarea>
                                </div>
                                
                                <div class="mb-0">
                                    <label class="form-label fw-semibold">Target Audiens</label>
                                    <textarea name="targetAudience" class="form-control" rows="3" placeholder="Kursus ini cocok untuk...">${course.targetAudience}</textarea>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Media -->
                        <div class="form-card">
                            <div class="form-card-header">
                                <h5><i class="fas fa-photo-video text-primary me-2"></i>Media</h5>
                            </div>
                            <div class="form-card-body">
                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Thumbnail Kursus</label>
                                    <div class="thumbnail-upload ${not empty course.thumbnail ? 'has-image' : ''}" id="thumbnailArea" onclick="document.getElementById('thumbnailInput').click()">
                                        <input type="file" name="thumbnail" id="thumbnailInput" accept="image/*" style="display: none;">
                                        <div id="thumbnailPreview">
                                            <c:choose>
                                                <c:when test="${not empty course.thumbnail}">
                                                    <img src="${course.thumbnail}" alt="Thumbnail">
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-cloud-upload-alt fa-3x text-muted mb-3"></i>
                                                    <p class="mb-1 text-muted">Klik atau drag & drop gambar</p>
                                                    <small class="text-muted">PNG, JPG (maks. 2MB, 1280x720 disarankan)</small>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="mb-0">
                                    <label class="form-label fw-semibold">URL Video Preview (Opsional)</label>
                                    <input type="url" name="previewVideo" class="form-control" value="${course.previewVideo}" placeholder="https://youtube.com/watch?v=...">
                                    <div class="form-text">Video pengenalan untuk menarik minat calon pelajar</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Sidebar Column -->
                    <div class="col-lg-4">
                        <div class="sticky-sidebar">
                            <div class="form-card">
                                <div class="form-card-header">
                                    <h5><i class="fas fa-cog text-primary me-2"></i>Pengaturan</h5>
                                </div>
                                <div class="form-card-body">
                                    <div class="mb-3">
                                        <label class="form-label fw-semibold">Kategori <span class="text-danger">*</span></label>
                                        <select name="categoryId" class="form-select" required>
                                            <option value="">Pilih Kategori</option>
                                            <c:forEach var="category" items="${categories}">
                                                <option value="${category.categoryId}" ${course.categoryId == category.categoryId ? 'selected' : ''}>${category.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label class="form-label fw-semibold">Tingkat Kesulitan <span class="text-danger">*</span></label>
                                        <select name="level" class="form-select" required>
                                            <option value="BEGINNER" ${course.level == 'BEGINNER' ? 'selected' : ''}>Pemula</option>
                                            <option value="INTERMEDIATE" ${course.level == 'INTERMEDIATE' ? 'selected' : ''}>Menengah</option>
                                            <option value="ADVANCED" ${course.level == 'ADVANCED' ? 'selected' : ''}>Lanjutan</option>
                                            <option value="ALL_LEVELS" ${course.level == 'ALL_LEVELS' ? 'selected' : ''}>Semua Level</option>
                                        </select>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label class="form-label fw-semibold">Bahasa</label>
                                        <select name="language" class="form-select">
                                            <option value="Bahasa Indonesia" ${course.language == 'Bahasa Indonesia' || course == null ? 'selected' : ''}>Bahasa Indonesia</option>
                                            <option value="English" ${course.language == 'English' ? 'selected' : ''}>English</option>
                                        </select>
                                    </div>
                                    
                                    <hr>
                                    
                                    <div class="mb-3">
                                        <label class="form-label fw-semibold">Tipe Harga</label>
                                        <div class="d-flex gap-3">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="isFree" value="true" id="priceFree" ${course.free ? 'checked' : ''} onchange="togglePrice()">
                                                <label class="form-check-label" for="priceFree">Gratis</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="isFree" value="false" id="pricePaid" ${!course.free || course == null ? 'checked' : ''} onchange="togglePrice()">
                                                <label class="form-check-label" for="pricePaid">Berbayar</label>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div id="priceFields">
                                        <div class="mb-3">
                                            <label class="form-label fw-semibold">Harga (Rp)</label>
                                            <input type="number" name="price" class="form-control" value="${course.price != null ? course.price : 0}" min="0" step="10000">
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label class="form-label fw-semibold">Harga Diskon</label>
                                            <input type="number" name="discountPrice" class="form-control" value="${course.discountPrice}" min="0" step="10000">
                                            <div class="form-text">Kosongkan jika tidak ada diskon</div>
                                        </div>
                                    </div>
                                    
                                    <hr>
                                    
                                    <div class="mb-4">
                                        <label class="form-label fw-semibold">Status</label>
                                        <select name="status" class="form-select">
                                            <option value="DRAFT" ${course.status == 'DRAFT' || course == null ? 'selected' : ''}>Draft - Simpan sebagai draft</option>
                                            <option value="PENDING" ${course.status == 'PENDING' ? 'selected' : ''}>Submit - Ajukan untuk review</option>
                                            <c:if test="${course.status == 'PUBLISHED'}">
                                                <option value="PUBLISHED" selected>Published - Sudah dipublikasikan</option>
                                            </c:if>
                                        </select>
                                    </div>
                                    
                                    <div class="d-grid gap-2">
                                        <button type="submit" class="btn btn-primary btn-lg">
                                            <i class="fas fa-save me-2"></i>${course != null ? 'Simpan Perubahan' : 'Buat Kursus'}
                                        </button>
                                        <a href="${pageContext.request.contextPath}/lecturer/courses" class="btn btn-outline-secondary">Batal</a>
                                    </div>
                                    
                                    <c:if test="${course != null}">
                                        <hr>
                                        <a href="${pageContext.request.contextPath}/lecturer/course/content/${course.courseId}" class="btn btn-secondary w-100">
                                            <i class="fas fa-list-ol me-2"></i>Kelola Materi
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </main>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- TinyMCE -->
    <script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
    
    <script>
        // Initialize TinyMCE
        tinymce.init({
            selector: '#description',
            height: 400,
            plugins: 'lists link image code table',
            toolbar: 'undo redo | formatselect | bold italic | alignleft aligncenter alignright | bullist numlist | link image | code',
            menubar: false,
            branding: false
        });
        
        // Thumbnail preview
        document.getElementById('thumbnailInput').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('thumbnailArea').classList.add('has-image');
                    document.getElementById('thumbnailPreview').innerHTML = '<img src="' + e.target.result + '" alt="Preview">';
                };
                reader.readAsDataURL(file);
            }
        });
        
        // Toggle price fields
        function togglePrice() {
            const isFree = document.getElementById('priceFree').checked;
            document.getElementById('priceFields').style.display = isFree ? 'none' : 'block';
        }
        togglePrice();
        
        // Auto-generate slug
        document.querySelector('input[name="title"]').addEventListener('input', function(e) {
            const slugInput = document.querySelector('input[name="slug"]');
            if (!slugInput.value || slugInput.dataset.auto === 'true') {
                slugInput.value = e.target.value.toLowerCase().replace(/[^a-z0-9\s-]/g, '').replace(/\s+/g, '-').substring(0, 100);
                slugInput.dataset.auto = 'true';
            }
        });
        document.querySelector('input[name="slug"]').addEventListener('input', function() { this.dataset.auto = 'false'; });
    </script>
</body>
</html>
