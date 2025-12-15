/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.Timestamp;
import java.math.BigDecimal;
import java.util.List;
import java.util.ArrayList;
/**
 *
 * @author user
 */
public class Transaction {
    public enum PaymentMethod { BANK_TRANSFER, E_WALLET, CREDIT_CARD, BALANCE }
    public enum PaymentStatus { PENDING, PAID, FAILED, REFUNDED, EXPIRED }
    
    private int transactionId;
    private int userId;
    private String transactionCode;
    private BigDecimal totalAmount;
    private PaymentMethod paymentMethod;
    private PaymentStatus paymentStatus = PaymentStatus.PENDING;
    private String paymentProof;
    private Timestamp paidAt;
    private Timestamp expiredAt;
    private String notes;
    private Timestamp createdAt;
    private User user;
    private List<TransactionItem> items = new ArrayList<>();
    
    // TODO: Add getters and setters
    public int getTransactionId() { return transactionId; }
    public void setTransactionId(int id) { this.transactionId = id; }
    public String getTransactionCode() { return transactionCode; }
    public void setTransactionCode(String code) { this.transactionCode = code; }
    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal amount) { this.totalAmount = amount; }
    public PaymentStatus getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(PaymentStatus status) { this.paymentStatus = status; }  
}
