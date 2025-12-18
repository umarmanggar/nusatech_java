/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Quiz;
import model.Question;
import model.QuestionOption;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class untuk Quiz
 * @author user
 */
public class QuizDAO {
    
    /**
     * Create a new quiz
     */
    public int create(Quiz quiz) throws SQLException {
        String sql = "INSERT INTO quizzes (material_id, title, description, passing_score, " +
                     "time_limit_minutes, max_attempts, shuffle_questions, show_correct_answers) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, quiz.getMaterialId());
            ps.setString(2, quiz.getTitle());
            ps.setString(3, quiz.getDescription());
            ps.setInt(4, quiz.getPassingScore());
            ps.setInt(5, quiz.getTimeLimitMinutes());
            ps.setInt(6, quiz.getMaxAttempts());
            ps.setBoolean(7, quiz.isShuffleQuestions());
            ps.setBoolean(8, quiz.isShowCorrectAnswers());
            
            ps.executeUpdate();
            
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return -1;
    }
    
    /**
     * Find quiz by ID
     */
    public Quiz findById(int quizId) throws SQLException {
        String sql = "SELECT * FROM quizzes WHERE quiz_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, quizId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSet(rs);
                }
            }
        }
        return null;
    }
    
    /**
     * Find quiz by material ID
     */
    public Quiz findByMaterial(int materialId) throws SQLException {
        String sql = "SELECT * FROM quizzes WHERE material_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, materialId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSet(rs);
                }
            }
        }
        return null;
    }
    
    /**
     * Find quizzes by section (through materials)
     */
    public List<Quiz> findBySection(int sectionId) throws SQLException {
        List<Quiz> quizzes = new ArrayList<>();
        String sql = "SELECT q.* FROM quizzes q " +
                     "JOIN materials m ON q.material_id = m.material_id " +
                     "WHERE m.section_id = ? ORDER BY m.display_order";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, sectionId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    quizzes.add(mapResultSet(rs));
                }
            }
        }
        return quizzes;
    }
    
    /**
     * Update quiz
     */
    public boolean update(Quiz quiz) throws SQLException {
        String sql = "UPDATE quizzes SET title = ?, description = ?, passing_score = ?, " +
                     "time_limit_minutes = ?, max_attempts = ?, shuffle_questions = ?, " +
                     "show_correct_answers = ? WHERE quiz_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, quiz.getTitle());
            ps.setString(2, quiz.getDescription());
            ps.setInt(3, quiz.getPassingScore());
            ps.setInt(4, quiz.getTimeLimitMinutes());
            ps.setInt(5, quiz.getMaxAttempts());
            ps.setBoolean(6, quiz.isShuffleQuestions());
            ps.setBoolean(7, quiz.isShowCorrectAnswers());
            ps.setInt(8, quiz.getQuizId());
            
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Delete quiz
     */
    public boolean delete(int quizId) throws SQLException {
        String sql = "DELETE FROM quizzes WHERE quiz_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, quizId);
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Get quiz with all questions and options
     */
    public Quiz getQuizWithQuestions(int quizId) throws SQLException {
        Quiz quiz = findById(quizId);
        if (quiz == null) return null;
        
        // Get questions
        String questionSql = "SELECT * FROM questions WHERE quiz_id = ? ORDER BY display_order";
        String optionSql = "SELECT * FROM question_options WHERE question_id = ? ORDER BY display_order";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement questionPs = conn.prepareStatement(questionSql)) {
            
            questionPs.setInt(1, quizId);
            
            try (ResultSet questionRs = questionPs.executeQuery()) {
                List<Question> questions = new ArrayList<>();
                
                while (questionRs.next()) {
                    Question question = new Question();
                    question.setQuestionId(questionRs.getInt("question_id"));
                    question.setQuizId(questionRs.getInt("quiz_id"));
                    question.setQuestionText(questionRs.getString("question_text"));
                    question.setQuestionType(Question.Type.valueOf(questionRs.getString("question_type")));
                    question.setPoints(questionRs.getInt("points"));
                    question.setDisplayOrder(questionRs.getInt("display_order"));
                    question.setExplanation(questionRs.getString("explanation"));
                    question.setCreatedAt(questionRs.getTimestamp("created_at"));
                    
                    // Get options for this question
                    try (PreparedStatement optionPs = conn.prepareStatement(optionSql)) {
                        optionPs.setInt(1, question.getQuestionId());
                        
                        try (ResultSet optionRs = optionPs.executeQuery()) {
                            List<QuestionOption> options = new ArrayList<>();
                            
                            while (optionRs.next()) {
                                QuestionOption option = new QuestionOption();
                                option.setOptionId(optionRs.getInt("option_id"));
                                option.setQuestionId(optionRs.getInt("question_id"));
                                option.setOptionText(optionRs.getString("option_text"));
                                option.setCorrect(optionRs.getBoolean("is_correct"));
                                option.setDisplayOrder(optionRs.getInt("display_order"));
                                options.add(option);
                            }
                            question.setOptions(options);
                        }
                    }
                    questions.add(question);
                }
                quiz.setQuestions(questions);
            }
        }
        return quiz;
    }
    
    /**
     * Count attempts by student for a quiz
     */
    public int countAttempts(int quizId, int studentId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM quiz_attempts WHERE quiz_id = ? AND student_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, quizId);
            ps.setInt(2, studentId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    
    /**
     * Check if student can attempt quiz
     */
    public boolean canAttempt(int quizId, int studentId) throws SQLException {
        Quiz quiz = findById(quizId);
        if (quiz == null) return false;
        
        int attempts = countAttempts(quizId, studentId);
        return attempts < quiz.getMaxAttempts();
    }
    
    /**
     * Get best score for a student on a quiz
     */
    public double getBestScore(int quizId, int studentId) throws SQLException {
        String sql = "SELECT MAX(score) FROM quiz_attempts WHERE quiz_id = ? AND student_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, quizId);
            ps.setInt(2, studentId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble(1);
                }
            }
        }
        return 0;
    }
    
    private Quiz mapResultSet(ResultSet rs) throws SQLException {
        Quiz quiz = new Quiz();
        quiz.setQuizId(rs.getInt("quiz_id"));
        quiz.setMaterialId(rs.getInt("material_id"));
        quiz.setTitle(rs.getString("title"));
        quiz.setDescription(rs.getString("description"));
        quiz.setPassingScore(rs.getInt("passing_score"));
        quiz.setTimeLimitMinutes(rs.getInt("time_limit_minutes"));
        quiz.setMaxAttempts(rs.getInt("max_attempts"));
        quiz.setShuffleQuestions(rs.getBoolean("shuffle_questions"));
        quiz.setShowCorrectAnswers(rs.getBoolean("show_correct_answers"));
        quiz.setCreatedAt(rs.getTimestamp("created_at"));
        return quiz;
    }
}
