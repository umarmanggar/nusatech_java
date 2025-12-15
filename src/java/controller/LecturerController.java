/*
 * LecturerController.java
 * Handles all lecturer-related routes
 */
package controller;

import dao.CourseDAO;
import dao.EnrollmentDAO;
import dao.CategoryDAO;
import dao.SectionDAO;
import dao.MaterialDAO;
import model.Course;
import model.Category;
import model.Section;
import model.Material;
import model.User;

import java.io.IOException;
import java.math.BigDecimal;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;

/**
 * Controller for lecturer-specific operations
 */
@WebServlet(name = "LecturerController", urlPatterns = {"/LecturerController"})
public class LecturerController extends HttpServlet {

    private CourseDAO courseDAO;
    private EnrollmentDAO enrollmentDAO;
    private CategoryDAO categoryDAO;
    private SectionDAO sectionDAO;
    private MaterialDAO materialDAO;
    
    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAO();
        enrollmentDAO = new EnrollmentDAO();
        categoryDAO = new CategoryDAO();
        sectionDAO = new SectionDAO();
        materialDAO = new MaterialDAO();
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
            } else if (pathInfo.startsWith("/course/edit/")) {
                showEditCourse(request, response, user, pathInfo);
            } else if (pathInfo.startsWith("/course/content/")) {
                showCourseContent(request, response, user, pathInfo);
            } else if (pathInfo.equals("/earnings")) {
                showEarnings(request, response, user);
            } else if (pathInfo.equals("/students")) {
                showStudents(request, response, user);
            } else if (pathInfo.equals("/profile")) {
                showProfile(request, response, user);
            } else {
                showDashboard(request, response, user);
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
        if (!user.isLecturer() && !user.isAdmin()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        String pathInfo = request.getPathInfo();
        try {
            if (pathInfo != null) {
                if (pathInfo.equals("/course/create")) {
                    createCourse(request, response, user);
                } else if (pathInfo.equals("/course/update")) {
                    updateCourse(request, response, user);
                } else if (pathInfo.equals("/section/create")) {
                    createSection(request, response, user);
                } else if (pathInfo.equals("/section/update")) {
                    updateSection(request, response, user);
                } else if (pathInfo.equals("/section/delete")) {
                    deleteSection(request, response, user);
                } else if (pathInfo.equals("/material/create")) {
                    createMaterial(request, response, user);
                } else if (pathInfo.equals("/material/update")) {
                    updateMaterial(request, response, user);
                } else if (pathInfo.equals("/material/delete")) {
                    deleteMaterial(request, response, user);
                } else {
                    response.sendRedirect(request.getContextPath() + "/lecturer/dashboard");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/pages/error/500.jsp").forward(request, response);
        }
    }
    
    private void showDashboard(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException, SQLException {
        List<Course> courses = courseDAO.findByLecturer(user.getUserId());
        request.setAttribute("courses", courses);
        request.setAttribute("totalCourses", courses.size());
        
        // Calculate total students across all courses
        int totalStudents = 0;
        for (Course course : courses) {
            totalStudents += course.getTotalStudents();
        }
        request.setAttribute("totalStudents", totalStudents);
        
        // Calculate average rating
        double totalRating = 0;
        int ratedCourses = 0;
        for (Course course : courses) {
            if (course.getAvgRating() != null && course.getAvgRating().doubleValue() > 0) {
                totalRating += course.getAvgRating().doubleValue();
                ratedCourses++;
            }
        }
        double avgRating = ratedCourses > 0 ? totalRating / ratedCourses : 0;
        request.setAttribute("avgRating", avgRating);
        
        request.getRequestDispatcher("/pages/lecturer/dashboard.jsp").forward(request, response);
    }
    
    private void listCourses(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException, SQLException {
        List<Course> courses = courseDAO.findByLecturer(user.getUserId());
        
        // Filter by status if specified
        String status = request.getParameter("status");
        if (status != null && !status.isEmpty()) {
            courses.removeIf(c -> !c.getStatus().name().equals(status));
        }
        
        // Count courses by status
        List<Course> allCourses = courseDAO.findByLecturer(user.getUserId());
        long publishedCount = allCourses.stream().filter(c -> c.getStatus().name().equals("PUBLISHED")).count();
        long pendingCount = allCourses.stream().filter(c -> c.getStatus().name().equals("PENDING")).count();
        long draftCount = allCourses.stream().filter(c -> c.getStatus().name().equals("DRAFT")).count();
        
        // Calculate total students
        int totalStudents = 0;
        for (Course course : allCourses) {
            totalStudents += course.getTotalStudents();
        }
        
        request.setAttribute("courses", courses);
        request.setAttribute("publishedCount", publishedCount);
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("draftCount", draftCount);
        request.setAttribute("totalStudents", totalStudents);
        
        request.getRequestDispatcher("/pages/lecturer/courses.jsp").forward(request, response);
    }
    
    private void showCreateCourse(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        List<Category> categories = categoryDAO.findAllActive();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/pages/lecturer/course-form.jsp").forward(request, response);
    }
    
    private void showEditCourse(HttpServletRequest request, HttpServletResponse response, User user, String pathInfo) 
            throws ServletException, IOException, SQLException {
        String[] parts = pathInfo.split("/");
        if (parts.length < 4) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        int courseId = Integer.parseInt(parts[3]);
        Course course = courseDAO.findById(courseId);
        
        if (course == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Kursus tidak ditemukan");
            return;
        }
        
        // Check ownership
        if (course.getLecturerId() != user.getUserId() && !user.isAdmin()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Anda tidak memiliki akses ke kursus ini");
            return;
        }
        
        List<Category> categories = categoryDAO.findAllActive();
        request.setAttribute("categories", categories);
        request.setAttribute("course", course);
        request.getRequestDispatcher("/pages/lecturer/course-form.jsp").forward(request, response);
    }
    
    private void showCourseContent(HttpServletRequest request, HttpServletResponse response, User user, String pathInfo) 
            throws ServletException, IOException, SQLException {
        String[] parts = pathInfo.split("/");
        if (parts.length < 4) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        int courseId = Integer.parseInt(parts[3]);
        Course course = courseDAO.findById(courseId);
        
        if (course == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Kursus tidak ditemukan");
            return;
        }
        
        // Check ownership
        if (course.getLecturerId() != user.getUserId() && !user.isAdmin()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Anda tidak memiliki akses ke kursus ini");
            return;
        }
        
        // Get sections with materials
        List<Section> sections = sectionDAO.findByCourse(courseId);
        for (Section section : sections) {
            List<Material> materials = materialDAO.findBySection(section.getSectionId());
            section.setMaterials(materials);
        }
        
        request.setAttribute("course", course);
        request.setAttribute("sections", sections);
        request.getRequestDispatcher("/pages/lecturer/course-content.jsp").forward(request, response);
    }
    
    private void showEarnings(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException, SQLException {
        // TODO: Implement earnings statistics from balance_history table
        request.getRequestDispatcher("/pages/lecturer/earnings.jsp").forward(request, response);
    }
    
    private void showStudents(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException, SQLException {
        // TODO: Get list of students enrolled in lecturer's courses
        request.getRequestDispatcher("/pages/lecturer/students.jsp").forward(request, response);
    }
    
    private void showProfile(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException, SQLException {
        request.setAttribute("user", user);
        request.getRequestDispatcher("/pages/lecturer/profile.jsp").forward(request, response);
    }
    
    private void createCourse(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException, SQLException {
        Course course = new Course();
        course.setLecturerId(user.getUserId());
        
        // Get form data
        course.setTitle(request.getParameter("title"));
        course.setSlug(request.getParameter("slug"));
        course.setShortDescription(request.getParameter("shortDescription"));
        course.setDescription(request.getParameter("description"));
        course.setObjectives(request.getParameter("objectives"));
        course.setRequirements(request.getParameter("requirements"));
        course.setTargetAudience(request.getParameter("targetAudience"));
        course.setPreviewVideo(request.getParameter("previewVideo"));
        
        // Category
        String categoryId = request.getParameter("categoryId");
        if (categoryId != null && !categoryId.isEmpty()) {
            course.setCategoryId(Integer.parseInt(categoryId));
        }
        
        // Level
        String level = request.getParameter("level");
        if (level != null) {
            course.setLevel(Course.Level.valueOf(level));
        }
        
        // Language
        course.setLanguage(request.getParameter("language"));
        
        // Duration
        String duration = request.getParameter("durationHours");
        if (duration != null && !duration.isEmpty()) {
            course.setDurationHours(Integer.parseInt(duration));
        }
        
        // Price settings
        boolean isFree = "true".equals(request.getParameter("isFree"));
        course.setFree(isFree);
        
        if (!isFree) {
            String price = request.getParameter("price");
            if (price != null && !price.isEmpty()) {
                course.setPrice(new BigDecimal(price));
            }
            String discountPrice = request.getParameter("discountPrice");
            if (discountPrice != null && !discountPrice.isEmpty()) {
                course.setDiscountPrice(new BigDecimal(discountPrice));
            }
        } else {
            course.setPrice(BigDecimal.ZERO);
        }
        
        // Status
        String status = request.getParameter("status");
        if (status != null) {
            course.setStatus(Course.Status.valueOf(status));
        } else {
            course.setStatus(Course.Status.DRAFT);
        }
        
        // Check if slug exists
        if (courseDAO.slugExists(course.getSlug())) {
            request.setAttribute("error", "Slug sudah digunakan. Silakan pilih slug lain.");
            request.setAttribute("course", course);
            List<Category> categories = categoryDAO.findAllActive();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/pages/lecturer/course-form.jsp").forward(request, response);
            return;
        }
        
        // Create course
        int courseId = courseDAO.create(course);
        
        if (courseId > 0) {
            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Kursus berhasil dibuat!");
            response.sendRedirect(request.getContextPath() + "/lecturer/course/content/" + courseId);
        } else {
            request.setAttribute("error", "Gagal membuat kursus. Silakan coba lagi.");
            request.setAttribute("course", course);
            List<Category> categories = categoryDAO.findAllActive();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/pages/lecturer/course-form.jsp").forward(request, response);
        }
    }
    
    private void updateCourse(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException, SQLException {
        String courseIdStr = request.getParameter("courseId");
        if (courseIdStr == null || courseIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        int courseId = Integer.parseInt(courseIdStr);
        Course course = courseDAO.findById(courseId);
        
        if (course == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Kursus tidak ditemukan");
            return;
        }
        
        // Check ownership
        if (course.getLecturerId() != user.getUserId() && !user.isAdmin()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        // Update course data
        course.setTitle(request.getParameter("title"));
        course.setSlug(request.getParameter("slug"));
        course.setShortDescription(request.getParameter("shortDescription"));
        course.setDescription(request.getParameter("description"));
        course.setObjectives(request.getParameter("objectives"));
        course.setRequirements(request.getParameter("requirements"));
        course.setTargetAudience(request.getParameter("targetAudience"));
        course.setPreviewVideo(request.getParameter("previewVideo"));
        
        String categoryId = request.getParameter("categoryId");
        if (categoryId != null && !categoryId.isEmpty()) {
            course.setCategoryId(Integer.parseInt(categoryId));
        }
        
        String level = request.getParameter("level");
        if (level != null) {
            course.setLevel(Course.Level.valueOf(level));
        }
        
        course.setLanguage(request.getParameter("language"));
        
        String durationUpdate = request.getParameter("durationHours");
        if (durationUpdate != null && !durationUpdate.isEmpty()) {
            course.setDurationHours(Integer.parseInt(durationUpdate));
        }
        
        boolean isFree = "true".equals(request.getParameter("isFree"));
        course.setFree(isFree);
        
        if (!isFree) {
            String price = request.getParameter("price");
            if (price != null && !price.isEmpty()) {
                course.setPrice(new BigDecimal(price));
            }
            String discountPrice = request.getParameter("discountPrice");
            if (discountPrice != null && !discountPrice.isEmpty()) {
                course.setDiscountPrice(new BigDecimal(discountPrice));
            }
        } else {
            course.setPrice(BigDecimal.ZERO);
        }
        
        String status = request.getParameter("status");
        if (status != null && !course.getStatus().name().equals("PUBLISHED")) {
            course.setStatus(Course.Status.valueOf(status));
        }
        
        if (courseDAO.update(course)) {
            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Kursus berhasil diperbarui!");
            response.sendRedirect(request.getContextPath() + "/lecturer/courses");
        } else {
            request.setAttribute("error", "Gagal memperbarui kursus");
            request.setAttribute("course", course);
            List<Category> categories = categoryDAO.findAllActive();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/pages/lecturer/course-form.jsp").forward(request, response);
        }
    }
    
    private void createSection(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException, SQLException {
        String courseIdStr = request.getParameter("courseId");
        int courseId = Integer.parseInt(courseIdStr);
        
        Course course = courseDAO.findById(courseId);
        if (course == null || (course.getLecturerId() != user.getUserId() && !user.isAdmin())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        Section section = new Section();
        section.setCourseId(courseId);
        section.setTitle(request.getParameter("title"));
        section.setDescription(request.getParameter("description"));
        
        String displayOrder = request.getParameter("displayOrder");
        if (displayOrder != null && !displayOrder.isEmpty()) {
            section.setDisplayOrder(Integer.parseInt(displayOrder));
        }
        
        section.setPreview("true".equals(request.getParameter("isPreview")));
        
        sectionDAO.create(section);
        
        response.sendRedirect(request.getContextPath() + "/lecturer/course/content/" + courseId);
    }
    
    private void updateSection(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException, SQLException {
        String sectionIdStr = request.getParameter("sectionId");
        int sectionId = Integer.parseInt(sectionIdStr);
        
        Section section = sectionDAO.findById(sectionId);
        if (section == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        Course course = courseDAO.findById(section.getCourseId());
        if (course == null || (course.getLecturerId() != user.getUserId() && !user.isAdmin())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        section.setTitle(request.getParameter("title"));
        section.setDescription(request.getParameter("description"));
        
        String displayOrder = request.getParameter("displayOrder");
        if (displayOrder != null && !displayOrder.isEmpty()) {
            section.setDisplayOrder(Integer.parseInt(displayOrder));
        }
        
        section.setPreview("true".equals(request.getParameter("isPreview")));
        
        sectionDAO.update(section);
        
        response.sendRedirect(request.getContextPath() + "/lecturer/course/content/" + section.getCourseId());
    }
    
    private void deleteSection(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException, SQLException {
        String sectionIdStr = request.getParameter("sectionId");
        int sectionId = Integer.parseInt(sectionIdStr);
        
        Section section = sectionDAO.findById(sectionId);
        if (section == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        Course course = courseDAO.findById(section.getCourseId());
        if (course == null || (course.getLecturerId() != user.getUserId() && !user.isAdmin())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        sectionDAO.delete(sectionId);
        
        response.sendRedirect(request.getContextPath() + "/lecturer/course/content/" + section.getCourseId());
    }
    
    private void createMaterial(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException, SQLException {
        String sectionIdStr = request.getParameter("sectionId");
        int sectionId = Integer.parseInt(sectionIdStr);
        
        Section section = sectionDAO.findById(sectionId);
        if (section == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        Course course = courseDAO.findById(section.getCourseId());
        if (course == null || (course.getLecturerId() != user.getUserId() && !user.isAdmin())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        Material material = new Material();
        material.setSectionId(sectionId);
        material.setTitle(request.getParameter("title"));
        material.setContent(request.getParameter("content"));
        material.setVideoUrl(request.getParameter("videoUrl"));
        
        String contentType = request.getParameter("contentType");
        if (contentType != null) {
            material.setContentType(Material.ContentType.valueOf(contentType));
        }
        
        String videoDuration = request.getParameter("videoDuration");
        if (videoDuration != null && !videoDuration.isEmpty()) {
            material.setVideoDuration(Integer.parseInt(videoDuration));
        }
        
        String displayOrder = request.getParameter("displayOrder");
        if (displayOrder != null && !displayOrder.isEmpty()) {
            material.setDisplayOrder(Integer.parseInt(displayOrder));
        }
        
        material.setPreview("true".equals(request.getParameter("isPreview")));
        material.setMandatory(!"false".equals(request.getParameter("isMandatory")));
        
        materialDAO.create(material);
        
        // Update course statistics
        courseDAO.updateStatistics(section.getCourseId());
        
        response.sendRedirect(request.getContextPath() + "/lecturer/course/content/" + section.getCourseId());
    }
    
    private void updateMaterial(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException, SQLException {
        String materialIdStr = request.getParameter("materialId");
        int materialId = Integer.parseInt(materialIdStr);
        
        Material material = materialDAO.findById(materialId);
        if (material == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        Section section = sectionDAO.findById(material.getSectionId());
        Course course = courseDAO.findById(section.getCourseId());
        
        if (course == null || (course.getLecturerId() != user.getUserId() && !user.isAdmin())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        material.setTitle(request.getParameter("title"));
        material.setContent(request.getParameter("content"));
        material.setVideoUrl(request.getParameter("videoUrl"));
        
        String contentType = request.getParameter("contentType");
        if (contentType != null) {
            material.setContentType(Material.ContentType.valueOf(contentType));
        }
        
        String videoDuration = request.getParameter("videoDuration");
        if (videoDuration != null && !videoDuration.isEmpty()) {
            material.setVideoDuration(Integer.parseInt(videoDuration));
        }
        
        String displayOrder = request.getParameter("displayOrder");
        if (displayOrder != null && !displayOrder.isEmpty()) {
            material.setDisplayOrder(Integer.parseInt(displayOrder));
        }
        
        material.setPreview("true".equals(request.getParameter("isPreview")));
        material.setMandatory(!"false".equals(request.getParameter("isMandatory")));
        
        materialDAO.update(material);
        
        response.sendRedirect(request.getContextPath() + "/lecturer/course/content/" + section.getCourseId());
    }
    
    private void deleteMaterial(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException, SQLException {
        String materialIdStr = request.getParameter("materialId");
        int materialId = Integer.parseInt(materialIdStr);
        
        Material material = materialDAO.findById(materialId);
        if (material == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        Section section = sectionDAO.findById(material.getSectionId());
        Course course = courseDAO.findById(section.getCourseId());
        
        if (course == null || (course.getLecturerId() != user.getUserId() && !user.isAdmin())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        materialDAO.delete(materialId);
        
        // Update course statistics
        courseDAO.updateStatistics(section.getCourseId());
        
        response.sendRedirect(request.getContextPath() + "/lecturer/course/content/" + section.getCourseId());
    }
}
