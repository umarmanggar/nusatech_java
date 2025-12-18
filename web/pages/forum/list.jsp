<%-- 
    Document   : list
    Created on : Dec 18, 2025
    Author     : NusaTech
    Description: Forum Discussion List for Course
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forum Diskusi - ${course.title} - NusaTech</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
        
        .navbar {
            background: white;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        }
        
        .navbar-brand {
            font-weight: 800;
            color: var(--primary) !important;
        }
        
        .btn-primary { background-color: var(--primary); border-color: var(--primary); }
        .btn-primary:hover { background-color: var(--primary-dark); border-color: var(--primary-dark); }
        .btn-outline-primary { color: var(--primary); border-color: var(--primary); }
        .btn-outline-primary:hover { background-color: var(--primary); border-color: var(--primary); }
        .text-primary { color: var(--primary) !important; }
        
        /* Forum Header */
        .forum-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }
        
        .forum-header-course {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }
        
        .forum-header-course img {
            width: 60px;
            height: 60px;
            border-radius: 0.5rem;
            object-fit: cover;
        }
        
        .breadcrumb-item a {
            color: rgba(255,255,255,0.8);
            text-decoration: none;
        }
        
        .breadcrumb-item a:hover {
            color: white;
        }
        
        .breadcrumb-item.active {
            color: white;
        }
        
        .breadcrumb-divider {
            color: rgba(255,255,255,0.5);
        }
        
        /* Stats Cards */
        .stats-row {
            display: flex;
            gap: 1.5rem;
            flex-wrap: wrap;
        }
        
        .stat-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.9rem;
            opacity: 0.9;
        }
        
        /* Filter Bar */
        .filter-bar {
            background: white;
            border-radius: 1rem;
            padding: 1rem 1.25rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
        }
        
        .search-input {
            border: none;
            background: #f8f9fa;
            padding: 0.75rem 1rem 0.75rem 2.75rem;
            border-radius: 0.5rem;
        }
        
        .search-input:focus {
            box-shadow: none;
            background: #f1f5f9;
        }
        
        .search-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
        }
        
        .sort-tabs {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }
        
        .sort-tab {
            padding: 0.5rem 1rem;
            border-radius: 999px;
            border: none;
            background: #f1f5f9;
            color: #4b5563;
            font-size: 0.85rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .sort-tab:hover {
            background: #e5e7eb;
        }
        
        .sort-tab.active {
            background: var(--primary);
            color: white;
        }
        
        /* Discussion List */
        .discussion-list {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }
        
        .discussion-card {
            background: white;
            border-radius: 1rem;
            padding: 1.25rem;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            transition: all 0.2s;
            text-decoration: none;
            color: inherit;
            display: block;
        }
        
        .discussion-card:hover {
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            transform: translateY(-2px);
            color: inherit;
        }
        
        .discussion-card.pinned {
            border-left: 4px solid var(--secondary);
            background: linear-gradient(90deg, rgba(212, 168, 75, 0.05) 0%, white 100%);
        }
        
        .discussion-card.answered {
            border-left: 4px solid #10b981;
        }
        
        .discussion-header {
            display: flex;
            align-items: flex-start;
            gap: 1rem;
            margin-bottom: 0.75rem;
        }
        
        .discussion-avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            object-fit: cover;
            flex-shrink: 0;
        }
        
        .discussion-info {
            flex: 1;
            min-width: 0;
        }
        
        .discussion-title {
            font-weight: 600;
            font-size: 1.05rem;
            color: #1f2937;
            margin-bottom: 0.25rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .discussion-card:hover .discussion-title {
            color: var(--primary);
        }
        
        .discussion-meta {
            font-size: 0.8rem;
            color: #6b7280;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            flex-wrap: wrap;
        }
        
        .discussion-excerpt {
            color: #6b7280;
            font-size: 0.9rem;
            margin-bottom: 0.75rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .discussion-stats {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            font-size: 0.85rem;
            color: #6b7280;
        }
        
        .discussion-stat {
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }
        
        .discussion-stat i {
            font-size: 0.9rem;
        }
        
        .discussion-tags {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }
        
        .discussion-tag {
            padding: 0.2rem 0.6rem;
            background: #f1f5f9;
            border-radius: 999px;
            font-size: 0.75rem;
            color: #4b5563;
        }
        
        /* Badges */
        .badge-pinned {
            background: rgba(212, 168, 75, 0.15);
            color: #b8860b;
            font-size: 0.7rem;
            padding: 0.25rem 0.5rem;
            border-radius: 999px;
        }
        
        .badge-answered {
            background: rgba(16, 185, 129, 0.15);
            color: #059669;
            font-size: 0.7rem;
            padding: 0.25rem 0.5rem;
            border-radius: 999px;
        }
        
        .badge-instructor {
            background: rgba(139, 21, 56, 0.15);
            color: var(--primary);
            font-size: 0.7rem;
            padding: 0.25rem 0.5rem;
            border-radius: 999px;
        }
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 1rem;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
        }
        
        .empty-state-icon {
            width: 100px;
            height: 100px;
            background: #f1f5f9;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
        }
        
        /* Create Discussion Modal */
        .modal-header {
            border-bottom: 1px solid #e5e7eb;
            padding: 1.25rem 1.5rem;
        }
        
        .modal-body {
            padding: 1.5rem;
        }
        
        .modal-footer {
            border-top: 1px solid #e5e7eb;
            padding: 1rem 1.5rem;
        }
        
        .form-label {
            font-weight: 500;
            color: #374151;
            margin-bottom: 0.5rem;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(139, 21, 56, 0.1);
        }
        
        /* Pagination */
        .pagination {
            justify-content: center;
            margin-top: 2rem;
        }
        
        .page-link {
            color: var(--primary);
            border-radius: 0.5rem;
            margin: 0 0.25rem;
        }
        
        .page-item.active .page-link {
            background-color: var(--primary);
            border-color: var(--primary);
        }
        
        /* Responsive */
        @media (max-width: 767.98px) {
            .filter-bar .row > div {
                margin-bottom: 0.75rem;
            }
            
            .sort-tabs {
                overflow-x: auto;
                flex-wrap: nowrap;
                padding-bottom: 0.5rem;
            }
            
            .discussion-stats {
                gap: 1rem;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg sticky-top">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-graduation-cap me-2"></i>NusaTech
            </a>
            <div class="d-flex align-items-center gap-3">
                <a href="${pageContext.request.contextPath}/learn/${course.slug}" class="btn btn-sm btn-outline-secondary">
                    <i class="fas fa-arrow-left me-1"></i> Kembali ke Kursus
                </a>
            </div>
        </div>
    </nav>
    
    <!-- Forum Header -->
    <section class="forum-header">
        <div class="container">
            <nav aria-label="breadcrumb" class="mb-3">
                <ol class="breadcrumb mb-0" style="--bs-breadcrumb-divider: '›';">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/course/${course.slug}">${course.title}</a></li>
                    <li class="breadcrumb-item active">Forum Diskusi</li>
                </ol>
            </nav>
            
            <div class="forum-header-course">
                <img src="${not empty course.thumbnail ? course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=60&h=60&fit=crop'}" 
                     alt="${course.title}">
                <div>
                    <h1 class="h3 fw-bold mb-1">Forum Diskusi</h1>
                    <p class="mb-0 opacity-75">${course.title}</p>
                </div>
            </div>
            
            <div class="stats-row">
                <div class="stat-item">
                    <i class="fas fa-comments"></i>
                    <span>${totalDiscussions} Diskusi</span>
                </div>
                <div class="stat-item">
                    <i class="fas fa-user-graduate"></i>
                    <span>${totalParticipants} Peserta</span>
                </div>
                <div class="stat-item">
                    <i class="fas fa-check-circle"></i>
                    <span>${answeredCount} Terjawab</span>
                </div>
            </div>
        </div>
    </section>
    
    <main class="container pb-5">
        <!-- Filter Bar -->
        <div class="filter-bar">
            <div class="row align-items-center g-3">
                <div class="col-lg-5">
                    <div class="position-relative">
                        <i class="fas fa-search search-icon"></i>
                        <input type="text" class="form-control search-input" id="searchInput" 
                               placeholder="Cari diskusi..." value="${param.q}">
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="sort-tabs">
                        <button class="sort-tab ${empty param.sort || param.sort == 'newest' ? 'active' : ''}" data-sort="newest">
                            <i class="fas fa-clock me-1"></i> Terbaru
                        </button>
                        <button class="sort-tab ${param.sort == 'popular' ? 'active' : ''}" data-sort="popular">
                            <i class="fas fa-fire me-1"></i> Populer
                        </button>
                        <button class="sort-tab ${param.sort == 'unanswered' ? 'active' : ''}" data-sort="unanswered">
                            <i class="fas fa-question-circle me-1"></i> Belum Dijawab
                        </button>
                    </div>
                </div>
                <div class="col-lg-3 text-lg-end">
                    <button class="btn btn-primary w-100 w-lg-auto" data-bs-toggle="modal" data-bs-target="#createModal">
                        <i class="fas fa-plus me-2"></i> Buat Diskusi Baru
                    </button>
                </div>
            </div>
        </div>
        
        <!-- Discussion List -->
        <div class="discussion-list" id="discussionList">
            <c:choose>
                <c:when test="${not empty discussions}">
                    <c:forEach var="post" items="${discussions}">
                        <a href="${pageContext.request.contextPath}/forum/thread/${post.postId}" class="discussion-card ${post.isPinned ? 'pinned' : ''} ${post.isAnswered ? 'answered' : ''}">
                            <div class="discussion-header">
                                <img src="${not empty post.user.profilePicture ? post.user.profilePicture : 'https://ui-avatars.com/api/?name='.concat(post.user.fullName).concat('&background=8B1538&color=fff')}" 
                                     alt="${post.user.fullName}" class="discussion-avatar">
                                <div class="discussion-info">
                                    <h3 class="discussion-title">
                                        <c:if test="${post.isPinned}">
                                            <i class="fas fa-thumbtack text-warning me-1" title="Pinned"></i>
                                        </c:if>
                                        ${post.title}
                                    </h3>
                                    <div class="discussion-meta">
                                        <span class="fw-medium">${post.user.fullName}</span>
                                        <c:if test="${post.user.role == 'LECTURER'}">
                                            <span class="badge-instructor"><i class="fas fa-chalkboard-teacher me-1"></i>Pengajar</span>
                                        </c:if>
                                        <span>•</span>
                                        <span><fmt:formatDate value="${post.createdAt}" pattern="dd MMM yyyy, HH:mm"/></span>
                                        <c:if test="${post.isAnswered}">
                                            <span class="badge-answered"><i class="fas fa-check me-1"></i>Terjawab</span>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            
                            <p class="discussion-excerpt">${post.contentPreview}</p>
                            
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="discussion-stats">
                                    <span class="discussion-stat">
                                        <i class="fas fa-arrow-up"></i> ${post.upvoteCount}
                                    </span>
                                    <span class="discussion-stat">
                                        <i class="fas fa-comment"></i> ${post.replyCount}
                                    </span>
                                    <span class="discussion-stat">
                                        <i class="fas fa-eye"></i> ${post.viewCount}
                                    </span>
                                </div>
                                
                                <c:if test="${not empty post.tags}">
                                    <div class="discussion-tags d-none d-md-flex">
                                        <c:forEach var="tag" items="${post.tags}" end="2">
                                            <span class="discussion-tag">${tag}</span>
                                        </c:forEach>
                                    </div>
                                </c:if>
                            </div>
                        </a>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-state-icon">
                            <i class="fas fa-comments fa-3x text-muted"></i>
                        </div>
                        <h4 class="fw-bold mb-2">Belum Ada Diskusi</h4>
                        <p class="text-muted mb-4">Jadilah yang pertama memulai diskusi di forum ini!</p>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createModal">
                            <i class="fas fa-plus me-2"></i> Buat Diskusi Baru
                        </button>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- Pagination -->
        <c:if test="${totalPages > 1}">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="?page=${currentPage - 1}&sort=${param.sort}&q=${param.q}">
                            <i class="fas fa-chevron-left"></i>
                        </a>
                    </li>
                    
                    <c:forEach begin="1" end="${totalPages}" var="page">
                        <c:if test="${page == 1 || page == totalPages || (page >= currentPage - 2 && page <= currentPage + 2)}">
                            <li class="page-item ${page == currentPage ? 'active' : ''}">
                                <a class="page-link" href="?page=${page}&sort=${param.sort}&q=${param.q}">${page}</a>
                            </li>
                        </c:if>
                    </c:forEach>
                    
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="?page=${currentPage + 1}&sort=${param.sort}&q=${param.q}">
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </main>
    
    <!-- Create Discussion Modal -->
    <div class="modal fade" id="createModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold">
                        <i class="fas fa-plus-circle text-primary me-2"></i>
                        Buat Diskusi Baru
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/forum/create" method="POST" id="createForm">
                    <input type="hidden" name="courseId" value="${course.courseId}">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Judul Diskusi <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="title" required 
                                   placeholder="Masukkan judul diskusi yang jelas dan deskriptif">
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Kategori</label>
                            <select class="form-select" name="category">
                                <option value="">Pilih Kategori (Opsional)</option>
                                <option value="question">Pertanyaan</option>
                                <option value="discussion">Diskusi Umum</option>
                                <option value="feedback">Feedback</option>
                                <option value="bug">Bug/Masalah</option>
                            </select>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Isi Diskusi <span class="text-danger">*</span></label>
                            <textarea class="form-control" name="content" rows="6" required
                                      placeholder="Jelaskan pertanyaan atau topik diskusi Anda secara detail..."></textarea>
                            <div class="form-text">Markdown didukung untuk formatting</div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Tags</label>
                            <input type="text" class="form-control" name="tags" 
                                   placeholder="Pisahkan dengan koma, contoh: javascript, react, hooks">
                        </div>
                        
                        <div class="alert alert-info mb-0">
                            <i class="fas fa-lightbulb me-2"></i>
                            <strong>Tips:</strong> Berikan judul yang jelas dan deskripsi yang lengkap agar pertanyaan Anda lebih mudah dijawab.
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Batal</button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-paper-plane me-2"></i> Kirim Diskusi
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Sort tabs
        document.querySelectorAll('.sort-tab').forEach(tab => {
            tab.addEventListener('click', function() {
                const sort = this.dataset.sort;
                const url = new URL(window.location);
                url.searchParams.set('sort', sort);
                url.searchParams.set('page', '1');
                window.location = url;
            });
        });
        
        // Search
        let searchTimeout;
        document.getElementById('searchInput').addEventListener('input', function() {
            clearTimeout(searchTimeout);
            searchTimeout = setTimeout(() => {
                const url = new URL(window.location);
                url.searchParams.set('q', this.value);
                url.searchParams.set('page', '1');
                window.location = url;
            }, 500);
        });
        
        // Form validation
        document.getElementById('createForm').addEventListener('submit', function(e) {
            const title = this.querySelector('[name="title"]').value.trim();
            const content = this.querySelector('[name="content"]').value.trim();
            
            if (title.length < 10) {
                e.preventDefault();
                alert('Judul diskusi minimal 10 karakter');
                return;
            }
            
            if (content.length < 20) {
                e.preventDefault();
                alert('Isi diskusi minimal 20 karakter');
                return;
            }
        });
    </script>
</body>
</html>
