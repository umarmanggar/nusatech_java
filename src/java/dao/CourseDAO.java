/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import model.Course;
import model.User;
import model.Category;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author user
 */
public class CourseDAO {
    public int create(Course course) throws SQLException {
        String sql = "INSERT INTO courses (lecturer_id, category_id, title, slug, description, short_description, " +
                     "thumbnail, preview_video, price, discount_price, level, language, requirements, objectives, " +
                     "target_audience, status, is_featured, is_free) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, course.getLecturerId());
            ps.setInt(2, course.getCategoryId());
            ps.setString(3, course.getTitle());
            ps.setString(4, course.getSlug());
            ps.setString(5, course.getDescription());
            ps.setString(6, course.getShortDescription());
            ps.setString(7, course.getThumbnail());
            ps.setString(8, course.getPreviewVideo());
            ps.setBigDecimal(9, course.getPrice());
            ps.setBigDecimal(10, course.getDiscountPrice());
            ps.setString(11, course.getLevel().name());
            ps.setString(12, course.getLanguage());
            ps.setString(13, course.getRequirements());
            ps.setString(14, course.getObjectives());
            ps.setString(15, course.getTargetAudience());
            ps.setString(16, course.getStatus().name());
            ps.setBoolean(17, course.isFeatured());
            ps.setBoolean(18, course.isFree());
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        int courseId = rs.getInt(1);
                        // Create forum for course
                        createForumForCourse(courseId, course.getTitle());
                        return courseId;
                    }
                }
            }
        }
        return -1;
    }
    
    /**
     * Create forum for course
     */
    private void createForumForCourse(int courseId, String courseTitle) throws SQLException {
        String sql = "INSERT INTO forums (course_id, title, description) VALUES (?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ps.setString(2, "Forum Diskusi: " + courseTitle);
            ps.setString(3, "Forum diskusi untuk kursus " + courseTitle);
            ps.executeUpdate();
        }
    }
    
    /**
     * Find course by ID
     */
    public Course findById(int courseId) throws SQLException {
        String sql = "SELECT c.*, u.name as lecturer_name, u.profile_picture as lecturer_avatar, " +
                     "cat.name as category_name, cat.slug as category_slug " +
                     "FROM courses c " +
                     "JOIN users u ON c.lecturer_id = u.user_id " +
                     "JOIN categories cat ON c.category_id = cat.category_id " +
                     "WHERE c.course_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, courseId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCourse(rs);
                }
            }
        }
        return null;
    }
    
    /**
     * Find course by slug
     */
    public Course findBySlug(String slug) throws SQLException {
        String sql = "SELECT c.*, u.name as lecturer_name, u.profile_picture as lecturer_avatar, " +
                     "cat.name as category_name, cat.slug as category_slug " +
                     "FROM courses c " +
                     "JOIN users u ON c.lecturer_id = u.user_id " +
                     "JOIN categories cat ON c.category_id = cat.category_id " +
                     "WHERE c.slug = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, slug);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCourse(rs);
                }
            }
        }
        return null;
    }
    
    /**
     * Get published courses with pagination
     */
    public List<Course> findPublished(int page, int pageSize) throws SQLException {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.*, u.name as lecturer_name, u.profile_picture as lecturer_avatar, " +
                     "cat.name as category_name, cat.slug as category_slug " +
                     "FROM courses c " +
                     "JOIN users u ON c.lecturer_id = u.user_id " +
                     "JOIN categories cat ON c.category_id = cat.category_id " +
                     "WHERE c.status = 'PUBLISHED' " +
                     "ORDER BY c.created_at DESC " +
                     "LIMIT ? OFFSET ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, pageSize);
            ps.setInt(2, (page - 1) * pageSize);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    courses.add(mapResultSetToCourse(rs));
                }
            }
        }
        return courses;
    }
    
    /**
     * Get featured courses
     */
    public List<Course> findFeatured(int limit) throws SQLException {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.*, u.name as lecturer_name, u.profile_picture as lecturer_avatar, " +
                     "cat.name as category_name, cat.slug as category_slug " +
                     "FROM courses c " +
                     "JOIN users u ON c.lecturer_id = u.user_id " +
                     "JOIN categories cat ON c.category_id = cat.category_id " +
                     "WHERE c.status = 'PUBLISHED' AND c.is_featured = TRUE " +
                     "ORDER BY c.avg_rating DESC, c.total_students DESC " +
                     "LIMIT ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    courses.add(mapResultSetToCourse(rs));
                }
            }
        }
        return courses;
    }
    
    /**
     * Get popular courses
     */
    public List<Course> findPopular(int limit) throws SQLException {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.*, u.name as lecturer_name, u.profile_picture as lecturer_avatar, " +
                     "cat.name as category_name, cat.slug as category_slug " +
                     "FROM courses c " +
                     "JOIN users u ON c.lecturer_id = u.user_id " +
                     "JOIN categories cat ON c.category_id = cat.category_id " +
                     "WHERE c.status = 'PUBLISHED' " +
                     "ORDER BY c.total_students DESC, c.avg_rating DESC " +
                     "LIMIT ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    courses.add(mapResultSetToCourse(rs));
                }
            }
        }
        return courses;
    }
    
    /**
     * Get newest courses
     */
    public List<Course> findNewest(int limit) throws SQLException {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.*, u.name as lecturer_name, u.profile_picture as lecturer_avatar, " +
                     "cat.name as category_name, cat.slug as category_slug " +
                     "FROM courses c " +
                     "JOIN users u ON c.lecturer_id = u.user_id " +
                     "JOIN categories cat ON c.category_id = cat.category_id " +
                     "WHERE c.status = 'PUBLISHED' " +
                     "ORDER BY c.published_at DESC " +
                     "LIMIT ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    courses.add(mapResultSetToCourse(rs));
                }
            }
        }
        return courses;
    }
    
    /**
     * Get courses by category
     */
    public List<Course> findByCategory(int categoryId, int page, int pageSize) throws SQLException {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.*, u.name as lecturer_name, u.profile_picture as lecturer_avatar, " +
                     "cat.name as category_name, cat.slug as category_slug " +
                     "FROM courses c " +
                     "JOIN users u ON c.lecturer_id = u.user_id " +
                     "JOIN categories cat ON c.category_id = cat.category_id " +
                     "WHERE c.status = 'PUBLISHED' AND c.category_id = ? " +
                     "ORDER BY c.created_at DESC " +
                     "LIMIT ? OFFSET ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, categoryId);
            ps.setInt(2, pageSize);
            ps.setInt(3, (page - 1) * pageSize);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    courses.add(mapResultSetToCourse(rs));
                }
            }
        }
        return courses;
    }
    
    /**
     * Get courses by lecturer
     */
    public List<Course> findByLecturer(int lecturerId) throws SQLException {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.*, u.name as lecturer_name, u.profile_picture as lecturer_avatar, " +
                     "cat.name as category_name, cat.slug as category_slug " +
                     "FROM courses c " +
                     "JOIN users u ON c.lecturer_id = u.user_id " +
                     "JOIN categories cat ON c.category_id = cat.category_id " +
                     "WHERE c.lecturer_id = ? " +
                     "ORDER BY c.created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, lecturerId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    courses.add(mapResultSetToCourse(rs));
                }
            }
        }
        return courses;
    }
    
    /**
     * Search courses
     */
    public List<Course> search(String keyword, int page, int pageSize) throws SQLException {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.*, u.name as lecturer_name, u.profile_picture as lecturer_avatar, " +
                     "cat.name as category_name, cat.slug as category_slug " +
                     "FROM courses c " +
                     "JOIN users u ON c.lecturer_id = u.user_id " +
                     "JOIN categories cat ON c.category_id = cat.category_id " +
                     "WHERE c.status = 'PUBLISHED' AND " +
                     "(c.title LIKE ? OR c.description LIKE ? OR c.short_description LIKE ?) " +
                     "ORDER BY c.total_students DESC " +
                     "LIMIT ? OFFSET ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ps.setInt(4, pageSize);
            ps.setInt(5, (page - 1) * pageSize);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    courses.add(mapResultSetToCourse(rs));
                }
            }
        }
        return courses;
    }
    
    /**
     * Update course
     */
    public boolean update(Course course) throws SQLException {
        String sql = "UPDATE courses SET category_id = ?, title = ?, slug = ?, description = ?, " +
                     "short_description = ?, thumbnail = ?, preview_video = ?, price = ?, discount_price = ?, " +
                     "level = ?, language = ?, requirements = ?, objectives = ?, target_audience = ?, " +
                     "status = ?, is_featured = ?, is_free = ? WHERE course_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, course.getCategoryId());
            ps.setString(2, course.getTitle());
            ps.setString(3, course.getSlug());
            ps.setString(4, course.getDescription());
            ps.setString(5, course.getShortDescription());
            ps.setString(6, course.getThumbnail());
            ps.setString(7, course.getPreviewVideo());
            ps.setBigDecimal(8, course.getPrice());
            ps.setBigDecimal(9, course.getDiscountPrice());
            ps.setString(10, course.getLevel().name());
            ps.setString(11, course.getLanguage());
            ps.setString(12, course.getRequirements());
            ps.setString(13, course.getObjectives());
            ps.setString(14, course.getTargetAudience());
            ps.setString(15, course.getStatus().name());
            ps.setBoolean(16, course.isFeatured());
            ps.setBoolean(17, course.isFree());
            ps.setInt(18, course.getCourseId());
            
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Update course status
     */
    public boolean updateStatus(int courseId, Course.Status status) throws SQLException {
        String sql = "UPDATE courses SET status = ?, published_at = ? WHERE course_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, status.name());
            ps.setTimestamp(2, status == Course.Status.PUBLISHED ? new Timestamp(System.currentTimeMillis()) : null);
            ps.setInt(3, courseId);
            
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Delete course
     */
    public boolean delete(int courseId) throws SQLException {
        String sql = "DELETE FROM courses WHERE course_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, courseId);
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Count published courses
     */
    public int countPublished() throws SQLException {
        String sql = "SELECT COUNT(*) FROM courses WHERE status = 'PUBLISHED'";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
    
    /**
     * Count courses by category
     */
    public int countByCategory(int categoryId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM courses WHERE category_id = ? AND status = 'PUBLISHED'";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, categoryId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    
    /**
     * Check if slug exists
     */
    public boolean slugExists(String slug) throws SQLException {
        String sql = "SELECT COUNT(*) FROM courses WHERE slug = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, slug);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }
    
    /**
     * Update course statistics
     */
    public void updateStatistics(int courseId) throws SQLException {
        String sql = "UPDATE courses c SET " +
                     "total_sections = (SELECT COUNT(*) FROM sections WHERE course_id = ?), " +
                     "total_materials = (SELECT COUNT(*) FROM materials m JOIN sections s ON m.section_id = s.section_id WHERE s.course_id = ?), " +
                     "duration_hours = (SELECT COALESCE(SUM(m.video_duration), 0) / 3600 FROM materials m JOIN sections s ON m.section_id = s.section_id WHERE s.course_id = ?) " +
                     "WHERE course_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, courseId);
            ps.setInt(2, courseId);
            ps.setInt(3, courseId);
            ps.setInt(4, courseId);
            ps.executeUpdate();
        }
    }
    
    /**
     * Map ResultSet to Course object
     */
    private Course mapResultSetToCourse(ResultSet rs) throws SQLException {
        Course course = new Course();
        course.setCourseId(rs.getInt("course_id"));
        course.setLecturerId(rs.getInt("lecturer_id"));
        course.setCategoryId(rs.getInt("category_id"));
        course.setTitle(rs.getString("title"));
        course.setSlug(rs.getString("slug"));
        course.setDescription(rs.getString("description"));
        course.setShortDescription(rs.getString("short_description"));
        course.setThumbnail(rs.getString("thumbnail"));
        course.setPreviewVideo(rs.getString("preview_video"));
        course.setPrice(rs.getBigDecimal("price"));
        course.setDiscountPrice(rs.getBigDecimal("discount_price"));
        course.setLevel(Course.Level.valueOf(rs.getString("level")));
        course.setLanguage(rs.getString("language"));
        course.setDurationHours(rs.getInt("duration_hours"));
        course.setTotalSections(rs.getInt("total_sections"));
        course.setTotalMaterials(rs.getInt("total_materials"));
        course.setTotalStudents(rs.getInt("total_students"));
        course.setAvgRating(rs.getBigDecimal("avg_rating"));
        course.setTotalReviews(rs.getInt("total_reviews"));
        course.setRequirements(rs.getString("requirements"));
        course.setObjectives(rs.getString("objectives"));
        course.setTargetAudience(rs.getString("target_audience"));
        course.setStatus(Course.Status.valueOf(rs.getString("status")));
        course.setFeatured(rs.getBoolean("is_featured"));
        course.setFree(rs.getBoolean("is_free"));
        course.setCreatedAt(rs.getTimestamp("created_at"));
        course.setUpdatedAt(rs.getTimestamp("updated_at"));
        course.setPublishedAt(rs.getTimestamp("published_at"));
        
        // Map related lecturer
        try {
            User lecturer = new User();
            lecturer.setUserId(course.getLecturerId());
            lecturer.setName(rs.getString("lecturer_name"));
            lecturer.setProfilePicture(rs.getString("lecturer_avatar"));
            course.setLecturer(lecturer);
        } catch (SQLException e) {
            // Columns might not exist
        }
        
        // Map related category
        try {
            Category category = new Category();
            category.setCategoryId(course.getCategoryId());
            category.setName(rs.getString("category_name"));
            category.setSlug(rs.getString("category_slug"));
            course.setCategory(category);
        } catch (SQLException e) {
            // Columns might not exist
        }
        
        return course;
    }
}
