/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.util.UUID;

/**
 * Model class untuk Certificate
 * Menyimpan data sertifikat yang dikeluarkan setelah siswa menyelesaikan course
 * @author user
 */
public class Certificate {
    private int certificateId;
    private int enrollmentId;
    private String certificateCode;
    private Timestamp issuedAt;
    private String pdfUrl;
    private String studentName;
    private String courseName;
    private String lecturerName;
    private int completionHours;
    private Timestamp expiryDate;
    private boolean isValid;
    
    // Related objects
    private Enrollment enrollment;
    
    // Default constructor
    public Certificate() {
        this.isValid = true;
    }
    
    // Constructor with required fields
    public Certificate(int enrollmentId) {
        this();
        this.enrollmentId = enrollmentId;
        this.certificateCode = generateCertificateCode();
        this.issuedAt = new Timestamp(System.currentTimeMillis());
    }
    
    // Constructor with enrollment and course details
    public Certificate(int enrollmentId, String studentName, String courseName, String lecturerName) {
        this(enrollmentId);
        this.studentName = studentName;
        this.courseName = courseName;
        this.lecturerName = lecturerName;
    }
    
    // Full constructor
    public Certificate(int certificateId, int enrollmentId, String certificateCode,
                       Timestamp issuedAt, String pdfUrl, String studentName,
                       String courseName, String lecturerName, int completionHours,
                       Timestamp expiryDate, boolean isValid) {
        this.certificateId = certificateId;
        this.enrollmentId = enrollmentId;
        this.certificateCode = certificateCode;
        this.issuedAt = issuedAt;
        this.pdfUrl = pdfUrl;
        this.studentName = studentName;
        this.courseName = courseName;
        this.lecturerName = lecturerName;
        this.completionHours = completionHours;
        this.expiryDate = expiryDate;
        this.isValid = isValid;
    }
    
    // Getters and Setters
    public int getCertificateId() { return certificateId; }
    public void setCertificateId(int certificateId) { this.certificateId = certificateId; }
    
    public int getEnrollmentId() { return enrollmentId; }
    public void setEnrollmentId(int enrollmentId) { this.enrollmentId = enrollmentId; }
    
    public String getCertificateCode() { return certificateCode; }
    public void setCertificateCode(String certificateCode) { this.certificateCode = certificateCode; }
    
    public Timestamp getIssuedAt() { return issuedAt; }
    public void setIssuedAt(Timestamp issuedAt) { this.issuedAt = issuedAt; }
    
    public String getPdfUrl() { return pdfUrl; }
    public void setPdfUrl(String pdfUrl) { this.pdfUrl = pdfUrl; }
    
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    
    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }
    
    public String getLecturerName() { return lecturerName; }
    public void setLecturerName(String lecturerName) { this.lecturerName = lecturerName; }
    
    public int getCompletionHours() { return completionHours; }
    public void setCompletionHours(int completionHours) { this.completionHours = completionHours; }
    
    public Timestamp getExpiryDate() { return expiryDate; }
    public void setExpiryDate(Timestamp expiryDate) { this.expiryDate = expiryDate; }
    
    public boolean isValid() { return isValid; }
    public void setValid(boolean valid) { isValid = valid; }
    
    public Enrollment getEnrollment() { return enrollment; }
    public void setEnrollment(Enrollment enrollment) { this.enrollment = enrollment; }
    
    // Helper methods
    
    /**
     * Generate kode sertifikat unik
     * Format: NT-YYYYMMDD-XXXXXXXX (NT = NusaTech)
     * @return kode sertifikat
     */
    public static String generateCertificateCode() {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMdd");
        String datePart = sdf.format(new java.util.Date());
        String uniquePart = UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        return "NT-" + datePart + "-" + uniquePart;
    }
    
    /**
     * Mengecek apakah sertifikat sudah kadaluarsa
     * @return true jika sudah kadaluarsa
     */
    public boolean isExpired() {
        if (expiryDate == null) {
            return false; // Tidak ada tanggal kadaluarsa
        }
        return new Timestamp(System.currentTimeMillis()).after(expiryDate);
    }
    
    /**
     * Mengecek apakah sertifikat masih berlaku
     * @return true jika masih berlaku
     */
    public boolean isActive() {
        return isValid && !isExpired();
    }
    
    /**
     * Membatalkan/menonaktifkan sertifikat
     */
    public void revoke() {
        this.isValid = false;
    }
    
    /**
     * Mendapatkan URL verifikasi sertifikat
     * @param baseUrl base URL aplikasi
     * @return URL lengkap untuk verifikasi
     */
    public String getVerificationUrl(String baseUrl) {
        return baseUrl + "/verify?code=" + certificateCode;
    }
    
    /**
     * Format tanggal penerbitan untuk display
     * @return string tanggal dalam format yang mudah dibaca
     */
    public String getFormattedIssuedDate() {
        if (issuedAt == null) return "-";
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd MMMM yyyy");
        return sdf.format(issuedAt);
    }
    
    /**
     * Mendapatkan status display
     * @return status dalam bahasa Indonesia
     */
    public String getStatusDisplayName() {
        if (!isValid) {
            return "Dibatalkan";
        }
        if (isExpired()) {
            return "Kadaluarsa";
        }
        return "Aktif";
    }
    
    @Override
    public String toString() {
        return "Certificate{" +
                "certificateId=" + certificateId +
                ", certificateCode='" + certificateCode + '\'' +
                ", studentName='" + studentName + '\'' +
                ", courseName='" + courseName + '\'' +
                ", isValid=" + isValid +
                '}';
    }
}
