<%-- 
    Document   : material
    Created on : Dec 18, 2025
    Author     : NusaTech
    Description: Material Viewer - Video, Text, PDF Content
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .material-container {
        background: white;
        border-radius: 1rem;
        overflow: hidden;
        box-shadow: 0 2px 12px rgba(0,0,0,0.08);
    }
    
    /* Video Player */
    .video-wrapper {
        position: relative;
        padding-bottom: 56.25%; /* 16:9 */
        height: 0;
        overflow: hidden;
        background: #000;
    }
    
    .video-wrapper iframe,
    .video-wrapper video {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
    }
    
    /* YouTube Player */
    .youtube-player {
        aspect-ratio: 16/9;
        width: 100%;
        border: none;
    }
    
    /* Text Content */
    .text-content {
        padding: 2rem;
        font-size: 1.05rem;
        line-height: 1.8;
        color: #374151;
    }
    
    .text-content h1, .text-content h2, .text-content h3, 
    .text-content h4, .text-content h5, .text-content h6 {
        color: #1f2937;
        margin-top: 1.5em;
        margin-bottom: 0.75em;
    }
    
    .text-content h1 { font-size: 2rem; }
    .text-content h2 { font-size: 1.5rem; }
    .text-content h3 { font-size: 1.25rem; }
    
    .text-content p {
        margin-bottom: 1.25rem;
    }
    
    .text-content ul, .text-content ol {
        margin-bottom: 1.25rem;
        padding-left: 1.5rem;
    }
    
    .text-content li {
        margin-bottom: 0.5rem;
    }
    
    .text-content code {
        background: #f1f5f9;
        padding: 0.2em 0.4em;
        border-radius: 0.25rem;
        font-size: 0.9em;
        color: #be185d;
    }
    
    .text-content pre {
        background: #1f2937;
        color: #e5e7eb;
        padding: 1rem 1.5rem;
        border-radius: 0.5rem;
        overflow-x: auto;
        margin: 1.5rem 0;
    }
    
    .text-content pre code {
        background: none;
        padding: 0;
        color: inherit;
    }
    
    .text-content blockquote {
        border-left: 4px solid var(--primary);
        margin: 1.5rem 0;
        padding: 0.5rem 1.5rem;
        background: #fef3f5;
        color: #6b7280;
    }
    
    .text-content img {
        max-width: 100%;
        height: auto;
        border-radius: 0.5rem;
        margin: 1rem 0;
    }
    
    .text-content table {
        width: 100%;
        border-collapse: collapse;
        margin: 1.5rem 0;
    }
    
    .text-content th, .text-content td {
        border: 1px solid #e5e7eb;
        padding: 0.75rem;
        text-align: left;
    }
    
    .text-content th {
        background: #f8f9fa;
        font-weight: 600;
    }
    
    /* PDF Viewer */
    .pdf-wrapper {
        background: #4b5563;
        min-height: 600px;
        display: flex;
        flex-direction: column;
    }
    
    .pdf-toolbar {
        background: #374151;
        padding: 0.75rem 1rem;
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 1rem;
    }
    
    .pdf-toolbar-btn {
        background: rgba(255,255,255,0.1);
        border: none;
        color: white;
        width: 36px;
        height: 36px;
        border-radius: 0.375rem;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: background 0.2s;
    }
    
    .pdf-toolbar-btn:hover {
        background: rgba(255,255,255,0.2);
    }
    
    .pdf-embed {
        flex: 1;
        width: 100%;
        min-height: 600px;
        border: none;
    }
    
    /* Material Info */
    .material-info-section {
        padding: 1.5rem 2rem;
        border-top: 1px solid #e5e7eb;
    }
    
    .material-title {
        font-size: 1.25rem;
        font-weight: 700;
        color: #1f2937;
        margin-bottom: 0.5rem;
    }
    
    .material-meta {
        display: flex;
        align-items: center;
        gap: 1.5rem;
        font-size: 0.875rem;
        color: #6b7280;
        flex-wrap: wrap;
    }
    
    .material-description {
        margin-top: 1rem;
        color: #4b5563;
        line-height: 1.7;
    }
    
    /* Attachments */
    .attachments-section {
        padding: 1.5rem 2rem;
        border-top: 1px solid #e5e7eb;
        background: #f9fafb;
    }
    
    .attachment-item {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        padding: 0.75rem 1rem;
        background: white;
        border-radius: 0.5rem;
        text-decoration: none;
        color: #374151;
        transition: all 0.2s;
        margin-bottom: 0.5rem;
    }
    
    .attachment-item:hover {
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        transform: translateY(-1px);
        color: #1f2937;
    }
    
    .attachment-icon {
        width: 40px;
        height: 40px;
        border-radius: 0.5rem;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1rem;
    }
    
    .attachment-icon.pdf { background: #fef2f2; color: #ef4444; }
    .attachment-icon.doc { background: #eff6ff; color: #3b82f6; }
    .attachment-icon.zip { background: #f0fdf4; color: #22c55e; }
    .attachment-icon.other { background: #f8fafc; color: #64748b; }
    
    .attachment-info {
        flex: 1;
        min-width: 0;
    }
    
    .attachment-name {
        font-weight: 500;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    
    .attachment-size {
        font-size: 0.75rem;
        color: #9ca3af;
    }
    
    /* Discussion Link */
    .discussion-section {
        padding: 1.5rem 2rem;
        border-top: 1px solid #e5e7eb;
    }
    
    .discussion-link {
        display: flex;
        align-items: center;
        gap: 1rem;
        padding: 1rem 1.25rem;
        background: linear-gradient(135deg, #f0f9ff 0%, #f8fafc 100%);
        border-radius: 0.75rem;
        text-decoration: none;
        color: #1f2937;
        transition: all 0.2s;
    }
    
    .discussion-link:hover {
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }
    
    .discussion-icon {
        width: 48px;
        height: 48px;
        background: white;
        border-radius: 0.75rem;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.25rem;
        color: var(--primary);
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    }
    
    /* Complete Status Banner */
    .complete-banner {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
        padding: 0.75rem;
        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
        color: white;
        font-weight: 500;
    }
    
    /* Free Preview Badge */
    .free-preview-badge {
        display: inline-flex;
        align-items: center;
        gap: 0.25rem;
        padding: 0.25rem 0.75rem;
        background: #fef3c7;
        color: #d97706;
        font-size: 0.75rem;
        font-weight: 600;
        border-radius: 999px;
    }
</style>

<div class="material-container">
    <!-- Complete Status Banner -->
    <c:if test="${currentMaterial.isCompleted}">
        <div class="complete-banner">
            <i class="fas fa-check-circle"></i>
            <span>Materi ini sudah selesai</span>
        </div>
    </c:if>
    
    <!-- Content Based on Type -->
    <c:choose>
        <%-- VIDEO CONTENT --%>
        <c:when test="${currentMaterial.contentType == 'VIDEO'}">
            <div class="video-wrapper">
                <c:choose>
                    <c:when test="${currentMaterial.contentUrl.contains('youtube.com') || currentMaterial.contentUrl.contains('youtu.be')}">
                        <c:set var="videoId" value="${currentMaterial.youtubeVideoId}" />
                        <iframe class="youtube-player" 
                                src="https://www.youtube.com/embed/${videoId}?rel=0&modestbranding=1" 
                                title="${currentMaterial.title}"
                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                                allowfullscreen></iframe>
                    </c:when>
                    <c:when test="${currentMaterial.contentUrl.contains('vimeo.com')}">
                        <c:set var="vimeoId" value="${currentMaterial.vimeoVideoId}" />
                        <iframe src="https://player.vimeo.com/video/${vimeoId}?dnt=1" 
                                title="${currentMaterial.title}"
                                allow="autoplay; fullscreen; picture-in-picture" 
                                allowfullscreen></iframe>
                    </c:when>
                    <c:otherwise>
                        <video controls preload="metadata" id="videoPlayer">
                            <source src="${currentMaterial.contentUrl}" type="video/mp4">
                            Browser Anda tidak mendukung video player.
                        </video>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:when>
        
        <%-- TEXT CONTENT --%>
        <c:when test="${currentMaterial.contentType == 'TEXT'}">
            <div class="text-content">
                ${currentMaterial.content}
            </div>
        </c:when>
        
        <%-- PDF CONTENT --%>
        <c:when test="${currentMaterial.contentType == 'PDF'}">
            <div class="pdf-wrapper">
                <div class="pdf-toolbar">
                    <div class="d-flex align-items-center gap-2">
                        <span class="text-white-50 small">
                            <i class="fas fa-file-pdf me-1"></i> ${currentMaterial.title}
                        </span>
                    </div>
                    <div class="d-flex gap-2">
                        <button class="pdf-toolbar-btn" onclick="zoomOut()" title="Perkecil">
                            <i class="fas fa-search-minus"></i>
                        </button>
                        <button class="pdf-toolbar-btn" onclick="zoomIn()" title="Perbesar">
                            <i class="fas fa-search-plus"></i>
                        </button>
                        <a href="${currentMaterial.contentUrl}" target="_blank" class="pdf-toolbar-btn" title="Buka di Tab Baru">
                            <i class="fas fa-external-link-alt"></i>
                        </a>
                        <a href="${currentMaterial.contentUrl}" download class="pdf-toolbar-btn" title="Download">
                            <i class="fas fa-download"></i>
                        </a>
                    </div>
                </div>
                <iframe src="${currentMaterial.contentUrl}#toolbar=0&navpanes=0" 
                        class="pdf-embed" 
                        id="pdfViewer"
                        title="${currentMaterial.title}"></iframe>
            </div>
        </c:when>
        
        <%-- QUIZ CONTENT - Redirect to Quiz Page --%>
        <c:when test="${currentMaterial.contentType == 'QUIZ'}">
            <div class="text-center py-5">
                <div class="mb-4">
                    <div class="d-inline-flex align-items-center justify-content-center rounded-circle" 
                         style="width: 100px; height: 100px; background: rgba(139, 21, 56, 0.1);">
                        <i class="fas fa-question fa-3x" style="color: var(--primary);"></i>
                    </div>
                </div>
                <h3 class="fw-bold mb-2">${currentMaterial.title}</h3>
                <p class="text-muted mb-4">Uji pemahaman Anda dengan mengerjakan quiz ini</p>
                
                <c:if test="${not empty quiz}">
                    <div class="d-flex justify-content-center gap-4 mb-4 flex-wrap">
                        <div class="text-center">
                            <div class="fw-bold text-primary fs-4">${quiz.questionCount}</div>
                            <div class="small text-muted">Pertanyaan</div>
                        </div>
                        <div class="text-center">
                            <div class="fw-bold text-primary fs-4">${quiz.passingScore}%</div>
                            <div class="small text-muted">Nilai Minimal</div>
                        </div>
                        <c:if test="${quiz.timeLimit > 0}">
                            <div class="text-center">
                                <div class="fw-bold text-primary fs-4">${quiz.timeLimit}</div>
                                <div class="small text-muted">Menit</div>
                            </div>
                        </c:if>
                    </div>
                </c:if>
                
                <a href="${pageContext.request.contextPath}/learn/${course.slug}/quiz/${currentMaterial.quizId}" class="btn btn-primary btn-lg">
                    <i class="fas fa-play me-2"></i> Mulai Quiz
                </a>
                
                <c:if test="${not empty lastAttempt}">
                    <div class="alert alert-info mt-4 text-start" style="max-width: 400px; margin: 0 auto;">
                        <div class="d-flex align-items-center gap-2 mb-2">
                            <i class="fas fa-history"></i>
                            <strong>Percobaan Terakhir</strong>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span>Nilai: <strong>${lastAttempt.score}%</strong></span>
                            <span class="badge ${lastAttempt.passed ? 'bg-success' : 'bg-danger'}">
                                ${lastAttempt.passed ? 'Lulus' : 'Tidak Lulus'}
                            </span>
                        </div>
                    </div>
                </c:if>
            </div>
        </c:when>
        
        <%-- DEFAULT/OTHER --%>
        <c:otherwise>
            <div class="text-center py-5">
                <i class="fas fa-file fa-4x text-muted mb-3"></i>
                <p class="text-muted">Tipe konten tidak didukung</p>
            </div>
        </c:otherwise>
    </c:choose>
    
    <!-- Material Info Section -->
    <div class="material-info-section">
        <div class="d-flex justify-content-between align-items-start flex-wrap gap-2">
            <h1 class="material-title">${currentMaterial.title}</h1>
            <c:if test="${currentMaterial.isFreePreview}">
                <span class="free-preview-badge">
                    <i class="fas fa-eye"></i> Preview Gratis
                </span>
            </c:if>
        </div>
        
        <div class="material-meta">
            <span>
                <i class="fas fa-${currentMaterial.contentType == 'VIDEO' ? 'play-circle' : currentMaterial.contentType == 'TEXT' ? 'file-alt' : currentMaterial.contentType == 'PDF' ? 'file-pdf' : 'file'} me-1"></i>
                ${currentMaterial.contentType}
            </span>
            <c:if test="${currentMaterial.duration > 0}">
                <span><i class="fas fa-clock me-1"></i> ${currentMaterial.duration} menit</span>
            </c:if>
            <c:if test="${not empty currentSection}">
                <span><i class="fas fa-folder me-1"></i> ${currentSection.title}</span>
            </c:if>
        </div>
        
        <c:if test="${not empty currentMaterial.description}">
            <div class="material-description">
                ${currentMaterial.description}
            </div>
        </c:if>
    </div>
    
    <!-- Attachments Section -->
    <c:if test="${not empty attachments && attachments.size() > 0}">
        <div class="attachments-section">
            <h6 class="fw-bold mb-3">
                <i class="fas fa-paperclip me-2"></i> Lampiran (${attachments.size()})
            </h6>
            <c:forEach var="attachment" items="${attachments}">
                <a href="${attachment.url}" download class="attachment-item">
                    <div class="attachment-icon ${attachment.type}">
                        <i class="fas fa-${attachment.type == 'pdf' ? 'file-pdf' : attachment.type == 'doc' ? 'file-word' : attachment.type == 'zip' ? 'file-archive' : 'file'}"></i>
                    </div>
                    <div class="attachment-info">
                        <div class="attachment-name">${attachment.name}</div>
                        <div class="attachment-size">${attachment.size}</div>
                    </div>
                    <i class="fas fa-download text-muted"></i>
                </a>
            </c:forEach>
        </div>
    </c:if>
    
    <!-- Discussion Section -->
    <div class="discussion-section">
        <a href="${pageContext.request.contextPath}/forum/${course.courseId}" class="discussion-link">
            <div class="discussion-icon">
                <i class="fas fa-comments"></i>
            </div>
            <div>
                <div class="fw-bold">Diskusi Kursus</div>
                <div class="text-muted small">Punya pertanyaan? Diskusikan dengan pengajar dan peserta lain</div>
            </div>
            <i class="fas fa-chevron-right ms-auto text-muted"></i>
        </a>
    </div>
</div>

<script>
    // PDF Zoom functions
    let pdfScale = 1;
    
    function zoomIn() {
        pdfScale += 0.1;
        if (pdfScale > 2) pdfScale = 2;
        document.getElementById('pdfViewer').style.transform = `scale(${pdfScale})`;
        document.getElementById('pdfViewer').style.transformOrigin = 'top left';
    }
    
    function zoomOut() {
        pdfScale -= 0.1;
        if (pdfScale < 0.5) pdfScale = 0.5;
        document.getElementById('pdfViewer').style.transform = `scale(${pdfScale})`;
    }
    
    // Track video completion
    document.addEventListener('DOMContentLoaded', function() {
        const videoPlayer = document.getElementById('videoPlayer');
        if (videoPlayer) {
            // Resume from last position if available
            <c:if test="${not empty materialProgress && materialProgress.lastPosition > 0}">
            videoPlayer.currentTime = ${materialProgress.lastPosition};
            </c:if>
            
            // Auto-mark complete when 90% watched
            videoPlayer.addEventListener('timeupdate', function() {
                const percentWatched = (videoPlayer.currentTime / videoPlayer.duration) * 100;
                if (percentWatched >= 90 && !${currentMaterial.isCompleted}) {
                    // Optionally auto-mark complete
                }
            });
        }
        
        // For YouTube player - use YouTube IFrame API for tracking
        // Implementation would require YouTube IFrame API integration
    });
</script>
