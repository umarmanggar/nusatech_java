<%-- 
    Document   : quiz-form
    Created on : Dec 18, 2025
    Author     : NusaTech
    Description: Quiz Builder Form with Bootstrap 5
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${quiz != null ? 'Edit' : 'Buat'} Quiz - NusaTech</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root { --primary: #8B1538; --primary-dark: #6d1029; --secondary: #D4A84B; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #f8f9fa; }
        .btn-primary { background-color: var(--primary); border-color: var(--primary); }
        .btn-primary:hover { background-color: var(--primary-dark); border-color: var(--primary-dark); }
        .btn-outline-primary { color: var(--primary); border-color: var(--primary); }
        .btn-outline-primary:hover { background-color: var(--primary); border-color: var(--primary); }
        .text-primary { color: var(--primary) !important; }
        .form-control:focus, .form-select:focus { border-color: var(--primary); box-shadow: 0 0 0 0.2rem rgba(139, 21, 56, 0.15); }
        
        .dashboard-wrapper { display: flex; min-height: 100vh; padding-top: 56px; }
        .main-content { flex: 1; margin-left: 280px; padding: 2rem; }
        @media (max-width: 991.98px) { .main-content { margin-left: 0; } }
        
        .sidebar { width: 280px; min-height: calc(100vh - 56px); background: white; border-right: 1px solid #e5e7eb; position: fixed; top: 56px; left: 0; z-index: 1020; }
        .sidebar-user { padding: 1.5rem; background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%); color: white; }
        .sidebar-menu { padding: 1rem; }
        .sidebar-item { display: flex; align-items: center; gap: 0.75rem; padding: 0.85rem 1rem; border-radius: 0.75rem; color: #4b5563; text-decoration: none; font-weight: 500; margin-bottom: 0.25rem; transition: all 0.2s; }
        .sidebar-item:hover { background: rgba(139, 21, 56, 0.08); color: var(--primary); }
        .sidebar-item.active { background: rgba(139, 21, 56, 0.12); color: var(--primary); font-weight: 600; }
        .sidebar-item i { width: 20px; text-align: center; }
        .sidebar-divider { height: 1px; background: #e5e7eb; margin: 1rem 0; }
        
        .form-card { background: white; border-radius: 1rem; box-shadow: 0 2px 8px rgba(0,0,0,0.04); margin-bottom: 1.5rem; }
        .form-card-header { padding: 1.25rem 1.5rem; border-bottom: 1px solid #e5e7eb; display: flex; align-items: center; justify-content: space-between; }
        .form-card-header h5 { font-weight: 700; margin: 0; }
        .form-card-body { padding: 1.5rem; }
        
        .question-card { background: #f8f9fa; border-radius: 1rem; padding: 1.5rem; margin-bottom: 1rem; position: relative; border: 2px solid transparent; transition: all 0.3s; }
        .question-card:hover { border-color: #e5e7eb; }
        .question-number { position: absolute; top: -10px; left: 20px; background: var(--primary); color: white; padding: 0.25rem 0.75rem; border-radius: 1rem; font-size: 0.8rem; font-weight: 600; }
        .question-actions { position: absolute; top: 10px; right: 10px; }
        
        .option-row { display: flex; align-items: center; gap: 0.75rem; padding: 0.75rem; border-radius: 0.75rem; margin-bottom: 0.5rem; background: white; border: 2px solid #e5e7eb; transition: all 0.2s; }
        .option-row:hover { border-color: #d1d5db; }
        .option-row.correct { border-color: #10b981; background: rgba(16, 185, 129, 0.05); }
        .option-letter { width: 32px; height: 32px; border-radius: 50%; background: #e5e7eb; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.9rem; flex-shrink: 0; }
        .option-row.correct .option-letter { background: #10b981; color: white; }
        
        .add-question-btn { border: 2px dashed #d1d5db; background: transparent; color: #6b7280; font-weight: 600; width: 100%; padding: 1rem; border-radius: 1rem; transition: all 0.3s; }
        .add-question-btn:hover { border-color: var(--primary); color: var(--primary); background: rgba(139, 21, 56, 0.02); }
        
        .sticky-sidebar { position: sticky; top: 80px; }
        
        .quiz-stats { display: flex; gap: 1rem; flex-wrap: wrap; margin-bottom: 1.5rem; }
        .stat-badge { background: white; padding: 0.75rem 1rem; border-radius: 0.75rem; display: flex; align-items: center; gap: 0.5rem; box-shadow: 0 2px 4px rgba(0,0,0,0.04); }
        .stat-badge i { color: var(--primary); }
        
        @media (max-width: 991.98px) {
            .sidebar { transform: translateX(-100%); transition: transform 0.3s; }
            .sidebar.show { transform: translateX(0); }
        }
    </style>
</head>
<body>
    <jsp:include page="/pages/common/navbar-dashboard.jsp"/>
    
    <div class="dashboard-wrapper">
        <!-- Sidebar -->
        <aside class="sidebar" id="sidebar">
            <div class="sidebar-user">
                <div class="d-flex align-items-center gap-3">
                    <img src="https://ui-avatars.com/api/?name=${sessionScope.user.name}&background=ffffff&color=8B1538" class="rounded-circle" style="width: 48px; height: 48px;">
                    <div>
                        <div class="fw-semibold">${sessionScope.user.name}</div>
                        <small class="opacity-75"><i class="fas fa-chalkboard-teacher me-1"></i> Pengajar</small>
                    </div>
                </div>
            </div>
            <nav class="sidebar-menu">
                <a href="${pageContext.request.contextPath}/lecturer/dashboard" class="sidebar-item"><i class="fas fa-home"></i> Dashboard</a>
                <a href="${pageContext.request.contextPath}/lecturer/courses" class="sidebar-item active"><i class="fas fa-book"></i> Kursus Saya</a>
                <a href="${pageContext.request.contextPath}/lecturer/course/create" class="sidebar-item"><i class="fas fa-plus-circle"></i> Buat Kursus</a>
                <a href="${pageContext.request.contextPath}/lecturer/students" class="sidebar-item"><i class="fas fa-users"></i> Pelajar</a>
                <a href="${pageContext.request.contextPath}/lecturer/earnings" class="sidebar-item"><i class="fas fa-wallet"></i> Pendapatan</a>
                <div class="sidebar-divider"></div>
                <a href="${pageContext.request.contextPath}/lecturer/profile" class="sidebar-item"><i class="fas fa-user-circle"></i> Profil</a>
                <a href="${pageContext.request.contextPath}/logout" class="sidebar-item text-danger"><i class="fas fa-sign-out-alt"></i> Keluar</a>
            </nav>
        </aside>
        
        <!-- Main Content -->
        <main class="main-content">
            <button class="btn btn-outline-secondary d-lg-none mb-3" onclick="document.getElementById('sidebar').classList.toggle('show')">
                <i class="fas fa-bars me-2"></i> Menu
            </button>
            
            <!-- Breadcrumb -->
            <nav aria-label="breadcrumb" class="mb-3">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/lecturer/courses" class="text-decoration-none">Kursus Saya</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/lecturer/course/content/${course.courseId}" class="text-decoration-none">${course.title}</a></li>
                    <li class="breadcrumb-item active">${quiz != null ? 'Edit Quiz' : 'Buat Quiz'}</li>
                </ol>
            </nav>
            
            <!-- Header -->
            <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
                <div>
                    <h1 class="h3 fw-bold mb-1">
                        <i class="fas fa-question-circle text-primary me-2"></i>${quiz != null ? 'Edit Quiz' : 'Buat Quiz Baru'}
                    </h1>
                    <p class="text-muted mb-0">Bab: <strong>${section.title}</strong></p>
                </div>
                <div class="quiz-stats">
                    <div class="stat-badge">
                        <i class="fas fa-list-ol"></i>
                        <span id="questionCount">0</span> Pertanyaan
                    </div>
                    <div class="stat-badge">
                        <i class="fas fa-star"></i>
                        <span id="totalPoints">0</span> Poin Total
                    </div>
                </div>
            </div>
            
            <!-- Alerts -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show"><i class="fas fa-exclamation-circle me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show"><i class="fas fa-check-circle me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/lecturer/course/${course.courseId}/section/${section.sectionId}/quiz/${quiz != null ? 'update' : 'save'}" method="POST" id="quizForm">
                <c:if test="${quiz != null}">
                    <input type="hidden" name="quizId" value="${quiz.quizId}">
                    <input type="hidden" name="materialId" value="${quiz.materialId}">
                </c:if>
                
                <div class="row g-4">
                    <div class="col-lg-8">
                        <!-- Quiz Info -->
                        <div class="form-card">
                            <div class="form-card-header">
                                <h5><i class="fas fa-info-circle text-primary me-2"></i>Informasi Quiz</h5>
                            </div>
                            <div class="form-card-body">
                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Judul Quiz <span class="text-danger">*</span></label>
                                    <input type="text" name="title" class="form-control" value="${quiz.title}" required placeholder="Contoh: Quiz Bab 1 - Pengenalan Python">
                                </div>
                                <div class="mb-0">
                                    <label class="form-label fw-semibold">Deskripsi (Opsional)</label>
                                    <textarea name="description" class="form-control" rows="2" placeholder="Instruksi atau deskripsi quiz...">${quiz.description}</textarea>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Questions -->
                        <div class="form-card">
                            <div class="form-card-header">
                                <h5><i class="fas fa-list-check text-primary me-2"></i>Pertanyaan</h5>
                                <button type="button" class="btn btn-sm btn-outline-primary" onclick="addQuestion()">
                                    <i class="fas fa-plus me-1"></i> Tambah
                                </button>
                            </div>
                            <div class="form-card-body">
                                <div id="questionsContainer">
                                    <c:choose>
                                        <c:when test="${not empty quiz.questions}">
                                            <c:forEach var="question" items="${quiz.questions}" varStatus="qStatus">
                                                <div class="question-card" data-question-index="${qStatus.index}">
                                                    <span class="question-number">Pertanyaan ${qStatus.index + 1}</span>
                                                    <div class="question-actions">
                                                        <button type="button" class="btn btn-sm btn-outline-danger" onclick="removeQuestion(${qStatus.index})">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </div>
                                                    
                                                    <input type="hidden" name="questions[${qStatus.index}].questionId" value="${question.questionId}">
                                                    
                                                    <div class="mb-3 mt-3">
                                                        <label class="form-label fw-semibold">Pertanyaan <span class="text-danger">*</span></label>
                                                        <textarea name="questions[${qStatus.index}].questionText" class="form-control" rows="2" required>${question.questionText}</textarea>
                                                    </div>
                                                    
                                                    <div class="row mb-3">
                                                        <div class="col-md-6">
                                                            <label class="form-label fw-semibold">Tipe</label>
                                                            <select name="questions[${qStatus.index}].type" class="form-select">
                                                                <option value="MULTIPLE_CHOICE" ${question.type == 'MULTIPLE_CHOICE' ? 'selected' : ''}>Pilihan Ganda</option>
                                                                <option value="TRUE_FALSE" ${question.type == 'TRUE_FALSE' ? 'selected' : ''}>Benar/Salah</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label class="form-label fw-semibold">Poin</label>
                                                            <input type="number" name="questions[${qStatus.index}].points" class="form-control points-input" value="${question.points != null ? question.points : 10}" min="1" max="100" onchange="updateTotalPoints()">
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="mb-0">
                                                        <label class="form-label fw-semibold">Pilihan Jawaban</label>
                                                        <div class="options-container" data-question="${qStatus.index}">
                                                            <c:forEach var="option" items="${question.options}" varStatus="oStatus">
                                                                <div class="option-row ${option.isCorrect ? 'correct' : ''}">
                                                                    <input type="hidden" name="questions[${qStatus.index}].options[${oStatus.index}].optionId" value="${option.optionId}">
                                                                    <span class="option-letter">${['A', 'B', 'C', 'D', 'E'][oStatus.index]}</span>
                                                                    <input type="text" name="questions[${qStatus.index}].options[${oStatus.index}].optionText" class="form-control" value="${option.optionText}" placeholder="Pilihan ${['A', 'B', 'C', 'D', 'E'][oStatus.index]}">
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="radio" name="questions[${qStatus.index}].correctOption" value="${oStatus.index}" ${option.isCorrect ? 'checked' : ''} onchange="markCorrect(this)">
                                                                        <label class="form-check-label small">Benar</label>
                                                                    </div>
                                                                    <button type="button" class="btn btn-sm btn-outline-secondary" onclick="removeOption(this)" ${question.options.size() <= 2 ? 'disabled' : ''}>
                                                                        <i class="fas fa-times"></i>
                                                                    </button>
                                                                </div>
                                                            </c:forEach>
                                                        </div>
                                                        <button type="button" class="btn btn-sm btn-outline-secondary mt-2" onclick="addOption(${qStatus.index})">
                                                            <i class="fas fa-plus me-1"></i> Tambah Pilihan
                                                        </button>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Empty state - will be filled by JS -->
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <button type="button" class="add-question-btn" onclick="addQuestion()">
                                    <i class="fas fa-plus me-2"></i> Tambah Pertanyaan
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Sidebar -->
                    <div class="col-lg-4">
                        <div class="sticky-sidebar">
                            <div class="form-card">
                                <div class="form-card-header">
                                    <h5><i class="fas fa-cog text-primary me-2"></i>Pengaturan</h5>
                                </div>
                                <div class="form-card-body">
                                    <div class="mb-3">
                                        <label class="form-label fw-semibold">Passing Score (%)</label>
                                        <input type="number" name="passingScore" class="form-control" value="${quiz.passingScore != null ? quiz.passingScore : 70}" min="0" max="100">
                                        <div class="form-text">Nilai minimum untuk lulus quiz</div>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label class="form-label fw-semibold">Batas Waktu (menit)</label>
                                        <input type="number" name="timeLimit" class="form-control" value="${quiz.timeLimit != null ? quiz.timeLimit : 0}" min="0">
                                        <div class="form-text">0 = tidak ada batas waktu</div>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label class="form-label fw-semibold">Maksimal Percobaan</label>
                                        <input type="number" name="maxAttempts" class="form-control" value="${quiz.maxAttempts != null ? quiz.maxAttempts : 0}" min="0">
                                        <div class="form-text">0 = tidak terbatas</div>
                                    </div>
                                    
                                    <div class="mb-4">
                                        <div class="form-check form-switch mb-2">
                                            <input class="form-check-input" type="checkbox" name="shuffleQuestions" id="shuffleQuestions" value="true" ${quiz.shuffleQuestions ? 'checked' : ''}>
                                            <label class="form-check-label" for="shuffleQuestions">Acak urutan soal</label>
                                        </div>
                                        <div class="form-check form-switch mb-2">
                                            <input class="form-check-input" type="checkbox" name="showResults" id="showResults" value="true" ${quiz.showResults == null || quiz.showResults ? 'checked' : ''}>
                                            <label class="form-check-label" for="showResults">Tampilkan hasil setelah selesai</label>
                                        </div>
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" name="isFree" id="isFree" value="true" ${quiz.free ? 'checked' : ''}>
                                            <label class="form-check-label" for="isFree">Free Preview</label>
                                        </div>
                                    </div>
                                    
                                    <hr>
                                    
                                    <div class="d-grid gap-2">
                                        <button type="submit" class="btn btn-primary btn-lg">
                                            <i class="fas fa-save me-2"></i>${quiz != null ? 'Simpan Perubahan' : 'Simpan Quiz'}
                                        </button>
                                        <a href="${pageContext.request.contextPath}/lecturer/course/content/${course.courseId}" class="btn btn-outline-secondary">Batal</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </main>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        let questionIndex = ${quiz != null && quiz.questions != null ? quiz.questions.size() : 0};
        
        // Add question if no questions exist
        document.addEventListener('DOMContentLoaded', function() {
            if (questionIndex === 0) {
                addQuestion();
            }
            updateStats();
        });
        
        // Add new question
        function addQuestion() {
            const container = document.getElementById('questionsContainer');
            const html = `
                <div class="question-card" data-question-index="${questionIndex}">
                    <span class="question-number">Pertanyaan ${questionIndex + 1}</span>
                    <div class="question-actions">
                        <button type="button" class="btn btn-sm btn-outline-danger" onclick="removeQuestion(${questionIndex})">
                            <i class="fas fa-trash"></i>
                        </button>
                    </div>
                    
                    <div class="mb-3 mt-3">
                        <label class="form-label fw-semibold">Pertanyaan <span class="text-danger">*</span></label>
                        <textarea name="questions[${questionIndex}].questionText" class="form-control" rows="2" required placeholder="Masukkan pertanyaan..."></textarea>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Tipe</label>
                            <select name="questions[${questionIndex}].type" class="form-select" onchange="handleTypeChange(this, ${questionIndex})">
                                <option value="MULTIPLE_CHOICE">Pilihan Ganda</option>
                                <option value="TRUE_FALSE">Benar/Salah</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Poin</label>
                            <input type="number" name="questions[${questionIndex}].points" class="form-control points-input" value="10" min="1" max="100" onchange="updateTotalPoints()">
                        </div>
                    </div>
                    
                    <div class="mb-0">
                        <label class="form-label fw-semibold">Pilihan Jawaban</label>
                        <div class="options-container" data-question="${questionIndex}">
                            <div class="option-row">
                                <span class="option-letter">A</span>
                                <input type="text" name="questions[${questionIndex}].options[0].optionText" class="form-control" placeholder="Pilihan A">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="questions[${questionIndex}].correctOption" value="0" checked onchange="markCorrect(this)">
                                    <label class="form-check-label small">Benar</label>
                                </div>
                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="removeOption(this)" disabled>
                                    <i class="fas fa-times"></i>
                                </button>
                            </div>
                            <div class="option-row">
                                <span class="option-letter">B</span>
                                <input type="text" name="questions[${questionIndex}].options[1].optionText" class="form-control" placeholder="Pilihan B">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="questions[${questionIndex}].correctOption" value="1" onchange="markCorrect(this)">
                                    <label class="form-check-label small">Benar</label>
                                </div>
                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="removeOption(this)" disabled>
                                    <i class="fas fa-times"></i>
                                </button>
                            </div>
                            <div class="option-row">
                                <span class="option-letter">C</span>
                                <input type="text" name="questions[${questionIndex}].options[2].optionText" class="form-control" placeholder="Pilihan C">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="questions[${questionIndex}].correctOption" value="2" onchange="markCorrect(this)">
                                    <label class="form-check-label small">Benar</label>
                                </div>
                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="removeOption(this)">
                                    <i class="fas fa-times"></i>
                                </button>
                            </div>
                            <div class="option-row">
                                <span class="option-letter">D</span>
                                <input type="text" name="questions[${questionIndex}].options[3].optionText" class="form-control" placeholder="Pilihan D">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="questions[${questionIndex}].correctOption" value="3" onchange="markCorrect(this)">
                                    <label class="form-check-label small">Benar</label>
                                </div>
                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="removeOption(this)">
                                    <i class="fas fa-times"></i>
                                </button>
                            </div>
                        </div>
                        <button type="button" class="btn btn-sm btn-outline-secondary mt-2" onclick="addOption(${questionIndex})">
                            <i class="fas fa-plus me-1"></i> Tambah Pilihan
                        </button>
                    </div>
                </div>
            `;
            
            container.insertAdjacentHTML('beforeend', html);
            questionIndex++;
            updateStats();
            
            // Mark first option as correct
            const newQuestion = container.lastElementChild;
            newQuestion.querySelector('.option-row').classList.add('correct');
        }
        
        // Remove question
        function removeQuestion(index) {
            const question = document.querySelector(`[data-question-index="${index}"]`);
            if (question && document.querySelectorAll('.question-card').length > 1) {
                question.remove();
                updateStats();
            }
        }
        
        // Add option
        function addOption(questionIndex) {
            const container = document.querySelector(`[data-question="${questionIndex}"]`);
            const optionCount = container.querySelectorAll('.option-row').length;
            
            if (optionCount >= 5) return;
            
            const letters = ['A', 'B', 'C', 'D', 'E'];
            const html = `
                <div class="option-row">
                    <span class="option-letter">${letters[optionCount]}</span>
                    <input type="text" name="questions[${questionIndex}].options[${optionCount}].optionText" class="form-control" placeholder="Pilihan ${letters[optionCount]}">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="questions[${questionIndex}].correctOption" value="${optionCount}" onchange="markCorrect(this)">
                        <label class="form-check-label small">Benar</label>
                    </div>
                    <button type="button" class="btn btn-sm btn-outline-secondary" onclick="removeOption(this)">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
            `;
            
            container.insertAdjacentHTML('beforeend', html);
            updateRemoveButtons(container);
        }
        
        // Remove option
        function removeOption(btn) {
            const row = btn.closest('.option-row');
            const container = row.closest('.options-container');
            const wasCorrect = row.classList.contains('correct');
            
            row.remove();
            
            // Reindex options
            const rows = container.querySelectorAll('.option-row');
            const letters = ['A', 'B', 'C', 'D', 'E'];
            rows.forEach((r, i) => {
                r.querySelector('.option-letter').textContent = letters[i];
                const radio = r.querySelector('input[type="radio"]');
                radio.value = i;
            });
            
            // If removed was correct, mark first as correct
            if (wasCorrect && rows.length > 0) {
                rows[0].classList.add('correct');
                rows[0].querySelector('input[type="radio"]').checked = true;
            }
            
            updateRemoveButtons(container);
        }
        
        // Update remove buttons (disable if only 2 options)
        function updateRemoveButtons(container) {
            const btns = container.querySelectorAll('.option-row button');
            const disable = btns.length <= 2;
            btns.forEach(btn => btn.disabled = disable);
        }
        
        // Mark correct option
        function markCorrect(radio) {
            const container = radio.closest('.options-container');
            container.querySelectorAll('.option-row').forEach(row => row.classList.remove('correct'));
            radio.closest('.option-row').classList.add('correct');
        }
        
        // Handle type change (True/False)
        function handleTypeChange(select, questionIndex) {
            const container = document.querySelector(`[data-question="${questionIndex}"]`);
            
            if (select.value === 'TRUE_FALSE') {
                container.innerHTML = `
                    <div class="option-row correct">
                        <span class="option-letter">A</span>
                        <input type="text" name="questions[${questionIndex}].options[0].optionText" class="form-control" value="Benar" readonly>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="questions[${questionIndex}].correctOption" value="0" checked onchange="markCorrect(this)">
                            <label class="form-check-label small">Benar</label>
                        </div>
                        <button type="button" class="btn btn-sm btn-outline-secondary" disabled><i class="fas fa-times"></i></button>
                    </div>
                    <div class="option-row">
                        <span class="option-letter">B</span>
                        <input type="text" name="questions[${questionIndex}].options[1].optionText" class="form-control" value="Salah" readonly>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="questions[${questionIndex}].correctOption" value="1" onchange="markCorrect(this)">
                            <label class="form-check-label small">Benar</label>
                        </div>
                        <button type="button" class="btn btn-sm btn-outline-secondary" disabled><i class="fas fa-times"></i></button>
                    </div>
                `;
                
                // Hide add option button
                container.nextElementSibling.style.display = 'none';
            } else {
                // Show add option button and restore editable options
                container.nextElementSibling.style.display = 'inline-block';
                container.querySelectorAll('input[type="text"]').forEach(input => input.readOnly = false);
            }
        }
        
        // Update stats
        function updateStats() {
            const questionCount = document.querySelectorAll('.question-card').length;
            document.getElementById('questionCount').textContent = questionCount;
            updateTotalPoints();
        }
        
        // Update total points
        function updateTotalPoints() {
            let total = 0;
            document.querySelectorAll('.points-input').forEach(input => {
                total += parseInt(input.value) || 0;
            });
            document.getElementById('totalPoints').textContent = total;
        }
    </script>
</body>
</html>
