/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.math.BigDecimal;
import java.math.RoundingMode;

/**
 * Model class untuk Quiz Attempt
 * Menyimpan record percobaan siswa mengerjakan quiz
 * @author user
 */
public class QuizAttempt {
    public enum Status {
        IN_PROGRESS, COMPLETED, TIMED_OUT, ABANDONED
    }
    
    private int attemptId;
    private int quizId;
    private int studentId;
    private BigDecimal score;
    private Timestamp startedAt;
    private Timestamp completedAt;
    private String answers; // JSON format untuk menyimpan jawaban
    private int totalQuestions;
    private int correctAnswers;
    private int timeSpentSeconds;
    private Status status;
    private boolean isPassed;
    
    // Related objects
    private Quiz quiz;
    private User student;
    
    // Default constructor
    public QuizAttempt() {
        this.score = BigDecimal.ZERO;
        this.totalQuestions = 0;
        this.correctAnswers = 0;
        this.timeSpentSeconds = 0;
        this.status = Status.IN_PROGRESS;
        this.isPassed = false;
    }
    
    // Constructor with required fields
    public QuizAttempt(int quizId, int studentId) {
        this();
        this.quizId = quizId;
        this.studentId = studentId;
        this.startedAt = new Timestamp(System.currentTimeMillis());
    }
    
    // Full constructor
    public QuizAttempt(int attemptId, int quizId, int studentId, BigDecimal score,
                       Timestamp startedAt, Timestamp completedAt, String answers,
                       int totalQuestions, int correctAnswers, int timeSpentSeconds,
                       Status status, boolean isPassed) {
        this.attemptId = attemptId;
        this.quizId = quizId;
        this.studentId = studentId;
        this.score = score;
        this.startedAt = startedAt;
        this.completedAt = completedAt;
        this.answers = answers;
        this.totalQuestions = totalQuestions;
        this.correctAnswers = correctAnswers;
        this.timeSpentSeconds = timeSpentSeconds;
        this.status = status;
        this.isPassed = isPassed;
    }
    
    // Getters and Setters
    public int getAttemptId() { return attemptId; }
    public void setAttemptId(int attemptId) { this.attemptId = attemptId; }
    
    public int getQuizId() { return quizId; }
    public void setQuizId(int quizId) { this.quizId = quizId; }
    
    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }
    
    public BigDecimal getScore() { return score; }
    public void setScore(BigDecimal score) { this.score = score; }
    
    public Timestamp getStartedAt() { return startedAt; }
    public void setStartedAt(Timestamp startedAt) { this.startedAt = startedAt; }
    
    public Timestamp getCompletedAt() { return completedAt; }
    public void setCompletedAt(Timestamp completedAt) { this.completedAt = completedAt; }
    
    public String getAnswers() { return answers; }
    public void setAnswers(String answers) { this.answers = answers; }
    
    public int getTotalQuestions() { return totalQuestions; }
    public void setTotalQuestions(int totalQuestions) { this.totalQuestions = totalQuestions; }
    
    public int getCorrectAnswers() { return correctAnswers; }
    public void setCorrectAnswers(int correctAnswers) { this.correctAnswers = correctAnswers; }
    
    public int getTimeSpentSeconds() { return timeSpentSeconds; }
    public void setTimeSpentSeconds(int timeSpentSeconds) { this.timeSpentSeconds = timeSpentSeconds; }
    
    public Status getStatus() { return status; }
    public void setStatus(Status status) { this.status = status; }
    
    public boolean isPassed() { return isPassed; }
    public void setPassed(boolean passed) { isPassed = passed; }
    
    public Quiz getQuiz() { return quiz; }
    public void setQuiz(Quiz quiz) { this.quiz = quiz; }
    
    public User getStudent() { return student; }
    public void setStudent(User student) { this.student = student; }
    
    // Helper methods
    
    /**
     * Menghitung dan mengupdate score berdasarkan jawaban benar
     */
    public void calculateScore() {
        if (totalQuestions > 0) {
            BigDecimal scoreValue = new BigDecimal(correctAnswers)
                    .multiply(new BigDecimal(100))
                    .divide(new BigDecimal(totalQuestions), 2, RoundingMode.HALF_UP);
            this.score = scoreValue;
        }
    }
    
    /**
     * Menyelesaikan attempt dan menghitung hasil
     * @param passingScore passing score dari quiz
     */
    public void complete(int passingScore) {
        this.completedAt = new Timestamp(System.currentTimeMillis());
        this.status = Status.COMPLETED;
        calculateScore();
        this.isPassed = this.score.compareTo(new BigDecimal(passingScore)) >= 0;
        
        // Calculate time spent
        if (startedAt != null && completedAt != null) {
            this.timeSpentSeconds = (int) ((completedAt.getTime() - startedAt.getTime()) / 1000);
        }
    }
    
    /**
     * Menandai attempt sebagai timeout
     */
    public void markAsTimedOut() {
        this.completedAt = new Timestamp(System.currentTimeMillis());
        this.status = Status.TIMED_OUT;
        calculateScore();
    }
    
    /**
     * Mengecek apakah attempt masih dalam progress
     * @return true jika masih dalam progress
     */
    public boolean isInProgress() {
        return status == Status.IN_PROGRESS;
    }
    
    /**
     * Mengecek apakah attempt sudah selesai
     * @return true jika sudah selesai
     */
    public boolean isCompleted() {
        return status == Status.COMPLETED;
    }
    
    /**
     * Mendapatkan persentase jawaban benar
     * @return persentase dalam integer
     */
    public int getCorrectPercentage() {
        if (totalQuestions == 0) return 0;
        return (correctAnswers * 100) / totalQuestions;
    }
    
    /**
     * Format waktu yang dihabiskan
     * @return string format mm:ss atau hh:mm:ss
     */
    public String getFormattedTimeSpent() {
        int hours = timeSpentSeconds / 3600;
        int minutes = (timeSpentSeconds % 3600) / 60;
        int seconds = timeSpentSeconds % 60;
        
        if (hours > 0) {
            return String.format("%d:%02d:%02d", hours, minutes, seconds);
        } else {
            return String.format("%d:%02d", minutes, seconds);
        }
    }
    
    /**
     * Mendapatkan display name untuk status
     * @return nama status dalam bahasa Indonesia
     */
    public String getStatusDisplayName() {
        switch (status) {
            case IN_PROGRESS: return "Sedang Mengerjakan";
            case COMPLETED: return "Selesai";
            case TIMED_OUT: return "Waktu Habis";
            case ABANDONED: return "Ditinggalkan";
            default: return "Unknown";
        }
    }
    
    @Override
    public String toString() {
        return "QuizAttempt{" +
                "attemptId=" + attemptId +
                ", quizId=" + quizId +
                ", studentId=" + studentId +
                ", score=" + score +
                ", status=" + status +
                ", isPassed=" + isPassed +
                '}';
    }
}
