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
public class Review {
    private int reviewId;
    private int courseId;
    private int studentId;
    private int rating;
    private String reviewText;
    private boolean isApproved = true;
    private int helpfulCount;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private User student;
    private Course course;
    
    public int getReviewId() { return reviewId; }
    public void setReviewId(int id) { this.reviewId = id; }
    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }
    public String getReviewText() { return reviewText; }
    public void setReviewText(String text) { this.reviewText = text; }
    public User getStudent() { return student; }
    public void setStudent(User student) { this.student = student; }
}
