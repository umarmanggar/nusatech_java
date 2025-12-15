<%-- 
    Document   : certificates
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Student Certificates Page
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
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <jsp:include page="/pages/common/navbar-dashboard.jsp"/>
    
    <div class="dashboard-layout">
        <jsp:include page="/pages/common/sidebar-student.jsp"/>
        
        <main class="main-content">
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fas fa-certificate" style="color: var(--secondary);"></i> Sertifikat Saya
                </h1>
                <p class="page-subtitle">Bukti pencapaian belajar Anda</p>
            </div>
            
            <c:choose>
                <c:when test="${not empty completedEnrollments}">
                    <div class="grid grid-2">
                        <c:forEach var="enrollment" items="${completedEnrollments}">
                            <div class="card" style="overflow: hidden;">
                                <!-- Certificate Preview -->
                                <div style="position: relative; padding: 2rem; background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%); color: white; text-align: center;">
                                    <div style="position: absolute; top: 0; right: 0; opacity: 0.1;">
                                        <i class="fas fa-award" style="font-size: 8rem;"></i>
                                    </div>
                                    <i class="fas fa-certificate" style="font-size: 3rem; margin-bottom: 1rem; color: var(--secondary);"></i>
                                    <h3 style="font-size: 1rem; opacity: 0.9; margin-bottom: 0.5rem;">SERTIFIKAT PENYELESAIAN</h3>
                                    <h2 style="font-size: 1.25rem; margin-bottom: 1rem; color: white;">${enrollment.course.title}</h2>
                                    <p style="font-size: 0.875rem; opacity: 0.8;">
                                        Diberikan kepada <strong>${user.name}</strong>
                                    </p>
                                </div>
                                
                                <!-- Certificate Details -->
                                <div style="padding: 1.5rem;">
                                    <div style="display: flex; justify-content: space-between; margin-bottom: 1rem; font-size: 0.875rem; color: var(--gray-600);">
                                        <span>
                                            <i class="fas fa-calendar"></i> 
                                            Selesai: <fmt:formatDate value="${enrollment.completedAt}" pattern="dd MMMM yyyy"/>
                                        </span>
                                        <span>
                                            <i class="fas fa-hashtag"></i> 
                                            ${enrollment.certificateUrl != null ? 'CERT-'.concat(enrollment.enrollmentId) : 'Belum Terbit'}
                                        </span>
                                    </div>
                                    
                                    <div style="display: flex; gap: 0.5rem;">
                                        <c:choose>
                                            <c:when test="${enrollment.certificateIssued}">
                                                <a href="${enrollment.certificateUrl}" class="btn btn-primary w-100" target="_blank">
                                                    <i class="fas fa-download"></i> Unduh PDF
                                                </a>
                                                <button onclick="shareCertificate('${enrollment.certificateUrl}')" class="btn btn-outline">
                                                    <i class="fas fa-share-alt"></i>
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn btn-secondary w-100" disabled>
                                                    <i class="fas fa-clock"></i> Sedang Diproses
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Empty State -->
                    <div class="empty-state">
                        <div class="empty-state-icon">
                            <i class="fas fa-award"></i>
                        </div>
                        <h3 class="empty-state-title">Belum Ada Sertifikat</h3>
                        <p class="empty-state-description">
                            Selesaikan kursus untuk mendapatkan sertifikat penyelesaian. 
                            Sertifikat dapat digunakan untuk menunjukkan pencapaian Anda.
                        </p>
                        <a href="${pageContext.request.contextPath}/my-learning" class="btn btn-primary btn-lg">
                            <i class="fas fa-book-open"></i> Lanjutkan Belajar
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
    
    <script>
        function shareCertificate(url) {
            if (navigator.share) {
                navigator.share({
                    title: 'Sertifikat NusaTech',
                    text: 'Lihat sertifikat pencapaian saya di NusaTech!',
                    url: url
                });
            } else {
                // Fallback: copy to clipboard
                navigator.clipboard.writeText(url).then(function() {
                    alert('Link sertifikat telah disalin!');
                });
            }
        }
    </script>
</body>
</html>
