/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Transaction;
import model.TransactionItem;
import model.User;
import model.Course;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class untuk Payment/Transaction
 * @author user
 */
public class PaymentDAO {
    
    /**
     * Create a new transaction
     */
    public int create(Transaction transaction) throws SQLException {
        String sql = "INSERT INTO transactions (user_id, transaction_code, total_amount, payment_method, " +
                     "payment_status, expired_at, notes) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, transaction.getUserId());
            ps.setString(2, transaction.getTransactionCode());
            ps.setBigDecimal(3, transaction.getTotalAmount());
            ps.setString(4, transaction.getPaymentMethod().name());
            ps.setString(5, transaction.getPaymentStatus().name());
            ps.setTimestamp(6, transaction.getExpiredAt());
            ps.setString(7, transaction.getNotes());
            
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
     * Create transaction with items in a single transaction
     */
    public int createWithItems(Transaction transaction, List<TransactionItem> items) throws SQLException {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);
            
            // Create transaction
            String transactionSql = "INSERT INTO transactions (user_id, transaction_code, total_amount, " +
                                    "payment_method, payment_status, expired_at, notes) VALUES (?, ?, ?, ?, ?, ?, ?)";
            
            int transactionId;
            try (PreparedStatement ps = conn.prepareStatement(transactionSql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, transaction.getUserId());
                ps.setString(2, transaction.getTransactionCode());
                ps.setBigDecimal(3, transaction.getTotalAmount());
                ps.setString(4, transaction.getPaymentMethod().name());
                ps.setString(5, transaction.getPaymentStatus().name());
                ps.setTimestamp(6, transaction.getExpiredAt());
                ps.setString(7, transaction.getNotes());
                
                ps.executeUpdate();
                
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        transactionId = rs.getInt(1);
                    } else {
                        throw new SQLException("Failed to create transaction");
                    }
                }
            }
            
            // Create items
            String itemSql = "INSERT INTO transaction_items (transaction_id, course_id, plan_id, item_type, price, discount) " +
                             "VALUES (?, ?, ?, ?, ?, ?)";
            
            try (PreparedStatement ps = conn.prepareStatement(itemSql)) {
                for (TransactionItem item : items) {
                    ps.setInt(1, transactionId);
                    if (item.getCourseId() != null) {
                        ps.setInt(2, item.getCourseId());
                    } else {
                        ps.setNull(2, Types.INTEGER);
                    }
                    if (item.getPlanId() != null) {
                        ps.setInt(3, item.getPlanId());
                    } else {
                        ps.setNull(3, Types.INTEGER);
                    }
                    ps.setString(4, item.getItemType().name());
                    ps.setBigDecimal(5, item.getPrice());
                    ps.setBigDecimal(6, item.getDiscount());
                    ps.addBatch();
                }
                ps.executeBatch();
            }
            
            conn.commit();
            return transactionId;
            
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
     * Find transaction by ID
     */
    public Transaction findById(int transactionId) throws SQLException {
        String sql = "SELECT t.*, u.name as user_name, u.email as user_email " +
                     "FROM transactions t " +
                     "JOIN users u ON t.user_id = u.user_id " +
                     "WHERE t.transaction_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, transactionId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Transaction transaction = mapResultSet(rs);
                    transaction.setItems(findItemsByTransaction(transactionId));
                    return transaction;
                }
            }
        }
        return null;
    }
    
    /**
     * Find transaction by transaction code
     */
    public Transaction findByTransactionCode(String transactionCode) throws SQLException {
        String sql = "SELECT t.*, u.name as user_name, u.email as user_email " +
                     "FROM transactions t " +
                     "JOIN users u ON t.user_id = u.user_id " +
                     "WHERE t.transaction_code = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, transactionCode);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Transaction transaction = mapResultSet(rs);
                    transaction.setItems(findItemsByTransaction(transaction.getTransactionId()));
                    return transaction;
                }
            }
        }
        return null;
    }
    
    /**
     * Find transactions by student (user)
     */
    public List<Transaction> findByStudent(int studentId) throws SQLException {
        List<Transaction> transactions = new ArrayList<>();
        String sql = "SELECT t.*, u.name as user_name, u.email as user_email " +
                     "FROM transactions t " +
                     "JOIN users u ON t.user_id = u.user_id " +
                     "WHERE t.user_id = ? " +
                     "ORDER BY t.created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    transactions.add(mapResultSet(rs));
                }
            }
        }
        return transactions;
    }
    
    /**
     * Find transactions by student with pagination
     */
    public List<Transaction> findByStudent(int studentId, int page, int pageSize) throws SQLException {
        List<Transaction> transactions = new ArrayList<>();
        String sql = "SELECT t.*, u.name as user_name, u.email as user_email " +
                     "FROM transactions t " +
                     "JOIN users u ON t.user_id = u.user_id " +
                     "WHERE t.user_id = ? " +
                     "ORDER BY t.created_at DESC " +
                     "LIMIT ? OFFSET ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, studentId);
            ps.setInt(2, pageSize);
            ps.setInt(3, (page - 1) * pageSize);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    transactions.add(mapResultSet(rs));
                }
            }
        }
        return transactions;
    }
    
    /**
     * Find transaction items
     */
    public List<TransactionItem> findItemsByTransaction(int transactionId) throws SQLException {
        List<TransactionItem> items = new ArrayList<>();
        String sql = "SELECT ti.*, c.title as course_title, c.thumbnail as course_thumbnail " +
                     "FROM transaction_items ti " +
                     "LEFT JOIN courses c ON ti.course_id = c.course_id " +
                     "WHERE ti.transaction_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, transactionId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    TransactionItem item = new TransactionItem();
                    item.setItemId(rs.getInt("item_id"));
                    item.setTransactionId(rs.getInt("transaction_id"));
                    
                    int courseId = rs.getInt("course_id");
                    if (!rs.wasNull()) {
                        item.setCourseId(courseId);
                    }
                    
                    int planId = rs.getInt("plan_id");
                    if (!rs.wasNull()) {
                        item.setPlanId(planId);
                    }
                    
                    item.setItemType(TransactionItem.ItemType.valueOf(rs.getString("item_type")));
                    item.setPrice(rs.getBigDecimal("price"));
                    item.setDiscount(rs.getBigDecimal("discount"));
                    
                    // Map course if exists
                    try {
                        if (item.getCourseId() != null) {
                            Course course = new Course();
                            course.setCourseId(item.getCourseId());
                            course.setTitle(rs.getString("course_title"));
                            course.setThumbnail(rs.getString("course_thumbnail"));
                            item.setCourse(course);
                        }
                    } catch (SQLException e) {
                        // Columns might not exist
                    }
                    
                    items.add(item);
                }
            }
        }
        return items;
    }
    
    /**
     * Update transaction status
     */
    public boolean updateStatus(int transactionId, Transaction.PaymentStatus status) throws SQLException {
        String sql;
        if (status == Transaction.PaymentStatus.PAID) {
            sql = "UPDATE transactions SET payment_status = ?, paid_at = CURRENT_TIMESTAMP WHERE transaction_id = ?";
        } else {
            sql = "UPDATE transactions SET payment_status = ? WHERE transaction_id = ?";
        }
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, status.name());
            ps.setInt(2, transactionId);
            
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Update payment proof
     */
    public boolean updatePaymentProof(int transactionId, String proofUrl) throws SQLException {
        String sql = "UPDATE transactions SET payment_proof = ? WHERE transaction_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, proofUrl);
            ps.setInt(2, transactionId);
            
            return ps.executeUpdate() > 0;
        }
    }
    
    /**
     * Find pending transactions that have expired
     */
    public List<Transaction> findExpiredPending() throws SQLException {
        List<Transaction> transactions = new ArrayList<>();
        String sql = "SELECT t.*, u.name as user_name, u.email as user_email " +
                     "FROM transactions t " +
                     "JOIN users u ON t.user_id = u.user_id " +
                     "WHERE t.payment_status = 'PENDING' AND t.expired_at < CURRENT_TIMESTAMP";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                transactions.add(mapResultSet(rs));
            }
        }
        return transactions;
    }
    
    /**
     * Mark expired transactions
     */
    public int markExpiredTransactions() throws SQLException {
        String sql = "UPDATE transactions SET payment_status = 'EXPIRED' " +
                     "WHERE payment_status = 'PENDING' AND expired_at < CURRENT_TIMESTAMP";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            return ps.executeUpdate();
        }
    }
    
    /**
     * Find all transactions with pagination (for admin)
     */
    public List<Transaction> findAll(int page, int pageSize) throws SQLException {
        List<Transaction> transactions = new ArrayList<>();
        String sql = "SELECT t.*, u.name as user_name, u.email as user_email " +
                     "FROM transactions t " +
                     "JOIN users u ON t.user_id = u.user_id " +
                     "ORDER BY t.created_at DESC " +
                     "LIMIT ? OFFSET ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, pageSize);
            ps.setInt(2, (page - 1) * pageSize);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    transactions.add(mapResultSet(rs));
                }
            }
        }
        return transactions;
    }
    
    /**
     * Find transactions by status
     */
    public List<Transaction> findByStatus(Transaction.PaymentStatus status, int page, int pageSize) throws SQLException {
        List<Transaction> transactions = new ArrayList<>();
        String sql = "SELECT t.*, u.name as user_name, u.email as user_email " +
                     "FROM transactions t " +
                     "JOIN users u ON t.user_id = u.user_id " +
                     "WHERE t.payment_status = ? " +
                     "ORDER BY t.created_at DESC " +
                     "LIMIT ? OFFSET ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, status.name());
            ps.setInt(2, pageSize);
            ps.setInt(3, (page - 1) * pageSize);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    transactions.add(mapResultSet(rs));
                }
            }
        }
        return transactions;
    }
    
    /**
     * Count transactions by user
     */
    public int countByUser(int userId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM transactions WHERE user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    
    private Transaction mapResultSet(ResultSet rs) throws SQLException {
        Transaction transaction = new Transaction();
        transaction.setTransactionId(rs.getInt("transaction_id"));
        transaction.setUserId(rs.getInt("user_id"));
        transaction.setTransactionCode(rs.getString("transaction_code"));
        transaction.setTotalAmount(rs.getBigDecimal("total_amount"));
        transaction.setPaymentMethod(Transaction.PaymentMethod.valueOf(rs.getString("payment_method")));
        transaction.setPaymentStatus(Transaction.PaymentStatus.valueOf(rs.getString("payment_status")));
        transaction.setPaymentProof(rs.getString("payment_proof"));
        transaction.setPaidAt(rs.getTimestamp("paid_at"));
        transaction.setExpiredAt(rs.getTimestamp("expired_at"));
        transaction.setNotes(rs.getString("notes"));
        transaction.setCreatedAt(rs.getTimestamp("created_at"));
        
        // Map related user
        try {
            User user = new User();
            user.setUserId(transaction.getUserId());
            user.setName(rs.getString("user_name"));
            user.setEmail(rs.getString("user_email"));
            transaction.setUser(user);
        } catch (SQLException e) {
            // Columns might not exist
        }
        
        return transaction;
    }
}
