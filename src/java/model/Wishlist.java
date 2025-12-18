/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 * Model class untuk Wishlist
 * @author user
 */
public class Wishlist {
    private int wishlistId;
    private int studentId;
    private int courseId;
    private Timestamp addedAt;
    
    // Related objects
    private User student;
    private Course course;
    
    // Default constructor
    public Wishlist() {
    }
    
    // Constructor with required fields
    public Wishlist(int studentId, int courseId) {
        this.studentId = studentId;
        this.courseId = courseId;
    }
    
    // Full constructor
    public Wishlist(int wishlistId, int studentId, int courseId, Timestamp addedAt) {
        this.wishlistId = wishlistId;
        this.studentId = studentId;
        this.courseId = courseId;
        this.addedAt = addedAt;
    }
    
    // Getters and Setters
    public int getWishlistId() { return wishlistId; }
    public void setWishlistId(int wishlistId) { this.wishlistId = wishlistId; }
    
    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }
    
    public int getCourseId() { return courseId; }
    public void setCourseId(int courseId) { this.courseId = courseId; }
    
    public Timestamp getAddedAt() { return addedAt; }
    public void setAddedAt(Timestamp addedAt) { this.addedAt = addedAt; }
    
    public User getStudent() { return student; }
    public void setStudent(User student) { this.student = student; }
    
    public Course getCourse() { return course; }
    public void setCourse(Course course) { this.course = course; }
    
    @Override
    public String toString() {
        return "Wishlist{" +
                "wishlistId=" + wishlistId +
                ", studentId=" + studentId +
                ", courseId=" + courseId +
                ", addedAt=" + addedAt +
                '}';
    }
}
