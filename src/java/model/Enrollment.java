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
public class Enrollment {
    public enum Status {
        ACTIVE, COMPLETED, EXPIRED, CANCELLED
    }
    
    private int enrollmentId;
    private int studentId;
    private int courseId;
    private Timestamp enrolledAt;
    private BigDecimal progressPercentage;
    private Timestamp lastAccessedAt;
    private Timestamp completedAt;
    private boolean certificateIssued;
    private String certificateUrl;
    private Status status;
    
    // Related objects
    private User student;
    private Course course;
    
    // Default constructor
    public Enrollment() {
        this.progressPercentage = BigDecimal.ZERO;
        this.status = Status.ACTIVE;
        this.certificateIssued = false;
    }
    
    // Constructor with required fields
    public Enrollment(int studentId, int courseId) {
        this();
        this.studentId = studentId;
        this.courseId = courseId;
    }
    
    // Getters and Setters
    public int getEnrollmentId() { return enrollmentId; }
    public void setEnrollmentId(int enrollmentId) { this.enrollmentId = enrollmentId; }
    
    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }
    
    public int getCourseId() { return courseId; }
    public void setCourseId(int courseId) { this.courseId = courseId; }
    
    public Timestamp getEnrolledAt() { return enrolledAt; }
    public void setEnrolledAt(Timestamp enrolledAt) { this.enrolledAt = enrolledAt; }
    
    public BigDecimal getProgressPercentage() { return progressPercentage; }
    public void setProgressPercentage(BigDecimal progressPercentage) { this.progressPercentage = progressPercentage; }
    
    public Timestamp getLastAccessedAt() { return lastAccessedAt; }
    public void setLastAccessedAt(Timestamp lastAccessedAt) { this.lastAccessedAt = lastAccessedAt; }
    
    public Timestamp getCompletedAt() { return completedAt; }
    public void setCompletedAt(Timestamp completedAt) { this.completedAt = completedAt; }
    
    public boolean isCertificateIssued() { return certificateIssued; }
    public void setCertificateIssued(boolean certificateIssued) { this.certificateIssued = certificateIssued; }
    
    public String getCertificateUrl() { return certificateUrl; }
    public void setCertificateUrl(String certificateUrl) { this.certificateUrl = certificateUrl; }
    
    public Status getStatus() { return status; }
    public void setStatus(Status status) { this.status = status; }
    
    public User getStudent() { return student; }
    public void setStudent(User student) { this.student = student; }
    
    public Course getCourse() { return course; }
    public void setCourse(Course course) { this.course = course; }
    
    // Helper methods
    public boolean isCompleted() {
        return status == Status.COMPLETED || progressPercentage.compareTo(new BigDecimal(100)) >= 0;
    }
    
    public String getStatusDisplayName() {
        switch (status) {
            case ACTIVE: return "Sedang Belajar";
            case COMPLETED: return "Selesai";
            case EXPIRED: return "Kadaluarsa";
            case CANCELLED: return "Dibatalkan";
            default: return "Unknown";
        }
    }
    
    public int getProgressInt() {
        return progressPercentage.intValue();
    }
    
    @Override
    public String toString() {
        return "Enrollment{" +
                "enrollmentId=" + enrollmentId +
                ", studentId=" + studentId +
                ", courseId=" + courseId +
                ", progress=" + progressPercentage + "%" +
                '}';
    }  
}
