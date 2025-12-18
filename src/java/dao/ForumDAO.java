/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Forum;
import model.Course;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class untuk Forum
 * @author user
 */
public class ForumDAO {
    
    /**
     * Create a new forum
     */
    public int create(Forum forum) throws SQLException {
        String sql = "INSERT INTO forums (course_id, title, description, is_active) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, forum.getCourseId());
            ps.setString(2, forum.getTitle());
            ps.setString(3, forum.getDescription());
            ps.setBoolean(4, forum.isActive());
            
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
     * Find forum by ID
     */
    public Forum findById(int forumId) throws SQLException {
        String sql = "SELECT f.*, c.title as course_title FROM forums f " +
                     "JOIN courses c ON f.course_id = c.course_id " +
                     "WHERE f.forum_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, forumId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSet(rs);
                }
            }
        }
        return null;
    }
    
    /**
     * Find forum by course ID
     */
    public Forum findByCourse(int courseId) throws SQLException {
        String sql = "SELECT f.*, c.title as course_title FROM forums f " +
                     "JOIN courses c ON f.course_id = c.course_id " +
                     "WHERE f.course_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, courseId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSet(rs);
                }
            }
        }
        return null;
    }
    
    /**
     * Find all active forums
     */
    public List<Forum> findAllActive() throws SQLException {
        List<Forum> forums = new ArrayList<>();
        String sql = "SELECT f.*, c.title as course_title FROM forums f " +
                     "JOIN courses c ON f.course_id = c.course_id " +
                     "WHERE f.is_active = TRUE ORDER BY f.created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                forums.add(mapResultSet(rs));
            }
        }
        return forums;
    }
    
    /**
     * Update forum
     */
    public boolean update(Forum forum) throws SQLException {
        String sql = "UPDATE forums SET title = ?, description = ?, is_active = ? WHERE forum_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, forum.getTitle());
            ps.setString(2, forum.getDescription());
            ps.setBoolean(3, forum.isActive());
            ps.setInt(4, forum.getForumId());
            
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Delete forum
     */
    public boolean delete(int forumId) throws SQLException {
        String sql = "DELETE FROM forums WHERE forum_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, forumId);
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Activate/deactivate forum
     */
    public boolean setActive(int forumId, boolean isActive) throws SQLException {
        String sql = "UPDATE forums SET is_active = ? WHERE forum_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setBoolean(1, isActive);
            ps.setInt(2, forumId);
            
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Count posts in forum
     */
    public int countPosts(int forumId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM forum_posts WHERE forum_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, forumId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    
    /**
     * Count main posts (not replies) in forum
     */
    public int countMainPosts(int forumId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM forum_posts WHERE forum_id = ? AND parent_id IS NULL";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, forumId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    
    private Forum mapResultSet(ResultSet rs) throws SQLException {
        Forum forum = new Forum();
        forum.setForumId(rs.getInt("forum_id"));
        forum.setCourseId(rs.getInt("course_id"));
        forum.setTitle(rs.getString("title"));
        forum.setDescription(rs.getString("description"));
        forum.setActive(rs.getBoolean("is_active"));
        forum.setCreatedAt(rs.getTimestamp("created_at"));
        
        // Map related course
        try {
            Course course = new Course();
            course.setCourseId(forum.getCourseId());
            course.setTitle(rs.getString("course_title"));
            forum.setCourse(course);
        } catch (SQLException e) {
            // Column might not exist
        }
        
        return forum;
    }
}
