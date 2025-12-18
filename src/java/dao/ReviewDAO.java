/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Review;
import model.User;
import model.Course;
import util.DBConnection;

import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class untuk Review
 * @author user
 */
public class ReviewDAO {
    
    /**
     * Create a new review
     */
    public int create(Review review) throws SQLException {
        String sql = "INSERT INTO reviews (course_id, student_id, rating, review_text, is_approved) " +
                     "VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, review.getCourseId());
            ps.setInt(2, review.getStudentId());
            ps.setInt(3, review.getRating());
            ps.setString(4, review.getComment());
            ps.setBoolean(5, review.isApproved());
            
            ps.executeUpdate();
            
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return -1;
    }
    
    /**
     * Find review by ID
     */
    public Review findById(int reviewId) throws SQLException {
        String sql = "SELECT r.*, u.name as student_name, u.profile_picture as student_avatar " +
                     "FROM reviews r " +
                     "JOIN users u ON r.student_id = u.user_id " +
                     "WHERE r.review_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, reviewId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSet(rs);
                }
            }
        }
        return null;
    }
    
    /**
     * Find reviews by course
     */
    public List<Review> findByCourse(int courseId) throws SQLException {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.*, u.name as student_name, u.profile_picture as student_avatar " +
                     "FROM reviews r " +
                     "JOIN users u ON r.student_id = u.user_id " +
                     "WHERE r.course_id = ? AND r.is_approved = TRUE " +
                     "ORDER BY r.created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, courseId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    reviews.add(mapResultSet(rs));
                }
            }
        }
        return reviews;
    }
    
    /**
     * Find reviews by course with pagination
     */
    public List<Review> findByCourse(int courseId, int page, int pageSize) throws SQLException {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.*, u.name as student_name, u.profile_picture as student_avatar " +
                     "FROM reviews r " +
                     "JOIN users u ON r.student_id = u.user_id " +
                     "WHERE r.course_id = ? AND r.is_approved = TRUE " +
                     "ORDER BY r.created_at DESC " +
                     "LIMIT ? OFFSET ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, courseId);
            ps.setInt(2, pageSize);
            ps.setInt(3, (page - 1) * pageSize);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    reviews.add(mapResultSet(rs));
                }
            }
        }
        return reviews;
    }
    
    /**
     * Find reviews by student
     */
    public List<Review> findByStudent(int studentId) throws SQLException {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.*, u.name as student_name, u.profile_picture as student_avatar, " +
                     "c.title as course_title, c.slug as course_slug " +
                     "FROM reviews r " +
                     "JOIN users u ON r.student_id = u.user_id " +
                     "JOIN courses c ON r.course_id = c.course_id " +
                     "WHERE r.student_id = ? " +
                     "ORDER BY r.created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Review review = mapResultSet(rs);
                    
                    // Map course
                    try {
                        Course course = new Course();
                        course.setCourseId(review.getCourseId());
                        course.setTitle(rs.getString("course_title"));
                        course.setSlug(rs.getString("course_slug"));
                        review.setCourse(course);
                    } catch (SQLException e) {
                        // Columns might not exist
                    }
                    
                    reviews.add(review);
                }
            }
        }
        return reviews;
    }
    
    /**
     * Update review
     */
    public boolean update(Review review) throws SQLException {
        String sql = "UPDATE reviews SET rating = ?, review_text = ? WHERE review_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, review.getRating());
            ps.setString(2, review.getComment());
            ps.setInt(3, review.getReviewId());
            
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Delete review
     */
    public boolean delete(int reviewId) throws SQLException {
        String sql = "DELETE FROM reviews WHERE review_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, reviewId);
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Get average rating for a course
     */
    public BigDecimal getAverageRating(int courseId) throws SQLException {
        String sql = "SELECT AVG(rating) as avg_rating FROM reviews " +
                     "WHERE course_id = ? AND is_approved = TRUE";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, courseId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    BigDecimal avg = rs.getBigDecimal("avg_rating");
                    return avg != null ? avg : BigDecimal.ZERO;
                }
            }
        }
        return BigDecimal.ZERO;
    }
    
    /**
     * Get rating distribution for a course
     */
    public int[] getRatingDistribution(int courseId) throws SQLException {
        int[] distribution = new int[5]; // Index 0 = 1 star, Index 4 = 5 stars
        String sql = "SELECT rating, COUNT(*) as count FROM reviews " +
                     "WHERE course_id = ? AND is_approved = TRUE " +
                     "GROUP BY rating ORDER BY rating";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, courseId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int rating = rs.getInt("rating");
                    int count = rs.getInt("count");
                    if (rating >= 1 && rating <= 5) {
                        distribution[rating - 1] = count;
                    }
                }
            }
        }
        return distribution;
    }
    
    /**
     * Check if student can review a course (must be enrolled and not reviewed yet)
     */
    public boolean canReview(int studentId, int courseId) throws SQLException {
        // Check if enrolled
        String enrollSql = "SELECT COUNT(*) FROM enrollments WHERE student_id = ? AND course_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(enrollSql)) {
            
            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next() && rs.getInt(1) == 0) {
                    return false; // Not enrolled
                }
            }
        }
        
        // Check if already reviewed
        String reviewSql = "SELECT COUNT(*) FROM reviews WHERE student_id = ? AND course_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(reviewSql)) {
            
            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    return false; // Already reviewed
                }
            }
        }
        
        return true;
    }
    
    /**
     * Get review by student for a course
     */
    public Review findByStudentAndCourse(int studentId, int courseId) throws SQLException {
        String sql = "SELECT r.*, u.name as student_name, u.profile_picture as student_avatar " +
                     "FROM reviews r " +
                     "JOIN users u ON r.student_id = u.user_id " +
                     "WHERE r.student_id = ? AND r.course_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSet(rs);
                }
            }
        }
        return null;
    }
    
    /**
     * Approve review
     */
    public boolean approve(int reviewId) throws SQLException {
        String sql = "UPDATE reviews SET is_approved = TRUE WHERE review_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, reviewId);
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Reject/unapprove review
     */
    public boolean reject(int reviewId) throws SQLException {
        String sql = "UPDATE reviews SET is_approved = FALSE WHERE review_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, reviewId);
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Increment helpful count
     */
    public boolean incrementHelpful(int reviewId) throws SQLException {
        String sql = "UPDATE reviews SET helpful_count = helpful_count + 1 WHERE review_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, reviewId);
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Count reviews by course
     */
    public int countByCourse(int courseId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM reviews WHERE course_id = ? AND is_approved = TRUE";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, courseId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    
    /**
     * Get pending reviews (for admin)
     */
    public List<Review> findPendingReviews() throws SQLException {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.*, u.name as student_name, u.profile_picture as student_avatar, " +
                     "c.title as course_title " +
                     "FROM reviews r " +
                     "JOIN users u ON r.student_id = u.user_id " +
                     "JOIN courses c ON r.course_id = c.course_id " +
                     "WHERE r.is_approved = FALSE " +
                     "ORDER BY r.created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Review review = mapResultSet(rs);
                
                try {
                    Course course = new Course();
                    course.setCourseId(review.getCourseId());
                    course.setTitle(rs.getString("course_title"));
                    review.setCourse(course);
                } catch (SQLException e) {
                    // Ignore
                }
                
                reviews.add(review);
            }
        }
        return reviews;
    }
    
    private Review mapResultSet(ResultSet rs) throws SQLException {
        Review review = new Review();
        review.setReviewId(rs.getInt("review_id"));
        review.setCourseId(rs.getInt("course_id"));
        review.setStudentId(rs.getInt("student_id"));
        review.setRating(rs.getInt("rating"));
        review.setComment(rs.getString("review_text"));
        review.setApproved(rs.getBoolean("is_approved"));
        review.setHelpfulCount(rs.getInt("helpful_count"));
        review.setCreatedAt(rs.getTimestamp("created_at"));
        review.setUpdatedAt(rs.getTimestamp("updated_at"));
        
        // Map related student
        try {
            User student = new User();
            student.setUserId(review.getStudentId());
            student.setName(rs.getString("student_name"));
            student.setProfilePicture(rs.getString("student_avatar"));
            review.setStudent(student);
        } catch (SQLException e) {
            // Columns might not exist
        }
        
        return review;
    }
}
