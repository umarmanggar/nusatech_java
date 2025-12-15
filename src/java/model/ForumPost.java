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
    private User user;
    private List<ForumPost> replies = new ArrayList<>();
    
    public int getPostId() { return postId; }
    public void setPostId(int id) { this.postId = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public int getUpvotes() { return upvotes; }
    public void setUpvotes(int votes) { this.upvotes = votes; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public List<ForumPost> getReplies() { return replies; }
}
