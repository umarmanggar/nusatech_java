<%-- 
    Document   : profile
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Student Profile Page with Bootstrap 5
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profil Saya - NusaTech</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #8B1538;
            --primary-dark: #6d1029;
            --secondary: #D4A84B;
        }
        
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8f9fa;
        }
        
        .btn-primary { background-color: var(--primary); border-color: var(--primary); }
        .btn-primary:hover { background-color: var(--primary-dark); border-color: var(--primary-dark); }
        .btn-outline-primary { color: var(--primary); border-color: var(--primary); }
        .btn-outline-primary:hover { background-color: var(--primary); border-color: var(--primary); }
        .text-primary { color: var(--primary) !important; }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.2rem rgba(139, 21, 56, 0.15);
        }
        
        /* Layout */
        .dashboard-wrapper {
            display: flex;
            min-height: 100vh;
            padding-top: 56px;
        }
        
        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 2rem;
        }
        
        @media (max-width: 991.98px) {
            .main-content { margin-left: 0; }
        }
        
        /* Page Header */
        .page-title {
            font-size: 1.75rem;
            font-weight: 800;
            color: #1f2937;
            margin-bottom: 0.25rem;
        }
        
        .page-subtitle {
            color: #6b7280;
        }
        
        /* Profile Card */
        .profile-card {
            background: white;
            border-radius: 1rem;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }
        
        .profile-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            padding: 2rem;
            text-align: center;
            color: white;
            position: relative;
        }
        
        .profile-avatar-wrapper {
            position: relative;
            display: inline-block;
        }
        
        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 4px solid rgba(255,255,255,0.3);
            object-fit: cover;
        }
        
        .profile-avatar-upload {
            position: absolute;
            bottom: 5px;
            right: 5px;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: var(--secondary);
            color: #1f2937;
            border: 3px solid white;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .profile-avatar-upload:hover {
            transform: scale(1.1);
        }
        
        .profile-name {
            font-size: 1.5rem;
            font-weight: 700;
            margin-top: 1rem;
            margin-bottom: 0.25rem;
        }
        
        .profile-email {
            opacity: 0.9;
            font-size: 0.9rem;
        }
        
        .profile-badge {
            display: inline-block;
            background: rgba(255,255,255,0.2);
            padding: 0.35rem 1rem;
            border-radius: 2rem;
            font-size: 0.8rem;
            margin-top: 0.75rem;
        }
        
        .profile-stats {
            display: flex;
            justify-content: center;
            gap: 3rem;
            padding: 1.5rem;
            border-bottom: 1px solid #e5e7eb;
        }
        
        .profile-stat {
            text-align: center;
        }
        
        .profile-stat-value {
            font-size: 1.75rem;
            font-weight: 800;
            color: var(--primary);
        }
        
        .profile-stat-label {
            font-size: 0.8rem;
            color: #6b7280;
        }
        
        .profile-info {
            padding: 1.5rem;
        }
        
        .profile-info-item {
            display: flex;
            align-items: center;
            padding: 0.75rem 0;
            border-bottom: 1px solid #f3f4f6;
        }
        
        .profile-info-item:last-child {
            border-bottom: none;
        }
        
        .profile-info-icon {
            width: 40px;
            height: 40px;
            border-radius: 0.75rem;
            background: rgba(139, 21, 56, 0.1);
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
        }
        
        .profile-info-label {
            font-size: 0.75rem;
            color: #9ca3af;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .profile-info-value {
            font-weight: 600;
            color: #1f2937;
        }
        
        /* Form Card */
        .form-card {
            background: white;
            border-radius: 1rem;
            padding: 2rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            margin-bottom: 1.5rem;
        }
        
        .form-card-title {
            font-size: 1.25rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .form-card-title i {
            color: var(--primary);
        }
        
        .form-label {
            font-weight: 600;
            font-size: 0.875rem;
            color: #374151;
        }
        
        .form-hint {
            font-size: 0.75rem;
            color: #9ca3af;
            margin-top: 0.25rem;
        }
        
        /* Alert Messages */
        .alert {
            border: none;
            border-radius: 0.75rem;
        }
        
        .alert-success {
            background: rgba(16, 185, 129, 0.1);
            color: #059669;
        }
        
        .alert-danger {
            background: rgba(239, 68, 68, 0.1);
            color: #dc2626;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <jsp:include page="/pages/common/navbar-dashboard.jsp"/>
    
    <div class="dashboard-wrapper">
        <!-- Sidebar -->
        <jsp:include page="/pages/common/sidebar-student.jsp"/>
        
        <!-- Main Content -->
        <main class="main-content">
            <!-- Mobile Sidebar Toggle -->
            <button class="btn btn-outline-secondary d-lg-none mb-3" onclick="toggleSidebar()">
                <i class="fas fa-bars me-2"></i> Menu
            </button>
            
            <!-- Page Header -->
            <div class="mb-4">
                <h1 class="page-title">Profil Saya</h1>
                <p class="page-subtitle mb-0">Kelola informasi profil Anda</p>
            </div>
            
            <!-- Alert Messages -->
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success d-flex align-items-center" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    <span>${sessionScope.successMessage}</span>
                    <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="successMessage" scope="session"/>
            </c:if>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger d-flex align-items-center" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <span>${error}</span>
                    <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            
            <div class="row g-4">
                <!-- Profile Card Column -->
                <div class="col-lg-4">
                    <div class="profile-card">
                        <div class="profile-header">
                            <div class="profile-avatar-wrapper">
                                <img src="${not empty user.profileImage ? user.profileImage : 'https://ui-avatars.com/api/?name='.concat(user.name).concat('&background=ffffff&color=8B1538&size=120')}" 
                                     alt="${user.name}" class="profile-avatar" id="avatarPreview">
                                <label for="avatarInput" class="profile-avatar-upload">
                                    <i class="fas fa-camera"></i>
                                </label>
                                <input type="file" id="avatarInput" accept="image/*" style="display: none;" onchange="uploadAvatar(this)">
                            </div>
                            <h2 class="profile-name">${user.name}</h2>
                            <p class="profile-email">${user.email}</p>
                            <span class="profile-badge">
                                <i class="fas fa-graduation-cap me-1"></i> ${user.roleDisplayName}
                            </span>
                        </div>
                        
                        <div class="profile-stats">
                            <div class="profile-stat">
                                <div class="profile-stat-value">${totalEnrolled != null ? totalEnrolled : 0}</div>
                                <div class="profile-stat-label">Kursus</div>
                            </div>
                            <div class="profile-stat">
                                <div class="profile-stat-value">${totalCompleted != null ? totalCompleted : 0}</div>
                                <div class="profile-stat-label">Selesai</div>
                            </div>
                            <div class="profile-stat">
                                <div class="profile-stat-value">${totalCertificates != null ? totalCertificates : 0}</div>
                                <div class="profile-stat-label">Sertifikat</div>
                            </div>
                        </div>
                        
                        <div class="profile-info">
                            <div class="profile-info-item">
                                <div class="profile-info-icon">
                                    <i class="fas fa-phone"></i>
                                </div>
                                <div>
                                    <div class="profile-info-label">Telepon</div>
                                    <div class="profile-info-value">${not empty user.phone ? user.phone : '-'}</div>
                                </div>
                            </div>
                            <div class="profile-info-item">
                                <div class="profile-info-icon">
                                    <i class="fas fa-calendar-alt"></i>
                                </div>
                                <div>
                                    <div class="profile-info-label">Bergabung</div>
                                    <div class="profile-info-value">
                                        <fmt:formatDate value="${user.createdAt}" pattern="dd MMMM yyyy"/>
                                    </div>
                                </div>
                            </div>
                            <div class="profile-info-item">
                                <div class="profile-info-icon">
                                    <i class="fas fa-clock"></i>
                                </div>
                                <div>
                                    <div class="profile-info-label">Total Jam Belajar</div>
                                    <div class="profile-info-value">${totalLearningHours != null ? totalLearningHours : 0} jam</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Forms Column -->
                <div class="col-lg-8">
                    <!-- Edit Profile Form -->
                    <div class="form-card">
                        <h3 class="form-card-title">
                            <i class="fas fa-user-edit"></i> Edit Profil
                        </h3>
                        
                        <form action="${pageContext.request.contextPath}/student/update-profile" method="POST">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Nama Lengkap <span class="text-danger">*</span></label>
                                    <input type="text" name="name" class="form-control" value="${user.name}" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" value="${user.email}" disabled>
                                    <div class="form-hint">Email tidak dapat diubah</div>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Nomor Telepon</label>
                                    <div class="input-group">
                                        <span class="input-group-text">+62</span>
                                        <input type="tel" name="phone" class="form-control" 
                                               value="${user.phone}" placeholder="8123456789"
                                               pattern="[0-9]{9,13}">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Tanggal Lahir</label>
                                    <input type="date" name="birthDate" class="form-control" value="${user.birthDate}">
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Bio</label>
                                    <textarea name="bio" class="form-control" rows="3" 
                                              placeholder="Ceritakan sedikit tentang diri Anda...">${user.bio}</textarea>
                                    <div class="form-hint">Maksimal 500 karakter</div>
                                </div>
                                <div class="col-12">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save me-2"></i> Simpan Perubahan
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                    
                    <!-- Social Links -->
                    <div class="form-card">
                        <h3 class="form-card-title">
                            <i class="fas fa-link"></i> Link Sosial Media
                        </h3>
                        
                        <form action="${pageContext.request.contextPath}/student/update-social" method="POST">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">
                                        <i class="fab fa-linkedin text-primary me-1"></i> LinkedIn
                                    </label>
                                    <input type="url" name="linkedin" class="form-control" 
                                           value="${user.linkedin}" placeholder="https://linkedin.com/in/username">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">
                                        <i class="fab fa-github text-dark me-1"></i> GitHub
                                    </label>
                                    <input type="url" name="github" class="form-control" 
                                           value="${user.github}" placeholder="https://github.com/username">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">
                                        <i class="fab fa-twitter text-info me-1"></i> Twitter
                                    </label>
                                    <input type="url" name="twitter" class="form-control" 
                                           value="${user.twitter}" placeholder="https://twitter.com/username">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">
                                        <i class="fas fa-globe text-success me-1"></i> Website
                                    </label>
                                    <input type="url" name="website" class="form-control" 
                                           value="${user.website}" placeholder="https://yourwebsite.com">
                                </div>
                                <div class="col-12">
                                    <button type="submit" class="btn btn-outline-primary">
                                        <i class="fas fa-save me-2"></i> Simpan Link
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                    
                    <!-- Change Password Form -->
                    <div class="form-card">
                        <h3 class="form-card-title">
                            <i class="fas fa-lock"></i> Ganti Password
                        </h3>
                        
                        <form action="${pageContext.request.contextPath}/student/change-password" method="POST" id="passwordForm">
                            <div class="row g-3">
                                <div class="col-12">
                                    <label class="form-label">Password Saat Ini <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <input type="password" name="currentPassword" class="form-control" required id="currentPassword">
                                        <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('currentPassword')">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Password Baru <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <input type="password" name="newPassword" class="form-control" required 
                                               minlength="8" id="newPassword" onkeyup="checkPasswordStrength()">
                                        <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('newPassword')">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                    <div class="form-hint">Minimal 8 karakter</div>
                                    <div class="progress mt-2" style="height: 4px;">
                                        <div class="progress-bar" id="passwordStrength" style="width: 0%"></div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Konfirmasi Password Baru <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <input type="password" name="confirmPassword" class="form-control" required id="confirmPassword">
                                        <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('confirmPassword')">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                    <div class="form-hint text-danger" id="passwordMatch" style="display: none;">
                                        <i class="fas fa-times-circle"></i> Password tidak cocok
                                    </div>
                                </div>
                                <div class="col-12">
                                    <button type="submit" class="btn btn-warning">
                                        <i class="fas fa-key me-2"></i> Ganti Password
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                    
                    <!-- Danger Zone -->
                    <div class="form-card border border-danger">
                        <h3 class="form-card-title text-danger">
                            <i class="fas fa-exclamation-triangle"></i> Zona Berbahaya
                        </h3>
                        <p class="text-muted mb-3">
                            Setelah Anda menghapus akun, tidak ada jalan untuk kembali. Harap yakin sebelum melanjutkan.
                        </p>
                        <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteAccountModal">
                            <i class="fas fa-trash me-2"></i> Hapus Akun Saya
                        </button>
                    </div>
                </div>
            </div>
        </main>
    </div>
    
    <!-- Delete Account Modal -->
    <div class="modal fade" id="deleteAccountModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-0">
                    <h5 class="modal-title text-danger">
                        <i class="fas fa-exclamation-triangle me-2"></i> Hapus Akun
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Apakah Anda yakin ingin menghapus akun? Tindakan ini akan:</p>
                    <ul class="text-muted">
                        <li>Menghapus semua data profil Anda</li>
                        <li>Menghapus progress belajar Anda</li>
                        <li>Menghapus semua sertifikat yang telah diperoleh</li>
                    </ul>
                    <p class="fw-bold text-danger mb-0">Tindakan ini tidak dapat dibatalkan!</p>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <form action="${pageContext.request.contextPath}/student/delete-account" method="POST" style="display: inline;">
                        <button type="submit" class="btn btn-danger">Ya, Hapus Akun Saya</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function togglePassword(fieldId) {
            const field = document.getElementById(fieldId);
            const icon = field.nextElementSibling.querySelector('i');
            
            if (field.type === 'password') {
                field.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                field.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }
        
        function checkPasswordStrength() {
            const password = document.getElementById('newPassword').value;
            const strengthBar = document.getElementById('passwordStrength');
            let strength = 0;
            
            if (password.length >= 8) strength += 25;
            if (password.match(/[a-z]/)) strength += 25;
            if (password.match(/[A-Z]/)) strength += 25;
            if (password.match(/[0-9]/) || password.match(/[^a-zA-Z0-9]/)) strength += 25;
            
            strengthBar.style.width = strength + '%';
            strengthBar.classList.remove('bg-danger', 'bg-warning', 'bg-success');
            
            if (strength <= 25) {
                strengthBar.classList.add('bg-danger');
            } else if (strength <= 50) {
                strengthBar.classList.add('bg-warning');
            } else {
                strengthBar.classList.add('bg-success');
            }
            
            // Check password match
            const confirm = document.getElementById('confirmPassword').value;
            const matchDiv = document.getElementById('passwordMatch');
            if (confirm && confirm !== password) {
                matchDiv.style.display = 'block';
            } else {
                matchDiv.style.display = 'none';
            }
        }
        
        document.getElementById('confirmPassword').addEventListener('keyup', function() {
            const password = document.getElementById('newPassword').value;
            const confirm = this.value;
            const matchDiv = document.getElementById('passwordMatch');
            
            if (confirm && confirm !== password) {
                matchDiv.style.display = 'block';
            } else {
                matchDiv.style.display = 'none';
            }
        });
        
        function uploadAvatar(input) {
            if (input.files && input.files[0]) {
                const formData = new FormData();
                formData.append('avatar', input.files[0]);
                
                fetch('${pageContext.request.contextPath}/student/upload-avatar', {
                    method: 'POST',
                    body: formData
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        document.getElementById('avatarPreview').src = data.imageUrl;
                        alert('Foto profil berhasil diperbarui!');
                    } else {
                        alert(data.message || 'Gagal mengupload foto');
                    }
                })
                .catch(error => {
                    // Preview locally if upload fails
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        document.getElementById('avatarPreview').src = e.target.result;
                    };
                    reader.readAsDataURL(input.files[0]);
                });
            }
        }
        
        // Form validation
        document.getElementById('passwordForm').addEventListener('submit', function(e) {
            const password = document.getElementById('newPassword').value;
            const confirm = document.getElementById('confirmPassword').value;
            
            if (password !== confirm) {
                e.preventDefault();
                alert('Password baru dan konfirmasi password tidak cocok!');
            }
        });
    </script>
</body>
</html>
