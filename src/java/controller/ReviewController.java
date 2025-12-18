/*
 * ReviewController.java
 * Handles review routes
 */
package controller;

import dao.ReviewDAO;
import dao.CourseDAO;
import dao.EnrollmentDAO;
import model.Review;
import model.Course;
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
 * Controller for course reviews
 * @author user
 */
@WebServlet(name = "ReviewController", urlPatterns = {"/review/*"})
public class ReviewController extends HttpServlet {

    private ReviewDAO reviewDAO;
    private CourseDAO courseDAO;
    private EnrollmentDAO enrollmentDAO;

    @Override
    public void init() throws ServletException {
        reviewDAO = new ReviewDAO();
        courseDAO = new CourseDAO();
        enrollmentDAO = new EnrollmentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                response.sendRedirect(request.getContextPath() + "/courses");
                return;
            }

            if (pathInfo.startsWith("/course/")) {
                // Get reviews for course: /review/course/{courseId}
                int courseId = Integer.parseInt(pathInfo.substring("/course/".length()));
                getReviewsForCourse(request, response, courseId);
            } else if (pathInfo.equals("/my-reviews")) {
                // Get user's reviews
                getMyReviews(request, response);
            } else if (pathInfo.startsWith("/can-review/")) {
                // Check if can review
                int courseId = Integer.parseInt(pathInfo.substring("/can-review/".length()));
                checkCanReview(request, response, courseId);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID tidak valid");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check authentication
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            String accept = request.getHeader("Accept");
            if (accept != null && accept.contains("application/json")) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.setContentType("application/json");
                response.getWriter().write("{\"success\":false,\"message\":\"Silakan login terlebih dahulu\"}");
            } else {
                response.sendRedirect(request.getContextPath() + "/login");
            }
            return;
        }

        User user = (User) session.getAttribute("user");
        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo == null || pathInfo.equals("/submit") || pathInfo.equals("/")) {
                submitReview(request, response, user);
            } else if (pathInfo.equals("/update")) {
                updateReview(request, response, user);
            } else if (pathInfo.equals("/delete")) {
                deleteReview(request, response, user);
            } else if (pathInfo.equals("/helpful")) {
                markHelpful(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            String accept = request.getHeader("Accept");
            if (accept != null && accept.contains("application/json")) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.setContentType("application/json");
                response.getWriter().write("{\"success\":false,\"message\":\"Terjadi kesalahan\"}");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        }
    }

    /**
     * Get reviews for a course
     */
    private void getReviewsForCourse(HttpServletRequest request, HttpServletResponse response, int courseId)
            throws ServletException, IOException, SQLException {
        
        Course course = courseDAO.findById(courseId);
        if (course == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Kursus tidak ditemukan");
            return;
        }

        // Get page parameter
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        List<Review> reviews = reviewDAO.findByCourse(courseId, page, 10);
        BigDecimal averageRating = reviewDAO.getAverageRating(courseId);
        int[] ratingDistribution = reviewDAO.getRatingDistribution(courseId);
        int totalReviews = reviewDAO.countByCourse(courseId);
        int totalPages = (int) Math.ceil((double) totalReviews / 10);

        // Check if JSON response
        String accept = request.getHeader("Accept");
        if (accept != null && accept.contains("application/json")) {
            response.setContentType("application/json");
            StringBuilder json = new StringBuilder();
            json.append("{");
            json.append("\"averageRating\":").append(averageRating).append(",");
            json.append("\"totalReviews\":").append(totalReviews).append(",");
            json.append("\"ratingDistribution\":[");
            for (int i = 0; i < 5; i++) {
                json.append(ratingDistribution[i]);
                if (i < 4) json.append(",");
            }
            json.append("],");
            json.append("\"reviews\":[");
            for (int i = 0; i < reviews.size(); i++) {
                Review r = reviews.get(i);
                json.append("{");
                json.append("\"reviewId\":").append(r.getReviewId()).append(",");
                json.append("\"rating\":").append(r.getRating()).append(",");
                json.append("\"comment\":\"").append(escapeJson(r.getComment())).append("\",");
                json.append("\"studentName\":\"").append(escapeJson(r.getStudent().getName())).append("\",");
                json.append("\"createdAt\":\"").append(r.getCreatedAt()).append("\"");
                json.append("}");
                if (i < reviews.size() - 1) json.append(",");
            }
            json.append("],");
            json.append("\"currentPage\":").append(page).append(",");
            json.append("\"totalPages\":").append(totalPages);
            json.append("}");
            response.getWriter().write(json.toString());
        } else {
            request.setAttribute("course", course);
            request.setAttribute("reviews", reviews);
            request.setAttribute("averageRating", averageRating);
            request.setAttribute("ratingDistribution", ratingDistribution);
            request.setAttribute("totalReviews", totalReviews);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            
            request.getRequestDispatcher("/pages/review/course-reviews.jsp").forward(request, response);
        }
    }

    /**
     * Get current user's reviews
     */
    private void getMyReviews(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        List<Review> reviews = reviewDAO.findByStudent(user.getUserId());

        request.setAttribute("reviews", reviews);
        request.getRequestDispatcher("/pages/review/my-reviews.jsp").forward(request, response);
    }

    /**
     * Check if user can review a course
     */
    private void checkCanReview(HttpServletRequest request, HttpServletResponse response, int courseId)
            throws ServletException, IOException, SQLException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.setContentType("application/json");
            response.getWriter().write("{\"canReview\":false,\"reason\":\"not_logged_in\"}");
            return;
        }

        User user = (User) session.getAttribute("user");
        boolean canReview = reviewDAO.canReview(user.getUserId(), courseId);
        
        String reason = "";
        if (!canReview) {
            if (!enrollmentDAO.isEnrolled(user.getUserId(), courseId)) {
                reason = "not_enrolled";
            } else {
                reason = "already_reviewed";
            }
        }

        // Get existing review if any
        Review existingReview = reviewDAO.findByStudentAndCourse(user.getUserId(), courseId);

        response.setContentType("application/json");
        StringBuilder json = new StringBuilder();
        json.append("{\"canReview\":").append(canReview);
        if (!reason.isEmpty()) {
            json.append(",\"reason\":\"").append(reason).append("\"");
        }
        if (existingReview != null) {
            json.append(",\"existingReview\":{");
            json.append("\"reviewId\":").append(existingReview.getReviewId()).append(",");
            json.append("\"rating\":").append(existingReview.getRating()).append(",");
            json.append("\"comment\":\"").append(escapeJson(existingReview.getComment())).append("\"");
            json.append("}");
        }
        json.append("}");
        response.getWriter().write(json.toString());
    }

    /**
     * Submit a new review
     */
    private void submitReview(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        String courseIdStr = request.getParameter("courseId");
        String ratingStr = request.getParameter("rating");
        String comment = request.getParameter("comment");

        if (courseIdStr == null || ratingStr == null) {
            sendErrorResponse(request, response, "Data tidak lengkap");
            return;
        }

        int courseId = Integer.parseInt(courseIdStr);
        int rating = Integer.parseInt(ratingStr);

        // Validate rating
        if (rating < 1 || rating > 5) {
            sendErrorResponse(request, response, "Rating harus antara 1-5");
            return;
        }

        // Check if can review
        if (!reviewDAO.canReview(user.getUserId(), courseId)) {
            // Check if updating existing review
            Review existingReview = reviewDAO.findByStudentAndCourse(user.getUserId(), courseId);
            if (existingReview != null) {
                // Update existing review
                existingReview.setRating(rating);
                existingReview.setComment(comment);
                reviewDAO.update(existingReview);
                sendSuccessResponse(request, response, "Review berhasil diperbarui", courseId);
                return;
            }
            
            sendErrorResponse(request, response, "Anda tidak dapat memberikan review untuk kursus ini");
            return;
        }

        // Create review
        Review review = new Review(user.getUserId(), courseId, rating, comment);
        int reviewId = reviewDAO.create(review);

        if (reviewId > 0) {
            sendSuccessResponse(request, response, "Review berhasil dikirim", courseId);
        } else {
            sendErrorResponse(request, response, "Gagal mengirim review");
        }
    }

    /**
     * Update an existing review
     */
    private void updateReview(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        String reviewIdStr = request.getParameter("reviewId");
        String ratingStr = request.getParameter("rating");
        String comment = request.getParameter("comment");

        if (reviewIdStr == null || ratingStr == null) {
            sendErrorResponse(request, response, "Data tidak lengkap");
            return;
        }

        int reviewId = Integer.parseInt(reviewIdStr);
        int rating = Integer.parseInt(ratingStr);

        Review review = reviewDAO.findById(reviewId);
        if (review == null) {
            sendErrorResponse(request, response, "Review tidak ditemukan");
            return;
        }

        // Check ownership
        if (review.getStudentId() != user.getUserId()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        review.setRating(rating);
        review.setComment(comment);

        if (reviewDAO.update(review)) {
            sendSuccessResponse(request, response, "Review berhasil diperbarui", review.getCourseId());
        } else {
            sendErrorResponse(request, response, "Gagal memperbarui review");
        }
    }

    /**
     * Delete a review
     */
    private void deleteReview(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        String reviewIdStr = request.getParameter("reviewId");
        if (reviewIdStr == null) {
            sendErrorResponse(request, response, "Review ID diperlukan");
            return;
        }

        int reviewId = Integer.parseInt(reviewIdStr);
        Review review = reviewDAO.findById(reviewId);

        if (review == null) {
            sendErrorResponse(request, response, "Review tidak ditemukan");
            return;
        }

        // Check ownership or admin
        if (review.getStudentId() != user.getUserId() && !user.isAdmin()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        int courseId = review.getCourseId();
        if (reviewDAO.delete(reviewId)) {
            sendSuccessResponse(request, response, "Review berhasil dihapus", courseId);
        } else {
            sendErrorResponse(request, response, "Gagal menghapus review");
        }
    }

    /**
     * Mark review as helpful
     */
    private void markHelpful(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        String reviewIdStr = request.getParameter("reviewId");
        if (reviewIdStr == null) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\":false}");
            return;
        }

        int reviewId = Integer.parseInt(reviewIdStr);
        reviewDAO.incrementHelpful(reviewId);

        Review review = reviewDAO.findById(reviewId);
        response.setContentType("application/json");
        response.getWriter().write("{\"success\":true,\"helpfulCount\":" + review.getHelpfulCount() + "}");
    }

    /**
     * Send success response
     */
    private void sendSuccessResponse(HttpServletRequest request, HttpServletResponse response,
                                     String message, int courseId)
            throws IOException, SQLException {
        
        String accept = request.getHeader("Accept");
        if (accept != null && accept.contains("application/json")) {
            BigDecimal newRating = reviewDAO.getAverageRating(courseId);
            int totalReviews = reviewDAO.countByCourse(courseId);
            
            response.setContentType("application/json");
            response.getWriter().write("{\"success\":true,\"message\":\"" + message + 
                                       "\",\"newRating\":" + newRating + 
                                       ",\"totalReviews\":" + totalReviews + "}");
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("successMessage", message);
            
            Course course = courseDAO.findById(courseId);
            response.sendRedirect(request.getContextPath() + "/course/" + course.getSlug());
        }
    }

    /**
     * Send error response
     */
    private void sendErrorResponse(HttpServletRequest request, HttpServletResponse response, String message)
            throws IOException {
        
        String accept = request.getHeader("Accept");
        if (accept != null && accept.contains("application/json")) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\":false,\"message\":\"" + message + "\"}");
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", message);
            
            String referer = request.getHeader("Referer");
            if (referer != null) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect(request.getContextPath() + "/courses");
            }
        }
    }

    /**
     * Escape JSON string
     */
    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}
