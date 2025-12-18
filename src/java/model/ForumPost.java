/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.util.List;
import java.util.ArrayList;

/**
 * Model class untuk Forum Post
 * @author user
 */
public class ForumPost {
    private int postId;
    private int forumId;
    private int userId;
    private Integer parentId;
    private String title;
    private String content;
    private int upvotes;
    private boolean isPinned;
    private boolean isAnswered;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Related objects
    private User user;
    private Forum forum;
    private ForumPost parent;
    private List<ForumPost> replies;
    
    // Default constructor
    public ForumPost() {
        this.upvotes = 0;
        this.isPinned = false;
        this.isAnswered = false;
        this.replies = new ArrayList<>();
    }
    
    // Constructor with required fields (for new post)
    public ForumPost(int forumId, int userId, String title, String content) {
        this();
        this.forumId = forumId;
        this.userId = userId;
        this.title = title;
        this.content = content;
    }
    
    // Constructor for reply
    public ForumPost(int forumId, int userId, int parentId, String content) {
        this();
        this.forumId = forumId;
        this.userId = userId;
        this.parentId = parentId;
        this.content = content;
    }
    
    // Full constructor
    public ForumPost(int postId, int forumId, int userId, Integer parentId, String title,
                     String content, int upvotes, boolean isPinned, boolean isAnswered,
                     Timestamp createdAt, Timestamp updatedAt) {
        this();
        this.postId = postId;
        this.forumId = forumId;
        this.userId = userId;
        this.parentId = parentId;
        this.title = title;
        this.content = content;
        this.upvotes = upvotes;
        this.isPinned = isPinned;
        this.isAnswered = isAnswered;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    // Getters and Setters
    public int getPostId() { return postId; }
    public void setPostId(int postId) { this.postId = postId; }
    
    public int getForumId() { return forumId; }
    public void setForumId(int forumId) { this.forumId = forumId; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public Integer getParentId() { return parentId; }
    public void setParentId(Integer parentId) { this.parentId = parentId; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public int getUpvotes() { return upvotes; }
    public void setUpvotes(int upvotes) { this.upvotes = upvotes; }
    
    public boolean isPinned() { return isPinned; }
    public void setPinned(boolean pinned) { isPinned = pinned; }
    
    public boolean isAnswered() { return isAnswered; }
    public void setAnswered(boolean answered) { isAnswered = answered; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
    
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    
    public Forum getForum() { return forum; }
    public void setForum(Forum forum) { this.forum = forum; }
    
    public ForumPost getParent() { return parent; }
    public void setParent(ForumPost parent) { this.parent = parent; }
    
    public List<ForumPost> getReplies() { return replies; }
    public void setReplies(List<ForumPost> replies) { this.replies = replies; }
    
    // Helper methods
    public boolean isReply() {
        return parentId != null;
    }
    
    public boolean isMainPost() {
        return parentId == null;
    }
    
    public int getReplyCount() {
        return replies != null ? replies.size() : 0;
    }
    
    public void incrementUpvotes() {
        this.upvotes++;
    }
    
    public void decrementUpvotes() {
        if (this.upvotes > 0) {
            this.upvotes--;
        }
    }
    
    @Override
    public String toString() {
        return "ForumPost{" +
                "postId=" + postId +
                ", forumId=" + forumId +
                ", userId=" + userId +
                ", title='" + title + '\'' +
                ", upvotes=" + upvotes +
                '}';
    }
}
