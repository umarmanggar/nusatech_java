/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.Timestamp;
import java.util.List;
import java.util.ArrayList;
/**
 *
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
    private List<Question> questions = new ArrayList<>();
    
    // TODO: Add getters and setters
    public int getQuizId() { return quizId; }
    public void setQuizId(int quizId) { this.quizId = quizId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public List<Question> getQuestions() { return questions; }
    public void setQuestions(List<Question> questions) { this.questions = questions; }   
}
