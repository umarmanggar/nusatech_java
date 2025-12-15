<%-- 
    Document   : list
    Created on : Dec 10, 2025, 4:40:48 PM
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
    <title>Jelajahi Kursus - NusaTech</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        .courses-page { padding-top: 100px; min-height: 100vh; }
        .courses-header { background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%); color: white; padding: 3rem 0; margin-bottom: 2rem; }
        .filter-sidebar { background: var(--white); padding: 1.5rem; border-radius: var(--radius-xl); height: fit-content; }
        .filter-title { font-size: 1rem; font-weight: 700; margin-bottom: 1rem; color: var(--gray-800); }
        .filter-group { margin-bottom: 1.5rem; }
        .filter-option { display: flex; align-items: center; gap: 0.5rem; padding: 0.5rem 0; cursor: pointer; }
        .filter-option input { accent-color: var(--primary); }
        .courses-grid { display: grid; grid-template-columns: 280px 1fr; gap: 2rem; }
        .pagination { display: flex; justify-content: center; gap: 0.5rem; margin-top: 2rem; }
        .pagination a { padding: 0.75rem 1rem; border-radius: var(--radius-md); background: var(--white); color: var(--gray-700); font-weight: 600; }
        .pagination a:hover, .pagination a.active { background: var(--primary); color: var(--white); }
    </style>
</head>
<body>
    <jsp:include page="/pages/common/navbar.jsp"/>
    
    <div class="courses-page">
        <div class="courses-header">
            <div class="container">
                <h1>Jelajahi Kursus</h1>
                <p style="opacity: 0.9;">Temukan kursus yang sesuai dengan minat dan kebutuhan Anda</p>
            </div>
        </div>
        
        <div class="container">
            <div class="courses-grid">
                <aside class="filter-sidebar">
                    <h3 class="filter-title">Filter</h3>
                    <form method="GET" action="${pageContext.request.contextPath}/courses">
                        <div class="filter-group">
                            <h4 class="filter-title">Kategori</h4>
                            <c:forEach var="cat" items="${categories}">
                                <label class="filter-option">
                                    <input type="radio" name="category" value="${cat.slug}" ${selectedCategory.slug == cat.slug ? 'checked' : ''}>
                                    <span>${cat.name}</span>
                                    <span style="margin-left: auto; color: var(--gray-400);">(${cat.courseCount})</span>
                                </label>
                            </c:forEach>
                        </div>
                        <div class="filter-group">
                            <h4 class="filter-title">Level</h4>
                            <label class="filter-option"><input type="checkbox" name="level" value="BEGINNER"> Pemula</label>
                            <label class="filter-option"><input type="checkbox" name="level" value="INTERMEDIATE"> Menengah</label>
                            <label class="filter-option"><input type="checkbox" name="level" value="ADVANCED"> Mahir</label>
                        </div>
                        <div class="filter-group">
                            <h4 class="filter-title">Harga</h4>
                            <label class="filter-option"><input type="checkbox" name="price" value="free"> Gratis</label>
                            <label class="filter-option"><input type="checkbox" name="price" value="paid"> Berbayar</label>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Terapkan Filter</button>
                    </form>
                </aside>
                
                <div>
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
                        <p style="color: var(--gray-600);">Menampilkan ${totalCourses} kursus</p>
                        <select style="padding: 0.5rem 1rem; border: 2px solid var(--gray-200); border-radius: var(--radius-md);">
                            <option>Terbaru</option>
                            <option>Terpopuler</option>
                            <option>Rating Tertinggi</option>
                            <option>Harga Terendah</option>
                        </select>
                    </div>
                    
                    <div class="grid grid-3">
                        <c:forEach var="course" items="${courses}">
                            <div class="card course-card">
                                <div class="course-card-image">
                                    <img src="${not empty course.thumbnail ? course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400&h=225&fit=crop'}" alt="${course.title}">
                                    <c:if test="${course.free}"><span class="course-card-badge free">GRATIS</span></c:if>
                                    <c:if test="${course.hasDiscount() and not course.free}"><span class="course-card-badge">-${course.discountPercentage}%</span></c:if>
                                </div>
                                <div class="course-card-body">
                                    <span class="course-card-category">${course.category.name}</span>
                                    <h3 class="course-card-title"><a href="${pageContext.request.contextPath}/course/${course.slug}">${course.title}</a></h3>
                                    <div class="course-card-instructor">
                                        <img src="https://ui-avatars.com/api/?name=${course.lecturer.name}&background=8B1538&color=fff" alt="${course.lecturer.name}">
                                        <span>${course.lecturer.name}</span>
                                    </div>
                                    <div class="course-card-meta">
                                        <span><i class="fas fa-users"></i> ${course.totalStudents}</span>
                                        <span class="course-card-rating"><i class="fas fa-star"></i> <fmt:formatNumber value="${course.avgRating}" maxFractionDigits="1"/></span>
                                    </div>
                                    <div class="course-card-footer">
                                        <c:choose>
                                            <c:when test="${course.free}"><span class="course-card-price-free">Gratis</span></c:when>
                                            <c:otherwise><span class="course-card-price-current">Rp <fmt:formatNumber value="${course.effectivePrice}" pattern="#,###"/></span></c:otherwise>
                                        </c:choose>
                                        <a href="${pageContext.request.contextPath}/course/${course.slug}" class="btn btn-sm btn-outline">Detail</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <c:if test="${totalPages > 1}">
                        <div class="pagination">
                            <c:if test="${currentPage > 1}"><a href="?page=${currentPage - 1}"><i class="fas fa-chevron-left"></i></a></c:if>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <a href="?page=${i}" class="${currentPage == i ? 'active' : ''}">${i}</a>
                            </c:forEach>
                            <c:if test="${currentPage < totalPages}"><a href="?page=${currentPage + 1}"><i class="fas fa-chevron-right"></i></a></c:if>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="/pages/common/footer.jsp"/>
</body>
</html>
