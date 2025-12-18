/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Question;
import model.QuestionOption;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class untuk Question
 * @author user
 */
public class QuestionDAO {
    
    /**
     * Create a new question
     */
    public int create(Question question) throws SQLException {
        String sql = "INSERT INTO questions (quiz_id, question_text, question_type, points, display_order, explanation) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, question.getQuizId());
            ps.setString(2, question.getQuestionText());
            ps.setString(3, question.getQuestionType().name());
            ps.setInt(4, question.getPoints());
            ps.setInt(5, question.getDisplayOrder());
            ps.setString(6, question.getExplanation());
            
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
     * Find question by ID
     */
    public Question findById(int questionId) throws SQLException {
        String sql = "SELECT * FROM questions WHERE question_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, questionId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSet(rs);
                }
            }
        }
        return null;
    }
    
    /**
     * Find questions by quiz ID
     */
    public List<Question> findByQuiz(int quizId) throws SQLException {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT * FROM questions WHERE quiz_id = ? ORDER BY display_order";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, quizId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    questions.add(mapResultSet(rs));
                }
            }
        }
        return questions;
    }
    
    /**
     * Find questions by quiz with options
     */
    public List<Question> findByQuizWithOptions(int quizId) throws SQLException {
        List<Question> questions = findByQuiz(quizId);
        
        String optionSql = "SELECT * FROM question_options WHERE question_id = ? ORDER BY display_order";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(optionSql)) {
            
            for (Question question : questions) {
                ps.setInt(1, question.getQuestionId());
                
                try (ResultSet rs = ps.executeQuery()) {
                    List<QuestionOption> options = new ArrayList<>();
                    while (rs.next()) {
                        options.add(mapOptionResultSet(rs));
                    }
                    question.setOptions(options);
                }
            }
        }
        return questions;
    }
    
    /**
     * Update question
     */
    public boolean update(Question question) throws SQLException {
        String sql = "UPDATE questions SET question_text = ?, question_type = ?, points = ?, " +
                     "display_order = ?, explanation = ? WHERE question_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, question.getQuestionText());
            ps.setString(2, question.getQuestionType().name());
            ps.setInt(3, question.getPoints());
            ps.setInt(4, question.getDisplayOrder());
            ps.setString(5, question.getExplanation());
            ps.setInt(6, question.getQuestionId());
            
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Delete question
     */
    public boolean delete(int questionId) throws SQLException {
        String sql = "DELETE FROM questions WHERE question_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, questionId);
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Create question with options in a transaction
     */
    public int createWithOptions(Question question, List<QuestionOption> options) throws SQLException {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);
            
            // Create question
            String questionSql = "INSERT INTO questions (quiz_id, question_text, question_type, points, display_order, explanation) " +
                                 "VALUES (?, ?, ?, ?, ?, ?)";
            
            int questionId;
            try (PreparedStatement ps = conn.prepareStatement(questionSql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, question.getQuizId());
                ps.setString(2, question.getQuestionText());
                ps.setString(3, question.getQuestionType().name());
                ps.setInt(4, question.getPoints());
                ps.setInt(5, question.getDisplayOrder());
                ps.setString(6, question.getExplanation());
                
                ps.executeUpdate();
                
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        questionId = rs.getInt(1);
                    } else {
                        throw new SQLException("Failed to create question");
                    }
                }
            }
            
            // Create options
            String optionSql = "INSERT INTO question_options (question_id, option_text, is_correct, display_order) " +
                               "VALUES (?, ?, ?, ?)";
            
            try (PreparedStatement ps = conn.prepareStatement(optionSql)) {
                for (int i = 0; i < options.size(); i++) {
                    QuestionOption option = options.get(i);
                    ps.setInt(1, questionId);
                    ps.setString(2, option.getOptionText());
                    ps.setBoolean(3, option.isCorrect());
                    ps.setInt(4, i);
                    ps.addBatch();
                }
                ps.executeBatch();
            }
            
            conn.commit();
            return questionId;
            
        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }
    
    /**
     * Create option for a question
     */
    public int createOption(QuestionOption option) throws SQLException {
        String sql = "INSERT INTO question_options (question_id, option_text, is_correct, display_order) " +
                     "VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, option.getQuestionId());
            ps.setString(2, option.getOptionText());
            ps.setBoolean(3, option.isCorrect());
            ps.setInt(4, option.getDisplayOrder());
            
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
     * Update option
     */
    public boolean updateOption(QuestionOption option) throws SQLException {
        String sql = "UPDATE question_options SET option_text = ?, is_correct = ?, display_order = ? " +
                     "WHERE option_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, option.getOptionText());
            ps.setBoolean(2, option.isCorrect());
            ps.setInt(3, option.getDisplayOrder());
            ps.setInt(4, option.getOptionId());
            
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Delete option
     */
    public boolean deleteOption(int optionId) throws SQLException {
        String sql = "DELETE FROM question_options WHERE option_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, optionId);
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Get options by question ID
     */
    public List<QuestionOption> getOptionsByQuestion(int questionId) throws SQLException {
        List<QuestionOption> options = new ArrayList<>();
        String sql = "SELECT * FROM question_options WHERE question_id = ? ORDER BY display_order";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, questionId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    options.add(mapOptionResultSet(rs));
                }
            }
        }
        return options;
    }
    
    /**
     * Get next display order for a quiz
     */
    public int getNextDisplayOrder(int quizId) throws SQLException {
        String sql = "SELECT COALESCE(MAX(display_order), -1) + 1 FROM questions WHERE quiz_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, quizId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    
    /**
     * Count questions by quiz
     */
    public int countByQuiz(int quizId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM questions WHERE quiz_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, quizId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    
    private Question mapResultSet(ResultSet rs) throws SQLException {
        Question question = new Question();
        question.setQuestionId(rs.getInt("question_id"));
        question.setQuizId(rs.getInt("quiz_id"));
        question.setQuestionText(rs.getString("question_text"));
        question.setQuestionType(Question.Type.valueOf(rs.getString("question_type")));
        question.setPoints(rs.getInt("points"));
        question.setDisplayOrder(rs.getInt("display_order"));
        question.setExplanation(rs.getString("explanation"));
        question.setCreatedAt(rs.getTimestamp("created_at"));
        return question;
    }
    
    private QuestionOption mapOptionResultSet(ResultSet rs) throws SQLException {
        QuestionOption option = new QuestionOption();
        option.setOptionId(rs.getInt("option_id"));
        option.setQuestionId(rs.getInt("question_id"));
        option.setOptionText(rs.getString("option_text"));
        option.setCorrect(rs.getBoolean("is_correct"));
        option.setDisplayOrder(rs.getInt("display_order"));
        return option;
    }
}
