/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.Timestamp;
import java.math.BigDecimal;
import java.util.List;
import java.util.ArrayList;
/**
 *
 * @author user
 */
public class Course {
    public enum Level {
        BEGINNER, INTERMEDIATE, ADVANCED, ALL_LEVELS
    }
    
    public enum Status {
        DRAFT, PENDING, PUBLISHED, ARCHIVED
    }
    
    private int courseId;
    private int lecturerId;
    private int categoryId;
    private String title;
    private String slug;
    private String description;
    private String shortDescription;
    private String thumbnail;
    private String previewVideo;
    private BigDecimal price;
    private BigDecimal discountPrice;
    private Level level;
    private String language;
    private int durationHours;
    private int totalSections;
    private int totalMaterials;
    private int totalStudents;
    private BigDecimal avgRating;
    private int totalReviews;
    private String requirements;
    private String objectives;
    private String targetAudience;
    private Status status;
    private boolean isFeatured;
    private boolean isFree;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private Timestamp publishedAt;
    
    // Related objects (untuk join)
    private User lecturer;
    private Category category;
    private List<Section> sections;
    
    // Default constructor
    public Course() {
        this.thumbnail = "default-course.png";
        this.price = BigDecimal.ZERO;
        this.level = Level.ALL_LEVELS;
        this.language = "Indonesia";
        this.status = Status.DRAFT;
        this.avgRating = BigDecimal.ZERO;
        this.sections = new ArrayList<>();
    }
    
    // Constructor with required fields
    public Course(int lecturerId, int categoryId, String title) {
        this();
        this.lecturerId = lecturerId;
        this.categoryId = categoryId;
        this.title = title;
    }
    
    // Getters and Setters
    public int getCourseId() { return courseId; }
    public void setCourseId(int courseId) { this.courseId = courseId; }
    
    public int getLecturerId() { return lecturerId; }
    public void setLecturerId(int lecturerId) { this.lecturerId = lecturerId; }
    
    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getSlug() { return slug; }
    public void setSlug(String slug) { this.slug = slug; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getShortDescription() { return shortDescription; }
    public void setShortDescription(String shortDescription) { this.shortDescription = shortDescription; }
    
    public String getThumbnail() { return thumbnail; }
    public void setThumbnail(String thumbnail) { this.thumbnail = thumbnail; }
    
    public String getPreviewVideo() { return previewVideo; }
    public void setPreviewVideo(String previewVideo) { this.previewVideo = previewVideo; }
    
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    
    public BigDecimal getDiscountPrice() { return discountPrice; }
    public void setDiscountPrice(BigDecimal discountPrice) { this.discountPrice = discountPrice; }
    
    public Level getLevel() { return level; }
    public void setLevel(Level level) { this.level = level; }
    
    public String getLanguage() { return language; }
    public void setLanguage(String language) { this.language = language; }
    
    public int getDurationHours() { return durationHours; }
    public void setDurationHours(int durationHours) { this.durationHours = durationHours; }
    
    public int getTotalSections() { return totalSections; }
    public void setTotalSections(int totalSections) { this.totalSections = totalSections; }
    
    public int getTotalMaterials() { return totalMaterials; }
    public void setTotalMaterials(int totalMaterials) { this.totalMaterials = totalMaterials; }
    
    public int getTotalStudents() { return totalStudents; }
    public void setTotalStudents(int totalStudents) { this.totalStudents = totalStudents; }
    
    public BigDecimal getAvgRating() { return avgRating; }
    public void setAvgRating(BigDecimal avgRating) { this.avgRating = avgRating; }
    
    public int getTotalReviews() { return totalReviews; }
    public void setTotalReviews(int totalReviews) { this.totalReviews = totalReviews; }
    
    public String getRequirements() { return requirements; }
    public void setRequirements(String requirements) { this.requirements = requirements; }
    
    public String getObjectives() { return objectives; }
    public void setObjectives(String objectives) { this.objectives = objectives; }
    
    public String getTargetAudience() { return targetAudience; }
    public void setTargetAudience(String targetAudience) { this.targetAudience = targetAudience; }
    
    public Status getStatus() { return status; }
    public void setStatus(Status status) { this.status = status; }
    
    public boolean isFeatured() { return isFeatured; }
    public void setFeatured(boolean featured) { isFeatured = featured; }
    
    public boolean isFree() { return isFree; }
    public void setFree(boolean free) { isFree = free; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
    
    public Timestamp getPublishedAt() { return publishedAt; }
    public void setPublishedAt(Timestamp publishedAt) { this.publishedAt = publishedAt; }
    
    public User getLecturer() { return lecturer; }
    public void setLecturer(User lecturer) { this.lecturer = lecturer; }
    
    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }
    
    public List<Section> getSections() { return sections; }
    public void setSections(List<Section> sections) { this.sections = sections; }
    
    // Helper methods
    public String getLevelDisplayName() {
        switch (level) {
            case BEGINNER: return "Pemula";
            case INTERMEDIATE: return "Menengah";
            case ADVANCED: return "Mahir";
            case ALL_LEVELS: return "Semua Level";
            default: return "Unknown";
        }
    }
    
    public String getStatusDisplayName() {
        switch (status) {
            case DRAFT: return "Draft";
            case PENDING: return "Menunggu Review";
            case PUBLISHED: return "Dipublikasikan";
            case ARCHIVED: return "Diarsipkan";
            default: return "Unknown";
        }
    }
    
    public BigDecimal getEffectivePrice() {
        if (isFree) return BigDecimal.ZERO;
        if (discountPrice != null && discountPrice.compareTo(BigDecimal.ZERO) > 0) {
            return discountPrice;
        }
        return price;
    }
    
    public boolean hasDiscount() {
        return discountPrice != null && discountPrice.compareTo(BigDecimal.ZERO) > 0 
               && discountPrice.compareTo(price) < 0;
    }
    
    public int getDiscountPercentage() {
        if (!hasDiscount()) return 0;
        BigDecimal discount = price.subtract(discountPrice);
        return discount.multiply(new BigDecimal(100)).divide(price, 0, BigDecimal.ROUND_HALF_UP).intValue();
    }
    
    @Override
    public String toString() {
        return "Course{" +
                "courseId=" + courseId +
                ", title='" + title + '\'' +
                ", status=" + status +
                '}';
    }
}
