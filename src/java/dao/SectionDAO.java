/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import model.Section;
import model.Material;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author user
 */
public class SectionDAO {
    public int create(Section section) throws SQLException {
        String sql = "INSERT INTO sections (course_id, title, description, display_order, is_preview) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, section.getCourseId());
            ps.setString(2, section.getTitle());
            ps.setString(3, section.getDescription());
            ps.setInt(4, section.getDisplayOrder());
            ps.setBoolean(5, section.isPreview());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return -1;
    }
    
    public Section findById(int sectionId) throws SQLException {
        String sql = "SELECT * FROM sections WHERE section_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, sectionId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSet(rs);
            }
        }
        return null;
    }
    
    public List<Section> findByCourse(int courseId) throws SQLException {
        List<Section> sections = new ArrayList<>();
        String sql = "SELECT * FROM sections WHERE course_id = ? ORDER BY display_order";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) sections.add(mapResultSet(rs));
            }
        }
        return sections;
    }
    
    public boolean update(Section section) throws SQLException {
        String sql = "UPDATE sections SET title = ?, description = ?, display_order = ?, is_preview = ? WHERE section_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, section.getTitle());
            ps.setString(2, section.getDescription());
            ps.setInt(3, section.getDisplayOrder());
            ps.setBoolean(4, section.isPreview());
            ps.setInt(5, section.getSectionId());
            return ps.executeUpdate() > 0;
        }
    }
    
    public boolean delete(int sectionId) throws SQLException {
        String sql = "DELETE FROM sections WHERE section_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, sectionId);
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Reorder sections for a course
     * @param courseId the course ID
     * @param sectionIds list of section IDs in new order
     * @return true if successful
     */
    public boolean reorderSections(int courseId, List<Integer> sectionIds) throws SQLException {
        String sql = "UPDATE sections SET display_order = ? WHERE section_id = ? AND course_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            conn.setAutoCommit(false);
            try {
                for (int i = 0; i < sectionIds.size(); i++) {
                    ps.setInt(1, i);
                    ps.setInt(2, sectionIds.get(i));
                    ps.setInt(3, courseId);
                    ps.addBatch();
                }
                int[] results = ps.executeBatch();
                conn.commit();
                
                for (int result : results) {
                    if (result < 0 && result != Statement.SUCCESS_NO_INFO) {
                        return false;
                    }
                }
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
     * Get next display order for a course
     */
    public int getNextDisplayOrder(int courseId) throws SQLException {
        String sql = "SELECT COALESCE(MAX(display_order), -1) + 1 FROM sections WHERE course_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
    }
    
    /**
     * Count sections by course
     */
    public int countByCourse(int courseId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM sections WHERE course_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
    }
    
    private Section mapResultSet(ResultSet rs) throws SQLException {
        Section s = new Section();
        s.setSectionId(rs.getInt("section_id"));
        s.setCourseId(rs.getInt("course_id"));
        s.setTitle(rs.getString("title"));
        s.setDescription(rs.getString("description"));
        s.setDisplayOrder(rs.getInt("display_order"));
        s.setPreview(rs.getBoolean("is_preview"));
        s.setCreatedAt(rs.getTimestamp("created_at"));
        return s;
    }
}
