<%-- 
    Document   : review-section
    Created on : Dec 18, 2025
    Author     : NusaTech
    Description: Review Component for Course Detail Page (Include)
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    /* Review Section Styles */
    .review-section {
        padding: 2rem 0;
    }
    
    .review-header {
        display: flex;
        flex-wrap: wrap;
        gap: 2rem;
        margin-bottom: 2rem;
    }
    
    /* Average Rating */
    .rating-overview {
        flex: 0 0 280px;
        background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
        border-radius: 1rem;
        padding: 1.5rem;
        text-align: center;
        border: 1px solid #e5e7eb;
    }
    
    .rating-big {
        font-size: 4rem;
        font-weight: 800;
        color: #1f2937;
        line-height: 1;
        margin-bottom: 0.5rem;
    }
    
    .rating-stars-big {
        font-size: 1.5rem;
        color: #fbbf24;
        margin-bottom: 0.5rem;
    }
    
    .rating-count {
        color: #6b7280;
        font-size: 0.9rem;
    }
    
    /* Rating Breakdown */
    .rating-breakdown {
        flex: 1;
        min-width: 250px;
    }
    
    .rating-bar-item {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        margin-bottom: 0.75rem;
    }
    
    .rating-bar-label {
        display: flex;
        align-items: center;
        gap: 0.25rem;
        width: 60px;
        font-size: 0.9rem;
        color: #374151;
    }
    
    .rating-bar-label i {
        color: #fbbf24;
        font-size: 0.8rem;
    }
    
    .rating-bar-track {
        flex: 1;
        height: 10px;
        background: #e5e7eb;
        border-radius: 999px;
        overflow: hidden;
    }
    
    .rating-bar-fill {
        height: 100%;
        background: linear-gradient(90deg, #fbbf24 0%, #f59e0b 100%);
        border-radius: 999px;
        transition: width 0.6s ease;
    }
    
    .rating-bar-percent {
        width: 50px;
        font-size: 0.85rem;
        color: #6b7280;
        text-align: right;
    }
    
    /* Review Form */
    .review-form-card {
        background: white;
        border-radius: 1rem;
        padding: 1.5rem;
        margin-bottom: 2rem;
        border: 1px solid #e5e7eb;
    }
    
    .review-form-title {
        font-weight: 700;
        font-size: 1.1rem;
        margin-bottom: 1rem;
        color: #1f2937;
    }
    
    .star-rating-input {
        display: flex;
        gap: 0.5rem;
        margin-bottom: 1rem;
    }
    
    .star-rating-input input {
        display: none;
    }
    
    .star-rating-input label {
        font-size: 2rem;
        color: #d1d5db;
        cursor: pointer;
        transition: all 0.15s;
    }
    
    .star-rating-input label:hover,
    .star-rating-input label:hover ~ label,
    .star-rating-input input:checked ~ label {
        color: #fbbf24;
    }
    
    .star-rating-input:hover label {
        color: #d1d5db;
    }
    
    .star-rating-input label:hover,
    .star-rating-input label:hover ~ label {
        color: #fbbf24;
    }
    
    /* Reverse order for CSS sibling selector to work */
    .star-rating-input {
        flex-direction: row-reverse;
        justify-content: flex-end;
    }
    
    .rating-text {
        font-size: 0.9rem;
        color: #6b7280;
        margin-bottom: 1rem;
    }
    
    .rating-text span {
        font-weight: 600;
        color: #374151;
    }
    
    /* Review Filters */
    .review-filters {
        display: flex;
        flex-wrap: wrap;
        gap: 1rem;
        align-items: center;
        margin-bottom: 1.5rem;
        padding-bottom: 1rem;
        border-bottom: 1px solid #e5e7eb;
    }
    
    .filter-label {
        font-weight: 500;
        color: #374151;
    }
    
    .filter-chips {
        display: flex;
        gap: 0.5rem;
        flex-wrap: wrap;
    }
    
    .filter-chip {
        padding: 0.4rem 1rem;
        border-radius: 999px;
        border: 1px solid #e5e7eb;
        background: white;
        color: #6b7280;
        font-size: 0.85rem;
        cursor: pointer;
        transition: all 0.2s;
    }
    
    .filter-chip:hover {
        border-color: #8B1538;
        color: #8B1538;
    }
    
    .filter-chip.active {
        background: #8B1538;
        border-color: #8B1538;
        color: white;
    }
    
    /* Review List */
    .review-list {
        display: flex;
        flex-direction: column;
        gap: 1rem;
    }
    
    .review-card {
        background: white;
        border-radius: 1rem;
        padding: 1.25rem;
        border: 1px solid #e5e7eb;
        transition: box-shadow 0.2s;
    }
    
    .review-card:hover {
        box-shadow: 0 4px 12px rgba(0,0,0,0.06);
    }
    
    .review-card-header {
        display: flex;
        align-items: flex-start;
        gap: 1rem;
        margin-bottom: 0.75rem;
    }
    
    .review-avatar {
        width: 48px;
        height: 48px;
        border-radius: 50%;
        object-fit: cover;
        flex-shrink: 0;
    }
    
    .review-author-info {
        flex: 1;
    }
    
    .review-author-name {
        font-weight: 600;
        color: #1f2937;
        margin-bottom: 0.25rem;
    }
    
    .review-meta {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        flex-wrap: wrap;
    }
    
    .review-stars {
        color: #fbbf24;
        font-size: 0.9rem;
    }
    
    .review-date {
        color: #9ca3af;
        font-size: 0.8rem;
    }
    
    .review-verified {
        display: inline-flex;
        align-items: center;
        gap: 0.25rem;
        background: rgba(16, 185, 129, 0.1);
        color: #059669;
        padding: 0.2rem 0.5rem;
        border-radius: 999px;
        font-size: 0.75rem;
    }
    
    .review-content {
        color: #374151;
        line-height: 1.7;
        margin-bottom: 0.75rem;
    }
    
    .review-helpful {
        display: flex;
        align-items: center;
        gap: 1rem;
        margin-top: 0.75rem;
        padding-top: 0.75rem;
        border-top: 1px solid #f3f4f6;
    }
    
    .helpful-text {
        color: #6b7280;
        font-size: 0.85rem;
    }
    
    .helpful-btn {
        display: inline-flex;
        align-items: center;
        gap: 0.4rem;
        padding: 0.35rem 0.75rem;
        border-radius: 0.5rem;
        border: 1px solid #e5e7eb;
        background: white;
        color: #6b7280;
        font-size: 0.8rem;
        cursor: pointer;
        transition: all 0.2s;
    }
    
    .helpful-btn:hover {
        background: #f9fafb;
        border-color: #d1d5db;
    }
    
    .helpful-btn.voted {
        background: rgba(139, 21, 56, 0.1);
        border-color: #8B1538;
        color: #8B1538;
    }
    
    /* Instructor Response */
    .instructor-response {
        background: #f0fdf4;
        border-left: 4px solid #10b981;
        border-radius: 0 0.5rem 0.5rem 0;
        padding: 1rem;
        margin-top: 0.75rem;
    }
    
    .instructor-response-header {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        margin-bottom: 0.5rem;
    }
    
    .instructor-badge {
        display: inline-flex;
        align-items: center;
        gap: 0.25rem;
        background: #10b981;
        color: white;
        padding: 0.2rem 0.5rem;
        border-radius: 999px;
        font-size: 0.7rem;
        font-weight: 600;
    }
    
    .instructor-response-date {
        color: #6b7280;
        font-size: 0.75rem;
    }
    
    .instructor-response-content {
        color: #374151;
        font-size: 0.9rem;
        line-height: 1.6;
    }
    
    /* Empty State */
    .review-empty {
        text-align: center;
        padding: 3rem 1rem;
        background: #f9fafb;
        border-radius: 1rem;
    }
    
    .review-empty-icon {
        width: 80px;
        height: 80px;
        background: #e5e7eb;
        border-radius: 50%;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 1rem;
    }
    
    /* Pagination */
    .review-pagination {
        display: flex;
        justify-content: center;
        margin-top: 2rem;
    }
    
    .review-pagination .page-link {
        color: #8B1538;
        border-radius: 0.5rem;
        margin: 0 0.25rem;
    }
    
    .review-pagination .page-item.active .page-link {
        background-color: #8B1538;
        border-color: #8B1538;
    }
    
    /* Responsive */
    @media (max-width: 767.98px) {
        .review-header {
            flex-direction: column;
        }
        
        .rating-overview {
            flex: 1;
        }
        
        .review-filters {
            flex-direction: column;
            align-items: flex-start;
        }
    }
</style>

<section class="review-section" id="reviewSection">
    <!-- Review Header with Rating Summary -->
    <div class="review-header">
        <!-- Average Rating -->
        <div class="rating-overview">
            <div class="rating-big">
                <fmt:formatNumber value="${averageRating}" maxFractionDigits="1"/>
            </div>
            <div class="rating-stars-big">
                <c:forEach begin="1" end="5" var="star">
                    <c:choose>
                        <c:when test="${star <= averageRating}">
                            <i class="fas fa-star"></i>
                        </c:when>
                        <c:when test="${star - 0.5 <= averageRating}">
                            <i class="fas fa-star-half-alt"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="far fa-star"></i>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
            <div class="rating-count">
                <fmt:formatNumber value="${totalReviews}"/> ulasan
            </div>
        </div>
        
        <!-- Rating Breakdown -->
        <div class="rating-breakdown">
            <c:forEach begin="1" end="5" var="rating">
                <c:set var="ratingIndex" value="${6 - rating}"/>
                <c:set var="ratingCount" value="${ratingBreakdown[ratingIndex]}"/>
                <c:set var="ratingPercent" value="${totalReviews > 0 ? (ratingCount / totalReviews) * 100 : 0}"/>
                
                <div class="rating-bar-item">
                    <div class="rating-bar-label">
                        <span>${ratingIndex}</span>
                        <i class="fas fa-star"></i>
                    </div>
                    <div class="rating-bar-track">
                        <div class="rating-bar-fill" style="width: ${ratingPercent}%"></div>
                    </div>
                    <div class="rating-bar-percent">
                        <fmt:formatNumber value="${ratingPercent}" maxFractionDigits="0"/>%
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    
    <!-- Review Form (for eligible users) -->
    <c:choose>
        <c:when test="${canReview}">
            <div class="review-form-card" id="reviewFormCard">
                <div class="review-form-title">
                    <i class="fas fa-edit text-primary me-2"></i>
                    Tulis Ulasan Anda
                </div>
                
                <form action="${pageContext.request.contextPath}/review/submit" method="POST" id="reviewForm">
                    <input type="hidden" name="courseId" value="${course.courseId}">
                    
                    <div class="mb-3">
                        <label class="form-label fw-medium">Rating <span class="text-danger">*</span></label>
                        <div class="star-rating-input" id="starRating">
                            <input type="radio" name="rating" id="star5" value="5" required>
                            <label for="star5" title="Sangat Bagus"><i class="fas fa-star"></i></label>
                            
                            <input type="radio" name="rating" id="star4" value="4">
                            <label for="star4" title="Bagus"><i class="fas fa-star"></i></label>
                            
                            <input type="radio" name="rating" id="star3" value="3">
                            <label for="star3" title="Cukup"><i class="fas fa-star"></i></label>
                            
                            <input type="radio" name="rating" id="star2" value="2">
                            <label for="star2" title="Kurang"><i class="fas fa-star"></i></label>
                            
                            <input type="radio" name="rating" id="star1" value="1">
                            <label for="star1" title="Sangat Kurang"><i class="fas fa-star"></i></label>
                        </div>
                        <div class="rating-text" id="ratingText">
                            Klik bintang untuk memberi rating
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label fw-medium">Ulasan <span class="text-danger">*</span></label>
                        <textarea class="form-control" name="comment" rows="4" required 
                                  placeholder="Bagikan pengalaman Anda tentang kursus ini. Apa yang Anda suka? Apa yang bisa ditingkatkan?"></textarea>
                        <div class="form-text">Minimal 20 karakter</div>
                    </div>
                    
                    <div class="d-flex justify-content-end">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-paper-plane me-2"></i> Kirim Ulasan
                        </button>
                    </div>
                </form>
            </div>
        </c:when>
        <c:when test="${hasReviewed}">
            <div class="alert alert-success mb-4">
                <i class="fas fa-check-circle me-2"></i>
                Anda sudah memberikan ulasan untuk kursus ini.
                <a href="#review-${userReviewId}" class="alert-link">Lihat ulasan Anda</a>
            </div>
        </c:when>
        <c:when test="${not empty sessionScope.user && !isEnrolled}">
            <div class="alert alert-info mb-4">
                <i class="fas fa-info-circle me-2"></i>
                Daftar dan selesaikan kursus ini untuk memberikan ulasan.
            </div>
        </c:when>
        <c:when test="${empty sessionScope.user}">
            <div class="alert alert-light mb-4 border">
                <i class="fas fa-lock me-2"></i>
                <a href="${pageContext.request.contextPath}/auth/login" class="alert-link">Login</a> untuk memberikan ulasan.
            </div>
        </c:when>
    </c:choose>
    
    <!-- Review Filters -->
    <c:if test="${totalReviews > 0}">
        <div class="review-filters">
            <span class="filter-label">Filter:</span>
            <div class="filter-chips">
                <button class="filter-chip ${empty param.filter ? 'active' : ''}" data-filter="all">
                    Semua
                </button>
                <button class="filter-chip ${param.filter == '5' ? 'active' : ''}" data-filter="5">
                    <i class="fas fa-star text-warning me-1"></i> 5
                </button>
                <button class="filter-chip ${param.filter == '4' ? 'active' : ''}" data-filter="4">
                    <i class="fas fa-star text-warning me-1"></i> 4
                </button>
                <button class="filter-chip ${param.filter == '3' ? 'active' : ''}" data-filter="3">
                    <i class="fas fa-star text-warning me-1"></i> 3
                </button>
                <button class="filter-chip ${param.filter == '2' ? 'active' : ''}" data-filter="2">
                    <i class="fas fa-star text-warning me-1"></i> 2
                </button>
                <button class="filter-chip ${param.filter == '1' ? 'active' : ''}" data-filter="1">
                    <i class="fas fa-star text-warning me-1"></i> 1
                </button>
            </div>
            
            <div class="ms-auto">
                <select class="form-select form-select-sm" id="reviewSort">
                    <option value="newest" ${param.sort == 'newest' ? 'selected' : ''}>Terbaru</option>
                    <option value="oldest" ${param.sort == 'oldest' ? 'selected' : ''}>Terlama</option>
                    <option value="highest" ${param.sort == 'highest' ? 'selected' : ''}>Rating Tertinggi</option>
                    <option value="lowest" ${param.sort == 'lowest' ? 'selected' : ''}>Rating Terendah</option>
                    <option value="helpful" ${param.sort == 'helpful' ? 'selected' : ''}>Paling Membantu</option>
                </select>
            </div>
        </div>
    </c:if>
    
    <!-- Review List -->
    <div class="review-list" id="reviewList">
        <c:choose>
            <c:when test="${not empty reviews}">
                <c:forEach var="review" items="${reviews}">
                    <div class="review-card" id="review-${review.reviewId}">
                        <div class="review-card-header">
                            <img src="${not empty review.student.profilePicture ? review.student.profilePicture : 'https://ui-avatars.com/api/?name='.concat(review.student.fullName).concat('&background=8B1538&color=fff')}" 
                                 alt="${review.student.fullName}" class="review-avatar">
                            <div class="review-author-info">
                                <div class="review-author-name">${review.student.fullName}</div>
                                <div class="review-meta">
                                    <span class="review-stars">
                                        <c:forEach begin="1" end="5" var="star">
                                            <c:choose>
                                                <c:when test="${star <= review.rating}">
                                                    <i class="fas fa-star"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="far fa-star"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </span>
                                    <span class="review-date">
                                        <fmt:formatDate value="${review.createdAt}" pattern="dd MMM yyyy"/>
                                    </span>
                                    <span class="review-verified">
                                        <i class="fas fa-check-circle"></i> Terverifikasi
                                    </span>
                                </div>
                            </div>
                        </div>
                        
                        <div class="review-content">
                            ${review.comment}
                        </div>
                        
                        <!-- Instructor Response -->
                        <c:if test="${not empty review.instructorResponse}">
                            <div class="instructor-response">
                                <div class="instructor-response-header">
                                    <span class="instructor-badge">
                                        <i class="fas fa-chalkboard-teacher"></i> Pengajar
                                    </span>
                                    <span class="instructor-response-date">
                                        <fmt:formatDate value="${review.responseDate}" pattern="dd MMM yyyy"/>
                                    </span>
                                </div>
                                <div class="instructor-response-content">
                                    ${review.instructorResponse}
                                </div>
                            </div>
                        </c:if>
                        
                        <!-- Helpful Section -->
                        <div class="review-helpful">
                            <span class="helpful-text">Apakah ulasan ini membantu?</span>
                            <button class="helpful-btn ${review.userMarkedHelpful ? 'voted' : ''}" 
                                    onclick="markHelpful(${review.reviewId}, this)">
                                <i class="fas fa-thumbs-up"></i>
                                <span class="helpful-count">${review.helpfulCount}</span>
                            </button>
                            <button class="helpful-btn" onclick="reportReview(${review.reviewId})">
                                <i class="fas fa-flag"></i> Laporkan
                            </button>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="review-empty">
                    <div class="review-empty-icon">
                        <i class="fas fa-star fa-2x text-muted"></i>
                    </div>
                    <h5 class="fw-bold mb-2">Belum Ada Ulasan</h5>
                    <p class="text-muted mb-0">Jadilah yang pertama memberikan ulasan untuk kursus ini!</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <!-- Pagination -->
    <c:if test="${reviewTotalPages > 1}">
        <nav aria-label="Review pagination" class="review-pagination">
            <ul class="pagination">
                <li class="page-item ${reviewCurrentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="javascript:void(0)" onclick="loadReviews(${reviewCurrentPage - 1})">
                        <i class="fas fa-chevron-left"></i>
                    </a>
                </li>
                
                <c:forEach begin="1" end="${reviewTotalPages}" var="page">
                    <c:if test="${page == 1 || page == reviewTotalPages || (page >= reviewCurrentPage - 2 && page <= reviewCurrentPage + 2)}">
                        <li class="page-item ${page == reviewCurrentPage ? 'active' : ''}">
                            <a class="page-link" href="javascript:void(0)" onclick="loadReviews(${page})">${page}</a>
                        </li>
                    </c:if>
                </c:forEach>
                
                <li class="page-item ${reviewCurrentPage == reviewTotalPages ? 'disabled' : ''}">
                    <a class="page-link" href="javascript:void(0)" onclick="loadReviews(${reviewCurrentPage + 1})">
                        <i class="fas fa-chevron-right"></i>
                    </a>
                </li>
            </ul>
        </nav>
    </c:if>
</section>

<script>
    // Star rating interaction
    document.querySelectorAll('.star-rating-input input').forEach(input => {
        input.addEventListener('change', function() {
            const ratingTexts = {
                '5': '<span>Sangat Bagus</span> - Saya sangat puas dengan kursus ini!',
                '4': '<span>Bagus</span> - Kursus ini memenuhi ekspektasi saya',
                '3': '<span>Cukup</span> - Ada beberapa hal yang bisa ditingkatkan',
                '2': '<span>Kurang</span> - Saya kurang puas dengan kursus ini',
                '1': '<span>Sangat Kurang</span> - Saya tidak merekomendasikan kursus ini'
            };
            document.getElementById('ratingText').innerHTML = ratingTexts[this.value];
        });
    });
    
    // Review form validation
    document.getElementById('reviewForm')?.addEventListener('submit', function(e) {
        const rating = this.querySelector('input[name="rating"]:checked');
        const comment = this.querySelector('textarea[name="comment"]').value.trim();
        
        if (!rating) {
            e.preventDefault();
            alert('Silakan berikan rating bintang');
            return;
        }
        
        if (comment.length < 20) {
            e.preventDefault();
            alert('Ulasan minimal 20 karakter');
            return;
        }
    });
    
    // Filter chips
    document.querySelectorAll('.filter-chip').forEach(chip => {
        chip.addEventListener('click', function() {
            document.querySelectorAll('.filter-chip').forEach(c => c.classList.remove('active'));
            this.classList.add('active');
            
            const filter = this.dataset.filter;
            loadReviews(1, filter);
        });
    });
    
    // Sort change
    document.getElementById('reviewSort')?.addEventListener('change', function() {
        const filter = document.querySelector('.filter-chip.active')?.dataset.filter || 'all';
        loadReviews(1, filter, this.value);
    });
    
    // Load reviews via AJAX
    function loadReviews(page, filter = null, sort = null) {
        const courseId = '${course.courseId}';
        filter = filter || document.querySelector('.filter-chip.active')?.dataset.filter || 'all';
        sort = sort || document.getElementById('reviewSort')?.value || 'newest';
        
        const params = new URLSearchParams({
            page: page,
            filter: filter === 'all' ? '' : filter,
            sort: sort
        });
        
        fetch(`${pageContext.request.contextPath}/review/course/${courseId}?${params}`, {
            headers: { 'X-Requested-With': 'XMLHttpRequest' }
        })
        .then(response => response.text())
        .then(html => {
            document.getElementById('reviewList').innerHTML = html;
        });
    }
    
    // Mark helpful
    function markHelpful(reviewId, btn) {
        fetch('${pageContext.request.contextPath}/review/helpful/' + reviewId, {
            method: 'POST'
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                btn.classList.toggle('voted');
                btn.querySelector('.helpful-count').textContent = data.helpfulCount;
            } else if (data.message === 'login_required') {
                window.location = '${pageContext.request.contextPath}/auth/login';
            }
        });
    }
    
    // Report review
    function reportReview(reviewId) {
        const reason = prompt('Alasan melaporkan ulasan ini:');
        if (reason) {
            fetch('${pageContext.request.contextPath}/review/report/' + reviewId, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ reason: reason })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Laporan berhasil dikirim. Terima kasih!');
                }
            });
        }
    }
</script>
