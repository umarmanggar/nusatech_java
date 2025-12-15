/*
 * AdminController.java
 * Handles all admin-related routes
 */
package controller;

import dao.CourseDAO;
import dao.UserDAO;
import dao.CategoryDAO;
import dao.EnrollmentDAO;
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
 * Controller for admin-specific operations
 */
@WebServlet(name = "AdminController", urlPatterns = {"/AdminController"})
public class AdminController extends HttpServlet {

    private CourseDAO courseDAO;
    private UserDAO userDAO;
    private CategoryDAO categoryDAO;
    private EnrollmentDAO enrollmentDAO;

    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAO();
        userDAO = new UserDAO();
        categoryDAO = new CategoryDAO();
        enrollmentDAO = new EnrollmentDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
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
            } else if (pathInfo.equals("/transactions")) {
                listTransactions(request, response);
            } else if (pathInfo.equals("/settings")) {
                showSettings(request, response);
            } else {
                showDashboard(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/pages/error/500.jsp").forward(request, response);
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
        if (!user.isAdmin()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        String pathInfo = request.getPathInfo();
        try {
            if (pathInfo != null) {
                if (pathInfo.equals("/user/toggle-status")) {
                    toggleUserStatus(request, response);
                } else if (pathInfo.equals("/user/create")) {
                    createUser(request, response);
                } else if (pathInfo.equals("/course/approve")) {
                    approveCourse(request, response);
                } else if (pathInfo.equals("/course/reject")) {
                    rejectCourse(request, response);
                } else if (pathInfo.equals("/course/toggle-featured")) {
                    toggleCourseFeatured(request, response);
                } else if (pathInfo.equals("/category/create")) {
                    createCategory(request, response);
                } else if (pathInfo.equals("/category/update")) {
                    updateCategory(request, response);
                } else if (pathInfo.equals("/category/delete")) {
                    deleteCategory(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/pages/error/500.jsp").forward(request, response);
        }
    }
    
    private void showDashboard(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        // Count statistics
        int totalStudents = userDAO.countByRole(User.Role.STUDENT);
        int totalLecturers = userDAO.countByRole(User.Role.LECTURER);
        int totalCourses = courseDAO.countPublished();
        
        // Get recent data
        List<User> recentUsers = userDAO.findAll(1, 5);
        List<Course> recentCourses = courseDAO.findNewest(5);
        List<Category> categories = categoryDAO.findAllActive();
        
        // Count by role for stats
        int totalAdmins = userDAO.countByRole(User.Role.ADMIN);
        
        request.setAttribute("totalStudents", totalStudents);
        request.setAttribute("totalLecturers", totalLecturers);
        request.setAttribute("totalCourses", totalCourses);
        request.setAttribute("totalAdmins", totalAdmins);
        request.setAttribute("recentUsers", recentUsers);
        request.setAttribute("recentCourses", recentCourses);
        request.setAttribute("categories", categories);
        
        request.getRequestDispatcher("/pages/admin/dashboard.jsp").forward(request, response);
    }
    
    private void listUsers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        // Get filter parameters
        String roleFilter = request.getParameter("role");
        String statusFilter = request.getParameter("status");
        String searchQuery = request.getParameter("search");
        int page = 1;
        int pageSize = 20;
        
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                page = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            // Use default
        }
        
        List<User> users;
        int totalUsers;
        
        if (roleFilter != null && !roleFilter.isEmpty()) {
            User.Role role = User.Role.valueOf(roleFilter);
            users = userDAO.findByRole(role);
            totalUsers = users.size();
        } else if (searchQuery != null && !searchQuery.isEmpty()) {
            users = userDAO.search(searchQuery, 100);
            totalUsers = users.size();
        } else {
            users = userDAO.findAll(page, pageSize);
            totalUsers = userDAO.countByRole(User.Role.STUDENT) + 
                        userDAO.countByRole(User.Role.LECTURER) + 
                        userDAO.countByRole(User.Role.ADMIN);
        }
        
        // Count by role for filter badges
        int studentCount = userDAO.countByRole(User.Role.STUDENT);
        int lecturerCount = userDAO.countByRole(User.Role.LECTURER);
        int adminCount = userDAO.countByRole(User.Role.ADMIN);
        
        request.setAttribute("users", users);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("studentCount", studentCount);
        request.setAttribute("lecturerCount", lecturerCount);
        request.setAttribute("adminCount", adminCount);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", (int) Math.ceil((double) totalUsers / pageSize));
        
        request.getRequestDispatcher("/pages/admin/users.jsp").forward(request, response);
    }
    
    private void listCourses(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        String statusFilter = request.getParameter("status");
        String categoryFilter = request.getParameter("category");
        int page = 1;
        int pageSize = 20;
        
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                page = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            // Use default
        }
        
        // Get all courses (admin can see all statuses)
        List<Course> courses = courseDAO.findPublished(page, pageSize);
        
        // Get categories for filter dropdown
        List<Category> categories = categoryDAO.findAllActive();
        
        request.setAttribute("courses", courses);
        request.setAttribute("categories", categories);
        request.setAttribute("currentPage", page);
        
        request.getRequestDispatcher("/pages/admin/courses.jsp").forward(request, response);
    }
    
    private void listCategories(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        List<Category> categories = categoryDAO.findAll();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/pages/admin/categories.jsp").forward(request, response);
    }
    
    private void listTransactions(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        // TODO: Implement transaction listing
        request.getRequestDispatcher("/pages/admin/transactions.jsp").forward(request, response);
    }
    
    private void showSettings(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        // TODO: Load settings from database
        request.getRequestDispatcher("/pages/admin/settings.jsp").forward(request, response);
    }
    
    // POST handlers
    
    private void toggleUserStatus(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        String userIdStr = request.getParameter("userId");
        if (userIdStr == null || userIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        int userId = Integer.parseInt(userIdStr);
        User user = userDAO.findById(userId);
        
        if (user != null) {
            user.setActive(!user.isActive());
            userDAO.update(user);
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
    
    private void createUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String roleStr = request.getParameter("role");
        
        if (email == null || password == null || name == null || roleStr == null) {
            request.setAttribute("error", "Semua field harus diisi");
            listUsers(request, response);
            return;
        }
        
        // Check if email already exists
        if (userDAO.emailExists(email)) {
            request.setAttribute("error", "Email sudah terdaftar");
            listUsers(request, response);
            return;
        }
        
        User newUser = new User();
        newUser.setEmail(email);
        newUser.setPassword(password); // Will be hashed in DAO
        newUser.setName(name);
        newUser.setRole(User.Role.valueOf(roleStr));
        newUser.setActive(true);
        newUser.setEmailVerified(true);
        
        int userId = userDAO.create(newUser);
        
        if (userId > 0) {
            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "User berhasil ditambahkan");
        } else {
            request.setAttribute("error", "Gagal menambahkan user");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
    
    private void approveCourse(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        String courseIdStr = request.getParameter("courseId");
        if (courseIdStr == null || courseIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        int courseId = Integer.parseInt(courseIdStr);
        courseDAO.updateStatus(courseId, Course.Status.PUBLISHED);
        
        HttpSession session = request.getSession();
        session.setAttribute("successMessage", "Kursus berhasil dipublikasikan");
        
        response.sendRedirect(request.getContextPath() + "/admin/courses");
    }
    
    private void rejectCourse(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        String courseIdStr = request.getParameter("courseId");
        if (courseIdStr == null || courseIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        int courseId = Integer.parseInt(courseIdStr);
        courseDAO.updateStatus(courseId, Course.Status.DRAFT);
        
        HttpSession session = request.getSession();
        session.setAttribute("successMessage", "Kursus ditolak dan dikembalikan ke draft");
        
        response.sendRedirect(request.getContextPath() + "/admin/courses");
    }
    
    private void toggleCourseFeatured(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        String courseIdStr = request.getParameter("courseId");
        if (courseIdStr == null || courseIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        int courseId = Integer.parseInt(courseIdStr);
        Course course = courseDAO.findById(courseId);
        
        if (course != null) {
            course.setFeatured(!course.isFeatured());
            courseDAO.update(course);
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/courses");
    }
    
    private void createCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        Category category = new Category();
        category.setName(request.getParameter("name"));
        category.setSlug(request.getParameter("slug"));
        category.setDescription(request.getParameter("description"));
        category.setIcon(request.getParameter("icon"));
        category.setColor(request.getParameter("color"));
        category.setActive("true".equals(request.getParameter("isActive")));
        
        String displayOrder = request.getParameter("displayOrder");
        if (displayOrder != null && !displayOrder.isEmpty()) {
            category.setDisplayOrder(Integer.parseInt(displayOrder));
        }
        
        // Check if slug exists
        if (categoryDAO.slugExists(category.getSlug())) {
            request.setAttribute("error", "Slug sudah digunakan");
            listCategories(request, response);
            return;
        }
        
        int categoryId = categoryDAO.create(category);
        
        if (categoryId > 0) {
            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Kategori berhasil ditambahkan");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/categories");
    }
    
    private void updateCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        String categoryIdStr = request.getParameter("categoryId");
        if (categoryIdStr == null || categoryIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        int categoryId = Integer.parseInt(categoryIdStr);
        Category category = categoryDAO.findById(categoryId);
        
        if (category == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        category.setName(request.getParameter("name"));
        category.setSlug(request.getParameter("slug"));
        category.setDescription(request.getParameter("description"));
        category.setIcon(request.getParameter("icon"));
        category.setColor(request.getParameter("color"));
        category.setActive("true".equals(request.getParameter("isActive")));
        
        String displayOrder = request.getParameter("displayOrder");
        if (displayOrder != null && !displayOrder.isEmpty()) {
            category.setDisplayOrder(Integer.parseInt(displayOrder));
        }
        
        categoryDAO.update(category);
        
        HttpSession session = request.getSession();
        session.setAttribute("successMessage", "Kategori berhasil diperbarui");
        
        response.sendRedirect(request.getContextPath() + "/admin/categories");
    }
    
    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        String categoryIdStr = request.getParameter("categoryId");
        if (categoryIdStr == null || categoryIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        int categoryId = Integer.parseInt(categoryIdStr);
        
        // Check if category has courses
        int courseCount = courseDAO.countByCategory(categoryId);
        if (courseCount > 0) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Tidak dapat menghapus kategori yang memiliki kursus");
            response.sendRedirect(request.getContextPath() + "/admin/categories");
            return;
        }
        
        categoryDAO.delete(categoryId);
        
        HttpSession session = request.getSession();
        session.setAttribute("successMessage", "Kategori berhasil dihapus");
        
        response.sendRedirect(request.getContextPath() + "/admin/categories");
    }
}
