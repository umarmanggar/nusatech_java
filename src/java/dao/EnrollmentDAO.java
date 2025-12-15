/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import model.Enrollment;
import model.Course;
import model.User;
import util.DBConnection;

import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author user
 */
public class EnrollmentDAO {
    public int create(Enrollment enrollment) throws SQLException {
        String sql = "INSERT INTO enrollments (student_id, course_id, progress_percentage, status) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, enrollment.getStudentId());
            ps.setInt(2, enrollment.getCourseId());
            ps.setBigDecimal(3, enrollment.getProgressPercentage());
            ps.setString(4, enrollment.getStatus().name());
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        }
        return -1;
    }
    
    /**
     * Find enrollment by ID
     */
    public Enrollment findById(int enrollmentId) throws SQLException {
        String sql = "SELECT e.*, c.title as course_title, c.thumbnail as course_thumbnail, " +
                     "c.slug as course_slug, u.name as student_name " +
                     "FROM enrollments e " +
                     "JOIN courses c ON e.course_id = c.course_id " +
                     "JOIN users u ON e.student_id = u.user_id " +
                     "WHERE e.enrollment_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, enrollmentId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEnrollment(rs);
                }
            }
        }
        return null;
    }
    
    /**
     * Find enrollment by student and course
     */
    public Enrollment findByStudentAndCourse(int studentId, int courseId) throws SQLException {
        String sql = "SELECT e.*, c.title as course_title, c.thumbnail as course_thumbnail, " +
                     "c.slug as course_slug, u.name as student_name " +
                     "FROM enrollments e " +
                     "JOIN courses c ON e.course_id = c.course_id " +
                     "JOIN users u ON e.student_id = u.user_id " +
                     "WHERE e.student_id = ? AND e.course_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEnrollment(rs);
                }
            }
        }
        return null;
    }
    
    /**
     * Check if student is enrolled
     */
    public boolean isEnrolled(int studentId, int courseId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM enrollments WHERE student_id = ? AND course_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }
    
    /**
     * Get enrollments by student (My Learning)
     */
    public List<Enrollment> findByStudent(int studentId) throws SQLException {
        List<Enrollment> enrollments = new ArrayList<>();
        String sql = "SELECT e.*, c.title as course_title, c.thumbnail as course_thumbnail, " +
                     "c.slug as course_slug, c.total_materials, c.lecturer_id, " +
                     "u.name as student_name, l.name as lecturer_name " +
                     "FROM enrollments e " +
                     "JOIN courses c ON e.course_id = c.course_id " +
                     "JOIN users u ON e.student_id = u.user_id " +
                     "JOIN users l ON c.lecturer_id = l.user_id " +
                     "WHERE e.student_id = ? " +
                     "ORDER BY e.last_accessed_at DESC, e.enrolled_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    enrollments.add(mapResultSetToEnrollmentWithCourse(rs));
                }
            }
        }
        return enrollments;
    }
    
    /**
     * Get active enrollments by student
     */
    public List<Enrollment> findActiveByStudent(int studentId) throws SQLException {
        List<Enrollment> enrollments = new ArrayList<>();
        String sql = "SELECT e.*, c.title as course_title, c.thumbnail as course_thumbnail, " +
                     "c.slug as course_slug, c.total_materials, c.lecturer_id, " +
                     "u.name as student_name, l.name as lecturer_name " +
                     "FROM enrollments e " +
                     "JOIN courses c ON e.course_id = c.course_id " +
                     "JOIN users u ON e.student_id = u.user_id " +
                     "JOIN users l ON c.lecturer_id = l.user_id " +
                     "WHERE e.student_id = ? AND e.status = 'ACTIVE' " +
                     "ORDER BY e.last_accessed_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    enrollments.add(mapResultSetToEnrollmentWithCourse(rs));
                }
            }
        }
        return enrollments;
    }
    
    /**
     * Get completed enrollments by student
     */
    public List<Enrollment> findCompletedByStudent(int studentId) throws SQLException {
        List<Enrollment> enrollments = new ArrayList<>();
        String sql = "SELECT e.*, c.title as course_title, c.thumbnail as course_thumbnail, " +
                     "c.slug as course_slug, u.name as student_name " +
                     "FROM enrollments e " +
                     "JOIN courses c ON e.course_id = c.course_id " +
                     "JOIN users u ON e.student_id = u.user_id " +
                     "WHERE e.student_id = ? AND e.status = 'COMPLETED' " +
                     "ORDER BY e.completed_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    enrollments.add(mapResultSetToEnrollment(rs));
                }
            }
        }
        return enrollments;
    }
    
    /**
     * Get enrollments by course (for lecturer)
     */
    public List<Enrollment> findByCourse(int courseId) throws SQLException {
        List<Enrollment> enrollments = new ArrayList<>();
        String sql = "SELECT e.*, u.name as student_name, u.email as student_email, " +
                     "u.profile_picture as student_avatar " +
                     "FROM enrollments e " +
                     "JOIN users u ON e.student_id = u.user_id " +
                     "WHERE e.course_id = ? " +
                     "ORDER BY e.enrolled_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, courseId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Enrollment enrollment = mapResultSetToEnrollment(rs);
                    User student = new User();
                    student.setUserId(enrollment.getStudentId());
                    student.setName(rs.getString("student_name"));
                    student.setEmail(rs.getString("student_email"));
                    student.setProfilePicture(rs.getString("student_avatar"));
                    enrollment.setStudent(student);
                    enrollments.add(enrollment);
                }
            }
        }
        return enrollments;
    }
    
    /**
     * Update progress
     */
    public boolean updateProgress(int enrollmentId, BigDecimal progress) throws SQLException {
        String sql = "UPDATE enrollments SET progress_percentage = ?, last_accessed_at = CURRENT_TIMESTAMP " +
                     "WHERE enrollment_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setBigDecimal(1, progress);
            ps.setInt(2, enrollmentId);
            
            boolean updated = ps.executeUpdate() > 0;
            
            // Check if course is completed
            if (updated && progress.compareTo(new BigDecimal(100)) >= 0) {
                markAsCompleted(enrollmentId);
            }
            
            return updated;
        }
    }
    
    /**
     * Mark enrollment as completed
     */
    public boolean markAsCompleted(int enrollmentId) throws SQLException {
        String sql = "UPDATE enrollments SET status = 'COMPLETED', completed_at = CURRENT_TIMESTAMP, " +
                     "progress_percentage = 100 WHERE enrollment_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, enrollmentId);
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Update last accessed
     */
    public void updateLastAccessed(int enrollmentId) throws SQLException {
        String sql = "UPDATE enrollments SET last_accessed_at = CURRENT_TIMESTAMP WHERE enrollment_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, enrollmentId);
            ps.executeUpdate();
        }
    }
    
    /**
     * Issue certificate
     */
    public boolean issueCertificate(int enrollmentId, String certificateUrl) throws SQLException {
        String sql = "UPDATE enrollments SET certificate_issued = TRUE, certificate_url = ? WHERE enrollment_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, certificateUrl);
            ps.setInt(2, enrollmentId);
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Count enrollments by student
     */
    public int countByStudent(int studentId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM enrollments WHERE student_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    
    /**
     * Count completed by student
     */
    public int countCompletedByStudent(int studentId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM enrollments WHERE student_id = ? AND status = 'COMPLETED'";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    
    /**
     * Map ResultSet to Enrollment object
     */
    private Enrollment mapResultSetToEnrollment(ResultSet rs) throws SQLException {
        Enrollment enrollment = new Enrollment();
        enrollment.setEnrollmentId(rs.getInt("enrollment_id"));
        enrollment.setStudentId(rs.getInt("student_id"));
        enrollment.setCourseId(rs.getInt("course_id"));
        enrollment.setEnrolledAt(rs.getTimestamp("enrolled_at"));
        enrollment.setProgressPercentage(rs.getBigDecimal("progress_percentage"));
        enrollment.setLastAccessedAt(rs.getTimestamp("last_accessed_at"));
        enrollment.setCompletedAt(rs.getTimestamp("completed_at"));
        enrollment.setCertificateIssued(rs.getBoolean("certificate_issued"));
        enrollment.setCertificateUrl(rs.getString("certificate_url"));
        enrollment.setStatus(Enrollment.Status.valueOf(rs.getString("status")));
        return enrollment;
    }
    
    /**
     * Map ResultSet to Enrollment with Course details
     */
    private Enrollment mapResultSetToEnrollmentWithCourse(ResultSet rs) throws SQLException {
        Enrollment enrollment = mapResultSetToEnrollment(rs);
        
        Course course = new Course();
        course.setCourseId(enrollment.getCourseId());
        course.setTitle(rs.getString("course_title"));
        course.setThumbnail(rs.getString("course_thumbnail"));
        course.setSlug(rs.getString("course_slug"));
        
        try {
            course.setTotalMaterials(rs.getInt("total_materials"));
            User lecturer = new User();
            lecturer.setUserId(rs.getInt("lecturer_id"));
            lecturer.setName(rs.getString("lecturer_name"));
            course.setLecturer(lecturer);
        } catch (SQLException e) {
            // Optional columns
        }
        
        enrollment.setCourse(course);
        return enrollment;
    }
}
