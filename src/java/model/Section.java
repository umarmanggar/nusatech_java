/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.Timestamp;
import java.util.List;
import java.util.ArrayList;
/**
 *
 * @author user
 */
public class Section {
    private int sectionId;
    private int courseId;
    private String title;
    private String description;
    private int displayOrder;
    private boolean isPreview;
    private Timestamp createdAt;
    
    // Related materials
    private List<Material> materials;
    
    // Default constructor
    public Section() {
        this.displayOrder = 0;
        this.isPreview = false;
        this.materials = new ArrayList<>();
    }
    
    // Constructor with required fields
    public Section(int courseId, String title) {
        this();
        this.courseId = courseId;
        this.title = title;
    }
    
    // Getters and Setters
    public int getSectionId() { return sectionId; }
    public void setSectionId(int sectionId) { this.sectionId = sectionId; }
    
    public int getCourseId() { return courseId; }
    public void setCourseId(int courseId) { this.courseId = courseId; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public int getDisplayOrder() { return displayOrder; }
    public void setDisplayOrder(int displayOrder) { this.displayOrder = displayOrder; }
    
    public boolean isPreview() { return isPreview; }
    public void setPreview(boolean preview) { isPreview = preview; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public List<Material> getMaterials() { return materials; }
    public void setMaterials(List<Material> materials) { this.materials = materials; }
    
    // Helper methods
    public int getMaterialCount() {
        return materials != null ? materials.size() : 0;
    }
    
    public int getTotalDuration() {
        if (materials == null) return 0;
        return materials.stream().mapToInt(Material::getVideoDuration).sum();
    }
    
    @Override
    public String toString() {
        return "Section{" +
                "sectionId=" + sectionId +
                ", title='" + title + '\'' +
                ", displayOrder=" + displayOrder +
                '}';
    }   
}
