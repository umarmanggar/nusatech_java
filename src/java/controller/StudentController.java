/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;
import dao.EnrollmentDAO;
import dao.CourseDAO;
import dao.UserDAO;
import model.Enrollment;
import model.Course;
import model.User;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
/**
 *
 * @author user
 */
@WebServlet(name = "StudentController", urlPatterns = {"/StudentController"})
public class StudentController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private EnrollmentDAO enrollmentDAO;
    private CourseDAO courseDAO;
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        enrollmentDAO = new EnrollmentDAO();
        courseDAO = new CourseDAO();
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get current user
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!user.isStudent()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            return;
        }
        
        String path = request.getServletPath();
        String pathInfo = request.getPathInfo();
        
        try {
            if (path.equals("/my-learning")) {
                showMyLearning(request, response, user);
            } else if (path.equals("/wishlist")) {
                showWishlist(request, response, user);
            } else if (pathInfo != null) {
                switch (pathInfo) {
                    case "/dashboard":
                        showDashboard(request, response, user);
                        break;
                    case "/profile":
                        showProfile(request, response, user);
                        break;
                    case "/certificates":
                        showCertificates(request, response, user);
                        break;
                    default:
                        showDashboard(request, response, user);
                }
            } else {
                showDashboard(request, response, user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Terjadi kesalahan saat memuat data");
            request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo != null) {
                switch (pathInfo) {
                    case "/enroll":
                        enrollCourse(request, response, user);
                        break;
                    case "/update-profile":
                        updateProfile(request, response, user);
                        break;
                    default:
                        response.sendRedirect(request.getContextPath() + "/student/dashboard");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Terjadi kesalahan saat memproses permintaan");
            request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
        }
    }
    
    /**
     * Show student dashboard
     */
    private void showDashboard(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        // Get active enrollments
        List<Enrollment> activeEnrollments = enrollmentDAO.findActiveByStudent(user.getUserId());
        request.setAttribute("activeEnrollments", activeEnrollments);
        
        // Get statistics
        int totalEnrolled = enrollmentDAO.countByStudent(user.getUserId());
        int totalCompleted = enrollmentDAO.countCompletedByStudent(user.getUserId());
        
        request.setAttribute("totalEnrolled", totalEnrolled);
        request.setAttribute("totalCompleted", totalCompleted);
        request.setAttribute("user", user);
        
        // Get recommended courses
        List<Course> recommendedCourses = courseDAO.findPopular(4);
        request.setAttribute("recommendedCourses", recommendedCourses);
        
        request.getRequestDispatcher("/pages/student/dashboard.jsp").forward(request, response);
    }
    
    /**
     * Show My Learning page
     */
    private void showMyLearning(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        String filter = request.getParameter("filter");
        List<Enrollment> enrollments;
        
        if ("completed".equals(filter)) {
            enrollments = enrollmentDAO.findCompletedByStudent(user.getUserId());
        } else if ("active".equals(filter)) {
            enrollments = enrollmentDAO.findActiveByStudent(user.getUserId());
        } else {
            enrollments = enrollmentDAO.findByStudent(user.getUserId());
        }
        
        request.setAttribute("enrollments", enrollments);
        request.setAttribute("filter", filter);
        request.setAttribute("user", user);
        
        request.getRequestDispatcher("/pages/student/my-learning.jsp").forward(request, response);
    }
    
    /**
     * Show Wishlist
     */
    private void showWishlist(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        // TODO: Implement wishlist DAO
        request.setAttribute("user", user);
        request.getRequestDispatcher("/pages/student/wishlist.jsp").forward(request, response);
    }
    
    /**
     * Show Profile
     */
    private void showProfile(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        request.setAttribute("user", user);
        request.getRequestDispatcher("/pages/student/profile.jsp").forward(request, response);
    }
    
    /**
     * Show Certificates
     */
    private void showCertificates(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        List<Enrollment> completedEnrollments = enrollmentDAO.findCompletedByStudent(user.getUserId());
        request.setAttribute("completedEnrollments", completedEnrollments);
        request.setAttribute("user", user);
        
        request.getRequestDispatcher("/pages/student/certificates.jsp").forward(request, response);
    }
    
    /**
     * Enroll to a course
     */
    private void enrollCourse(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        String courseIdStr = request.getParameter("courseId");
        
        if (courseIdStr == null || courseIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/courses");
            return;
        }
        
        int courseId = Integer.parseInt(courseIdStr);
        Course course = courseDAO.findById(courseId);
        
        if (course == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Kursus tidak ditemukan");
            return;
        }
        
        // Check if already enrolled
        if (enrollmentDAO.isEnrolled(user.getUserId(), courseId)) {
            response.sendRedirect(request.getContextPath() + "/my-learning");
            return;
        }
        
        // For free courses, enroll directly
        if (course.isFree() || course.getPrice().compareTo(java.math.BigDecimal.ZERO) == 0) {
            Enrollment enrollment = new Enrollment(user.getUserId(), courseId);
            int enrollmentId = enrollmentDAO.create(enrollment);
            
            if (enrollmentId > 0) {
                HttpSession session = request.getSession();
                session.setAttribute("successMessage", "Berhasil mendaftar kursus: " + course.getTitle());
                response.sendRedirect(request.getContextPath() + "/my-learning");
            } else {
                request.setAttribute("error", "Gagal mendaftar kursus");
                response.sendRedirect(request.getContextPath() + "/course/" + course.getSlug());
            }
        } else {
            // Redirect to checkout for paid courses
            response.sendRedirect(request.getContextPath() + "/checkout?courseId=" + courseId);
        }
    }
    
    /**
     * Update profile
     */
    private void updateProfile(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        
        user.setName(name);
        user.setPhone(phone);
        
        if (userDAO.update(user)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("successMessage", "Profil berhasil diperbarui");
        } else {
            request.setAttribute("error", "Gagal memperbarui profil");
        }
        
        response.sendRedirect(request.getContextPath() + "/student/profile");
    }
}
