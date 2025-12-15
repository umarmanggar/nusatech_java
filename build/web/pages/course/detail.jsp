<%-- 
    Document   : detail
    Created on : Dec 10, 2025, 4:40:58 PM
    Author     : user
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
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        .course-hero { background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%); color: white; padding: 6rem 0 3rem; }
        .course-hero-grid { display: grid; grid-template-columns: 1fr 400px; gap: 3rem; align-items: start; }
        .course-breadcrumb { display: flex; gap: 0.5rem; margin-bottom: 1rem; opacity: 0.8; font-size: 0.875rem; }
        .course-breadcrumb a:hover { text-decoration: underline; }
        .course-meta { display: flex; flex-wrap: wrap; gap: 1.5rem; margin: 1.5rem 0; }
        .course-meta-item { display: flex; align-items: center; gap: 0.5rem; }
        .course-card-sticky { background: var(--white); border-radius: var(--radius-xl); overflow: hidden; box-shadow: var(--shadow-xl); position: sticky; top: 100px; }
        .course-card-image { aspect-ratio: 16/9; }
        .course-card-image img { width: 100%; height: 100%; object-fit: cover; }
        .course-card-body { padding: 1.5rem; }
        .course-price { font-size: 2rem; font-weight: 800; color: var(--gray-900); margin-bottom: 1rem; }
        .course-price-original { font-size: 1rem; color: var(--gray-400); text-decoration: line-through; margin-left: 0.5rem; }
        .course-includes { margin: 1.5rem 0; }
        .course-includes li { display: flex; align-items: center; gap: 0.75rem; padding: 0.5rem 0; color: var(--gray-700); }
        .course-includes i { color: var(--primary); width: 20px; }
        .course-content { padding: 3rem 0; }
        .course-content-grid { display: grid; grid-template-columns: 1fr 400px; gap: 3rem; }
        .course-section { background: var(--white); border-radius: var(--radius-xl); margin-bottom: 1rem; overflow: hidden; }
        .course-section-header { display: flex; justify-content: space-between; align-items: center; padding: 1rem 1.5rem; background: var(--gray-50); cursor: pointer; }
        .course-section-title { font-weight: 700; }
        .course-section-content { padding: 0; max-height: 0; overflow: hidden; transition: 0.3s; }
        .course-section.active .course-section-content { max-height: 1000px; padding: 1rem 1.5rem; }
        .course-material { display: flex; align-items: center; gap: 1rem; padding: 0.75rem 0; border-bottom: 1px solid var(--gray-100); }
        .course-material:last-child { border-bottom: none; }
        .course-material i { color: var(--gray-400); width: 24px; }
        .instructor-card { background: var(--white); border-radius: var(--radius-xl); padding: 1.5rem; display: flex; gap: 1rem; align-items: start; }
        .instructor-avatar { width: 80px; height: 80px; border-radius: var(--radius-xl); object-fit: cover; }
        .rating-stars { color: var(--warning); }
    </style>
