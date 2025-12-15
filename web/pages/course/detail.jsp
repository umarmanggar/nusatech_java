<%-- 
    Document   : detail
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Course Detail Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${course.title} - NusaTech</title>
    <meta name="description" content="${course.shortDescription}">
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <!-- Navbar -->
    <jsp:include page="/pages/common/navbar.jsp"/>
    
    <!-- Course Hero -->
    <section class="course-hero">
        <div class="container">
            <div class="course-hero-content">
                <div>
                    <!-- Breadcrumb -->
                    <nav class="course-breadcrumb">
                        <a href="${pageContext.request.contextPath}/">Beranda</a>
                        <i class="fas fa-chevron-right" style="font-size: 0.625rem;"></i>
                        <a href="${pageContext.request.contextPath}/courses">Kursus</a>
                        <i class="fas fa-chevron-right" style="font-size: 0.625rem;"></i>
                        <a href="${pageContext.request.contextPath}/courses?category=${course.category.slug}">${course.category.name}</a>
                        <i class="fas fa-chevron-right" style="font-size: 0.625rem;"></i>
                        <span>${course.title}</span>
                    </nav>
                    
                    <!-- Category Badge -->
                    <span class="badge badge-secondary" style="margin-bottom: 1rem;">${course.category.name}</span>
                    
                    <!-- Title -->
                    <h1 class="course-hero-title">${course.title}</h1>
                    
                    <!-- Description -->
                    <p class="course-hero-description">${course.shortDescription}</p>
                    
                    <!-- Meta Info -->
                    <div class="course-meta-list">
                        <div class="course-meta-item">
                            <i class="fas fa-star"></i>
                            <strong><fmt:formatNumber value="${course.avgRating}" maxFractionDigits="1"/></strong>
                            <span>(${course.totalReviews} ulasan)</span>
                        </div>
                        <div class="course-meta-item">
                            <i class="fas fa-users"></i>
                            <span>${course.totalStudents} pelajar</span>
                        </div>
                        <div class="course-meta-item">
                            <i class="fas fa-signal"></i>
                            <span>${course.levelDisplayName}</span>
                        </div>
                        <div class="course-meta-item">
                            <i class="fas fa-language"></i>
                            <span>${course.language}</span>
                        </div>
                        <div class="course-meta-item">
                            <i class="fas fa-calendar"></i>
                            <span>Update terakhir <fmt:formatDate value="${course.updatedAt}" pattern="MMM yyyy"/></span>
                        </div>
                    </div>
                    
                    <!-- Instructor -->
                    <div style="display: flex; align-items: center; gap: 1rem; margin-top: 1.5rem;">
                        <img src="https://ui-avatars.com/api/?name=${course.lecturer.name}&background=ffffff&color=8B1538&size=56" 
                             alt="${course.lecturer.name}" 
                             style="width: 56px; height: 56px; border-radius: 50%; border: 3px solid rgba(255,255,255,0.3);">
                        <div>
                            <p style="font-size: 0.875rem; opacity: 0.8;">Dibuat oleh</p>
                            <p style="font-weight: 700; font-size: 1.125rem;">${course.lecturer.name}</p>
                        </div>
                    </div>
                </div>
                
                <!-- Sidebar Card -->
                <div class="course-sidebar-card">
                    <div class="course-sidebar-video">
                        <c:choose>
                            <c:when test="${not empty course.previewVideo}">
                                <video width="100%" height="100%" controls poster="${course.thumbnail}">
                                    <source src="${course.previewVideo}" type="video/mp4">
                                </video>
                            </c:when>
                            <c:otherwise>
                                <img src="${not empty course.thumbnail && !course.thumbnail.equals('default-course.png') ? course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400&h=225&fit=crop'}" 
                                     alt="${course.title}" style="width: 100%; height: 100%; object-fit: cover;">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="course-sidebar-body">
                        <!-- Price -->
                        <div class="course-price-display">
                            <c:choose>
                                <c:when test="${course.free}">
                                    <span class="course-price-current" style="color: var(--success);">Gratis</span>
                                </c:when>
                                <c:when test="${course.hasDiscount()}">
                                    <span class="course-price-current">Rp <fmt:formatNumber value="${course.discountPrice}" pattern="#,###"/></span>
                                    <span class="course-price-original">Rp <fmt:formatNumber value="${course.price}" pattern="#,###"/></span>
                                    <span class="course-discount-badge">-${course.discountPercentage}%</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="course-price-current">Rp <fmt:formatNumber value="${course.price}" pattern="#,###"/></span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <!-- Action Buttons -->
                        <c:choose>
                            <c:when test="${isEnrolled}">
                                <a href="${pageContext.request.contextPath}/learn/${course.slug}" class="btn btn-primary btn-lg w-100 mb-3">
                                    <i class="fas fa-play"></i> Lanjutkan Belajar
                                </a>
                                <div class="progress mb-2">
                                    <div class="progress-bar" style="width: ${enrollment.progressInt}%"></div>
                                </div>
                                <p style="text-align: center; font-size: 0.875rem; color: var(--gray-500);">
                                    Progress: ${enrollment.progressInt}%
                                </p>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${course.free}">
                                        <form action="${pageContext.request.contextPath}/student/enroll" method="POST">
                                            <input type="hidden" name="courseId" value="${course.courseId}">
                                            <button type="submit" class="btn btn-primary btn-lg w-100 mb-3">
                                                <i class="fas fa-play"></i> Mulai Belajar Gratis
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/checkout?courseId=${course.courseId}" class="btn btn-primary btn-lg w-100 mb-3">
                                            <i class="fas fa-shopping-cart"></i> Beli Sekarang
                                        </a>
                                        <a href="${pageContext.request.contextPath}/cart/add?courseId=${course.courseId}" class="btn btn-outline btn-lg w-100 mb-3">
                                            <i class="fas fa-cart-plus"></i> Tambah ke Keranjang
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                        
                        <!-- Wishlist -->
                        <c:if test="${!isEnrolled}">
                            <button onclick="addToWishlist(${course.courseId})" class="btn btn-ghost w-100" style="color: var(--gray-600);">
                                <i class="far fa-heart"></i> Tambahkan ke Wishlist
                            </button>
                        </c:if>
                        
                        <!-- Features -->
                        <div class="course-features-list">
                            <div class="course-feature-item">
                                <i class="fas fa-clock"></i>
                                <span>${course.durationHours > 0 ? course.durationHours : '10'}+ jam konten video</span>
                            </div>
                            <div class="course-feature-item">
                                <i class="fas fa-book"></i>
                                <span>${course.totalMaterials > 0 ? course.totalMaterials : '20'}+ materi pembelajaran</span>
                            </div>
                            <div class="course-feature-item">
                                <i class="fas fa-layer-group"></i>
                                <span>${course.totalSections > 0 ? course.totalSections : '5'}+ bab/section</span>
                            </div>
                            <div class="course-feature-item">
                                <i class="fas fa-tasks"></i>
                                <span>Quiz & latihan praktis</span>
                            </div>
                            <div class="course-feature-item">
                                <i class="fas fa-certificate"></i>
                                <span>Sertifikat penyelesaian</span>
                            </div>
                            <div class="course-feature-item">
                                <i class="fas fa-infinity"></i>
                                <span>Akses selamanya</span>
                            </div>
                            <div class="course-feature-item">
                                <i class="fas fa-mobile-alt"></i>
                                <span>Akses di semua perangkat</span>
                            </div>
                            <div class="course-feature-item">
                                <i class="fas fa-comments"></i>
                                <span>Forum diskusi</span>
                            </div>
                        </div>
                        
                        <!-- Guarantee -->
                        <p style="text-align: center; font-size: 0.875rem; color: var(--gray-500); margin-top: 1rem;">
                            <i class="fas fa-shield-alt" style="color: var(--success);"></i>
                            Garansi uang kembali 30 hari
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Course Content -->
    <section class="section" style="background: var(--gray-50);">
        <div class="container">
            <div style="display: grid; grid-template-columns: 1fr 400px; gap: 2rem;">
                <div>
                    <!-- What You'll Learn -->
                    <div style="background: white; border-radius: var(--radius-2xl); padding: 2rem; margin-bottom: 2rem;">
                        <h2 style="font-size: 1.5rem; margin-bottom: 1.5rem;">
                            <i class="fas fa-lightbulb" style="color: var(--secondary);"></i> Yang Akan Anda Pelajari
                        </h2>
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                            <c:choose>
                                <c:when test="${not empty course.objectives}">
                                    <c:forTokens items="${course.objectives}" delims="|" var="objective">
                                        <div style="display: flex; gap: 0.75rem;">
                                            <i class="fas fa-check" style="color: var(--success); margin-top: 4px;"></i>
                                            <span>${objective}</span>
                                        </div>
                                    </c:forTokens>
                                </c:when>
                                <c:otherwise>
                                    <div style="display: flex; gap: 0.75rem;">
                                        <i class="fas fa-check" style="color: var(--success); margin-top: 4px;"></i>
                                        <span>Memahami konsep dasar dan fundamental</span>
                                    </div>
                                    <div style="display: flex; gap: 0.75rem;">
                                        <i class="fas fa-check" style="color: var(--success); margin-top: 4px;"></i>
                                        <span>Praktik langsung dengan studi kasus</span>
                                    </div>
                                    <div style="display: flex; gap: 0.75rem;">
                                        <i class="fas fa-check" style="color: var(--success); margin-top: 4px;"></i>
                                        <span>Membangun proyek nyata</span>
                                    </div>
                                    <div style="display: flex; gap: 0.75rem;">
                                        <i class="fas fa-check" style="color: var(--success); margin-top: 4px;"></i>
                                        <span>Best practices dan tips profesional</span>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    <!-- Requirements -->
                    <div style="background: white; border-radius: var(--radius-2xl); padding: 2rem; margin-bottom: 2rem;">
                        <h2 style="font-size: 1.5rem; margin-bottom: 1.5rem;">
                            <i class="fas fa-clipboard-list" style="color: var(--primary);"></i> Persyaratan
                        </h2>
                        <ul style="padding-left: 1.5rem; display: flex; flex-direction: column; gap: 0.75rem;">
                            <c:choose>
                                <c:when test="${not empty course.requirements}">
                                    <c:forTokens items="${course.requirements}" delims="|" var="req">
                                        <li>${req}</li>
                                    </c:forTokens>
                                </c:when>
                                <c:otherwise>
                                    <li>Laptop/komputer dengan koneksi internet</li>
                                    <li>Semangat belajar dan berlatih</li>
                                    <li>Tidak diperlukan pengalaman sebelumnya</li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                    
                    <!-- Description -->
                    <div style="background: white; border-radius: var(--radius-2xl); padding: 2rem; margin-bottom: 2rem;">
                        <h2 style="font-size: 1.5rem; margin-bottom: 1.5rem;">
                            <i class="fas fa-file-alt" style="color: var(--info);"></i> Deskripsi
                        </h2>
                        <div style="line-height: 1.8; color: var(--gray-700);">
                            ${not empty course.description ? course.description : '<p>Kursus ini akan membantu Anda mempelajari materi secara komprehensif dengan berbagai studi kasus praktis. Anda akan dipandu langkah demi langkah dari konsep dasar hingga implementasi lanjutan.</p><p>Setelah menyelesaikan kursus ini, Anda akan memiliki pemahaman yang mendalam dan siap untuk mengaplikasikan pengetahuan dalam proyek nyata.</p>'}
                        </div>
                    </div>
                    
                    <!-- Course Curriculum -->
                    <div style="background: white; border-radius: var(--radius-2xl); padding: 2rem; margin-bottom: 2rem;">
                        <h2 style="font-size: 1.5rem; margin-bottom: 1.5rem;">
                            <i class="fas fa-list-ol" style="color: var(--warning);"></i> Kurikulum Kursus
                        </h2>
                        <p style="color: var(--gray-500); margin-bottom: 1.5rem;">
                            ${course.totalSections > 0 ? course.totalSections : '5'} Bab • ${course.totalMaterials > 0 ? course.totalMaterials : '20'} Materi • ${course.durationHours > 0 ? course.durationHours : '10'}+ jam total durasi
                        </p>
                        
                        <!-- Sample Curriculum -->
                        <div style="border: 1px solid var(--gray-200); border-radius: var(--radius-xl); overflow: hidden;">
                            <div style="border-bottom: 1px solid var(--gray-200);">
                                <button onclick="this.parentElement.classList.toggle('open')" style="width: 100%; display: flex; align-items: center; justify-content: space-between; padding: 1rem 1.5rem; background: var(--gray-50);">
                                    <div style="display: flex; align-items: center; gap: 0.75rem;">
                                        <i class="fas fa-chevron-down"></i>
                                        <strong>Bab 1: Pengenalan</strong>
                                    </div>
                                    <span style="font-size: 0.875rem; color: var(--gray-500);">4 materi • 45 menit</span>
                                </button>
                                <div style="padding: 0 1.5rem 1rem;">
                                    <div style="display: flex; align-items: center; gap: 1rem; padding: 0.75rem 0; border-bottom: 1px solid var(--gray-100);">
                                        <i class="fas fa-play-circle" style="color: var(--primary);"></i>
                                        <span>1.1 Pendahuluan</span>
                                        <span style="margin-left: auto; font-size: 0.875rem; color: var(--gray-500);">10:00</span>
                                    </div>
                                    <div style="display: flex; align-items: center; gap: 1rem; padding: 0.75rem 0; border-bottom: 1px solid var(--gray-100);">
                                        <i class="fas fa-play-circle" style="color: var(--primary);"></i>
                                        <span>1.2 Instalasi & Setup</span>
                                        <span style="margin-left: auto; font-size: 0.875rem; color: var(--gray-500);">15:00</span>
                                    </div>
                                    <div style="display: flex; align-items: center; gap: 1rem; padding: 0.75rem 0; border-bottom: 1px solid var(--gray-100);">
                                        <i class="fas fa-file-alt" style="color: var(--info);"></i>
                                        <span>1.3 Konsep Dasar</span>
                                        <span style="margin-left: auto; font-size: 0.875rem; color: var(--gray-500);">10:00</span>
                                    </div>
                                    <div style="display: flex; align-items: center; gap: 1rem; padding: 0.75rem 0;">
                                        <i class="fas fa-question-circle" style="color: var(--warning);"></i>
                                        <span>1.4 Quiz Bab 1</span>
                                        <span style="margin-left: auto; font-size: 0.875rem; color: var(--gray-500);">10 soal</span>
                                    </div>
                                </div>
                            </div>
                            <div>
                                <button onclick="this.parentElement.classList.toggle('open')" style="width: 100%; display: flex; align-items: center; justify-content: space-between; padding: 1rem 1.5rem; background: var(--gray-50);">
                                    <div style="display: flex; align-items: center; gap: 0.75rem;">
                                        <i class="fas fa-chevron-right"></i>
                                        <strong>Bab 2: Materi Lanjutan</strong>
                                    </div>
                                    <span style="font-size: 0.875rem; color: var(--gray-500);">6 materi • 1.5 jam</span>
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Instructor -->
                    <div style="background: white; border-radius: var(--radius-2xl); padding: 2rem; margin-bottom: 2rem;">
                        <h2 style="font-size: 1.5rem; margin-bottom: 1.5rem;">
                            <i class="fas fa-chalkboard-teacher" style="color: var(--success);"></i> Pengajar
                        </h2>
                        <div style="display: flex; gap: 1.5rem; align-items: flex-start;">
                            <img src="https://ui-avatars.com/api/?name=${course.lecturer.name}&background=8B1538&color=fff&size=100" 
                                 alt="${course.lecturer.name}" 
                                 style="width: 100px; height: 100px; border-radius: var(--radius-xl);">
                            <div>
                                <h3 style="font-size: 1.25rem; margin-bottom: 0.5rem;">${course.lecturer.name}</h3>
                                <p style="color: var(--primary); font-weight: 500; margin-bottom: 1rem;">${course.category.name} Expert</p>
                                <div style="display: flex; gap: 1.5rem; margin-bottom: 1rem; color: var(--gray-600); font-size: 0.875rem;">
                                    <span><i class="fas fa-star" style="color: var(--warning);"></i> 4.8 Rating</span>
                                    <span><i class="fas fa-users"></i> 1,000+ Pelajar</span>
                                    <span><i class="fas fa-play-circle"></i> 5 Kursus</span>
                                </div>
                                <p style="color: var(--gray-600); line-height: 1.7;">
                                    Pengajar profesional dengan pengalaman lebih dari 5 tahun di industri teknologi. 
                                    Berdedikasi untuk berbagi pengetahuan dan membantu generasi muda Indonesia berkembang di bidang teknologi.
                                </p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Reviews -->
                    <div style="background: white; border-radius: var(--radius-2xl); padding: 2rem;">
                        <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 1.5rem;">
                            <h2 style="font-size: 1.5rem;">
                                <i class="fas fa-star" style="color: var(--warning);"></i> Ulasan Pelajar
                            </h2>
                            <span style="font-size: 0.875rem; color: var(--gray-500);">${course.totalReviews} ulasan</span>
                        </div>
                        
                        <!-- Rating Summary -->
                        <div style="display: flex; gap: 2rem; padding: 1.5rem; background: var(--gray-50); border-radius: var(--radius-xl); margin-bottom: 1.5rem;">
                            <div style="text-align: center;">
                                <div style="font-size: 3rem; font-weight: 800; color: var(--gray-900);">
                                    <fmt:formatNumber value="${course.avgRating}" maxFractionDigits="1"/>
                                </div>
                                <div style="color: var(--warning); margin-bottom: 0.25rem;">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star-half-alt"></i>
                                </div>
                                <div style="font-size: 0.875rem; color: var(--gray-500);">Rating Kursus</div>
                            </div>
                            <div style="flex: 1;">
                                <c:forEach begin="5" end="1" step="-1" var="star">
                                    <div style="display: flex; align-items: center; gap: 0.5rem; margin-bottom: 0.25rem;">
                                        <div class="progress" style="flex: 1; height: 6px;">
                                            <div class="progress-bar" style="width: ${star == 5 ? '70' : star == 4 ? '20' : star == 3 ? '7' : star == 2 ? '2' : '1'}%;"></div>
                                        </div>
                                        <span style="font-size: 0.75rem; color: var(--gray-500); width: 60px;">
                                            <i class="fas fa-star" style="color: var(--warning);"></i> ${star}
                                        </span>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        
                        <!-- Sample Reviews -->
                        <div style="border-top: 1px solid var(--gray-200); padding-top: 1.5rem;">
                            <div style="margin-bottom: 1.5rem; padding-bottom: 1.5rem; border-bottom: 1px solid var(--gray-100);">
                                <div style="display: flex; align-items: flex-start; gap: 1rem; margin-bottom: 0.75rem;">
                                    <img src="https://ui-avatars.com/api/?name=Ahmad+Rizki&background=3B82F6&color=fff" 
                                         style="width: 44px; height: 44px; border-radius: 50%;">
                                    <div style="flex: 1;">
                                        <div style="display: flex; align-items: center; justify-content: space-between;">
                                            <strong>Ahmad Rizki</strong>
                                            <span style="font-size: 0.75rem; color: var(--gray-500);">2 minggu lalu</span>
                                        </div>
                                        <div style="color: var(--warning); font-size: 0.875rem;">
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                        </div>
                                    </div>
                                </div>
                                <p style="color: var(--gray-700); line-height: 1.7;">
                                    Kursus yang sangat bagus! Materi disampaikan dengan jelas dan mudah dipahami. 
                                    Pengajar sangat responsif dalam menjawab pertanyaan di forum. Sangat recommended!
                                </p>
                            </div>
                            
                            <div>
                                <div style="display: flex; align-items: flex-start; gap: 1rem; margin-bottom: 0.75rem;">
                                    <img src="https://ui-avatars.com/api/?name=Siti+Nurhaliza&background=10B981&color=fff" 
                                         style="width: 44px; height: 44px; border-radius: 50%;">
                                    <div style="flex: 1;">
                                        <div style="display: flex; align-items: center; justify-content: space-between;">
                                            <strong>Siti Nurhaliza</strong>
                                            <span style="font-size: 0.75rem; color: var(--gray-500);">1 bulan lalu</span>
                                        </div>
                                        <div style="color: var(--warning); font-size: 0.875rem;">
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="far fa-star"></i>
                                        </div>
                                    </div>
                                </div>
                                <p style="color: var(--gray-700); line-height: 1.7;">
                                    Materi lengkap dan terstruktur dengan baik. Cocok untuk pemula yang ingin belajar dari nol. 
                                    Beberapa bagian mungkin bisa diperlambat temponya, tapi overall sangat membantu!
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Sticky Placeholder for Desktop -->
                <div style="width: 400px;"></div>
            </div>
        </div>
    </section>
    
    <!-- Related Courses -->
    <c:if test="${not empty relatedCourses}">
        <section class="section" style="background: white;">
            <div class="container">
                <div class="section-header">
                    <div>
                        <h2 class="section-title">Kursus Terkait</h2>
                        <p class="section-subtitle">Kursus lain yang mungkin Anda minati</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/courses?category=${course.category.slug}" class="section-link">
                        Lihat Semua <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
                
                <div class="grid grid-4">
                    <c:forEach var="relCourse" items="${relatedCourses}" end="3">
                        <div class="card course-card">
                            <div class="course-card-image">
                                <img src="${not empty relCourse.thumbnail && !relCourse.thumbnail.equals('default-course.png') ? relCourse.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400&h=225&fit=crop'}" 
                                     alt="${relCourse.title}">
                                <c:if test="${relCourse.free}">
                                    <span class="course-card-badge free">GRATIS</span>
                                </c:if>
                            </div>
                            <div class="course-card-body">
                                <span class="course-card-category">${relCourse.category.name}</span>
                                <h3 class="course-card-title">
                                    <a href="${pageContext.request.contextPath}/course/${relCourse.slug}">${relCourse.title}</a>
                                </h3>
                                <div class="course-card-instructor">
                                    <img src="https://ui-avatars.com/api/?name=${relCourse.lecturer.name}&background=8B1538&color=fff" 
                                         alt="${relCourse.lecturer.name}">
                                    <span>${relCourse.lecturer.name}</span>
                                </div>
                                <div class="course-card-meta">
                                    <span><i class="fas fa-users"></i> ${relCourse.totalStudents}</span>
                                    <span class="course-card-rating">
                                        <i class="fas fa-star"></i> 
                                        <fmt:formatNumber value="${relCourse.avgRating}" maxFractionDigits="1"/>
                                    </span>
                                </div>
                                <div class="course-card-footer">
                                    <div class="course-card-price">
                                        <c:choose>
                                            <c:when test="${relCourse.free}">
                                                <span class="course-card-price-free">Gratis</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="course-card-price-current">
                                                    Rp <fmt:formatNumber value="${relCourse.price}" pattern="#,###"/>
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/course/${relCourse.slug}" class="btn btn-sm btn-outline">
                                        Detail
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
    </c:if>
    
    <!-- Footer -->
    <jsp:include page="/pages/common/footer.jsp"/>
    
    <script>
        function addToWishlist(courseId) {
            // Check if user is logged in
            <c:if test="${empty sessionScope.user}">
                window.location.href = '${pageContext.request.contextPath}/login?redirect=' + encodeURIComponent(window.location.href);
                return;
            </c:if>
            
            fetch('${pageContext.request.contextPath}/wishlist/add?courseId=' + courseId, {
                method: 'POST'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Berhasil ditambahkan ke wishlist!');
                } else {
                    alert(data.message || 'Gagal menambahkan ke wishlist');
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
        }
        
        // Navbar scroll effect
        window.addEventListener('scroll', function() {
            const navbar = document.getElementById('navbar');
            if (navbar && window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else if (navbar) {
                navbar.classList.remove('scrolled');
            }
        });
    </script>
</body>
</html>
