<%-- 
    Document   : certificates
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Student Certificates Page with Bootstrap 5
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sertifikat Saya - NusaTech</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
    
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
        
        /* Certificate Card */
        .certificate-card {
            background: white;
            border-radius: 1rem;
            overflow: hidden;
            box-shadow: 0 4px 16px rgba(0,0,0,0.08);
            transition: all 0.3s;
        }
        
        .certificate-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 24px rgba(0,0,0,0.12);
        }
        
        .certificate-preview {
            position: relative;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            padding: 2rem;
            text-align: center;
            color: white;
            min-height: 200px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .certificate-preview::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 150px;
            height: 150px;
            background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%23ffffff' opacity='0.1'%3E%3Cpath d='M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z'/%3E%3C/svg%3E") no-repeat;
            background-size: contain;
            opacity: 0.1;
        }
        
        .certificate-icon {
            font-size: 3rem;
            color: var(--secondary);
            margin-bottom: 1rem;
        }
        
        .certificate-label {
            font-size: 0.7rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            opacity: 0.9;
            margin-bottom: 0.5rem;
        }
        
        .certificate-course {
            font-family: 'Playfair Display', serif;
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 0.75rem;
            line-height: 1.3;
        }
        
        .certificate-recipient {
            font-size: 0.875rem;
            opacity: 0.9;
        }
        
        .certificate-details {
            padding: 1.5rem;
        }
        
        .certificate-meta {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
            font-size: 0.8rem;
            color: #6b7280;
        }
        
        .certificate-code {
            font-family: monospace;
            background: #f3f4f6;
            padding: 0.25rem 0.5rem;
            border-radius: 0.25rem;
            font-size: 0.75rem;
        }
        
        .certificate-actions {
            display: flex;
            gap: 0.5rem;
        }
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 1rem;
        }
        
        .empty-state-icon {
            width: 100px;
            height: 100px;
            background: rgba(212, 168, 75, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 2.5rem;
            color: var(--secondary);
        }
        
        /* Modal Certificate Preview */
        .modal-certificate {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            padding: 3rem;
            text-align: center;
            color: white;
            border: 8px double rgba(255,255,255,0.3);
        }
        
        .modal-certificate-title {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        
        /* Stats */
        .stats-banner {
            background: linear-gradient(135deg, var(--secondary) 0%, #c69a3e 100%);
            border-radius: 1rem;
            padding: 1.5rem 2rem;
            display: flex;
            align-items: center;
            justify-content: space-around;
            gap: 2rem;
            color: #1f2937;
            margin-bottom: 2rem;
        }
        
        .stat-item {
            text-align: center;
        }
        
        .stat-value {
            font-size: 2rem;
            font-weight: 800;
        }
        
        .stat-label {
            font-size: 0.875rem;
            opacity: 0.8;
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
                <h1 class="page-title">
                    <i class="fas fa-certificate" style="color: var(--secondary);"></i> Sertifikat Saya
                </h1>
                <p class="page-subtitle mb-0">Bukti pencapaian belajar Anda</p>
            </div>
            
            <c:choose>
                <c:when test="${not empty certificates}">
                    <!-- Stats Banner -->
                    <div class="stats-banner">
                        <div class="stat-item">
                            <div class="stat-value">${certificates.size()}</div>
                            <div class="stat-label">Total Sertifikat</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-value">${totalHours != null ? totalHours : 0}</div>
                            <div class="stat-label">Jam Belajar</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-value">${currentYear != null ? currentYear : '2025'}</div>
                            <div class="stat-label">Tahun Aktif</div>
                        </div>
                    </div>
                    
                    <!-- Certificates Grid -->
                    <div class="row row-cols-1 row-cols-lg-2 g-4">
                        <c:forEach var="cert" items="${certificates}">
                            <div class="col">
                                <div class="certificate-card">
                                    <!-- Certificate Preview -->
                                    <div class="certificate-preview">
                                        <i class="fas fa-award certificate-icon"></i>
                                        <div class="certificate-label">Sertifikat Penyelesaian</div>
                                        <div class="certificate-course">${cert.courseName}</div>
                                        <div class="certificate-recipient">
                                            Diberikan kepada <strong>${cert.studentName}</strong>
                                        </div>
                                    </div>
                                    
                                    <!-- Certificate Details -->
                                    <div class="certificate-details">
                                        <div class="certificate-meta">
                                            <span>
                                                <i class="fas fa-calendar me-1"></i> 
                                                Selesai: <fmt:formatDate value="${cert.issuedAt}" pattern="dd MMMM yyyy"/>
                                            </span>
                                            <span class="certificate-code">
                                                <i class="fas fa-hashtag me-1"></i> ${cert.certificateCode}
                                            </span>
                                        </div>
                                        
                                        <div class="certificate-actions">
                                            <button class="btn btn-primary flex-fill" onclick="downloadCertificate('${cert.certificateCode}')">
                                                <i class="fas fa-download me-2"></i> Unduh PDF
                                            </button>
                                            <button class="btn btn-outline-primary" onclick="previewCertificate('${cert.certificateId}')" title="Preview">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <div class="dropdown">
                                                <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                                    <i class="fas fa-share-alt"></i>
                                                </button>
                                                <ul class="dropdown-menu dropdown-menu-end">
                                                    <li>
                                                        <a class="dropdown-item" href="https://www.linkedin.com/profile/add?startTask=CERTIFICATION_NAME&name=${cert.courseName}&organizationName=NusaTech&issueYear=${cert.issuedYear}&issueMonth=${cert.issuedMonth}&certUrl=${cert.verificationUrl}" target="_blank">
                                                            <i class="fab fa-linkedin text-primary me-2"></i> LinkedIn
                                                        </a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="https://twitter.com/intent/tweet?text=Saya%20telah%20menyelesaikan%20kursus%20${cert.courseName}%20di%20NusaTech!&url=${cert.verificationUrl}" target="_blank">
                                                            <i class="fab fa-twitter text-info me-2"></i> Twitter
                                                        </a>
                                                    </li>
                                                    <li>
                                                        <a class="dropdown-item" href="https://www.facebook.com/sharer/sharer.php?u=${cert.verificationUrl}" target="_blank">
                                                            <i class="fab fa-facebook text-primary me-2"></i> Facebook
                                                        </a>
                                                    </li>
                                                    <li><hr class="dropdown-divider"></li>
                                                    <li>
                                                        <a class="dropdown-item" href="#" onclick="copyVerificationLink('${cert.verificationUrl}'); return false;">
                                                            <i class="fas fa-link text-secondary me-2"></i> Salin Link
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        
                                        <div class="mt-3 text-center">
                                            <small class="text-muted">
                                                <i class="fas fa-shield-alt text-success me-1"></i>
                                                Verifikasi: <a href="${cert.verificationUrl}" target="_blank" class="text-decoration-none">${cert.certificateCode}</a>
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Check if there are completed courses without certificates -->
                    <c:if test="${not empty completedEnrollments}">
                        <div class="alert alert-warning mb-4">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            Anda memiliki ${completedEnrollments.size()} kursus yang telah selesai. Sertifikat sedang diproses.
                        </div>
                        
                        <!-- Processing Certificates -->
                        <div class="row row-cols-1 row-cols-lg-2 g-4 mb-4">
                            <c:forEach var="enrollment" items="${completedEnrollments}">
                                <div class="col">
                                    <div class="certificate-card">
                                        <div class="certificate-preview" style="background: linear-gradient(135deg, #6b7280 0%, #4b5563 100%);">
                                            <i class="fas fa-hourglass-half certificate-icon" style="color: #d1d5db;"></i>
                                            <div class="certificate-label">Sertifikat Penyelesaian</div>
                                            <div class="certificate-course">${enrollment.course.title}</div>
                                            <div class="certificate-recipient">
                                                Diberikan kepada <strong>${sessionScope.user.name}</strong>
                                            </div>
                                        </div>
                                        <div class="certificate-details">
                                            <div class="certificate-meta">
                                                <span>
                                                    <i class="fas fa-calendar me-1"></i> 
                                                    Selesai: <fmt:formatDate value="${enrollment.completedAt}" pattern="dd MMMM yyyy"/>
                                                </span>
                                                <span class="badge bg-warning text-dark">
                                                    <i class="fas fa-clock me-1"></i> Sedang Diproses
                                                </span>
                                            </div>
                                            <button class="btn btn-secondary w-100" disabled>
                                                <i class="fas fa-spinner fa-spin me-2"></i> Sertifikat Sedang Dibuat...
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                    
                    <!-- Empty State -->
                    <div class="empty-state">
                        <div class="empty-state-icon">
                            <i class="fas fa-award"></i>
                        </div>
                        <h4 class="fw-bold mb-2">Belum Ada Sertifikat</h4>
                        <p class="text-muted mb-4 mx-auto" style="max-width: 400px;">
                            Selesaikan kursus untuk mendapatkan sertifikat penyelesaian. 
                            Sertifikat dapat digunakan untuk menunjukkan pencapaian Anda kepada perusahaan atau di LinkedIn.
                        </p>
                        <a href="${pageContext.request.contextPath}/student/my-learning" class="btn btn-primary btn-lg">
                            <i class="fas fa-book-open me-2"></i> Lanjutkan Belajar
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
    
    <!-- Certificate Preview Modal -->
    <div class="modal fade" id="previewModal" tabindex="-1">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-0">
                    <h5 class="modal-title">Preview Sertifikat</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-0">
                    <div class="modal-certificate" id="certificateContent">
                        <!-- Certificate content will be loaded here -->
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Tutup</button>
                    <button type="button" class="btn btn-primary" onclick="printCertificate()">
                        <i class="fas fa-print me-2"></i> Cetak
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function downloadCertificate(code) {
            window.open('${pageContext.request.contextPath}/certificate/download/' + code, '_blank');
        }
        
        function previewCertificate(certId) {
            // Load certificate preview via AJAX
            fetch('${pageContext.request.contextPath}/certificate/preview/' + certId)
                .then(response => response.text())
                .then(html => {
                    document.getElementById('certificateContent').innerHTML = html;
                    new bootstrap.Modal(document.getElementById('previewModal')).show();
                })
                .catch(error => {
                    // Show a sample preview if fetch fails
                    document.getElementById('certificateContent').innerHTML = `
                        <i class="fas fa-award" style="font-size: 4rem; color: var(--secondary); margin-bottom: 1rem;"></i>
                        <div style="font-size: 0.8rem; text-transform: uppercase; letter-spacing: 3px; margin-bottom: 1rem;">Sertifikat Penyelesaian</div>
                        <div class="modal-certificate-title">Certificate Preview</div>
                        <p style="opacity: 0.9;">Diberikan kepada</p>
                        <h3 style="margin-bottom: 1rem;">${sessionScope.user.name}</h3>
                        <p style="opacity: 0.8;">Atas keberhasilannya menyelesaikan kursus dengan baik</p>
                    `;
                    new bootstrap.Modal(document.getElementById('previewModal')).show();
                });
        }
        
        function copyVerificationLink(url) {
            navigator.clipboard.writeText(url).then(function() {
                alert('Link verifikasi telah disalin!');
            }).catch(function() {
                prompt('Salin link berikut:', url);
            });
        }
        
        function printCertificate() {
            window.print();
        }
    </script>
</body>
</html>
