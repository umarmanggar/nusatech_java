/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 * Model class untuk Material Progress
 * Menyimpan progress belajar siswa untuk setiap material
 * @author user
 */
public class MaterialProgress {
    private int progressId;
    private int enrollmentId;
    private int materialId;
    private boolean isCompleted;
    private Timestamp completedAt;
    private Timestamp lastAccessedAt;
    private int timeSpentSeconds;
    private int lastPosition; // untuk video, menyimpan posisi terakhir
    private int viewCount;
    
    // Related objects
    private Enrollment enrollment;
    private Material material;
    
    // Default constructor
    public MaterialProgress() {
        this.isCompleted = false;
        this.timeSpentSeconds = 0;
        this.lastPosition = 0;
        this.viewCount = 0;
    }
    
    // Constructor with required fields
    public MaterialProgress(int enrollmentId, int materialId) {
        this();
        this.enrollmentId = enrollmentId;
        this.materialId = materialId;
    }
    
    // Full constructor
    public MaterialProgress(int progressId, int enrollmentId, int materialId,
                           boolean isCompleted, Timestamp completedAt, Timestamp lastAccessedAt,
                           int timeSpentSeconds, int lastPosition, int viewCount) {
        this.progressId = progressId;
        this.enrollmentId = enrollmentId;
        this.materialId = materialId;
        this.isCompleted = isCompleted;
        this.completedAt = completedAt;
        this.lastAccessedAt = lastAccessedAt;
        this.timeSpentSeconds = timeSpentSeconds;
        this.lastPosition = lastPosition;
        this.viewCount = viewCount;
    }
    
    // Getters and Setters
    public int getProgressId() { return progressId; }
    public void setProgressId(int progressId) { this.progressId = progressId; }
    
    public int getEnrollmentId() { return enrollmentId; }
    public void setEnrollmentId(int enrollmentId) { this.enrollmentId = enrollmentId; }
    
    public int getMaterialId() { return materialId; }
    public void setMaterialId(int materialId) { this.materialId = materialId; }
    
    public boolean isCompleted() { return isCompleted; }
    public void setCompleted(boolean completed) { isCompleted = completed; }
    
    public Timestamp getCompletedAt() { return completedAt; }
    public void setCompletedAt(Timestamp completedAt) { this.completedAt = completedAt; }
    
    public Timestamp getLastAccessedAt() { return lastAccessedAt; }
    public void setLastAccessedAt(Timestamp lastAccessedAt) { this.lastAccessedAt = lastAccessedAt; }
    
    public int getTimeSpentSeconds() { return timeSpentSeconds; }
    public void setTimeSpentSeconds(int timeSpentSeconds) { this.timeSpentSeconds = timeSpentSeconds; }
    
    public int getLastPosition() { return lastPosition; }
    public void setLastPosition(int lastPosition) { this.lastPosition = lastPosition; }
    
    public int getViewCount() { return viewCount; }
    public void setViewCount(int viewCount) { this.viewCount = viewCount; }
    
    public Enrollment getEnrollment() { return enrollment; }
    public void setEnrollment(Enrollment enrollment) { this.enrollment = enrollment; }
    
    public Material getMaterial() { return material; }
    public void setMaterial(Material material) { this.material = material; }
    
    // Helper methods
    
    /**
     * Menandai material sebagai selesai
     */
    public void markAsCompleted() {
        this.isCompleted = true;
        this.completedAt = new Timestamp(System.currentTimeMillis());
    }
    
    /**
     * Update akses terakhir
     */
    public void updateLastAccess() {
        this.lastAccessedAt = new Timestamp(System.currentTimeMillis());
        this.viewCount++;
    }
    
    /**
     * Menambah waktu yang dihabiskan
     * @param seconds jumlah detik yang ditambahkan
     */
    public void addTimeSpent(int seconds) {
        this.timeSpentSeconds += seconds;
    }
    
    /**
     * Update posisi video terakhir
     * @param position posisi dalam detik
     */
    public void updateVideoPosition(int position) {
        this.lastPosition = position;
        updateLastAccess();
    }
    
    /**
     * Format waktu yang dihabiskan
     * @return string format mm:ss atau hh:mm:ss
     */
    public String getFormattedTimeSpent() {
        int hours = timeSpentSeconds / 3600;
        int minutes = (timeSpentSeconds % 3600) / 60;
        int seconds = timeSpentSeconds % 60;
        
        if (hours > 0) {
            return String.format("%d:%02d:%02d", hours, minutes, seconds);
        } else {
            return String.format("%d:%02d", minutes, seconds);
        }
    }
    
    /**
     * Mendapatkan persentase progress untuk video
     * Berdasarkan posisi terakhir dan durasi video
     * @return persentase progress
     */
    public int getVideoProgressPercentage() {
        if (material != null && material.getVideoDuration() > 0) {
            return (lastPosition * 100) / material.getVideoDuration();
        }
        return isCompleted ? 100 : 0;
    }
    
    @Override
    public String toString() {
        return "MaterialProgress{" +
                "progressId=" + progressId +
                ", enrollmentId=" + enrollmentId +
                ", materialId=" + materialId +
                ", isCompleted=" + isCompleted +
                ", timeSpentSeconds=" + timeSpentSeconds +
                '}';
    }
}