</head>
<body>
    <jsp:include page="/pages/common/navbar.jsp"/>
    
    <section class="course-hero">
        <div class="container">
            <div class="course-hero-grid">
                <div>
                    <div class="course-breadcrumb">
                        <a href="${pageContext.request.contextPath}/">Beranda</a> /
                        <a href="${pageContext.request.contextPath}/courses">Kursus</a> /
                        <a href="${pageContext.request.contextPath}/courses?category=${course.category.slug}">${course.category.name}</a>
                    </div>
                    <h1 style="font-size: 2.5rem; margin-bottom: 1rem;">${course.title}</h1>
                    <p style="font-size: 1.125rem; opacity: 0.9; margin-bottom: 1.5rem;">${course.shortDescription}</p>
                    <div class="course-meta">
                        <div class="course-meta-item">
                            <span class="rating-stars"><i class="fas fa-star"></i></span>
                            <span><fmt:formatNumber value="${course.avgRating}" maxFractionDigits="1"/> (${course.totalReviews} ulasan)</span>
                        </div>
                        <div class="course-meta-item"><i class="fas fa-users"></i><span>${course.totalStudents} pelajar</span></div>
                        <div class="course-meta-item"><i class="fas fa-signal"></i><span>${course.levelDisplayName}</span></div>
                        <div class="course-meta-item"><i class="fas fa-globe"></i><span>${course.language}</span></div>
                    </div>
                    <div class="course-meta">
                        <div class="course-meta-item">
                            <img src="https://ui-avatars.com/api/?name=${course.lecturer.name}&background=ffffff&color=8B1538" style="width: 32px; height: 32px; border-radius: 50%;">
                            <span>Dibuat oleh <strong>${course.lecturer.name}</strong></span>
                        </div>
                        <div class="course-meta-item"><i class="fas fa-calendar"></i><span>Update terakhir: <fmt:formatDate value="${course.updatedAt}" pattern="dd MMM yyyy"/></span></div>
                    </div>
                </div>
                <div class="course-card-sticky">
                    <div class="course-card-image">
                        <img src="${not empty course.thumbnail ? course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800&h=450&fit=crop'}" alt="${course.title}">
                    </div>
                    <div class="course-card-body">
                        <div class="course-price">
                            <c:choose>
                                <c:when test="${course.free}"><span style="color: var(--success);">Gratis</span></c:when>
                                <c:when test="${course.hasDiscount()}">
                                    Rp <fmt:formatNumber value="${course.discountPrice}" pattern="#,###"/>
                                    <span class="course-price-original">Rp <fmt:formatNumber value="${course.price}" pattern="#,###"/></span>
                                </c:when>
                                <c:otherwise>Rp <fmt:formatNumber value="${course.price}" pattern="#,###"/></c:otherwise>
                            </c:choose>
                        </div>
                        <c:choose>
                            <c:when test="${isEnrolled}">
                                <a href="${pageContext.request.contextPath}/learn/${course.slug}" class="btn btn-primary btn-lg w-100"><i class="fas fa-play"></i> Lanjutkan Belajar</a>
                                <div class="progress" style="margin-top: 1rem;"><div class="progress-bar" style="width: ${enrollment.progressInt}%"></div></div>
                                <p style="text-align: center; margin-top: 0.5rem; color: var(--gray-500);">Progress: ${enrollment.progressInt}%</p>
                            </c:when>
                            <c:when test="${course.free}">
                                <form action="${pageContext.request.contextPath}/student/enroll" method="POST">
                                    <input type="hidden" name="courseId" value="${course.courseId}">
                                    <button type="submit" class="btn btn-primary btn-lg w-100"><i class="fas fa-graduation-cap"></i> Daftar Gratis</button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/checkout?courseId=${course.courseId}" class="btn btn-primary btn-lg w-100"><i class="fas fa-shopping-cart"></i> Beli Sekarang</a>
                                <a href="#" class="btn btn-outline btn-lg w-100" style="margin-top: 0.75rem;"><i class="fas fa-heart"></i> Tambah ke Wishlist</a>
                            </c:otherwise>
                        </c:choose>
                        <ul class="course-includes">
                            <li><i class="fas fa-video"></i><span>${course.durationHours} jam video pembelajaran</span></li>
                            <li><i class="fas fa-file-alt"></i><span>${course.totalMaterials} materi pembelajaran</span></li>
                            <li><i class="fas fa-infinity"></i><span>Akses selamanya</span></li>
                            <li><i class="fas fa-mobile-alt"></i><span>Akses di mobile & desktop</span></li>
                            <li><i class="fas fa-certificate"></i><span>Sertifikat penyelesaian</span></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <section class="course-content">
        <div class="container">
            <div class="course-content-grid">
                <div>
                    <h2 style="margin-bottom: 1.5rem;">Tentang Kursus</h2>
                    <div style="background: var(--white); border-radius: var(--radius-xl); padding: 1.5rem; margin-bottom: 2rem;">
                        <p>${course.description}</p>
                    </div>
                    
                    <h2 style="margin-bottom: 1.5rem;">Apa yang Akan Dipelajari</h2>
                    <div style="background: var(--white); border-radius: var(--radius-xl); padding: 1.5rem; margin-bottom: 2rem;">
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                            <c:if test="${not empty course.objectives}">
                                <c:forEach var="objective" items="${fn:split(course.objectives, '\n')}">
                                    <div style="display: flex; gap: 0.75rem;"><i class="fas fa-check" style="color: var(--success);"></i><span>${objective}</span></div>
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>
                    
                    <h2 style="margin-bottom: 1.5rem;">Konten Kursus</h2>
                    <p style="margin-bottom: 1rem; color: var(--gray-600);">${course.totalSections} bab • ${course.totalMaterials} materi • ${course.durationHours} jam total</p>
                    <c:forEach var="section" items="${course.sections}" varStatus="status">
                        <div class="course-section ${status.index == 0 ? 'active' : ''}" onclick="this.classList.toggle('active')">
                            <div class="course-section-header">
                                <span class="course-section-title">Bab ${status.index + 1}: ${section.title}</span>
                                <i class="fas fa-chevron-down"></i>
                            </div>
                            <div class="course-section-content">
                                <c:forEach var="material" items="${section.materials}">
                                    <div class="course-material">
                                        <i class="${material.contentTypeIcon}"></i>
                                        <span style="flex: 1;">${material.title}</span>
                                        <span style="color: var(--gray-400);">${material.formattedDuration}</span>
                                        <c:if test="${material.preview}"><span class="badge badge-primary">Preview</span></c:if>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                    
                    <h2 style="margin: 2rem 0 1.5rem;">Pengajar</h2>
                    <div class="instructor-card">
                        <img src="https://ui-avatars.com/api/?name=${course.lecturer.name}&background=8B1538&color=fff&size=160" alt="${course.lecturer.name}" class="instructor-avatar">
                        <div>
                            <h3>${course.lecturer.name}</h3>
                            <p style="color: var(--gray-500); margin-bottom: 0.5rem;">Pengajar Profesional</p>
                            <div style="display: flex; gap: 1.5rem; margin-bottom: 1rem; font-size: 0.875rem; color: var(--gray-600);">
                                <span><i class="fas fa-star" style="color: var(--warning);"></i> 4.8 Rating</span>
                                <span><i class="fas fa-users"></i> 1,234 Pelajar</span>
                                <span><i class="fas fa-play-circle"></i> 5 Kursus</span>
                            </div>
                            <p style="color: var(--gray-600);">Pengajar berpengalaman dengan keahlian di bidang pengembangan software.</p>
                        </div>
                    </div>
                </div>
                <div></div>
            </div>
        </div>
    </section>
    
    <jsp:include page="/pages/common/footer.jsp"/>
</body>
</html>
