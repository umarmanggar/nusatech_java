/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.Timestamp;
import java.math.BigDecimal;
/**
 *
 * @author user
 */
public class User {
    public enum Role {
        ADMIN, LECTURER, STUDENT
    }
    
    private int userId;
    private String email;
    private String password;
    private String name;
    private String phone;
    private String profilePicture;
    private Role role;
    private BigDecimal balance;
    private boolean isActive;
    private boolean emailVerified;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private Timestamp lastLogin;
    
    // Default constructor
    public User() {
        this.profilePicture = "default-avatar.png";
        this.balance = BigDecimal.ZERO;
        this.isActive = true;
        this.emailVerified = false;
    }
    
    // Constructor with required fields
    public User(String email, String password, String name, Role role) {
        this();
        this.email = email;
        this.password = password;
        this.name = name;
        this.role = role;
    }
    
    // Full constructor
    public User(int userId, String email, String password, String name, String phone,
                String profilePicture, Role role, BigDecimal balance, boolean isActive,
                boolean emailVerified, Timestamp createdAt, Timestamp updatedAt, Timestamp lastLogin) {
        this.userId = userId;
        this.email = email;
        this.password = password;
        this.name = name;
        this.phone = phone;
        this.profilePicture = profilePicture;
        this.role = role;
        this.balance = balance;
        this.isActive = isActive;
        this.emailVerified = emailVerified;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.lastLogin = lastLogin;
    }
    
    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getProfilePicture() { return profilePicture; }
    public void setProfilePicture(String profilePicture) { this.profilePicture = profilePicture; }
    
    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role; }
    
    public BigDecimal getBalance() { return balance; }
    public void setBalance(BigDecimal balance) { this.balance = balance; }
    
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
    
    public boolean isEmailVerified() { return emailVerified; }
    public void setEmailVerified(boolean emailVerified) { this.emailVerified = emailVerified; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
    
    public Timestamp getLastLogin() { return lastLogin; }
    public void setLastLogin(Timestamp lastLogin) { this.lastLogin = lastLogin; }
    
    // Helper methods
    public boolean isAdmin() { return role == Role.ADMIN; }
    public boolean isLecturer() { return role == Role.LECTURER; }
    public boolean isStudent() { return role == Role.STUDENT; }
    
    public String getRoleDisplayName() {
        switch (role) {
            case ADMIN: return "Administrator";
            case LECTURER: return "Pengajar";
            case STUDENT: return "Pelajar";
            default: return "Unknown";
        }
    }
    
    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", email='" + email + '\'' +
                ", name='" + name + '\'' +
                ", role=" + role +
                '}';
    } 
}
