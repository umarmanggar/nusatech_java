/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

/**
 * Model class untuk Review
 * @author user
 */
public class Review {
    private int reviewId;
    private int studentId;
    private int courseId;
    private int rating; // 1-5
    private String comment;
    private String reviewText; // alias untuk comment (backward compatibility)
    private boolean isApproved;
    private int helpfulCount;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Related objects
    private User student;
    private Course course;
    
    // Default constructor
    public Review() {
        this.rating = 5;
        this.isApproved = true;
        this.helpfulCount = 0;
    }
    
    // Constructor with required fields
    public Review(int studentId, int courseId, int rating, String comment) {
        this();
        this.studentId = studentId;
        this.courseId = courseId;
        setRating(rating); // Use setter to validate
        this.comment = comment;
        this.reviewText = comment;
    }
    
    // Full constructor
    public Review(int reviewId, int studentId, int courseId, int rating, String comment,
                  boolean isApproved, int helpfulCount, Timestamp createdAt, Timestamp updatedAt) {
        this.reviewId = reviewId;
        this.studentId = studentId;
        this.courseId = courseId;
        setRating(rating);
        this.comment = comment;
        this.reviewText = comment;
        this.isApproved = isApproved;
        this.helpfulCount = helpfulCount;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    // Getters and Setters
    public int getReviewId() { return reviewId; }
    public void setReviewId(int reviewId) { this.reviewId = reviewId; }
    
    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }
    
    public int getCourseId() { return courseId; }
    public void setCourseId(int courseId) { this.courseId = courseId; }
    
    public int getRating() { return rating; }
    public void setRating(int rating) {
        // Validate rating between 1-5
        if (rating < 1) {
            this.rating = 1;
        } else if (rating > 5) {
            this.rating = 5;
        } else {
            this.rating = rating;
        }
    }
    
    public String getComment() { return comment; }
    public void setComment(String comment) {
        this.comment = comment;
        this.reviewText = comment;
    }
    
    // Backward compatibility
    public String getReviewText() { return reviewText != null ? reviewText : comment; }
    public void setReviewText(String reviewText) {
        this.reviewText = reviewText;
        this.comment = reviewText;
    }
    
    public boolean isApproved() { return isApproved; }
    public void setApproved(boolean approved) { isApproved = approved; }
    
    public int getHelpfulCount() { return helpfulCount; }
    public void setHelpfulCount(int helpfulCount) { this.helpfulCount = helpfulCount; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
    
    public User getStudent() { return student; }
    public void setStudent(User student) { this.student = student; }
    
    public Course getCourse() { return course; }
    public void setCourse(Course course) { this.course = course; }
    
    // Helper methods
    
    /**
     * Menghitung rata-rata rating dari list review
     * @param reviews List review yang akan dihitung rata-ratanya
     * @return rata-rata rating dengan 2 desimal, atau 0 jika list kosong
     */
    public static BigDecimal calculateAverageRating(List<Review> reviews) {
        if (reviews == null || reviews.isEmpty()) {
            return BigDecimal.ZERO;
        }
        
        int totalRating = 0;
        int count = 0;
        
        for (Review review : reviews) {
            if (review.isApproved()) {
                totalRating += review.getRating();
                count++;
            }
        }
        
        if (count == 0) {
            return BigDecimal.ZERO;
        }
        
        return new BigDecimal(totalRating)
                .divide(new BigDecimal(count), 2, RoundingMode.HALF_UP);
    }
    
    /**
     * Menambah helpful count
     */
    public void incrementHelpfulCount() {
        this.helpfulCount++;
    }
    
    /**
     * Mendapatkan rating dalam bentuk bintang (★☆)
     * @return String representasi bintang
     */
    public String getRatingStars() {
        StringBuilder stars = new StringBuilder();
        for (int i = 1; i <= 5; i++) {
            if (i <= rating) {
                stars.append("★");
            } else {
                stars.append("☆");
            }
        }
        return stars.toString();
    }
    
    /**
     * Mendapatkan display name untuk rating
     * @return nama rating dalam bahasa Indonesia
     */
    public String getRatingDisplayName() {
        switch (rating) {
            case 1: return "Sangat Buruk";
            case 2: return "Buruk";
            case 3: return "Cukup";
            case 4: return "Baik";
            case 5: return "Sangat Baik";
            default: return "Unknown";
        }
    }
    
    @Override
    public String toString() {
        return "Review{" +
                "reviewId=" + reviewId +
                ", studentId=" + studentId +
                ", courseId=" + courseId +
                ", rating=" + rating +
                ", isApproved=" + isApproved +
                '}';
    }
}
