/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 * Model class untuk Question Option
 * @author user
 */
public class QuestionOption {
    private int optionId;
    private int questionId;
    private String optionText;
    private boolean isCorrect;
    private int displayOrder;
    
    // Related object
    private Question question;
    
    // Default constructor
    public QuestionOption() {
        this.isCorrect = false;
        this.displayOrder = 0;
    }
    
    // Constructor with required fields
    public QuestionOption(int questionId, String optionText, boolean isCorrect) {
        this();
        this.questionId = questionId;
        this.optionText = optionText;
        this.isCorrect = isCorrect;
    }
    
    // Full constructor
    public QuestionOption(int optionId, int questionId, String optionText, 
                          boolean isCorrect, int displayOrder) {
        this.optionId = optionId;
        this.questionId = questionId;
        this.optionText = optionText;
        this.isCorrect = isCorrect;
        this.displayOrder = displayOrder;
    }
    
    // Getters and Setters
    public int getOptionId() { return optionId; }
    public void setOptionId(int optionId) { this.optionId = optionId; }
    
    public int getQuestionId() { return questionId; }
    public void setQuestionId(int questionId) { this.questionId = questionId; }
    
    public String getOptionText() { return optionText; }
    public void setOptionText(String optionText) { this.optionText = optionText; }
    
    public boolean isCorrect() { return isCorrect; }
    public void setCorrect(boolean correct) { isCorrect = correct; }
    
    public int getDisplayOrder() { return displayOrder; }
    public void setDisplayOrder(int displayOrder) { this.displayOrder = displayOrder; }
    
    public Question getQuestion() { return question; }
    public void setQuestion(Question question) { this.question = question; }
    
    // Helper method untuk mendapatkan label opsi (A, B, C, D, etc.)
    public String getOptionLabel() {
        if (displayOrder >= 0 && displayOrder < 26) {
            return String.valueOf((char) ('A' + displayOrder));
        }
        return String.valueOf(displayOrder + 1);
    }
    
    @Override
    public String toString() {
        return "QuestionOption{" +
                "optionId=" + optionId +
                ", questionId=" + questionId +
                ", isCorrect=" + isCorrect +
                '}';
    }
}
