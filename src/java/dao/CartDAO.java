/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Cart;
import model.CartItem;
import model.Course;
import model.User;
import model.Category;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

/**
 * DAO class untuk Shopping Cart
 * @author user
 */
public class CartDAO {
    
    /**
     * Get cart for a student (creates one if not exists)
     */
    public Cart getCart(int studentId) throws SQLException {
        Cart cart = new Cart(studentId);
        cart.setItems(getCartItems(studentId));
        return cart;
    }
    
    /**
     * Get cart items for a student
     */
    public List<CartItem> getCartItems(int studentId) throws SQLException {
        List<CartItem> items = new ArrayList<>();
        String sql = "SELECT ci.*, c.course_id, c.title, c.slug, c.thumbnail, c.price, c.discount_price, " +
                     "c.is_free, u.name as lecturer_name, cat.name as category_name " +
                     "FROM cart_items ci " +
                     "JOIN courses c ON ci.course_id = c.course_id " +
                     "JOIN users u ON c.lecturer_id = u.user_id " +
                     "JOIN categories cat ON c.category_id = cat.category_id " +
                     "WHERE ci.user_id = ? " +
                     "ORDER BY ci.added_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem();
                    item.setCartItemId(rs.getInt("cart_id"));
                    item.setCourseId(rs.getInt("course_id"));
                    item.setAddedAt(rs.getTimestamp("added_at"));
                    
                    // Map course
                    Course course = new Course();
                    course.setCourseId(rs.getInt("course_id"));
                    course.setTitle(rs.getString("title"));
                    course.setSlug(rs.getString("slug"));
                    course.setThumbnail(rs.getString("thumbnail"));
                    course.setPrice(rs.getBigDecimal("price"));
                    course.setDiscountPrice(rs.getBigDecimal("discount_price"));
                    course.setFree(rs.getBoolean("is_free"));
                    
                    // Map lecturer
                    User lecturer = new User();
                    lecturer.setName(rs.getString("lecturer_name"));
                    course.setLecturer(lecturer);
                    
                    // Map category
                    Category category = new Category();
                    category.setName(rs.getString("category_name"));
                    course.setCategory(category);
                    
                    item.setCourse(course);
                    items.add(item);
                }
            }
        }
        return items;
    }
    
    /**
     * Add item to cart
     */
    public boolean addItem(int studentId, int courseId) throws SQLException {
        // Check if already in cart
        if (isInCart(studentId, courseId)) {
            return false;
        }
        
        // Check if already enrolled
        if (isEnrolled(studentId, courseId)) {
            return false;
        }
        
        String sql = "INSERT INTO cart_items (user_id, course_id) VALUES (?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Remove item from cart
     */
    public boolean removeItem(int studentId, int courseId) throws SQLException {
        String sql = "DELETE FROM cart_items WHERE user_id = ? AND course_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Remove item by cart item ID
     */
    public boolean removeItemById(int cartItemId) throws SQLException {
        String sql = "DELETE FROM cart_items WHERE cart_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, cartItemId);
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Clear cart for a student
     */
    public boolean clearCart(int studentId) throws SQLException {
        String sql = "DELETE FROM cart_items WHERE user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Check if course is in cart
     */
    public boolean isInCart(int studentId, int courseId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM cart_items WHERE user_id = ? AND course_id = ?";
        
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
     * Check if student is enrolled in course
     */
    private boolean isEnrolled(int studentId, int courseId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM enrollments WHERE student_id = ? AND course_id = ?";
        
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
     * Get cart item count
     */
    public int getItemCount(int studentId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM cart_items WHERE user_id = ?";
        
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
     * Get cart total
     */
    public BigDecimal getCartTotal(int studentId) throws SQLException {
        String sql = "SELECT COALESCE(SUM(CASE WHEN c.is_free THEN 0 " +
                     "WHEN c.discount_price IS NOT NULL AND c.discount_price > 0 THEN c.discount_price " +
                     "ELSE c.price END), 0) as total " +
                     "FROM cart_items ci " +
                     "JOIN courses c ON ci.course_id = c.course_id " +
                     "WHERE ci.user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getBigDecimal("total");
                }
            }
        }
        return BigDecimal.ZERO;
    }
    
    /**
     * Move items from cart to enrollment after payment
     */
    public boolean processCartPurchase(int studentId, int transactionId) throws SQLException {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);
            
            // Get cart items
            List<CartItem> items = getCartItems(studentId);
            
            // Create enrollments for each course
            String enrollSql = "INSERT INTO enrollments (student_id, course_id) VALUES (?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(enrollSql)) {
                for (CartItem item : items) {
                    ps.setInt(1, studentId);
                    ps.setInt(2, item.getCourseId());
                    ps.addBatch();
                }
                ps.executeBatch();
            }
            
            // Clear cart
            String clearSql = "DELETE FROM cart_items WHERE user_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(clearSql)) {
                ps.setInt(1, studentId);
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
}
