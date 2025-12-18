<%-- 
    Document   : quiz
    Created on : Dec 18, 2025
    Author     : NusaTech
    Description: Quiz Interface with Timer, Navigation, and Results
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz: ${quiz.title} - NusaTech</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #8B1538;
            --primary-dark: #6d1029;
            --secondary: #D4A84B;
            --success: #10b981;
            --danger: #ef4444;
        }
        
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #e8ecf1 100%);
            min-height: 100vh;
        }
        
        /* Quiz Header */
        .quiz-header {
            background: white;
            border-bottom: 1px solid #e5e7eb;
            padding: 1rem;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1030;
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .quiz-header-title {
            flex: 1;
            font-weight: 600;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        .quiz-timer {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            background: #fef3c7;
            color: #d97706;
            border-radius: 999px;
            font-weight: 600;
            font-size: 0.9rem;
        }
        
        .quiz-timer.warning {
            background: #fee2e2;
            color: #dc2626;
            animation: pulse 1s infinite;
        }
        
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }
        
        /* Main Container */
        .quiz-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 80px 1rem 2rem;
        }
        
        /* Question Card */
        .question-card {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            margin-bottom: 1.5rem;
            overflow: hidden;
        }
        
        .question-header {
            padding: 1.25rem 1.5rem;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .question-number {
            font-weight: 700;
            font-size: 1.1rem;
        }
        
        .question-points {
            background: rgba(255,255,255,0.2);
            padding: 0.25rem 0.75rem;
            border-radius: 999px;
            font-size: 0.8rem;
        }
        
        .question-body {
            padding: 1.5rem;
        }
        
        .question-text {
            font-size: 1.1rem;
            font-weight: 500;
            color: #1f2937;
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }
        
        .question-image {
            max-width: 100%;
            border-radius: 0.5rem;
            margin-bottom: 1.5rem;
        }
        
        /* Options */
        .option-list {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }
        
        .option-item {
            position: relative;
        }
        
        .option-input {
            position: absolute;
            opacity: 0;
            cursor: pointer;
        }
        
        .option-label {
            display: flex;
            align-items: flex-start;
            gap: 1rem;
            padding: 1rem 1.25rem;
            background: #f8fafc;
            border: 2px solid #e5e7eb;
            border-radius: 0.75rem;
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .option-label:hover {
            background: #f1f5f9;
            border-color: #cbd5e1;
        }
        
        .option-input:checked + .option-label {
            background: rgba(139, 21, 56, 0.08);
            border-color: var(--primary);
        }
        
        .option-marker {
            width: 28px;
            height: 28px;
            border-radius: 50%;
            border: 2px solid #d1d5db;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            font-weight: 600;
            font-size: 0.85rem;
            color: #6b7280;
            transition: all 0.2s;
        }
        
        .option-input:checked + .option-label .option-marker {
            background: var(--primary);
            border-color: var(--primary);
            color: white;
        }
        
        .option-text {
            flex: 1;
            padding-top: 0.2rem;
            line-height: 1.5;
        }
        
        /* True/False Options */
        .tf-options {
            display: flex;
            gap: 1rem;
        }
        
        .tf-option {
            flex: 1;
        }
        
        .tf-label {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.5rem;
            padding: 1.5rem;
            background: #f8fafc;
            border: 2px solid #e5e7eb;
            border-radius: 0.75rem;
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .tf-label:hover {
            background: #f1f5f9;
        }
        
        .option-input:checked + .tf-label {
            border-color: var(--primary);
            background: rgba(139, 21, 56, 0.08);
        }
        
        .tf-icon {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
        }
        
        .tf-icon.true { background: #d1fae5; color: #059669; }
        .tf-icon.false { background: #fee2e2; color: #dc2626; }
        
        .option-input:checked + .tf-label .tf-icon.true {
            background: #059669;
            color: white;
        }
        
        .option-input:checked + .tf-label .tf-icon.false {
            background: #dc2626;
            color: white;
        }
        
        /* Question Navigation */
        .question-nav {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            padding: 1rem;
            background: white;
            border-radius: 1rem;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            margin-bottom: 1.5rem;
        }
        
        .question-nav-title {
            width: 100%;
            font-weight: 600;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
            color: #4b5563;
        }
        
        .question-nav-btn {
            width: 40px;
            height: 40px;
            border-radius: 0.5rem;
            border: 2px solid #e5e7eb;
            background: white;
            font-weight: 600;
            font-size: 0.85rem;
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .question-nav-btn:hover {
            background: #f8fafc;
        }
        
        .question-nav-btn.active {
            background: var(--primary);
            border-color: var(--primary);
            color: white;
        }
        
        .question-nav-btn.answered {
            background: #d1fae5;
            border-color: #059669;
            color: #059669;
        }
        
        .question-nav-btn.flagged {
            border-color: #f59e0b;
            position: relative;
        }
        
        .question-nav-btn.flagged::after {
            content: '';
            position: absolute;
            top: -4px;
            right: -4px;
            width: 12px;
            height: 12px;
            background: #f59e0b;
            border-radius: 50%;
        }
        
        /* Bottom Actions */
        .quiz-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
            background: white;
            border-radius: 1rem;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
        }
        
        .btn-primary { background-color: var(--primary); border-color: var(--primary); }
        .btn-primary:hover { background-color: var(--primary-dark); border-color: var(--primary-dark); }
        .btn-outline-primary { color: var(--primary); border-color: var(--primary); }
        .btn-outline-primary:hover { background-color: var(--primary); border-color: var(--primary); }
        
        .btn-flag {
            background: none;
            border: none;
            color: #9ca3af;
            cursor: pointer;
            padding: 0.5rem;
            transition: color 0.2s;
        }
        
        .btn-flag:hover, .btn-flag.flagged {
            color: #f59e0b;
        }
        
        /* Results Section */
        .results-container {
            text-align: center;
            padding: 2rem;
        }
        
        .results-icon {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
        }
        
        .results-icon.passed {
            background: #d1fae5;
            color: #059669;
        }
        
        .results-icon.failed {
            background: #fee2e2;
            color: #dc2626;
        }
        
        .results-score {
            font-size: 4rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
        }
        
        .results-score.passed { color: var(--success); }
        .results-score.failed { color: var(--danger); }
        
        .results-details {
            display: flex;
            justify-content: center;
            gap: 2rem;
            margin: 2rem 0;
            flex-wrap: wrap;
        }
        
        .results-detail-item {
            text-align: center;
        }
        
        .results-detail-value {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1f2937;
        }
        
        .results-detail-label {
            font-size: 0.85rem;
            color: #6b7280;
        }
        
        /* Review Answer Section */
        .review-answer {
            text-align: left;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid #e5e7eb;
        }
        
        .answer-item {
            padding: 1rem;
            border-radius: 0.75rem;
            margin-bottom: 1rem;
        }
        
        .answer-item.correct {
            background: #d1fae5;
            border: 1px solid #a7f3d0;
        }
        
        .answer-item.incorrect {
            background: #fee2e2;
            border: 1px solid #fecaca;
        }
        
        .answer-status {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        
        .answer-item.correct .answer-status { color: #059669; }
        .answer-item.incorrect .answer-status { color: #dc2626; }
        
        /* Confirmation Modal */
        .modal-confirm .modal-header {
            border-bottom: none;
            padding-bottom: 0;
        }
        
        .modal-confirm .modal-body {
            text-align: center;
            padding: 2rem;
        }
        
        .modal-confirm-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: #fef3c7;
            color: #d97706;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin-bottom: 1.5rem;
        }
        
        .modal-confirm .modal-footer {
            border-top: none;
            justify-content: center;
            gap: 1rem;
        }
        
        /* Responsive */
        @media (max-width: 767.98px) {
            .quiz-header-title {
                font-size: 0.9rem;
            }
            
            .quiz-timer {
                font-size: 0.8rem;
                padding: 0.4rem 0.75rem;
            }
            
            .question-body {
                padding: 1rem;
            }
            
            .tf-options {
                flex-direction: column;
            }
            
            .results-score {
                font-size: 3rem;
            }
            
            .results-details {
                gap: 1rem;
            }
        }
    </style>
</head>
<body>
    <c:choose>
        <%-- QUIZ RESULTS VIEW --%>
        <c:when test="${showResults}">
            <div class="quiz-header">
                <a href="${pageContext.request.contextPath}/learn/${course.slug}" class="btn btn-sm btn-outline-secondary">
                    <i class="fas fa-arrow-left me-1"></i> Kembali
                </a>
                <span class="quiz-header-title">${quiz.title}</span>
            </div>
            
            <div class="quiz-container">
                <div class="question-card">
                    <div class="results-container">
                        <div class="results-icon ${attempt.passed ? 'passed' : 'failed'}">
                            <i class="fas fa-${attempt.passed ? 'trophy' : 'times-circle'} fa-3x"></i>
                        </div>
                        
                        <h2 class="fw-bold mb-2">
                            ${attempt.passed ? 'Selamat! Anda Lulus!' : 'Belum Berhasil'}
                        </h2>
                        <p class="text-muted mb-4">
                            ${attempt.passed ? 'Anda telah berhasil menyelesaikan quiz ini' : 'Terus semangat! Anda bisa mencoba lagi'}
                        </p>
                        
                        <div class="results-score ${attempt.passed ? 'passed' : 'failed'}">
                            <fmt:formatNumber value="${attempt.score}" maxFractionDigits="0"/>%
                        </div>
                        <p class="text-muted">Nilai minimum: ${quiz.passingScore}%</p>
                        
                        <div class="results-details">
                            <div class="results-detail-item">
                                <div class="results-detail-value text-success">${attempt.correctCount}</div>
                                <div class="results-detail-label">Jawaban Benar</div>
                            </div>
                            <div class="results-detail-item">
                                <div class="results-detail-value text-danger">${attempt.incorrectCount}</div>
                                <div class="results-detail-label">Jawaban Salah</div>
                            </div>
                            <div class="results-detail-item">
                                <div class="results-detail-value">${totalQuestions}</div>
                                <div class="results-detail-label">Total Soal</div>
                            </div>
                            <c:if test="${not empty attempt.duration}">
                                <div class="results-detail-item">
                                    <div class="results-detail-value">${attempt.durationFormatted}</div>
                                    <div class="results-detail-label">Waktu</div>
                                </div>
                            </c:if>
                        </div>
                        
                        <div class="d-flex justify-content-center gap-3 flex-wrap">
                            <a href="${pageContext.request.contextPath}/learn/${course.slug}" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left me-2"></i> Kembali ke Kursus
                            </a>
                            <c:if test="${!attempt.passed && (quiz.maxAttempts == 0 || userAttempts < quiz.maxAttempts)}">
                                <a href="${pageContext.request.contextPath}/learn/${course.slug}/quiz/${quiz.quizId}" class="btn btn-primary">
                                    <i class="fas fa-redo me-2"></i> Coba Lagi
                                </a>
                            </c:if>
                        </div>
                        
                        <c:if test="${quiz.showResults}">
                            <div class="review-answer">
                                <h5 class="fw-bold mb-3"><i class="fas fa-clipboard-check me-2"></i> Pembahasan</h5>
                                
                                <c:forEach var="question" items="${questions}" varStatus="qStatus">
                                    <div class="answer-item ${userAnswers[question.questionId] == question.correctOptionId ? 'correct' : 'incorrect'}">
                                        <div class="answer-status">
                                            <i class="fas fa-${userAnswers[question.questionId] == question.correctOptionId ? 'check-circle' : 'times-circle'}"></i>
                                            Soal ${qStatus.index + 1}
                                        </div>
                                        <div class="fw-medium mb-2">${question.questionText}</div>
                                        <div class="small">
                                            <span class="text-muted">Jawaban Anda:</span> 
                                            <span class="${userAnswers[question.questionId] == question.correctOptionId ? 'text-success' : 'text-danger'}">
                                                ${userAnswerTexts[question.questionId]}
                                            </span>
                                        </div>
                                        <c:if test="${userAnswers[question.questionId] != question.correctOptionId}">
                                            <div class="small">
                                                <span class="text-muted">Jawaban Benar:</span> 
                                                <span class="text-success">${correctAnswerTexts[question.questionId]}</span>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty question.explanation}">
                                            <div class="small mt-2 p-2 bg-light rounded">
                                                <i class="fas fa-lightbulb text-warning me-1"></i> ${question.explanation}
                                            </div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:when>
        
        <%-- QUIZ TAKING VIEW --%>
        <c:otherwise>
            <!-- Quiz Header -->
            <header class="quiz-header">
                <button class="btn btn-sm btn-outline-secondary" onclick="confirmExit()">
                    <i class="fas fa-times"></i>
                </button>
                <span class="quiz-header-title">${quiz.title}</span>
                
                <c:if test="${quiz.timeLimit > 0}">
                    <div class="quiz-timer" id="quizTimer">
                        <i class="fas fa-clock"></i>
                        <span id="timerDisplay">${quiz.timeLimit}:00</span>
                    </div>
                </c:if>
            </header>
            
            <div class="quiz-container">
                <!-- Question Navigation -->
                <div class="question-nav">
                    <div class="question-nav-title">Navigasi Soal</div>
                    <c:forEach var="question" items="${questions}" varStatus="qStatus">
                        <button class="question-nav-btn ${qStatus.index == 0 ? 'active' : ''}" 
                                id="navBtn${qStatus.index}"
                                onclick="goToQuestion(${qStatus.index})"
                                title="Soal ${qStatus.index + 1}">
                            ${qStatus.index + 1}
                        </button>
                    </c:forEach>
                </div>
                
                <!-- Quiz Form -->
                <form id="quizForm" action="${pageContext.request.contextPath}/learn/${course.slug}/quiz/${quiz.quizId}/submit" method="POST">
                    <input type="hidden" name="attemptId" value="${attemptId}">
                    <input type="hidden" name="startTime" value="${startTime}">
                    
                    <c:forEach var="question" items="${questions}" varStatus="qStatus">
                        <div class="question-card" id="question${qStatus.index}" style="${qStatus.index > 0 ? 'display: none;' : ''}">
                            <div class="question-header">
                                <span class="question-number">
                                    Soal ${qStatus.index + 1} dari ${questions.size()}
                                </span>
                                <span class="question-points">
                                    <i class="fas fa-star me-1"></i> ${question.points} poin
                                </span>
                            </div>
                            
                            <div class="question-body">
                                <div class="question-text">${question.questionText}</div>
                                
                                <c:if test="${not empty question.imageUrl}">
                                    <img src="${question.imageUrl}" alt="Question Image" class="question-image">
                                </c:if>
                                
                                <c:choose>
                                    <%-- TRUE/FALSE Question --%>
                                    <c:when test="${question.type == 'TRUE_FALSE'}">
                                        <div class="tf-options">
                                            <div class="tf-option">
                                                <input type="radio" class="option-input" 
                                                       id="q${question.questionId}_true" 
                                                       name="answer_${question.questionId}" 
                                                       value="true"
                                                       onchange="markAnswered(${qStatus.index})">
                                                <label class="tf-label" for="q${question.questionId}_true">
                                                    <div class="tf-icon true">
                                                        <i class="fas fa-check"></i>
                                                    </div>
                                                    <span class="fw-medium">Benar</span>
                                                </label>
                                            </div>
                                            <div class="tf-option">
                                                <input type="radio" class="option-input" 
                                                       id="q${question.questionId}_false" 
                                                       name="answer_${question.questionId}" 
                                                       value="false"
                                                       onchange="markAnswered(${qStatus.index})">
                                                <label class="tf-label" for="q${question.questionId}_false">
                                                    <div class="tf-icon false">
                                                        <i class="fas fa-times"></i>
                                                    </div>
                                                    <span class="fw-medium">Salah</span>
                                                </label>
                                            </div>
                                        </div>
                                    </c:when>
                                    
                                    <%-- MULTIPLE CHOICE Question --%>
                                    <c:otherwise>
                                        <div class="option-list">
                                            <c:forEach var="option" items="${question.options}" varStatus="oStatus">
                                                <div class="option-item">
                                                    <input type="radio" class="option-input" 
                                                           id="q${question.questionId}_${option.optionId}" 
                                                           name="answer_${question.questionId}" 
                                                           value="${option.optionId}"
                                                           onchange="markAnswered(${qStatus.index})">
                                                    <label class="option-label" for="q${question.questionId}_${option.optionId}">
                                                        <span class="option-marker">
                                                            <c:choose>
                                                                <c:when test="${oStatus.index == 0}">A</c:when>
                                                                <c:when test="${oStatus.index == 1}">B</c:when>
                                                                <c:when test="${oStatus.index == 2}">C</c:when>
                                                                <c:when test="${oStatus.index == 3}">D</c:when>
                                                                <c:when test="${oStatus.index == 4}">E</c:when>
                                                                <c:otherwise>${oStatus.index + 1}</c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                        <span class="option-text">${option.optionText}</span>
                                                    </label>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>
                    
                    <!-- Quiz Actions -->
                    <div class="quiz-actions">
                        <button type="button" class="btn btn-outline-secondary" id="prevBtn" onclick="prevQuestion()" disabled>
                            <i class="fas fa-arrow-left me-2"></i> Sebelumnya
                        </button>
                        
                        <div class="d-flex align-items-center gap-2">
                            <button type="button" class="btn-flag" id="flagBtn" onclick="toggleFlag()" title="Tandai soal ini">
                                <i class="fas fa-flag"></i>
                            </button>
                            <span class="text-muted small" id="questionProgress">1 / ${questions.size()}</span>
                        </div>
                        
                        <div class="d-flex gap-2">
                            <button type="button" class="btn btn-outline-primary" id="nextBtn" onclick="nextQuestion()">
                                Selanjutnya <i class="fas fa-arrow-right ms-2"></i>
                            </button>
                            <button type="button" class="btn btn-primary d-none" id="submitBtn" onclick="confirmSubmit()">
                                <i class="fas fa-paper-plane me-2"></i> Kirim Jawaban
                            </button>
                        </div>
                    </div>
                </form>
            </div>
            
            <!-- Submit Confirmation Modal -->
            <div class="modal fade modal-confirm" id="submitModal" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div class="modal-confirm-icon">
                                <i class="fas fa-question-circle"></i>
                            </div>
                            <h4 class="fw-bold mb-2">Kirim Jawaban?</h4>
                            <p class="text-muted mb-3">Pastikan Anda sudah memeriksa semua jawaban</p>
                            
                            <div class="d-flex justify-content-center gap-4 mb-3">
                                <div class="text-center">
                                    <div class="fs-4 fw-bold text-success" id="answeredCount">0</div>
                                    <div class="small text-muted">Terjawab</div>
                                </div>
                                <div class="text-center">
                                    <div class="fs-4 fw-bold text-warning" id="unansweredCount">${questions.size()}</div>
                                    <div class="small text-muted">Belum Dijawab</div>
                                </div>
                                <div class="text-center">
                                    <div class="fs-4 fw-bold text-danger" id="flaggedCount">0</div>
                                    <div class="small text-muted">Ditandai</div>
                                </div>
                            </div>
                            
                            <div class="alert alert-warning d-none" id="unansweredWarning">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                <span id="unansweredWarningText"></span>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                Periksa Lagi
                            </button>
                            <button type="button" class="btn btn-primary" onclick="submitQuiz()">
                                Ya, Kirim Jawaban
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Exit Confirmation Modal -->
            <div class="modal fade modal-confirm" id="exitModal" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div class="modal-confirm-icon" style="background: #fee2e2; color: #dc2626;">
                                <i class="fas fa-sign-out-alt"></i>
                            </div>
                            <h4 class="fw-bold mb-2">Keluar dari Quiz?</h4>
                            <p class="text-muted">Jawaban Anda tidak akan disimpan jika keluar sekarang</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                Lanjut Quiz
                            </button>
                            <a href="${pageContext.request.contextPath}/learn/${course.slug}" class="btn btn-danger">
                                Ya, Keluar
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        <c:if test="${!showResults}">
        // Quiz state
        let currentQuestion = 0;
        const totalQuestions = ${questions.size()};
        const flaggedQuestions = new Set();
        const answeredQuestions = new Set();
        
        // Timer
        <c:if test="${quiz.timeLimit > 0}">
        let timeRemaining = ${quiz.timeLimit} * 60; // Convert to seconds
        const timerInterval = setInterval(updateTimer, 1000);
        
        function updateTimer() {
            timeRemaining--;
            
            const minutes = Math.floor(timeRemaining / 60);
            const seconds = timeRemaining % 60;
            
            document.getElementById('timerDisplay').textContent = 
                `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
            
            // Warning when less than 2 minutes
            if (timeRemaining <= 120) {
                document.getElementById('quizTimer').classList.add('warning');
            }
            
            // Auto-submit when time is up
            if (timeRemaining <= 0) {
                clearInterval(timerInterval);
                alert('Waktu habis! Quiz akan dikirim otomatis.');
                submitQuiz();
            }
        }
        </c:if>
        
        // Navigation functions
        function goToQuestion(index) {
            // Hide current question
            document.getElementById(`question${currentQuestion}`).style.display = 'none';
            document.getElementById(`navBtn${currentQuestion}`).classList.remove('active');
            
            // Show new question
            currentQuestion = index;
            document.getElementById(`question${currentQuestion}`).style.display = 'block';
            document.getElementById(`navBtn${currentQuestion}`).classList.add('active');
            
            updateNavigationButtons();
        }
        
        function nextQuestion() {
            if (currentQuestion < totalQuestions - 1) {
                goToQuestion(currentQuestion + 1);
            }
        }
        
        function prevQuestion() {
            if (currentQuestion > 0) {
                goToQuestion(currentQuestion - 1);
            }
        }
        
        function updateNavigationButtons() {
            // Update prev/next buttons
            document.getElementById('prevBtn').disabled = currentQuestion === 0;
            
            // Show submit button on last question
            if (currentQuestion === totalQuestions - 1) {
                document.getElementById('nextBtn').classList.add('d-none');
                document.getElementById('submitBtn').classList.remove('d-none');
            } else {
                document.getElementById('nextBtn').classList.remove('d-none');
                document.getElementById('submitBtn').classList.add('d-none');
            }
            
            // Update progress text
            document.getElementById('questionProgress').textContent = `${currentQuestion + 1} / ${totalQuestions}`;
            
            // Update flag button
            const flagBtn = document.getElementById('flagBtn');
            if (flaggedQuestions.has(currentQuestion)) {
                flagBtn.classList.add('flagged');
            } else {
                flagBtn.classList.remove('flagged');
            }
        }
        
        // Mark question as answered
        function markAnswered(questionIndex) {
            answeredQuestions.add(questionIndex);
            document.getElementById(`navBtn${questionIndex}`).classList.add('answered');
        }
        
        // Toggle flag
        function toggleFlag() {
            const flagBtn = document.getElementById('flagBtn');
            const navBtn = document.getElementById(`navBtn${currentQuestion}`);
            
            if (flaggedQuestions.has(currentQuestion)) {
                flaggedQuestions.delete(currentQuestion);
                flagBtn.classList.remove('flagged');
                navBtn.classList.remove('flagged');
            } else {
                flaggedQuestions.add(currentQuestion);
                flagBtn.classList.add('flagged');
                navBtn.classList.add('flagged');
            }
        }
        
        // Confirm submit
        function confirmSubmit() {
            const answered = answeredQuestions.size;
            const unanswered = totalQuestions - answered;
            const flagged = flaggedQuestions.size;
            
            document.getElementById('answeredCount').textContent = answered;
            document.getElementById('unansweredCount').textContent = unanswered;
            document.getElementById('flaggedCount').textContent = flagged;
            
            // Show warning if there are unanswered questions
            const warningEl = document.getElementById('unansweredWarning');
            if (unanswered > 0) {
                warningEl.classList.remove('d-none');
                document.getElementById('unansweredWarningText').textContent = 
                    `Anda masih memiliki ${unanswered} soal yang belum dijawab`;
            } else {
                warningEl.classList.add('d-none');
            }
            
            const modal = new bootstrap.Modal(document.getElementById('submitModal'));
            modal.show();
        }
        
        // Submit quiz
        function submitQuiz() {
            document.getElementById('quizForm').submit();
        }
        
        // Confirm exit
        function confirmExit() {
            const modal = new bootstrap.Modal(document.getElementById('exitModal'));
            modal.show();
        }
        
        // Prevent accidental navigation
        window.addEventListener('beforeunload', function(e) {
            e.preventDefault();
            e.returnValue = '';
        });
        
        // Keyboard navigation
        document.addEventListener('keydown', function(e) {
            if (e.key === 'ArrowLeft') {
                prevQuestion();
            } else if (e.key === 'ArrowRight') {
                nextQuestion();
            }
        });
        </c:if>
    </script>
</body>
</html>
