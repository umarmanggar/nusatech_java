/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author user
 */
public class QuestionOption {
    private int optionId;
    private int questionId;
    private String optionText;
    private boolean isCorrect;
    private int displayOrder;
    
    public int getOptionId() { return optionId; }
    public void setOptionId(int optionId) { this.optionId = optionId; }
    public String getOptionText() { return optionText; }
    public void setOptionText(String text) { this.optionText = text; }
    public boolean isCorrect() { return isCorrect; }
    public void setCorrect(boolean correct) { isCorrect = correct; }   
}
