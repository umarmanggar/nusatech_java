/*
 * LearnController.java
 * Handles learning experience routes
 */
package controller;

import dao.CourseDAO;
import dao.EnrollmentDAO;
import dao.SectionDAO;
import dao.MaterialDAO;
import dao.QuizDAO;
import dao.QuestionDAO;
import model.Course;
import model.Enrollment;
import model.Section;
import model.Material;
import model.Quiz;
import model.Question;
import model.QuestionOption;
import model.User;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Controller for learning experience
 * @author user
 */
@WebServlet(name = "LearnController", urlPatterns = {"/learn/*"})
public class LearnController extends HttpServlet {

    private CourseDAO courseDAO;
    private EnrollmentDAO enrollmentDAO;
    private SectionDAO sectionDAO;
    private MaterialDAO materialDAO;
    private QuizDAO quizDAO;
    private QuestionDAO questionDAO;

    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAO();
        enrollmentDAO = new EnrollmentDAO();
        sectionDAO = new SectionDAO();
        materialDAO = new MaterialDAO();
        quizDAO = new QuizDAO();
        questionDAO = new QuestionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check authentication
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            session = request.getSession(true);
            session.setAttribute("redirectUrl", request.getRequestURI());
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!user.isStudent()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Hanya student yang dapat mengakses halaman ini");
            return;
        }

        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/my-learning");
            return;
        }

        try {
            // Parse path: /learn/{courseSlug} or /learn/{courseSlug}/material/{id} or /learn/{courseSlug}/quiz/{id}
            String[] parts = pathInfo.substring(1).split("/");
            String courseSlug = parts[0];

            // Get course
            Course course = courseDAO.findBySlug(courseSlug);
            if (course == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Kursus tidak ditemukan");
                return;
            }

            // Check enrollment
            Enrollment enrollment = enrollmentDAO.findByStudentAndCourse(user.getUserId(), course.getCourseId());
            if (enrollment == null) {
                session.setAttribute("errorMessage", "Anda belum terdaftar di kursus ini");
                response.sendRedirect(request.getContextPath() + "/course/" + courseSlug);
                return;
            }

            // Update last accessed
            enrollmentDAO.updateLastAccessed(enrollment.getEnrollmentId());

            if (parts.length == 1) {
                // Show main learning page
                showLearningPage(request, response, course, enrollment, user);
            } else if (parts.length >= 3 && "material".equals(parts[1])) {
                // View material
                int materialId = Integer.parseInt(parts[2]);
                viewMaterial(request, response, course, enrollment, materialId, user);
            } else if (parts.length >= 3 && "quiz".equals(parts[1])) {
                // Start quiz
                int quizId = Integer.parseInt(parts[2]);
                startQuiz(request, response, course, enrollment, quizId, user);
            } else {
                showLearningPage(request, response, course, enrollment, user);
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID tidak valid");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/pages/error/500.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check authentication
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!user.isStudent()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            String[] parts = pathInfo.substring(1).split("/");
            String courseSlug = parts[0];

            // Get course and enrollment
            Course course = courseDAO.findBySlug(courseSlug);
            if (course == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            Enrollment enrollment = enrollmentDAO.findByStudentAndCourse(user.getUserId(), course.getCourseId());
            if (enrollment == null) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }

            if (parts.length >= 4 && "material".equals(parts[1]) && "complete".equals(parts[3])) {
                // Mark material as complete
                int materialId = Integer.parseInt(parts[2]);
                markMaterialComplete(request, response, course, enrollment, materialId);
            } else if (parts.length >= 4 && "quiz".equals(parts[1]) && "submit".equals(parts[3])) {
                // Submit quiz
                int quizId = Integer.parseInt(parts[2]);
                submitQuiz(request, response, course, enrollment, quizId, user);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID tidak valid");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Show main learning page
     */
    private void showLearningPage(HttpServletRequest request, HttpServletResponse response,
                                  Course course, Enrollment enrollment, User user)
            throws ServletException, IOException, SQLException {
        
        // Get sections with materials
        List<Section> sections = sectionDAO.findByCourse(course.getCourseId());
        for (Section section : sections) {
            List<Material> materials = materialDAO.findBySectionWithProgress(
                section.getSectionId(), enrollment.getEnrollmentId()
            );
            section.setMaterials(materials);
        }

        // Calculate progress
        int totalMaterials = 0;
        int completedMaterials = 0;
        Material nextMaterial = null;

        for (Section section : sections) {
            for (Material material : section.getMaterials()) {
                totalMaterials++;
                if (material.isCompleted()) {
                    completedMaterials++;
                } else if (nextMaterial == null) {
                    nextMaterial = material;
                }
            }
        }

        int progressPercentage = totalMaterials > 0 ? (completedMaterials * 100) / totalMaterials : 0;
        
        // Update enrollment progress
        enrollment.setProgressPercentage(new BigDecimal(progressPercentage));
        enrollmentDAO.updateProgress(enrollment.getEnrollmentId(), new BigDecimal(progressPercentage));

        request.setAttribute("course", course);
        request.setAttribute("enrollment", enrollment);
        request.setAttribute("sections", sections);
        request.setAttribute("progressPercentage", progressPercentage);
        request.setAttribute("totalMaterials", totalMaterials);
        request.setAttribute("completedMaterials", completedMaterials);
        request.setAttribute("nextMaterial", nextMaterial);

        request.getRequestDispatcher("/pages/learn/course.jsp").forward(request, response);
    }

    /**
     * View material content
     */
    private void viewMaterial(HttpServletRequest request, HttpServletResponse response,
                              Course course, Enrollment enrollment, int materialId, User user)
            throws ServletException, IOException, SQLException {
        
        Material material = materialDAO.findById(materialId);
        if (material == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Materi tidak ditemukan");
            return;
        }

        // Get section info
        Section section = sectionDAO.findById(material.getSectionId());
        if (section == null || section.getCourseId() != course.getCourseId()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Materi tidak ditemukan dalam kursus ini");
            return;
        }

        // Get all sections for navigation
        List<Section> sections = sectionDAO.findByCourse(course.getCourseId());
        for (Section s : sections) {
            s.setMaterials(materialDAO.findBySectionWithProgress(s.getSectionId(), enrollment.getEnrollmentId()));
        }

        // Find previous and next materials
        Material prevMaterial = null;
        Material nextMaterial = null;
        boolean foundCurrent = false;

        for (Section s : sections) {
            for (Material m : s.getMaterials()) {
                if (foundCurrent && nextMaterial == null) {
                    nextMaterial = m;
                    break;
                }
                if (m.getMaterialId() == materialId) {
                    foundCurrent = true;
                } else if (!foundCurrent) {
                    prevMaterial = m;
                }
            }
            if (nextMaterial != null) break;
        }

        // If material is quiz type, get quiz data
        Quiz quiz = null;
        if (material.getContentType() == Material.ContentType.QUIZ) {
            quiz = quizDAO.findByMaterial(materialId);
        }

        request.setAttribute("course", course);
        request.setAttribute("enrollment", enrollment);
        request.setAttribute("section", section);
        request.setAttribute("sections", sections);
        request.setAttribute("material", material);
        request.setAttribute("prevMaterial", prevMaterial);
        request.setAttribute("nextMaterial", nextMaterial);
        request.setAttribute("quiz", quiz);

        request.getRequestDispatcher("/pages/learn/material.jsp").forward(request, response);
    }

    /**
     * Start quiz
     */
    private void startQuiz(HttpServletRequest request, HttpServletResponse response,
                           Course course, Enrollment enrollment, int quizId, User user)
            throws ServletException, IOException, SQLException {
        
        Quiz quiz = quizDAO.getQuizWithQuestions(quizId);
        if (quiz == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Quiz tidak ditemukan");
            return;
        }

        // Check if can attempt
        if (!quizDAO.canAttempt(quizId, user.getUserId())) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Anda sudah mencapai batas maksimal percobaan quiz ini");
            response.sendRedirect(request.getContextPath() + "/learn/" + course.getSlug());
            return;
        }

        // Get attempt count
        int attemptCount = quizDAO.countAttempts(quizId, user.getUserId());
        double bestScore = quizDAO.getBestScore(quizId, user.getUserId());

        request.setAttribute("course", course);
        request.setAttribute("enrollment", enrollment);
        request.setAttribute("quiz", quiz);
        request.setAttribute("attemptCount", attemptCount);
        request.setAttribute("bestScore", bestScore);

        request.getRequestDispatcher("/pages/learn/quiz.jsp").forward(request, response);
    }

    /**
     * Mark material as complete
     */
    private void markMaterialComplete(HttpServletRequest request, HttpServletResponse response,
                                      Course course, Enrollment enrollment, int materialId)
            throws ServletException, IOException, SQLException {
        
        materialDAO.markAsCompleted(materialId, enrollment.getEnrollmentId());
        
        // Recalculate progress
        List<Section> sections = sectionDAO.findByCourse(course.getCourseId());
        int total = 0;
        int completed = 0;
        
        for (Section section : sections) {
            List<Material> materials = materialDAO.findBySectionWithProgress(
                section.getSectionId(), enrollment.getEnrollmentId()
            );
            for (Material m : materials) {
                total++;
                if (m.isCompleted()) completed++;
            }
        }
        
        int progress = total > 0 ? (completed * 100) / total : 0;
        enrollmentDAO.updateProgress(enrollment.getEnrollmentId(), new BigDecimal(progress));
        
        // Check if course is completed
        if (progress >= 100) {
            enrollmentDAO.markAsCompleted(enrollment.getEnrollmentId());
        }

        // Return JSON response for AJAX
        response.setContentType("application/json");
        response.getWriter().write("{\"success\":true,\"progress\":" + progress + "}");
    }

    /**
     * Submit quiz answers
     */
    private void submitQuiz(HttpServletRequest request, HttpServletResponse response,
                            Course course, Enrollment enrollment, int quizId, User user)
            throws ServletException, IOException, SQLException {
        
        Quiz quiz = quizDAO.getQuizWithQuestions(quizId);
        if (quiz == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Calculate score
        int totalPoints = 0;
        int earnedPoints = 0;

        for (Question question : quiz.getQuestions()) {
            totalPoints += question.getPoints();
            
            String answerParam = request.getParameter("question_" + question.getQuestionId());
            if (answerParam != null) {
                int selectedOptionId = Integer.parseInt(answerParam);
                
                // Check if answer is correct
                for (QuestionOption option : question.getOptions()) {
                    if (option.getOptionId() == selectedOptionId && option.isCorrect()) {
                        earnedPoints += question.getPoints();
                        break;
                    }
                }
            }
        }

        // Calculate percentage score
        int score = totalPoints > 0 ? (earnedPoints * 100) / totalPoints : 0;
        boolean passed = score >= quiz.getPassingScore();

        // Store results in session for result page
        HttpSession session = request.getSession();
        session.setAttribute("quizScore", score);
        session.setAttribute("quizPassed", passed);
        session.setAttribute("quizTotalPoints", totalPoints);
        session.setAttribute("quizEarnedPoints", earnedPoints);

        // If passed, mark material as completed
        if (passed) {
            Material material = materialDAO.findById(quiz.getMaterialId());
            if (material != null) {
                materialDAO.markAsCompleted(material.getMaterialId(), enrollment.getEnrollmentId());
            }
        }

        response.sendRedirect(request.getContextPath() + "/learn/" + course.getSlug() + 
                            "/quiz/" + quizId + "/result");
    }
}
