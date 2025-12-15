/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.util.List;
import java.util.ArrayList;
/**
 *
 * @author user
 */
public class Question {
    public enum Type { MULTIPLE_CHOICE, TRUE_FALSE, ESSAY }
    
    private int questionId;
    private int quizId;
    private String questionText;
    private Type questionType = Type.MULTIPLE_CHOICE;
    private int points = 1;
    private int displayOrder;
    private String explanation;
    private List<QuestionOption> options = new ArrayList<>();
    
    // TODO: Add getters and setters
    public int getQuestionId() { return questionId; }
    public void setQuestionId(int questionId) { this.questionId = questionId; }
    public String getQuestionText() { return questionText; }
    public void setQuestionText(String text) { this.questionText = text; }
    public List<QuestionOption> getOptions() { return options; }   
}
