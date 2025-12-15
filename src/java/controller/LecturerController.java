/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;
import dao.CourseDAO;
import dao.EnrollmentDAO;
import dao.UserDAO;
import model.Course;
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
@WebServlet(name = "LecturerController", urlPatterns = {"/LecturerController"})
public class LecturerController extends HttpServlet {

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
    private EnrollmentDAO enrollmentDAO;
    
    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAO();
        enrollmentDAO = new EnrollmentDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!user.isLecturer() && !user.isAdmin()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        String pathInfo = request.getPathInfo();
        try {
            if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/dashboard")) {
                showDashboard(request, response, user);
            } else if (pathInfo.equals("/courses")) {
                listCourses(request, response, user);
            } else if (pathInfo.equals("/course/create")) {
                showCreateCourse(request, response);
            } else {
                showDashboard(request, response, user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error");
            request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Implement POST handlers for course creation, update, etc.
    }
    
    private void showDashboard(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException, SQLException {
        List<Course> courses = courseDAO.findByLecturer(user.getUserId());
        request.setAttribute("courses", courses);
        request.setAttribute("totalCourses", courses.size());
        // TODO: Calculate total students
        request.getRequestDispatcher("/pages/lecturer/dashboard.jsp").forward(request, response);
    }
    
    private void listCourses(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException, SQLException {
        List<Course> courses = courseDAO.findByLecturer(user.getUserId());
        request.setAttribute("courses", courses);
        request.getRequestDispatcher("/pages/lecturer/courses.jsp").forward(request, response);
    }
    
    private void showCreateCourse(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Load categories for dropdown
        request.getRequestDispatcher("/pages/lecturer/course-form.jsp").forward(request, response);
    }
}
