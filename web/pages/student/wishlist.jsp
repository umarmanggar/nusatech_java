<%-- 
    Document   : wishlist
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Student Wishlist Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wishlist - NusaTech</title>
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
                    <i class="fas fa-heart" style="color: var(--error);"></i> Wishlist
                </h1>
                <p class="page-subtitle">Kursus yang Anda simpan untuk nanti</p>
            </div>
            
            <c:choose>
                <c:when test="${not empty wishlistCourses}">
                    <div class="grid grid-3">
                        <c:forEach var="course" items="${wishlistCourses}">
                            <div class="card course-card">
                                <div class="course-card-image">
                                    <img src="${not empty course.thumbnail && !course.thumbnail.equals('default-course.png') ? course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400&h=225&fit=crop'}" 
                                         alt="${course.title}">
                                    <c:if test="${course.free}">
                                        <span class="course-card-badge free">GRATIS</span>
                                    </c:if>
                                    <c:if test="${course.hasDiscount() && !course.free}">
                                        <span class="course-card-badge">-${course.discountPercentage}%</span>
                                    </c:if>
                                    <button onclick="removeFromWishlist(${course.courseId})" 
                                            style="position: absolute; top: 1rem; right: 1rem; width: 36px; height: 36px; border-radius: 50%; background: white; color: var(--error); display: flex; align-items: center; justify-content: center; box-shadow: var(--shadow-md);"
                                            title="Hapus dari Wishlist">
                                        <i class="fas fa-heart"></i>
                                    </button>
                                </div>
                                <div class="course-card-body">
                                    <span class="course-card-category">${course.category.name}</span>
                                    <h3 class="course-card-title">
                                        <a href="${pageContext.request.contextPath}/course/${course.slug}">${course.title}</a>
                                    </h3>
                                    <div class="course-card-instructor">
                                        <img src="https://ui-avatars.com/api/?name=${course.lecturer.name}&background=8B1538&color=fff" 
                                             alt="${course.lecturer.name}">
                                        <span>${course.lecturer.name}</span>
                                    </div>
                                    <div class="course-card-meta">
                                        <span><i class="fas fa-users"></i> ${course.totalStudents}</span>
                                        <span class="course-card-rating">
                                            <i class="fas fa-star"></i> 
                                            <fmt:formatNumber value="${course.avgRating}" maxFractionDigits="1"/>
                                        </span>
                                    </div>
                                    <div class="course-card-footer">
                                        <div class="course-card-price">
                                            <c:choose>
                                                <c:when test="${course.free}">
                                                    <span class="course-card-price-free">Gratis</span>
                                                </c:when>
                                                <c:when test="${course.hasDiscount()}">
                                                    <span class="course-card-price-current">
                                                        Rp <fmt:formatNumber value="${course.discountPrice}" pattern="#,###"/>
                                                    </span>
                                                    <span class="course-card-price-original">
                                                        Rp <fmt:formatNumber value="${course.price}" pattern="#,###"/>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="course-card-price-current">
                                                        Rp <fmt:formatNumber value="${course.price}" pattern="#,###"/>
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/cart/add?courseId=${course.courseId}" class="btn btn-sm btn-primary">
                                            <i class="fas fa-cart-plus"></i>
                                        </a>
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
                            <i class="far fa-heart"></i>
                        </div>
                        <h3 class="empty-state-title">Wishlist Kosong</h3>
                        <p class="empty-state-description">
                            Simpan kursus yang Anda minati untuk dibeli nanti.
                        </p>
                        <a href="${pageContext.request.contextPath}/courses" class="btn btn-primary btn-lg">
                            <i class="fas fa-search"></i> Jelajahi Kursus
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
    
    <script>
        function removeFromWishlist(courseId) {
            if (confirm('Hapus kursus ini dari wishlist?')) {
                window.location.href = '${pageContext.request.contextPath}/wishlist/remove?courseId=' + courseId;
            }
        }
    </script>
</body>
</html>
