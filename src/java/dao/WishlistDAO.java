/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Wishlist;
import model.Course;
import model.User;
import model.Category;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class untuk Wishlist
 * @author user
 */
public class WishlistDAO {
    
    /**
     * Add course to wishlist
     */
    public boolean add(int studentId, int courseId) throws SQLException {
        // Check if already in wishlist
        if (isInWishlist(studentId, courseId)) {
            return false;
        }
        
        String sql = "INSERT INTO wishlist (user_id, course_id) VALUES (?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Remove course from wishlist
     */
    public boolean remove(int studentId, int courseId) throws SQLException {
        String sql = "DELETE FROM wishlist WHERE user_id = ? AND course_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Remove by wishlist ID
     */
    public boolean removeById(int wishlistId) throws SQLException {
        String sql = "DELETE FROM wishlist WHERE wishlist_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, wishlistId);
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Get wishlist by student
     */
    public List<Wishlist> getByStudent(int studentId) throws SQLException {
        List<Wishlist> wishlist = new ArrayList<>();
        String sql = "SELECT w.*, c.course_id, c.title, c.slug, c.thumbnail, c.price, c.discount_price, " +
                     "c.is_free, c.avg_rating, c.total_students, " +
                     "u.name as lecturer_name, cat.name as category_name " +
                     "FROM wishlist w " +
                     "JOIN courses c ON w.course_id = c.course_id " +
                     "JOIN users u ON c.lecturer_id = u.user_id " +
                     "JOIN categories cat ON c.category_id = cat.category_id " +
                     "WHERE w.user_id = ? " +
                     "ORDER BY w.added_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    wishlist.add(mapResultSet(rs));
                }
            }
        }
        return wishlist;
    }
    
    /**
     * Get wishlist by student with pagination
     */
    public List<Wishlist> getByStudent(int studentId, int page, int pageSize) throws SQLException {
        List<Wishlist> wishlist = new ArrayList<>();
        String sql = "SELECT w.*, c.course_id, c.title, c.slug, c.thumbnail, c.price, c.discount_price, " +
                     "c.is_free, c.avg_rating, c.total_students, " +
                     "u.name as lecturer_name, cat.name as category_name " +
                     "FROM wishlist w " +
                     "JOIN courses c ON w.course_id = c.course_id " +
                     "JOIN users u ON c.lecturer_id = u.user_id " +
                     "JOIN categories cat ON c.category_id = cat.category_id " +
                     "WHERE w.user_id = ? " +
                     "ORDER BY w.added_at DESC " +
                     "LIMIT ? OFFSET ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            ps.setInt(2, pageSize);
            ps.setInt(3, (page - 1) * pageSize);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    wishlist.add(mapResultSet(rs));
                }
            }
        }
        return wishlist;
    }
    
    /**
     * Check if course is in wishlist
     */
    public boolean isInWishlist(int studentId, int courseId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM wishlist WHERE user_id = ? AND course_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }
    
    /**
     * Toggle wishlist (add if not exists, remove if exists)
     */
    public boolean toggle(int studentId, int courseId) throws SQLException {
        if (isInWishlist(studentId, courseId)) {
            return remove(studentId, courseId);
        } else {
            return add(studentId, courseId);
        }
    }
    
    /**
     * Count wishlist items
     */
    public int count(int studentId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM wishlist WHERE user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    
    /**
     * Clear wishlist
     */
    public boolean clear(int studentId) throws SQLException {
        String sql = "DELETE FROM wishlist WHERE user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Move from wishlist to cart
     */
    public boolean moveToCart(int studentId, int courseId) throws SQLException {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);
            
            // Add to cart
            String cartSql = "INSERT IGNORE INTO cart_items (user_id, course_id) VALUES (?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(cartSql)) {
                ps.setInt(1, studentId);
                ps.setInt(2, courseId);
                ps.executeUpdate();
            }
            
            // Remove from wishlist
            String wishlistSql = "DELETE FROM wishlist WHERE user_id = ? AND course_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(wishlistSql)) {
                ps.setInt(1, studentId);
                ps.setInt(2, courseId);
                ps.executeUpdate();
            }
            
            conn.commit();
            return true;
            
        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }
    
    /**
     * Get popular wishlisted courses
     */
    public List<Course> getPopularWishlistedCourses(int limit) throws SQLException {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.*, COUNT(w.wishlist_id) as wishlist_count, " +
                     "u.name as lecturer_name, cat.name as category_name " +
                     "FROM wishlist w " +
                     "JOIN courses c ON w.course_id = c.course_id " +
                     "JOIN users u ON c.lecturer_id = u.user_id " +
                     "JOIN categories cat ON c.category_id = cat.category_id " +
                     "WHERE c.status = 'PUBLISHED' " +
                     "GROUP BY c.course_id " +
                     "ORDER BY wishlist_count DESC " +
                     "LIMIT ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Course course = new Course();
                    course.setCourseId(rs.getInt("course_id"));
                    course.setTitle(rs.getString("title"));
                    course.setSlug(rs.getString("slug"));
                    course.setThumbnail(rs.getString("thumbnail"));
                    course.setPrice(rs.getBigDecimal("price"));
                    course.setDiscountPrice(rs.getBigDecimal("discount_price"));
                    course.setFree(rs.getBoolean("is_free"));
                    course.setAvgRating(rs.getBigDecimal("avg_rating"));
                    course.setTotalStudents(rs.getInt("total_students"));
                    
                    User lecturer = new User();
                    lecturer.setName(rs.getString("lecturer_name"));
                    course.setLecturer(lecturer);
                    
                    Category category = new Category();
                    category.setName(rs.getString("category_name"));
                    course.setCategory(category);
                    
                    courses.add(course);
                }
            }
        }
        return courses;
    }
    
    private Wishlist mapResultSet(ResultSet rs) throws SQLException {
        Wishlist wishlist = new Wishlist();
        wishlist.setWishlistId(rs.getInt("wishlist_id"));
        wishlist.setStudentId(rs.getInt("user_id"));
        wishlist.setCourseId(rs.getInt("course_id"));
        wishlist.setAddedAt(rs.getTimestamp("added_at"));
        
        // Map course
        Course course = new Course();
        course.setCourseId(rs.getInt("course_id"));
        course.setTitle(rs.getString("title"));
        course.setSlug(rs.getString("slug"));
        course.setThumbnail(rs.getString("thumbnail"));
        course.setPrice(rs.getBigDecimal("price"));
        course.setDiscountPrice(rs.getBigDecimal("discount_price"));
        course.setFree(rs.getBoolean("is_free"));
        course.setAvgRating(rs.getBigDecimal("avg_rating"));
        course.setTotalStudents(rs.getInt("total_students"));
        
        // Map lecturer
        User lecturer = new User();
        lecturer.setName(rs.getString("lecturer_name"));
        course.setLecturer(lecturer);
        
        // Map category
        Category category = new Category();
        category.setName(rs.getString("category_name"));
        course.setCategory(category);
        
        wishlist.setCourse(course);
        
        return wishlist;
    }
}
