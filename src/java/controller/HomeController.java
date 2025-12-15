/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;
import dao.CourseDAO;
import dao.CategoryDAO;
import dao.UserDAO;
import model.Course;
import model.Category;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author user
 */
@WebServlet(name = "HomeController", urlPatterns = {"/HomeController"})
public class HomeController extends HttpServlet {

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
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAO();
        categoryDAO = new CategoryDAO();
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get featured courses
            List<Course> featuredCourses = courseDAO.findFeatured(6);
            request.setAttribute("featuredCourses", featuredCourses);
            
            // Get popular courses
            List<Course> popularCourses = courseDAO.findPopular(8);
            request.setAttribute("popularCourses", popularCourses);
            
            // Get newest courses
            List<Course> newestCourses = courseDAO.findNewest(8);
            request.setAttribute("newestCourses", newestCourses);
            
            // Get categories
            List<Category> categories = categoryDAO.findAllActive();
            request.setAttribute("categories", categories);
            
            // Get statistics
            int totalCourses = courseDAO.countPublished();
            int totalStudents = userDAO.countByRole(model.User.Role.STUDENT);
            int totalLecturers = userDAO.countByRole(model.User.Role.LECTURER);
            
            request.setAttribute("totalCourses", totalCourses);
            request.setAttribute("totalStudents", totalStudents);
            request.setAttribute("totalLecturers", totalLecturers);
            
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Terjadi kesalahan saat memuat data");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}
