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
public class Material {
    public enum ContentType {
        VIDEO, TEXT, PDF, QUIZ, PROJECT, DOWNLOAD
    }
    
    private int materialId;
    private int sectionId;
    private String title;
    private ContentType contentType;
    private String content;
    private String videoUrl;
    private int videoDuration;
    private String attachmentUrl;
    private int displayOrder;
    private boolean isPreview;
    private boolean isMandatory;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Progress info (untuk student)
    private boolean isCompleted;
    private int timeSpentSeconds;
    private int lastPosition;
    
    // Default constructor
    public Material() {
        this.contentType = ContentType.TEXT;
        this.displayOrder = 0;
        this.isPreview = false;
        this.isMandatory = true;
        this.videoDuration = 0;
    }
    
    // Constructor with required fields
    public Material(int sectionId, String title, ContentType contentType) {
        this();
        this.sectionId = sectionId;
        this.title = title;
        this.contentType = contentType;
    }
    
    // Getters and Setters
    public int getMaterialId() { return materialId; }
    public void setMaterialId(int materialId) { this.materialId = materialId; }
    
    public int getSectionId() { return sectionId; }
    public void setSectionId(int sectionId) { this.sectionId = sectionId; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public ContentType getContentType() { return contentType; }
    public void setContentType(ContentType contentType) { this.contentType = contentType; }
    
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public String getVideoUrl() { return videoUrl; }
    public void setVideoUrl(String videoUrl) { this.videoUrl = videoUrl; }
    
    public int getVideoDuration() { return videoDuration; }
    public void setVideoDuration(int videoDuration) { this.videoDuration = videoDuration; }
    
    public String getAttachmentUrl() { return attachmentUrl; }
    public void setAttachmentUrl(String attachmentUrl) { this.attachmentUrl = attachmentUrl; }
    
    public int getDisplayOrder() { return displayOrder; }
    public void setDisplayOrder(int displayOrder) { this.displayOrder = displayOrder; }
    
    public boolean isPreview() { return isPreview; }
    public void setPreview(boolean preview) { isPreview = preview; }
    
    public boolean isMandatory() { return isMandatory; }
    public void setMandatory(boolean mandatory) { isMandatory = mandatory; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
    
    public boolean isCompleted() { return isCompleted; }
    public void setCompleted(boolean completed) { isCompleted = completed; }
    
    public int getTimeSpentSeconds() { return timeSpentSeconds; }
    public void setTimeSpentSeconds(int timeSpentSeconds) { this.timeSpentSeconds = timeSpentSeconds; }
    
    public int getLastPosition() { return lastPosition; }
    public void setLastPosition(int lastPosition) { this.lastPosition = lastPosition; }
    
    // Helper methods
    public String getContentTypeDisplayName() {
        switch (contentType) {
            case VIDEO: return "Video";
            case TEXT: return "Artikel";
            case PDF: return "PDF";
            case QUIZ: return "Kuis";
            case PROJECT: return "Proyek";
            case DOWNLOAD: return "Download";
            default: return "Unknown";
        }
    }
    
    public String getContentTypeIcon() {
        switch (contentType) {
            case VIDEO: return "fa-play-circle";
            case TEXT: return "fa-file-alt";
            case PDF: return "fa-file-pdf";
            case QUIZ: return "fa-question-circle";
            case PROJECT: return "fa-project-diagram";
            case DOWNLOAD: return "fa-download";
            default: return "fa-file";
        }
    }
    
    public String getFormattedDuration() {
        if (videoDuration <= 0) return "";
        int hours = videoDuration / 3600;
        int minutes = (videoDuration % 3600) / 60;
        int seconds = videoDuration % 60;
        
        if (hours > 0) {
            return String.format("%d:%02d:%02d", hours, minutes, seconds);
        } else {
            return String.format("%d:%02d", minutes, seconds);
        }
    }
    
    @Override
    public String toString() {
        return "Material{" +
                "materialId=" + materialId +
                ", title='" + title + '\'' +
                ", contentType=" + contentType +
                '}';
    }
}
