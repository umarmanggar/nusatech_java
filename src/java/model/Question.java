/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.util.List;
import java.util.ArrayList;

/**
 * Model class untuk Question
 * @author user
 */
public class Question {
    public enum Type { 
        MULTIPLE_CHOICE, TRUE_FALSE, ESSAY 
    }
    
    private int questionId;
    private int quizId;
    private String questionText;
    private Type questionType;
    private int points;
    private int displayOrder;
    private String explanation;
    private Timestamp createdAt;
    
    // Related objects
    private Quiz quiz;
    private List<QuestionOption> options;
    
    // Default constructor
    public Question() {
        this.questionType = Type.MULTIPLE_CHOICE;
        this.points = 1;
        this.displayOrder = 0;
        this.options = new ArrayList<>();
    }
    
    // Constructor with required fields
    public Question(int quizId, String questionText, Type questionType) {
        this();
        this.quizId = quizId;
        this.questionText = questionText;
        this.questionType = questionType;
    }
    
    // Full constructor
    public Question(int questionId, int quizId, String questionText, Type questionType,
                    int points, int displayOrder, String explanation, Timestamp createdAt) {
        this();
        this.questionId = questionId;
        this.quizId = quizId;
        this.questionText = questionText;
        this.questionType = questionType;
        this.points = points;
        this.displayOrder = displayOrder;
        this.explanation = explanation;
        this.createdAt = createdAt;
    }
    
    // Getters and Setters
    public int getQuestionId() { return questionId; }
    public void setQuestionId(int questionId) { this.questionId = questionId; }
    
    public int getQuizId() { return quizId; }
    public void setQuizId(int quizId) { this.quizId = quizId; }
    
    public String getQuestionText() { return questionText; }
    public void setQuestionText(String questionText) { this.questionText = questionText; }
    
    public Type getQuestionType() { return questionType; }
    public void setQuestionType(Type questionType) { this.questionType = questionType; }
    
    public int getPoints() { return points; }
    public void setPoints(int points) { this.points = points; }
    
    public int getDisplayOrder() { return displayOrder; }
    public void setDisplayOrder(int displayOrder) { this.displayOrder = displayOrder; }
    
    public String getExplanation() { return explanation; }
    public void setExplanation(String explanation) { this.explanation = explanation; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public Quiz getQuiz() { return quiz; }
    public void setQuiz(Quiz quiz) { this.quiz = quiz; }
    
    public List<QuestionOption> getOptions() { return options; }
    public void setOptions(List<QuestionOption> options) { this.options = options; }
    
    // Helper methods
    public void addOption(QuestionOption option) {
        option.setQuestionId(this.questionId);
        this.options.add(option);
    }
    
    public QuestionOption getCorrectOption() {
        if (options == null) return null;
        return options.stream()
                .filter(QuestionOption::isCorrect)
                .findFirst()
                .orElse(null);
    }
    
    public String getTypeDisplayName() {
        switch (questionType) {
            case MULTIPLE_CHOICE: return "Pilihan Ganda";
            case TRUE_FALSE: return "Benar/Salah";
            case ESSAY: return "Essay";
            default: return "Unknown";
        }
    }
    
    public boolean isMultipleChoice() {
        return questionType == Type.MULTIPLE_CHOICE;
    }
    
    public boolean isTrueFalse() {
        return questionType == Type.TRUE_FALSE;
    }
    
    public boolean isEssay() {
        return questionType == Type.ESSAY;
    }
    
    @Override
    public String toString() {
        return "Question{" +
                "questionId=" + questionId +
                ", quizId=" + quizId +
                ", questionType=" + questionType +
                ", points=" + points +
                '}';
    }
}
