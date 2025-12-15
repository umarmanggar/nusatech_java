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
