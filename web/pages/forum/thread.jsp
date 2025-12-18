<%-- 
    Document   : thread
    Created on : Dec 18, 2025
    Author     : NusaTech
    Description: Forum Thread View with Replies
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${post.title} - Forum NusaTech</title>
    
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
        
        /* Breadcrumb */
        .breadcrumb-wrapper {
            background: white;
            border-bottom: 1px solid #e5e7eb;
            padding: 0.75rem 0;
        }
        
        .breadcrumb {
            margin-bottom: 0;
            font-size: 0.85rem;
        }
        
        .breadcrumb a {
            color: #6b7280;
            text-decoration: none;
        }
        
        .breadcrumb a:hover {
            color: var(--primary);
        }
        
        /* Main Post */
        .main-post {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            margin-bottom: 1.5rem;
            overflow: hidden;
        }
        
        .main-post.pinned {
            border-top: 4px solid var(--secondary);
        }
        
        .main-post.answered {
            border-top: 4px solid #10b981;
        }
        
        .post-header {
            padding: 1.5rem;
            border-bottom: 1px solid #e5e7eb;
        }
        
        .post-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 1rem;
            line-height: 1.4;
        }
        
        .post-meta {
            display: flex;
            align-items: center;
            gap: 1rem;
            flex-wrap: wrap;
        }
        
        .post-author {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .post-author-avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            object-fit: cover;
        }
        
        .post-author-name {
            font-weight: 600;
            color: #1f2937;
        }
        
        .post-author-role {
            font-size: 0.8rem;
            color: #6b7280;
        }
        
        .badge-instructor {
            background: rgba(139, 21, 56, 0.15);
            color: var(--primary);
            font-size: 0.7rem;
            padding: 0.25rem 0.5rem;
            border-radius: 999px;
        }
        
        .badge-answered {
            background: rgba(16, 185, 129, 0.15);
            color: #059669;
            font-size: 0.75rem;
            padding: 0.3rem 0.6rem;
            border-radius: 999px;
        }
        
        .badge-pinned {
            background: rgba(212, 168, 75, 0.15);
            color: #b8860b;
            font-size: 0.75rem;
            padding: 0.3rem 0.6rem;
            border-radius: 999px;
        }
        
        .post-date {
            font-size: 0.85rem;
            color: #9ca3af;
        }
        
        /* Post Content */
        .post-body {
            padding: 1.5rem;
        }
        
        .post-content {
            font-size: 1rem;
            line-height: 1.8;
            color: #374151;
        }
        
        .post-content p {
            margin-bottom: 1rem;
        }
        
        .post-content pre {
            background: #1f2937;
            color: #e5e7eb;
            padding: 1rem;
            border-radius: 0.5rem;
            overflow-x: auto;
            margin: 1rem 0;
        }
        
        .post-content code {
            background: #f1f5f9;
            padding: 0.2em 0.4em;
            border-radius: 0.25rem;
            font-size: 0.9em;
            color: #be185d;
        }
        
        .post-content pre code {
            background: none;
            color: inherit;
            padding: 0;
        }
        
        .post-content img {
            max-width: 100%;
            border-radius: 0.5rem;
        }
        
        .post-content blockquote {
            border-left: 4px solid var(--primary);
            padding: 0.5rem 1rem;
            margin: 1rem 0;
            background: #f9fafb;
            color: #6b7280;
        }
        
        .post-tags {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
            margin-top: 1.5rem;
            padding-top: 1rem;
            border-top: 1px solid #e5e7eb;
        }
        
        .post-tag {
            padding: 0.35rem 0.75rem;
            background: #f1f5f9;
            border-radius: 999px;
            font-size: 0.8rem;
            color: #4b5563;
        }
        
        /* Post Actions */
        .post-actions {
            padding: 1rem 1.5rem;
            background: #f9fafb;
            border-top: 1px solid #e5e7eb;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 1rem;
            flex-wrap: wrap;
        }
        
        .action-buttons {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }
        
        .btn-vote {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 999px;
            border: 2px solid #e5e7eb;
            background: white;
            color: #6b7280;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .btn-vote:hover {
            border-color: var(--primary);
            color: var(--primary);
        }
        
        .btn-vote.voted {
            background: var(--primary);
            border-color: var(--primary);
            color: white;
        }
        
        .btn-action {
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            border: none;
            background: transparent;
            color: #6b7280;
            font-size: 0.85rem;
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .btn-action:hover {
            background: #e5e7eb;
            color: #374151;
        }
        
        /* Replies Section */
        .replies-section {
            margin-top: 2rem;
        }
        
        .replies-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1rem;
        }
        
        .replies-count {
            font-weight: 700;
            font-size: 1.1rem;
            color: #1f2937;
        }
        
        /* Reply Card */
        .reply-card {
            background: white;
            border-radius: 1rem;
            padding: 1.25rem;
            margin-bottom: 1rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            border: 1px solid #e5e7eb;
        }
        
        .reply-card.is-answer {
            border: 2px solid #10b981;
            background: linear-gradient(135deg, rgba(16, 185, 129, 0.05) 0%, white 100%);
        }
        
        .reply-card.is-answer::before {
            content: '✓ Jawaban Terbaik';
            display: inline-block;
            background: #10b981;
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 999px;
            font-size: 0.75rem;
            font-weight: 600;
            margin-bottom: 0.75rem;
        }
        
        .reply-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1rem;
        }
        
        .reply-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }
        
        .reply-author-name {
            font-weight: 600;
            color: #1f2937;
            font-size: 0.95rem;
        }
        
        .reply-date {
            font-size: 0.8rem;
            color: #9ca3af;
        }
        
        .reply-content {
            color: #374151;
            line-height: 1.7;
            font-size: 0.95rem;
        }
        
        .reply-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-top: 1rem;
            padding-top: 0.75rem;
            border-top: 1px solid #f3f4f6;
        }
        
        .reply-vote {
            display: flex;
            align-items: center;
            gap: 0.35rem;
            color: #9ca3af;
            font-size: 0.85rem;
            cursor: pointer;
            transition: color 0.2s;
        }
        
        .reply-vote:hover {
            color: var(--primary);
        }
        
        .reply-vote.voted {
            color: var(--primary);
        }
        
        /* Nested Replies */
        .nested-replies {
            margin-left: 2.5rem;
            padding-left: 1rem;
            border-left: 2px solid #e5e7eb;
        }
        
        .nested-replies .reply-card {
            margin-bottom: 0.75rem;
            padding: 1rem;
        }
        
        /* Reply Form */
        .reply-form-card {
            background: white;
            border-radius: 1rem;
            padding: 1.5rem;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            margin-top: 1.5rem;
        }
        
        .reply-form-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1rem;
        }
        
        .reply-form-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }
        
        .reply-textarea {
            border: 1px solid #e5e7eb;
            border-radius: 0.75rem;
            padding: 1rem;
            width: 100%;
            min-height: 120px;
            resize: vertical;
            font-family: inherit;
        }
        
        .reply-textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(139, 21, 56, 0.1);
        }
        
        .reply-form-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 1rem;
        }
        
        /* Instructor Actions */
        .instructor-actions {
            background: #fffbeb;
            border: 1px solid #fef3c7;
            border-radius: 0.75rem;
            padding: 1rem;
            margin-bottom: 1.5rem;
        }
        
        .instructor-actions-title {
            font-weight: 600;
            color: #92400e;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }
        
        /* Sidebar */
        .sidebar-card {
            background: white;
            border-radius: 1rem;
            padding: 1.25rem;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            margin-bottom: 1rem;
        }
        
        .sidebar-title {
            font-weight: 700;
            font-size: 0.9rem;
            color: #1f2937;
            margin-bottom: 1rem;
            padding-bottom: 0.75rem;
            border-bottom: 1px solid #e5e7eb;
        }
        
        .related-thread {
            display: block;
            padding: 0.75rem 0;
            border-bottom: 1px solid #f3f4f6;
            text-decoration: none;
            color: #374151;
            font-size: 0.9rem;
            transition: color 0.2s;
        }
        
        .related-thread:last-child {
            border-bottom: none;
        }
        
        .related-thread:hover {
            color: var(--primary);
        }
        
        /* Responsive */
        @media (max-width: 991.98px) {
            .nested-replies {
                margin-left: 1rem;
            }
        }
        
        @media (max-width: 767.98px) {
            .post-title {
                font-size: 1.25rem;
            }
            
            .post-meta {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .action-buttons {
                width: 100%;
                justify-content: flex-start;
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
                <c:if test="${not empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/student/dashboard" class="btn btn-sm btn-outline-secondary">
                        <i class="fas fa-user me-1"></i> Dashboard
                    </a>
                </c:if>
            </div>
        </div>
    </nav>
    
    <!-- Breadcrumb -->
    <div class="breadcrumb-wrapper">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb" style="--bs-breadcrumb-divider: '›';">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/course/${course.slug}">${course.title}</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/forum/${course.courseId}">Forum</a></li>
                    <li class="breadcrumb-item active text-truncate" style="max-width: 200px;">${post.title}</li>
                </ol>
            </nav>
        </div>
    </div>
    
    <main class="container py-4">
        <div class="row">
            <!-- Main Content -->
            <div class="col-lg-8">
                <!-- Main Post -->
                <article class="main-post ${post.isPinned ? 'pinned' : ''} ${post.isAnswered ? 'answered' : ''}">
                    <div class="post-header">
                        <h1 class="post-title">
                            <c:if test="${post.isPinned}">
                                <i class="fas fa-thumbtack text-warning me-2" title="Pinned"></i>
                            </c:if>
                            ${post.title}
                        </h1>
                        
                        <div class="post-meta">
                            <div class="post-author">
                                <img src="${not empty post.user.profilePicture ? post.user.profilePicture : 'https://ui-avatars.com/api/?name='.concat(post.user.fullName).concat('&background=8B1538&color=fff')}" 
                                     alt="${post.user.fullName}" class="post-author-avatar">
                                <div>
                                    <div class="post-author-name">
                                        ${post.user.fullName}
                                        <c:if test="${post.user.role == 'LECTURER'}">
                                            <span class="badge-instructor ms-1"><i class="fas fa-chalkboard-teacher me-1"></i>Pengajar</span>
                                        </c:if>
                                    </div>
                                    <div class="post-author-role">${post.user.role == 'LECTURER' ? 'Pengajar Kursus' : 'Peserta'}</div>
                                </div>
                            </div>
                            
                            <div class="d-flex align-items-center gap-2 flex-wrap">
                                <span class="post-date">
                                    <i class="far fa-clock me-1"></i>
                                    <fmt:formatDate value="${post.createdAt}" pattern="dd MMMM yyyy, HH:mm"/>
                                </span>
                                <c:if test="${post.isAnswered}">
                                    <span class="badge-answered"><i class="fas fa-check me-1"></i>Terjawab</span>
                                </c:if>
                                <c:if test="${post.isPinned}">
                                    <span class="badge-pinned"><i class="fas fa-thumbtack me-1"></i>Disematkan</span>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    
                    <div class="post-body">
                        <div class="post-content">
                            ${post.content}
                        </div>
                        
                        <c:if test="${not empty post.tags}">
                            <div class="post-tags">
                                <c:forEach var="tag" items="${post.tags}">
                                    <span class="post-tag">${tag}</span>
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>
                    
                    <div class="post-actions">
                        <div class="action-buttons">
                            <button class="btn-vote ${post.userUpvoted ? 'voted' : ''}" onclick="upvote(${post.postId}, this)">
                                <i class="fas fa-arrow-up"></i>
                                <span class="vote-count">${post.upvoteCount}</span>
                            </button>
                            <button class="btn-action" onclick="scrollToReply()">
                                <i class="fas fa-reply me-1"></i> Balas
                            </button>
                            <button class="btn-action" onclick="sharePost()">
                                <i class="fas fa-share me-1"></i> Bagikan
                            </button>
                            <c:if test="${sessionScope.user.userId == post.user.userId}">
                                <button class="btn-action" onclick="editPost(${post.postId})">
                                    <i class="fas fa-edit me-1"></i> Edit
                                </button>
                            </c:if>
                        </div>
                        
                        <div class="d-flex align-items-center gap-3 text-muted small">
                            <span><i class="fas fa-eye me-1"></i> ${post.viewCount} views</span>
                            <span><i class="fas fa-comment me-1"></i> ${replies.size()} balasan</span>
                        </div>
                    </div>
                </article>
                
                <!-- Instructor Actions (shown to course instructor) -->
                <c:if test="${isInstructor && !post.isAnswered}">
                    <div class="instructor-actions">
                        <div class="instructor-actions-title">
                            <i class="fas fa-user-shield me-1"></i> Aksi Pengajar
                        </div>
                        <div class="d-flex gap-2 flex-wrap">
                            <button class="btn btn-sm btn-outline-warning" onclick="togglePin(${post.postId})">
                                <i class="fas fa-thumbtack me-1"></i> ${post.isPinned ? 'Lepas Pin' : 'Pin Diskusi'}
                            </button>
                        </div>
                    </div>
                </c:if>
                
                <!-- Replies Section -->
                <section class="replies-section">
                    <div class="replies-header">
                        <span class="replies-count">
                            <i class="fas fa-comments me-2"></i>${replies.size()} Balasan
                        </span>
                        <select class="form-select form-select-sm" style="width: auto;" onchange="sortReplies(this.value)">
                            <option value="newest">Terbaru</option>
                            <option value="oldest">Terlama</option>
                            <option value="popular">Terpopuler</option>
                        </select>
                    </div>
                    
                    <c:forEach var="reply" items="${replies}">
                        <div class="reply-card ${reply.isAnswer ? 'is-answer' : ''}" id="reply-${reply.postId}">
                            <div class="reply-header">
                                <img src="${not empty reply.user.profilePicture ? reply.user.profilePicture : 'https://ui-avatars.com/api/?name='.concat(reply.user.fullName).concat('&background=8B1538&color=fff')}" 
                                     alt="${reply.user.fullName}" class="reply-avatar">
                                <div>
                                    <div class="reply-author-name">
                                        ${reply.user.fullName}
                                        <c:if test="${reply.user.role == 'LECTURER'}">
                                            <span class="badge-instructor ms-1"><i class="fas fa-chalkboard-teacher"></i> Pengajar</span>
                                        </c:if>
                                    </div>
                                    <div class="reply-date">
                                        <fmt:formatDate value="${reply.createdAt}" pattern="dd MMM yyyy, HH:mm"/>
                                        <c:if test="${reply.isEdited}">
                                            <span class="text-muted">(diedit)</span>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="reply-content">
                                ${reply.content}
                            </div>
                            
                            <div class="reply-actions">
                                <span class="reply-vote ${reply.userUpvoted ? 'voted' : ''}" onclick="upvote(${reply.postId}, this)">
                                    <i class="fas fa-arrow-up"></i>
                                    <span class="vote-count">${reply.upvoteCount}</span>
                                </span>
                                <span class="reply-vote" onclick="replyTo(${reply.postId}, '${reply.user.fullName}')">
                                    <i class="fas fa-reply"></i> Balas
                                </span>
                                
                                <c:if test="${isInstructor && !post.isAnswered && reply.user.userId != post.user.userId}">
                                    <span class="reply-vote text-success" onclick="markAsAnswer(${reply.postId})">
                                        <i class="fas fa-check-circle"></i> Tandai Jawaban
                                    </span>
                                </c:if>
                                
                                <c:if test="${sessionScope.user.userId == reply.user.userId}">
                                    <span class="reply-vote" onclick="editReply(${reply.postId})">
                                        <i class="fas fa-edit"></i> Edit
                                    </span>
                                    <span class="reply-vote text-danger" onclick="deleteReply(${reply.postId})">
                                        <i class="fas fa-trash"></i> Hapus
                                    </span>
                                </c:if>
                            </div>
                            
                            <!-- Nested Replies -->
                            <c:if test="${not empty reply.replies}">
                                <div class="nested-replies">
                                    <c:forEach var="nestedReply" items="${reply.replies}">
                                        <div class="reply-card" id="reply-${nestedReply.postId}">
                                            <div class="reply-header">
                                                <img src="${not empty nestedReply.user.profilePicture ? nestedReply.user.profilePicture : 'https://ui-avatars.com/api/?name='.concat(nestedReply.user.fullName).concat('&background=8B1538&color=fff')}" 
                                                     alt="${nestedReply.user.fullName}" class="reply-avatar">
                                                <div>
                                                    <div class="reply-author-name">
                                                        ${nestedReply.user.fullName}
                                                        <c:if test="${nestedReply.user.role == 'LECTURER'}">
                                                            <span class="badge-instructor ms-1"><i class="fas fa-chalkboard-teacher"></i></span>
                                                        </c:if>
                                                    </div>
                                                    <div class="reply-date">
                                                        <fmt:formatDate value="${nestedReply.createdAt}" pattern="dd MMM yyyy, HH:mm"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="reply-content">
                                                ${nestedReply.content}
                                            </div>
                                            <div class="reply-actions">
                                                <span class="reply-vote ${nestedReply.userUpvoted ? 'voted' : ''}" onclick="upvote(${nestedReply.postId}, this)">
                                                    <i class="fas fa-arrow-up"></i>
                                                    <span class="vote-count">${nestedReply.upvoteCount}</span>
                                                </span>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </div>
                    </c:forEach>
                    
                    <c:if test="${empty replies}">
                        <div class="text-center py-4 text-muted">
                            <i class="fas fa-comments fa-3x mb-3 opacity-25"></i>
                            <p>Belum ada balasan. Jadilah yang pertama membalas!</p>
                        </div>
                    </c:if>
                </section>
                
                <!-- Reply Form -->
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <div class="reply-form-card" id="replyForm">
                            <div class="reply-form-header">
                                <img src="${not empty sessionScope.user.profilePicture ? sessionScope.user.profilePicture : 'https://ui-avatars.com/api/?name='.concat(sessionScope.user.fullName).concat('&background=8B1538&color=fff')}" 
                                     alt="${sessionScope.user.fullName}" class="reply-form-avatar">
                                <div>
                                    <span class="fw-medium">${sessionScope.user.fullName}</span>
                                    <div class="small text-muted">Menulis balasan...</div>
                                </div>
                            </div>
                            
                            <form action="${pageContext.request.contextPath}/forum/reply" method="POST">
                                <input type="hidden" name="postId" value="${post.postId}">
                                <input type="hidden" name="parentId" id="parentId" value="">
                                
                                <div id="replyingTo" class="alert alert-light d-none mb-3">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span><i class="fas fa-reply me-1"></i> Membalas <strong id="replyingToName"></strong></span>
                                        <button type="button" class="btn-close btn-sm" onclick="cancelReplyTo()"></button>
                                    </div>
                                </div>
                                
                                <textarea class="reply-textarea" name="content" placeholder="Tulis balasan Anda..." required></textarea>
                                
                                <div class="reply-form-actions">
                                    <div class="text-muted small">
                                        <i class="fas fa-info-circle me-1"></i> Markdown didukung
                                    </div>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-paper-plane me-2"></i> Kirim Balasan
                                    </button>
                                </div>
                            </form>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="reply-form-card text-center">
                            <p class="mb-3"><i class="fas fa-lock me-2"></i>Login untuk membalas diskusi ini</p>
                            <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-primary">
                                <i class="fas fa-sign-in-alt me-2"></i> Login
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <!-- Sidebar -->
            <div class="col-lg-4">
                <!-- Course Info -->
                <div class="sidebar-card">
                    <div class="sidebar-title">
                        <i class="fas fa-book-open me-2"></i>Tentang Kursus
                    </div>
                    <a href="${pageContext.request.contextPath}/course/${course.slug}" class="d-flex gap-3 text-decoration-none">
                        <img src="${not empty course.thumbnail ? course.thumbnail : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=80&h=60&fit=crop'}" 
                             alt="${course.title}" class="rounded" style="width: 80px; height: 60px; object-fit: cover;">
                        <div>
                            <div class="fw-medium text-dark">${course.title}</div>
                            <div class="small text-muted">${course.instructor.fullName}</div>
                        </div>
                    </a>
                    <div class="mt-3">
                        <a href="${pageContext.request.contextPath}/learn/${course.slug}" class="btn btn-sm btn-outline-primary w-100">
                            <i class="fas fa-play me-1"></i> Lanjutkan Belajar
                        </a>
                    </div>
                </div>
                
                <!-- Related Threads -->
                <div class="sidebar-card">
                    <div class="sidebar-title">
                        <i class="fas fa-link me-2"></i>Diskusi Terkait
                    </div>
                    <c:forEach var="related" items="${relatedThreads}" end="4">
                        <a href="${pageContext.request.contextPath}/forum/thread/${related.postId}" class="related-thread">
                            <c:if test="${related.isAnswered}">
                                <i class="fas fa-check-circle text-success me-1"></i>
                            </c:if>
                            ${related.title}
                        </a>
                    </c:forEach>
                    <c:if test="${empty relatedThreads}">
                        <p class="text-muted small mb-0">Tidak ada diskusi terkait</p>
                    </c:if>
                </div>
                
                <!-- Forum Stats -->
                <div class="sidebar-card">
                    <div class="sidebar-title">
                        <i class="fas fa-chart-bar me-2"></i>Statistik Forum
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Total Diskusi</span>
                        <span class="fw-medium">${forumStats.totalDiscussions}</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Terjawab</span>
                        <span class="fw-medium text-success">${forumStats.answeredCount}</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Partisipan</span>
                        <span class="fw-medium">${forumStats.participantsCount}</span>
                    </div>
                    <div class="d-flex justify-content-between">
                        <span class="text-muted">Waktu Respon Rata-rata</span>
                        <span class="fw-medium">${forumStats.avgResponseTime}</span>
                    </div>
                </div>
            </div>
        </div>
    </main>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Upvote
        function upvote(postId, btn) {
            fetch('${pageContext.request.contextPath}/forum/upvote/' + postId, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    btn.classList.toggle('voted');
                    btn.querySelector('.vote-count').textContent = data.upvoteCount;
                } else if (data.message === 'login_required') {
                    window.location = '${pageContext.request.contextPath}/auth/login';
                }
            });
        }
        
        // Reply to specific post
        function replyTo(postId, userName) {
            document.getElementById('parentId').value = postId;
            document.getElementById('replyingTo').classList.remove('d-none');
            document.getElementById('replyingToName').textContent = userName;
            document.querySelector('.reply-textarea').focus();
            scrollToReply();
        }
        
        function cancelReplyTo() {
            document.getElementById('parentId').value = '';
            document.getElementById('replyingTo').classList.add('d-none');
        }
        
        function scrollToReply() {
            document.getElementById('replyForm').scrollIntoView({ behavior: 'smooth', block: 'center' });
            document.querySelector('.reply-textarea').focus();
        }
        
        // Mark as answer (for instructor)
        function markAsAnswer(replyId) {
            if (confirm('Tandai balasan ini sebagai jawaban terbaik?')) {
                fetch('${pageContext.request.contextPath}/forum/answer/' + replyId, {
                    method: 'POST'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        location.reload();
                    }
                });
            }
        }
        
        // Toggle pin
        function togglePin(postId) {
            fetch('${pageContext.request.contextPath}/forum/pin/' + postId, {
                method: 'POST'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    location.reload();
                }
            });
        }
        
        // Share post
        function sharePost() {
            const url = window.location.href;
            if (navigator.share) {
                navigator.share({
                    title: '${post.title}',
                    url: url
                });
            } else {
                navigator.clipboard.writeText(url).then(() => {
                    alert('Link berhasil disalin!');
                });
            }
        }
        
        // Sort replies
        function sortReplies(order) {
            const url = new URL(window.location);
            url.searchParams.set('sort', order);
            window.location = url;
        }
        
        // Edit post/reply
        function editPost(postId) {
            window.location = '${pageContext.request.contextPath}/forum/edit/' + postId;
        }
        
        function editReply(replyId) {
            // Implementation for inline edit
            alert('Fitur edit akan segera tersedia');
        }
        
        function deleteReply(replyId) {
            if (confirm('Apakah Anda yakin ingin menghapus balasan ini?')) {
                fetch('${pageContext.request.contextPath}/forum/delete/' + replyId, {
                    method: 'POST'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        document.getElementById('reply-' + replyId).remove();
                    }
                });
            }
        }
    </script>
</body>
</html>
