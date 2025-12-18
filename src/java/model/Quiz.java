/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.util.List;
import java.util.ArrayList;

/**
 * Model class untuk Quiz
 * @author user
 */
public class Quiz {
    private int quizId;
    private int materialId;
    private String title;
    private String description;
    private int passingScore;
    private int timeLimitMinutes;
    private int maxAttempts;
    private boolean shuffleQuestions;
    private boolean showCorrectAnswers;
    private Timestamp createdAt;
    
    // Related objects
    private Material material;
    private List<Question> questions;
    
    // Default constructor
    public Quiz() {
        this.passingScore = 70;
        this.timeLimitMinutes = 0;
        this.maxAttempts = 3;
        this.shuffleQuestions = true;
        this.showCorrectAnswers = false;
        this.questions = new ArrayList<>();
    }
    
    // Constructor with required fields
    public Quiz(int materialId, String title) {
        this();
        this.materialId = materialId;
        this.title = title;
    }
    
    // Full constructor
    public Quiz(int quizId, int materialId, String title, String description,
                int passingScore, int timeLimitMinutes, int maxAttempts,
                boolean shuffleQuestions, boolean showCorrectAnswers, Timestamp createdAt) {
        this();
        this.quizId = quizId;
        this.materialId = materialId;
        this.title = title;
        this.description = description;
        this.passingScore = passingScore;
        this.timeLimitMinutes = timeLimitMinutes;
        this.maxAttempts = maxAttempts;
        this.shuffleQuestions = shuffleQuestions;
        this.showCorrectAnswers = showCorrectAnswers;
        this.createdAt = createdAt;
    }
    
    // Getters and Setters
    public int getQuizId() { return quizId; }
    public void setQuizId(int quizId) { this.quizId = quizId; }
    
    public int getMaterialId() { return materialId; }
    public void setMaterialId(int materialId) { this.materialId = materialId; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public int getPassingScore() { return passingScore; }
    public void setPassingScore(int passingScore) { this.passingScore = passingScore; }
    
    public int getTimeLimitMinutes() { return timeLimitMinutes; }
    public void setTimeLimitMinutes(int timeLimitMinutes) { this.timeLimitMinutes = timeLimitMinutes; }
    
    public int getMaxAttempts() { return maxAttempts; }
    public void setMaxAttempts(int maxAttempts) { this.maxAttempts = maxAttempts; }
    
    public boolean isShuffleQuestions() { return shuffleQuestions; }
    public void setShuffleQuestions(boolean shuffleQuestions) { this.shuffleQuestions = shuffleQuestions; }
    
    public boolean isShowCorrectAnswers() { return showCorrectAnswers; }
    public void setShowCorrectAnswers(boolean showCorrectAnswers) { this.showCorrectAnswers = showCorrectAnswers; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public Material getMaterial() { return material; }
    public void setMaterial(Material material) { this.material = material; }
    
    public List<Question> getQuestions() { return questions; }
    public void setQuestions(List<Question> questions) { this.questions = questions; }
    
    // Helper methods
    public int getTotalQuestions() {
        return questions != null ? questions.size() : 0;
    }
    
    public int getTotalPoints() {
        if (questions == null) return 0;
        return questions.stream().mapToInt(Question::getPoints).sum();
    }
    
    public boolean hasTimeLimit() {
        return timeLimitMinutes > 0;
    }
    
    public String getFormattedTimeLimit() {
        if (timeLimitMinutes <= 0) return "Tidak ada batas waktu";
        int hours = timeLimitMinutes / 60;
        int minutes = timeLimitMinutes % 60;
        if (hours > 0) {
            return hours + " jam " + minutes + " menit";
        }
        return minutes + " menit";
    }
    
    @Override
    public String toString() {
        return "Quiz{" +
                "quizId=" + quizId +
                ", title='" + title + '\'' +
                ", passingScore=" + passingScore +
                ", totalQuestions=" + getTotalQuestions() +
                '}';
    }
}
