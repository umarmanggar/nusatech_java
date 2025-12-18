/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.util.List;
import java.util.ArrayList;

/**
 * Model class untuk Forum
 * @author user
 */
public class Forum {
    private int forumId;
    private int courseId;
    private String title;
    private String description;
    private boolean isActive;
    private Timestamp createdAt;
    
    // Related objects
    private Course course;
    private List<ForumPost> posts;
    
    // Default constructor
    public Forum() {
        this.isActive = true;
        this.posts = new ArrayList<>();
    }
    
    // Constructor with required fields
    public Forum(int courseId, String title) {
        this();
        this.courseId = courseId;
        this.title = title;
    }
    
    // Full constructor
    public Forum(int forumId, int courseId, String title, String description, 
                 boolean isActive, Timestamp createdAt) {
        this();
        this.forumId = forumId;
        this.courseId = courseId;
        this.title = title;
        this.description = description;
        this.isActive = isActive;
        this.createdAt = createdAt;
    }
    
    // Getters and Setters
    public int getForumId() { return forumId; }
    public void setForumId(int forumId) { this.forumId = forumId; }
    
    public int getCourseId() { return courseId; }
    public void setCourseId(int courseId) { this.courseId = courseId; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public Course getCourse() { return course; }
    public void setCourse(Course course) { this.course = course; }
    
    public List<ForumPost> getPosts() { return posts; }
    public void setPosts(List<ForumPost> posts) { this.posts = posts; }
    
    // Helper methods
    public int getPostCount() {
        return posts != null ? posts.size() : 0;
    }
    
    @Override
    public String toString() {
        return "Forum{" +
                "forumId=" + forumId +
                ", courseId=" + courseId +
                ", title='" + title + '\'' +
                ", isActive=" + isActive +
                '}';
    }
}
