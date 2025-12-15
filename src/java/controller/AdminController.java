/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;
import dao.CourseDAO;
import dao.UserDAO;
import dao.CategoryDAO;
import model.Course;
import model.User;
import model.Category;

import java.sql.SQLException;
import java.util.List;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author user
 */
@WebServlet(name = "AdminController", urlPatterns = {"/AdminController"})
public class AdminController extends HttpServlet {

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
    private UserDAO userDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAO();
        userDAO = new UserDAO();
        categoryDAO = new CategoryDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!user.isAdmin()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        String pathInfo = request.getPathInfo();
        try {
            if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/dashboard")) {
                showDashboard(request, response);
            } else if (pathInfo.equals("/users")) {
                listUsers(request, response);
            } else if (pathInfo.equals("/courses")) {
                listCourses(request, response);
            } else if (pathInfo.equals("/categories")) {
                listCategories(request, response);
            } else {
                showDashboard(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error");
            request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
        }
    }
    
    private void showDashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        int totalStudents = userDAO.countByRole(User.Role.STUDENT);
        int totalLecturers = userDAO.countByRole(User.Role.LECTURER);
        int totalCourses = courseDAO.countPublished();
        
        List<User> recentUsers = userDAO.findAll(1, 5);
        List<Course> recentCourses = courseDAO.findNewest(5);
        
        request.setAttribute("totalStudents", totalStudents);
        request.setAttribute("totalLecturers", totalLecturers);
        request.setAttribute("totalCourses", totalCourses);
        request.setAttribute("recentUsers", recentUsers);
        request.setAttribute("recentCourses", recentCourses);
        
        request.getRequestDispatcher("/pages/admin/dashboard.jsp").forward(request, response);
    }
    
    private void listUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        List<User> users = userDAO.findAll(1, 50);
        request.setAttribute("users", users);
        request.getRequestDispatcher("/pages/admin/users.jsp").forward(request, response);
    }
    
    private void listCourses(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        List<Course> courses = courseDAO.findPublished(1, 50);
        request.setAttribute("courses", courses);
        request.getRequestDispatcher("/pages/admin/courses.jsp").forward(request, response);
    }
    
    private void listCategories(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        List<Category> categories = categoryDAO.findAll();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/pages/admin/categories.jsp").forward(request, response);
    }   
}
