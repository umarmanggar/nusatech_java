/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.Timestamp;
/**
 *
 * @author user
 */
public class Category {
    private int categoryId;
    private String name;
    private String slug;
    private String description;
    private String icon;
    private String color;
    private boolean isActive;
    private int displayOrder;
    private Timestamp createdAt;
    
    // Course count (untuk statistik)
    private int courseCount;
    
    // Default constructor
    public Category() {
        this.isActive = true;
        this.color = "#8B1538";
        this.displayOrder = 0;
    }
    
    // Constructor with required fields
    public Category(String name, String slug) {
        this();
        this.name = name;
        this.slug = slug;
    }
    
    // Full constructor
    public Category(int categoryId, String name, String slug, String description,
                    String icon, String color, boolean isActive, int displayOrder, Timestamp createdAt) {
        this.categoryId = categoryId;
        this.name = name;
        this.slug = slug;
        this.description = description;
        this.icon = icon;
        this.color = color;
        this.isActive = isActive;
        this.displayOrder = displayOrder;
        this.createdAt = createdAt;
    }
    
    // Getters and Setters
    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getSlug() { return slug; }
    public void setSlug(String slug) { this.slug = slug; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getIcon() { return icon; }
    public void setIcon(String icon) { this.icon = icon; }
    
    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
    
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
    
    public int getDisplayOrder() { return displayOrder; }
    public void setDisplayOrder(int displayOrder) { this.displayOrder = displayOrder; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public int getCourseCount() { return courseCount; }
    public void setCourseCount(int courseCount) { this.courseCount = courseCount; }
    
    @Override
    public String toString() {
        return "Category{" +
                "categoryId=" + categoryId +
                ", name='" + name + '\'' +
                ", slug='" + slug + '\'' +
                '}';
    }
}
