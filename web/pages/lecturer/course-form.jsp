<%-- 
    Document   : course-form
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Create/Edit Course Form for Lecturers
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
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <jsp:include page="/pages/common/navbar-dashboard.jsp"/>
    
    <div class="dashboard-layout">
        <aside class="sidebar">
            <div class="sidebar-menu">
                <a href="${pageContext.request.contextPath}/lecturer/dashboard" class="sidebar-item">
                    <i class="fas fa-home"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/lecturer/courses" class="sidebar-item">
                    <i class="fas fa-book"></i> Kursus Saya
                </a>
                <a href="${pageContext.request.contextPath}/lecturer/course/create" class="sidebar-item active">
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
                <h1 class="page-title">
                    <i class="fas fa-${course != null ? 'edit' : 'plus-circle'}" style="color: var(--primary);"></i>
                    ${course != null ? 'Edit Kursus' : 'Buat Kursus Baru'}
                </h1>
                <p class="page-subtitle">
                    ${course != null ? 'Perbarui informasi kursus Anda' : 'Bagikan pengetahuan Anda dengan membuat kursus baru'}
                </p>
            </div>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>
            
            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> ${success}
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/lecturer/course/${course != null ? 'update' : 'create'}" 
                  method="post" enctype="multipart/form-data" id="courseForm">
                <c:if test="${course != null}">
                    <input type="hidden" name="courseId" value="${course.courseId}">
                </c:if>
                
                <div class="grid" style="grid-template-columns: 2fr 1fr; gap: 2rem;">
                    <!-- Main Content -->
                    <div>
                        <!-- Basic Info Card -->
                        <div class="card" style="margin-bottom: 1.5rem;">
                            <div class="card-header">
                                <h3><i class="fas fa-info-circle"></i> Informasi Dasar</h3>
                            </div>
                            <div class="card-body">
                                <div class="form-group">
                                    <label class="form-label">Judul Kursus <span class="text-danger">*</span></label>
                                    <input type="text" name="title" class="form-control" 
                                           value="${course.title}" required
                                           placeholder="Contoh: Belajar Python dari Nol">
                                    <small class="form-hint">Judul yang menarik dan deskriptif (maksimal 100 karakter)</small>
                                </div>
                                
                                <div class="form-group">
                                    <label class="form-label">URL Slug <span class="text-danger">*</span></label>
                                    <div style="display: flex; align-items: center; gap: 0.5rem;">
                                        <span style="color: var(--gray-500);">nusatech.com/course/</span>
                                        <input type="text" name="slug" class="form-control" 
                                               value="${course.slug}" required
                                               placeholder="belajar-python-dari-nol" style="flex: 1;">
                                    </div>
                                    <small class="form-hint">URL unik untuk kursus Anda (huruf kecil, gunakan tanda hubung)</small>
                                </div>
                                
                                <div class="form-group">
                                    <label class="form-label">Deskripsi Singkat <span class="text-danger">*</span></label>
                                    <textarea name="shortDescription" class="form-control" rows="2" required
                                              placeholder="Ringkasan singkat tentang kursus ini (maksimal 200 karakter)">${course.shortDescription}</textarea>
                                    <small class="form-hint">Tampil di kartu kursus dan hasil pencarian</small>
                                </div>
                                
                                <div class="form-group">
                                    <label class="form-label">Deskripsi Lengkap <span class="text-danger">*</span></label>
                                    <textarea name="description" class="form-control" rows="6" required
                                              placeholder="Jelaskan secara detail tentang kursus ini, apa yang akan dipelajari, dan siapa target audiensnya...">${course.description}</textarea>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Course Details Card -->
                        <div class="card" style="margin-bottom: 1.5rem;">
                            <div class="card-header">
                                <h3><i class="fas fa-list-check"></i> Detail Kursus</h3>
                            </div>
                            <div class="card-body">
                                <div class="form-group">
                                    <label class="form-label">Yang Akan Dipelajari</label>
                                    <textarea name="objectives" class="form-control" rows="4" 
                                              placeholder="Satu poin per baris:&#10;- Memahami dasar-dasar Python&#10;- Mampu membuat program sederhana&#10;- Menguasai konsep OOP">${course.objectives}</textarea>
                                    <small class="form-hint">Tulis satu poin pembelajaran per baris</small>
                                </div>
                                
                                <div class="form-group">
                                    <label class="form-label">Persyaratan</label>
                                    <textarea name="requirements" class="form-control" rows="3" 
                                              placeholder="Satu persyaratan per baris:&#10;- Memiliki komputer/laptop&#10;- Koneksi internet stabil">${course.requirements}</textarea>
                                    <small class="form-hint">Prasyarat yang diperlukan sebelum mengikuti kursus</small>
                                </div>
                                
                                <div class="form-group">
                                    <label class="form-label">Target Audiens</label>
                                    <textarea name="targetAudience" class="form-control" rows="3" 
                                              placeholder="Kursus ini cocok untuk:&#10;- Pemula yang ingin belajar programming&#10;- Mahasiswa jurusan IT">${course.targetAudience}</textarea>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Media Card -->
                        <div class="card">
                            <div class="card-header">
                                <h3><i class="fas fa-photo-video"></i> Media</h3>
                            </div>
                            <div class="card-body">
                                <div class="form-group">
                                    <label class="form-label">Thumbnail Kursus</label>
                                    <div class="file-upload-area" style="border: 2px dashed var(--gray-300); border-radius: var(--radius-lg); padding: 2rem; text-align: center; cursor: pointer; transition: all 0.3s ease;">
                                        <input type="file" name="thumbnail" id="thumbnailInput" accept="image/*" style="display: none;">
                                        <div id="thumbnailPreview">
                                            <c:choose>
                                                <c:when test="${not empty course.thumbnail}">
                                                    <img src="${course.thumbnail}" alt="Thumbnail" style="max-width: 200px; border-radius: var(--radius-md);">
                                                    <p style="margin-top: 0.5rem; color: var(--gray-500);">Klik untuk mengganti</p>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-cloud-upload-alt" style="font-size: 3rem; color: var(--gray-400);"></i>
                                                    <p style="margin-top: 0.5rem; color: var(--gray-500);">Klik atau drag & drop gambar di sini</p>
                                                    <p style="font-size: 0.75rem; color: var(--gray-400);">PNG, JPG (maks. 2MB, disarankan 1280x720)</p>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="form-label">URL Video Preview (Opsional)</label>
                                    <input type="url" name="previewVideo" class="form-control" 
                                           value="${course.previewVideo}"
                                           placeholder="https://youtube.com/watch?v=...">
                                    <small class="form-hint">Video pengenalan singkat untuk menarik minat calon pelajar</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Sidebar -->
                    <div>
                        <!-- Settings Card -->
                        <div class="card" style="margin-bottom: 1.5rem; position: sticky; top: 1rem;">
                            <div class="card-header">
                                <h3><i class="fas fa-cog"></i> Pengaturan</h3>
                            </div>
                            <div class="card-body">
                                <div class="form-group">
                                    <label class="form-label">Kategori <span class="text-danger">*</span></label>
                                    <select name="categoryId" class="form-control" required>
                                        <option value="">Pilih Kategori</option>
                                        <c:forEach var="category" items="${categories}">
                                            <option value="${category.categoryId}" 
                                                    ${course.categoryId == category.categoryId ? 'selected' : ''}>
                                                ${category.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                
                                <div class="form-group">
                                    <label class="form-label">Tingkat Kesulitan <span class="text-danger">*</span></label>
                                    <select name="level" class="form-control" required>
                                        <option value="BEGINNER" ${course.level == 'BEGINNER' ? 'selected' : ''}>Pemula</option>
                                        <option value="INTERMEDIATE" ${course.level == 'INTERMEDIATE' ? 'selected' : ''}>Menengah</option>
                                        <option value="ADVANCED" ${course.level == 'ADVANCED' ? 'selected' : ''}>Lanjutan</option>
                                        <option value="ALL_LEVELS" ${course.level == 'ALL_LEVELS' ? 'selected' : ''}>Semua Level</option>
                                    </select>
                                </div>
                                
                                <div class="form-group">
                                    <label class="form-label">Bahasa</label>
                                    <select name="language" class="form-control">
                                        <option value="Bahasa Indonesia" ${course.language == 'Bahasa Indonesia' || course == null ? 'selected' : ''}>Bahasa Indonesia</option>
                                        <option value="English" ${course.language == 'English' ? 'selected' : ''}>English</option>
                                    </select>
                                </div>
                                
                                <div class="form-group">
                                    <label class="form-label">Durasi (jam)</label>
                                    <input type="number" name="durationHours" class="form-control" 
                                           value="${course.durationHours != null ? course.durationHours : 0}" 
                                           min="0" step="0.5" placeholder="0">
                                </div>
                                
                                <hr style="margin: 1.5rem 0;">
                                
                                <div class="form-group">
                                    <label class="form-label">Tipe Harga</label>
                                    <div style="display: flex; gap: 1rem; margin-top: 0.5rem;">
                                        <label style="display: flex; align-items: center; gap: 0.5rem; cursor: pointer;">
                                            <input type="radio" name="isFree" value="true" 
                                                   ${course.isFree ? 'checked' : ''} 
                                                   onchange="togglePriceField(this)">
                                            <span>Gratis</span>
                                        </label>
                                        <label style="display: flex; align-items: center; gap: 0.5rem; cursor: pointer;">
                                            <input type="radio" name="isFree" value="false" 
                                                   ${!course.isFree || course == null ? 'checked' : ''} 
                                                   onchange="togglePriceField(this)">
                                            <span>Berbayar</span>
                                        </label>
                                    </div>
                                </div>
                                
                                <div class="form-group" id="priceGroup">
                                    <label class="form-label">Harga (Rp)</label>
                                    <input type="number" name="price" class="form-control" 
                                           value="${course.price != null ? course.price : 0}" 
                                           min="0" step="10000" placeholder="0">
                                </div>
                                
                                <div class="form-group" id="discountGroup">
                                    <label class="form-label">Harga Diskon (Opsional)</label>
                                    <input type="number" name="discountPrice" class="form-control" 
                                           value="${course.discountPrice}" 
                                           min="0" step="10000" placeholder="0">
                                    <small class="form-hint">Kosongkan jika tidak ada diskon</small>
                                </div>
                                
                                <hr style="margin: 1.5rem 0;">
                                
                                <div class="form-group">
                                    <label class="form-label">Status</label>
                                    <select name="status" class="form-control">
                                        <option value="DRAFT" ${course.status == 'DRAFT' || course == null ? 'selected' : ''}>Draft - Simpan sebagai draft</option>
                                        <option value="PENDING" ${course.status == 'PENDING' ? 'selected' : ''}>Submit - Ajukan untuk review</option>
                                        <c:if test="${course.status == 'PUBLISHED'}">
                                            <option value="PUBLISHED" selected>Published - Sudah dipublikasikan</option>
                                        </c:if>
                                    </select>
                                </div>
                                
                                <div style="margin-top: 1.5rem;">
                                    <button type="submit" class="btn btn-primary btn-lg w-100">
                                        <i class="fas fa-save"></i> ${course != null ? 'Simpan Perubahan' : 'Buat Kursus'}
                                    </button>
                                    <a href="${pageContext.request.contextPath}/lecturer/courses" 
                                       class="btn btn-outline btn-lg w-100" style="margin-top: 0.75rem;">
                                        Batal
                                    </a>
                                </div>
                                
                                <c:if test="${course != null}">
                                    <hr style="margin: 1.5rem 0;">
                                    <a href="${pageContext.request.contextPath}/lecturer/course/content/${course.courseId}" 
                                       class="btn btn-secondary btn-lg w-100">
                                        <i class="fas fa-list"></i> Kelola Materi
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </main>
    </div>
    
    <script>
        // File upload area click handler
        document.querySelector('.file-upload-area').addEventListener('click', function() {
            document.getElementById('thumbnailInput').click();
        });
        
        // Preview thumbnail on select
        document.getElementById('thumbnailInput').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('thumbnailPreview').innerHTML = 
                        '<img src="' + e.target.result + '" alt="Preview" style="max-width: 200px; border-radius: var(--radius-md);">' +
                        '<p style="margin-top: 0.5rem; color: var(--gray-500);">Klik untuk mengganti</p>';
                };
                reader.readAsDataURL(file);
            }
        });
        
        // Toggle price field based on free/paid selection
        function togglePriceField(radio) {
            const priceGroup = document.getElementById('priceGroup');
            const discountGroup = document.getElementById('discountGroup');
            if (radio.value === 'true') {
                priceGroup.style.display = 'none';
                discountGroup.style.display = 'none';
            } else {
                priceGroup.style.display = 'block';
                discountGroup.style.display = 'block';
            }
        }
        
        // Initialize price field visibility
        document.addEventListener('DOMContentLoaded', function() {
            const checkedRadio = document.querySelector('input[name="isFree"]:checked');
            if (checkedRadio) {
                togglePriceField(checkedRadio);
            }
        });
        
        // Auto-generate slug from title
        document.querySelector('input[name="title"]').addEventListener('input', function(e) {
            const slugInput = document.querySelector('input[name="slug"]');
            if (!slugInput.value || slugInput.dataset.autoGenerated === 'true') {
                slugInput.value = e.target.value
                    .toLowerCase()
                    .replace(/[^a-z0-9\s-]/g, '')
                    .replace(/\s+/g, '-')
                    .replace(/-+/g, '-')
                    .substring(0, 100);
                slugInput.dataset.autoGenerated = 'true';
            }
        });
        
        // Mark slug as manually edited
        document.querySelector('input[name="slug"]').addEventListener('input', function() {
            this.dataset.autoGenerated = 'false';
        });
    </script>
</body>
</html>
