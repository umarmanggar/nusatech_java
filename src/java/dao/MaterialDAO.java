/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import model.Material;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author user
 */
public class MaterialDAO {
    public int create(Material material) throws SQLException {
        String sql = "INSERT INTO materials (section_id, title, content_type, content, video_url, video_duration, attachment_url, display_order, is_preview, is_mandatory) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, material.getSectionId());
            ps.setString(2, material.getTitle());
            ps.setString(3, material.getContentType().name());
            ps.setString(4, material.getContent());
            ps.setString(5, material.getVideoUrl());
            ps.setInt(6, material.getVideoDuration());
            ps.setString(7, material.getAttachmentUrl());
            ps.setInt(8, material.getDisplayOrder());
            ps.setBoolean(9, material.isPreview());
            ps.setBoolean(10, material.isMandatory());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return -1;
    }
    
    public Material findById(int materialId) throws SQLException {
        String sql = "SELECT * FROM materials WHERE material_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, materialId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSet(rs);
            }
        }
        return null;
    }
    
    public List<Material> findBySection(int sectionId) throws SQLException {
        List<Material> materials = new ArrayList<>();
        String sql = "SELECT * FROM materials WHERE section_id = ? ORDER BY display_order";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, sectionId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) materials.add(mapResultSet(rs));
            }
        }
        return materials;
    }
    
    public boolean update(Material material) throws SQLException {
        String sql = "UPDATE materials SET title = ?, content_type = ?, content = ?, video_url = ?, video_duration = ?, attachment_url = ?, display_order = ?, is_preview = ?, is_mandatory = ? WHERE material_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, material.getTitle());
            ps.setString(2, material.getContentType().name());
            ps.setString(3, material.getContent());
            ps.setString(4, material.getVideoUrl());
            ps.setInt(5, material.getVideoDuration());
            ps.setString(6, material.getAttachmentUrl());
            ps.setInt(7, material.getDisplayOrder());
            ps.setBoolean(8, material.isPreview());
            ps.setBoolean(9, material.isMandatory());
            ps.setInt(10, material.getMaterialId());
            return ps.executeUpdate() > 0;
        }
    }
    
    public boolean delete(int materialId) throws SQLException {
        String sql = "DELETE FROM materials WHERE material_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, materialId);
            return ps.executeUpdate() > 0;
        }
    }
    
    private Material mapResultSet(ResultSet rs) throws SQLException {
        Material m = new Material();
        m.setMaterialId(rs.getInt("material_id"));
        m.setSectionId(rs.getInt("section_id"));
        m.setTitle(rs.getString("title"));
        m.setContentType(Material.ContentType.valueOf(rs.getString("content_type")));
        m.setContent(rs.getString("content"));
        m.setVideoUrl(rs.getString("video_url"));
        m.setVideoDuration(rs.getInt("video_duration"));
        m.setAttachmentUrl(rs.getString("attachment_url"));
        m.setDisplayOrder(rs.getInt("display_order"));
        m.setPreview(rs.getBoolean("is_preview"));
        m.setMandatory(rs.getBoolean("is_mandatory"));
        m.setCreatedAt(rs.getTimestamp("created_at"));
        m.setUpdatedAt(rs.getTimestamp("updated_at"));
        return m;
    }
}
