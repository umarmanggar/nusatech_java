/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.ForumPost;
import model.User;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class untuk Forum Post
 * @author user
 */
public class PostDAO {
    
    /**
     * Create a new post
     */
    public int create(ForumPost post) throws SQLException {
        String sql = "INSERT INTO forum_posts (forum_id, user_id, parent_id, title, content, is_pinned, is_answered) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, post.getForumId());
            ps.setInt(2, post.getUserId());
            if (post.getParentId() != null) {
                ps.setInt(3, post.getParentId());
            } else {
                ps.setNull(3, Types.INTEGER);
            }
            ps.setString(4, post.getTitle());
            ps.setString(5, post.getContent());
            ps.setBoolean(6, post.isPinned());
            ps.setBoolean(7, post.isAnswered());
            
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
     * Find post by ID
     */
    public ForumPost findById(int postId) throws SQLException {
        String sql = "SELECT p.*, u.name as user_name, u.profile_picture as user_avatar " +
                     "FROM forum_posts p " +
                     "JOIN users u ON p.user_id = u.user_id " +
                     "WHERE p.post_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, postId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSet(rs);
                }
            }
        }
        return null;
    }
    
    /**
     * Find posts by forum (main posts only, not replies)
     */
    public List<ForumPost> findByForum(int forumId) throws SQLException {
        List<ForumPost> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.name as user_name, u.profile_picture as user_avatar, " +
                     "(SELECT COUNT(*) FROM forum_posts WHERE parent_id = p.post_id) as reply_count " +
                     "FROM forum_posts p " +
                     "JOIN users u ON p.user_id = u.user_id " +
                     "WHERE p.forum_id = ? AND p.parent_id IS NULL " +
                     "ORDER BY p.is_pinned DESC, p.created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, forumId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    posts.add(mapResultSet(rs));
                }
            }
        }
        return posts;
    }
    
    /**
     * Find posts by forum with pagination
     */
    public List<ForumPost> findByForum(int forumId, int page, int pageSize) throws SQLException {
        List<ForumPost> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.name as user_name, u.profile_picture as user_avatar, " +
                     "(SELECT COUNT(*) FROM forum_posts WHERE parent_id = p.post_id) as reply_count " +
                     "FROM forum_posts p " +
                     "JOIN users u ON p.user_id = u.user_id " +
                     "WHERE p.forum_id = ? AND p.parent_id IS NULL " +
                     "ORDER BY p.is_pinned DESC, p.created_at DESC " +
                     "LIMIT ? OFFSET ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, forumId);
            ps.setInt(2, pageSize);
            ps.setInt(3, (page - 1) * pageSize);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    posts.add(mapResultSet(rs));
                }
            }
        }
        return posts;
    }
    
    /**
     * Find replies to a post
     */
    public List<ForumPost> findReplies(int parentId) throws SQLException {
        List<ForumPost> replies = new ArrayList<>();
        String sql = "SELECT p.*, u.name as user_name, u.profile_picture as user_avatar " +
                     "FROM forum_posts p " +
                     "JOIN users u ON p.user_id = u.user_id " +
                     "WHERE p.parent_id = ? " +
                     "ORDER BY p.created_at ASC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, parentId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    replies.add(mapResultSet(rs));
                }
            }
        }
        return replies;
    }
    
    /**
     * Update post
     */
    public boolean update(ForumPost post) throws SQLException {
        String sql = "UPDATE forum_posts SET title = ?, content = ?, is_pinned = ?, is_answered = ? " +
                     "WHERE post_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, post.getTitle());
            ps.setString(2, post.getContent());
            ps.setBoolean(3, post.isPinned());
            ps.setBoolean(4, post.isAnswered());
            ps.setInt(5, post.getPostId());
            
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Delete post
     */
    public boolean delete(int postId) throws SQLException {
        String sql = "DELETE FROM forum_posts WHERE post_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, postId);
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Upvote a post
     */
    public boolean upvote(int postId, int userId) throws SQLException {
        // Check if user already voted
        String checkSql = "SELECT vote_type FROM post_votes WHERE post_id = ? AND user_id = ?";
        String insertVoteSql = "INSERT INTO post_votes (post_id, user_id, vote_type) VALUES (?, ?, 'UP')";
        String updateVoteSql = "UPDATE post_votes SET vote_type = 'UP' WHERE post_id = ? AND user_id = ?";
        String deleteVoteSql = "DELETE FROM post_votes WHERE post_id = ? AND user_id = ?";
        String updateCountSql = "UPDATE forum_posts SET upvotes = (SELECT COUNT(*) FROM post_votes WHERE post_id = ? AND vote_type = 'UP') WHERE post_id = ?";
        
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            
            try {
                String existingVote = null;
                
                // Check existing vote
                try (PreparedStatement checkPs = conn.prepareStatement(checkSql)) {
                    checkPs.setInt(1, postId);
                    checkPs.setInt(2, userId);
                    try (ResultSet rs = checkPs.executeQuery()) {
                        if (rs.next()) {
                            existingVote = rs.getString("vote_type");
                        }
                    }
                }
                
                // Handle vote
                if (existingVote == null) {
                    // No existing vote - add upvote
                    try (PreparedStatement insertPs = conn.prepareStatement(insertVoteSql)) {
                        insertPs.setInt(1, postId);
                        insertPs.setInt(2, userId);
                        insertPs.executeUpdate();
                    }
                } else if ("UP".equals(existingVote)) {
                    // Already upvoted - remove vote
                    try (PreparedStatement deletePs = conn.prepareStatement(deleteVoteSql)) {
                        deletePs.setInt(1, postId);
                        deletePs.setInt(2, userId);
                        deletePs.executeUpdate();
                    }
                } else {
                    // Was downvote - change to upvote
                    try (PreparedStatement updatePs = conn.prepareStatement(updateVoteSql)) {
                        updatePs.setInt(1, postId);
                        updatePs.setInt(2, userId);
                        updatePs.executeUpdate();
                    }
                }
                
                // Update count
                try (PreparedStatement countPs = conn.prepareStatement(updateCountSql)) {
                    countPs.setInt(1, postId);
                    countPs.setInt(2, postId);
                    countPs.executeUpdate();
                }
                
                conn.commit();
                return true;
                
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }
    
    /**
     * Mark post as answered
     */
    public boolean markAsAnswered(int postId) throws SQLException {
        String sql = "UPDATE forum_posts SET is_answered = TRUE WHERE post_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, postId);
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Toggle pin status
     */
    public boolean togglePin(int postId) throws SQLException {
        String sql = "UPDATE forum_posts SET is_pinned = NOT is_pinned WHERE post_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, postId);
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Find posts by user
     */
    public List<ForumPost> findByUser(int userId) throws SQLException {
        List<ForumPost> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.name as user_name, u.profile_picture as user_avatar " +
                     "FROM forum_posts p " +
                     "JOIN users u ON p.user_id = u.user_id " +
                     "WHERE p.user_id = ? " +
                     "ORDER BY p.created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    posts.add(mapResultSet(rs));
                }
            }
        }
        return posts;
    }
    
    /**
     * Search posts
     */
    public List<ForumPost> search(int forumId, String keyword) throws SQLException {
        List<ForumPost> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.name as user_name, u.profile_picture as user_avatar " +
                     "FROM forum_posts p " +
                     "JOIN users u ON p.user_id = u.user_id " +
                     "WHERE p.forum_id = ? AND (p.title LIKE ? OR p.content LIKE ?) " +
                     "ORDER BY p.created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            String pattern = "%" + keyword + "%";
            ps.setInt(1, forumId);
            ps.setString(2, pattern);
            ps.setString(3, pattern);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    posts.add(mapResultSet(rs));
                }
            }
        }
        return posts;
    }
    
    private ForumPost mapResultSet(ResultSet rs) throws SQLException {
        ForumPost post = new ForumPost();
        post.setPostId(rs.getInt("post_id"));
        post.setForumId(rs.getInt("forum_id"));
        post.setUserId(rs.getInt("user_id"));
        
        int parentId = rs.getInt("parent_id");
        if (!rs.wasNull()) {
            post.setParentId(parentId);
        }
        
        post.setTitle(rs.getString("title"));
        post.setContent(rs.getString("content"));
        post.setUpvotes(rs.getInt("upvotes"));
        post.setPinned(rs.getBoolean("is_pinned"));
        post.setAnswered(rs.getBoolean("is_answered"));
        post.setCreatedAt(rs.getTimestamp("created_at"));
        post.setUpdatedAt(rs.getTimestamp("updated_at"));
        
        // Map related user
        try {
            User user = new User();
            user.setUserId(post.getUserId());
            user.setName(rs.getString("user_name"));
            user.setProfilePicture(rs.getString("user_avatar"));
            post.setUser(user);
        } catch (SQLException e) {
            // Columns might not exist
        }
        
        return post;
    }
}
