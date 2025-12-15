/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;
import dao.CourseDAO;
import dao.CategoryDAO;
import dao.EnrollmentDAO;
import model.Course;
import model.Category;
import model.Enrollment;
import model.User;

import java.io.IOException;
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
@WebServlet(name = "CourseController", urlPatterns = {"/CourseController"})
public class CourseController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private CourseDAO courseDAO;
    private CategoryDAO categoryDAO;
    private EnrollmentDAO enrollmentDAO;
    
    private static final int PAGE_SIZE = 12;
    
    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAO();
        categoryDAO = new CategoryDAO();
        enrollmentDAO = new EnrollmentDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        String pathInfo = request.getPathInfo();
        
        try {
            switch (path) {
                case "/courses":
                    listCourses(request, response);
                    break;
                case "/course":
                    if (pathInfo != null && pathInfo.length() > 1) {
                        String slug = pathInfo.substring(1);
                        showCourse(request, response, slug);
                    } else {
                        response.sendRedirect(request.getContextPath() + "/courses");
                    }
                    break;
                case "/search":
                    searchCourses(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/courses");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Terjadi kesalahan saat memuat data");
            request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
        }
    }
    
    /**
     * List all courses with pagination and filters
     */
    private void listCourses(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        // Get parameters
        int page = getIntParam(request, "page", 1);
        String categorySlug = request.getParameter("category");
        String level = request.getParameter("level");
        String sort = request.getParameter("sort");
        
        List<Course> courses;
        int totalCourses;
        
        // Filter by category if specified
        if (categorySlug != null && !categorySlug.isEmpty()) {
            Category category = categoryDAO.findBySlug(categorySlug);
            if (category != null) {
                courses = courseDAO.findByCategory(category.getCategoryId(), page, PAGE_SIZE);
                totalCourses = courseDAO.countByCategory(category.getCategoryId());
                request.setAttribute("selectedCategory", category);
            } else {
                courses = courseDAO.findPublished(page, PAGE_SIZE);
                totalCourses = courseDAO.countPublished();
            }
        } else {
            courses = courseDAO.findPublished(page, PAGE_SIZE);
            totalCourses = courseDAO.countPublished();
        }
        
        // Get all categories for filter
        List<Category> categories = categoryDAO.findAllActive();
        
        // Calculate pagination
        int totalPages = (int) Math.ceil((double) totalCourses / PAGE_SIZE);
        
        request.setAttribute("courses", courses);
        request.setAttribute("categories", categories);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalCourses", totalCourses);
        
        request.getRequestDispatcher("/pages/course/list.jsp").forward(request, response);
    }
    
    /**
     * Show single course detail
     */
    private void showCourse(HttpServletRequest request, HttpServletResponse response, String slug)
            throws ServletException, IOException, SQLException {
        
        Course course = courseDAO.findBySlug(slug);
        
        if (course == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Kursus tidak ditemukan");
            return;
        }
        
        // Check if current user is enrolled
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null && user.isStudent()) {
                boolean isEnrolled = enrollmentDAO.isEnrolled(user.getUserId(), course.getCourseId());
                request.setAttribute("isEnrolled", isEnrolled);
                
                if (isEnrolled) {
                    Enrollment enrollment = enrollmentDAO.findByStudentAndCourse(user.getUserId(), course.getCourseId());
                    request.setAttribute("enrollment", enrollment);
                }
            }
        }
        
        // Get related courses from same category
        List<Course> relatedCourses = courseDAO.findByCategory(course.getCategoryId(), 1, 4);
        relatedCourses.removeIf(c -> c.getCourseId() == course.getCourseId());
        
        request.setAttribute("course", course);
        request.setAttribute("relatedCourses", relatedCourses);
        
        request.getRequestDispatcher("/pages/course/detail.jsp").forward(request, response);
    }
    
    /**
     * Search courses
     */
    private void searchCourses(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        String keyword = request.getParameter("q");
        int page = getIntParam(request, "page", 1);
        
        if (keyword == null || keyword.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/courses");
            return;
        }
        
        List<Course> courses = courseDAO.search(keyword.trim(), page, PAGE_SIZE);
        List<Category> categories = categoryDAO.findAllActive();
        
        request.setAttribute("courses", courses);
        request.setAttribute("categories", categories);
        request.setAttribute("keyword", keyword);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalCourses", courses.size());
        
        request.getRequestDispatcher("/pages/course/search.jsp").forward(request, response);
    }
    
    /**
     * Helper to get int parameter with default
     */
    private int getIntParam(HttpServletRequest request, String name, int defaultValue) {
        String value = request.getParameter(name);
        if (value != null && !value.isEmpty()) {
            try {
                return Integer.parseInt(value);
            } catch (NumberFormatException e) {
                return defaultValue;
            }
        }
        return defaultValue;
    }
}
