/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import model.Category;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author user
 */
public class CategoryDAO {
    public int create(Category category) throws SQLException {
        String sql = "INSERT INTO categories (name, slug, description, icon, color, is_active, display_order) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, category.getName());
            ps.setString(2, category.getSlug());
            ps.setString(3, category.getDescription());
            ps.setString(4, category.getIcon());
            ps.setString(5, category.getColor());
            ps.setBoolean(6, category.isActive());
            ps.setInt(7, category.getDisplayOrder());
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        }
        return -1;
    }
    
    /**
     * Find category by ID
     */
    public Category findById(int categoryId) throws SQLException {
        String sql = "SELECT c.*, COUNT(co.course_id) as course_count " +
                     "FROM categories c " +
                     "LEFT JOIN courses co ON c.category_id = co.category_id AND co.status = 'PUBLISHED' " +
                     "WHERE c.category_id = ? " +
                     "GROUP BY c.category_id";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, categoryId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCategory(rs);
                }
            }
        }
        return null;
    }
    
    /**
     * Find category by slug
     */
    public Category findBySlug(String slug) throws SQLException {
        String sql = "SELECT c.*, COUNT(co.course_id) as course_count " +
                     "FROM categories c " +
                     "LEFT JOIN courses co ON c.category_id = co.category_id AND co.status = 'PUBLISHED' " +
                     "WHERE c.slug = ? " +
                     "GROUP BY c.category_id";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, slug);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCategory(rs);
                }
            }
        }
        return null;
    }
    
    /**
     * Get all active categories
     */
    public List<Category> findAllActive() throws SQLException {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT c.*, COUNT(co.course_id) as course_count " +
                     "FROM categories c " +
                     "LEFT JOIN courses co ON c.category_id = co.category_id AND co.status = 'PUBLISHED' " +
                     "WHERE c.is_active = TRUE " +
                     "GROUP BY c.category_id " +
                     "ORDER BY c.display_order ASC, c.name ASC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                categories.add(mapResultSetToCategory(rs));
            }
        }
        return categories;
    }
    
    /**
     * Get all categories (for admin)
     */
    public List<Category> findAll() throws SQLException {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT c.*, COUNT(co.course_id) as course_count " +
                     "FROM categories c " +
                     "LEFT JOIN courses co ON c.category_id = co.category_id " +
                     "GROUP BY c.category_id " +
                     "ORDER BY c.display_order ASC, c.name ASC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                categories.add(mapResultSetToCategory(rs));
            }
        }
        return categories;
    }
    
    /**
     * Update category
     */
    public boolean update(Category category) throws SQLException {
        String sql = "UPDATE categories SET name = ?, slug = ?, description = ?, icon = ?, " +
                     "color = ?, is_active = ?, display_order = ? WHERE category_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, category.getName());
            ps.setString(2, category.getSlug());
            ps.setString(3, category.getDescription());
            ps.setString(4, category.getIcon());
            ps.setString(5, category.getColor());
            ps.setBoolean(6, category.isActive());
            ps.setInt(7, category.getDisplayOrder());
            ps.setInt(8, category.getCategoryId());
            
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Delete category
     */
    public boolean delete(int categoryId) throws SQLException {
        String sql = "DELETE FROM categories WHERE category_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, categoryId);
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Check if slug exists
     */
    public boolean slugExists(String slug) throws SQLException {
        String sql = "SELECT COUNT(*) FROM categories WHERE slug = ?";
        
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
     * Map ResultSet to Category object
     */
    private Category mapResultSetToCategory(ResultSet rs) throws SQLException {
        Category category = new Category();
        category.setCategoryId(rs.getInt("category_id"));
        category.setName(rs.getString("name"));
        category.setSlug(rs.getString("slug"));
        category.setDescription(rs.getString("description"));
        category.setIcon(rs.getString("icon"));
        category.setColor(rs.getString("color"));
        category.setActive(rs.getBoolean("is_active"));
        category.setDisplayOrder(rs.getInt("display_order"));
        category.setCreatedAt(rs.getTimestamp("created_at"));
        
        try {
            category.setCourseCount(rs.getInt("course_count"));
        } catch (SQLException e) {
            // Column might not exist in some queries
        }
        
        return category;
    }
}
