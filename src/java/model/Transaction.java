/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.math.BigDecimal;
import java.util.List;
import java.util.ArrayList;
import java.util.UUID;

/**
 * Model class untuk Transaction (Payment)
 * @author user
 */
public class Transaction {
    public enum PaymentMethod { 
        BANK_TRANSFER, E_WALLET, CREDIT_CARD, BALANCE 
    }
    
    public enum PaymentStatus { 
        PENDING, PAID, FAILED, REFUNDED, EXPIRED 
    }
    
    private int transactionId;
    private int userId;
    private String transactionCode;
    private BigDecimal totalAmount;
    private PaymentMethod paymentMethod;
    private PaymentStatus paymentStatus;
    private String paymentProof;
    private Timestamp paidAt;
    private Timestamp expiredAt;
    private String notes;
    private Timestamp createdAt;
    
    // Related objects
    private User user;
    private List<TransactionItem> items;
    
    // Default constructor
    public Transaction() {
        this.paymentStatus = PaymentStatus.PENDING;
        this.totalAmount = BigDecimal.ZERO;
        this.items = new ArrayList<>();
    }
    
    // Constructor with required fields
    public Transaction(int userId, PaymentMethod paymentMethod) {
        this();
        this.userId = userId;
        this.paymentMethod = paymentMethod;
        this.transactionCode = generateTransactionCode();
        // Set expiry to 24 hours from now
        this.expiredAt = new Timestamp(System.currentTimeMillis() + (24 * 60 * 60 * 1000));
    }
    
    // Full constructor
    public Transaction(int transactionId, int userId, String transactionCode,
                       BigDecimal totalAmount, PaymentMethod paymentMethod,
                       PaymentStatus paymentStatus, String paymentProof,
                       Timestamp paidAt, Timestamp expiredAt, String notes,
                       Timestamp createdAt) {
        this();
        this.transactionId = transactionId;
        this.userId = userId;
        this.transactionCode = transactionCode;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.paymentProof = paymentProof;
        this.paidAt = paidAt;
        this.expiredAt = expiredAt;
        this.notes = notes;
        this.createdAt = createdAt;
    }
    
    // Getters and Setters
    public int getTransactionId() { return transactionId; }
    public void setTransactionId(int transactionId) { this.transactionId = transactionId; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public String getTransactionCode() { return transactionCode; }
    public void setTransactionCode(String transactionCode) { this.transactionCode = transactionCode; }
    
    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }
    
    public PaymentMethod getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(PaymentMethod paymentMethod) { this.paymentMethod = paymentMethod; }
    
    public PaymentStatus getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(PaymentStatus paymentStatus) { this.paymentStatus = paymentStatus; }
    
    public String getPaymentProof() { return paymentProof; }
    public void setPaymentProof(String paymentProof) { this.paymentProof = paymentProof; }
    
    public Timestamp getPaidAt() { return paidAt; }
    public void setPaidAt(Timestamp paidAt) { this.paidAt = paidAt; }
    
    public Timestamp getExpiredAt() { return expiredAt; }
    public void setExpiredAt(Timestamp expiredAt) { this.expiredAt = expiredAt; }
    
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    
    public List<TransactionItem> getItems() { return items; }
    public void setItems(List<TransactionItem> items) { this.items = items; }
    
    // Helper methods
    public static String generateTransactionCode() {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMdd");
        String datePart = sdf.format(new java.util.Date());
        String uniquePart = UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        return "TRX-" + datePart + "-" + uniquePart;
    }
    
    public void addItem(TransactionItem item) {
        item.setTransactionId(this.transactionId);
        this.items.add(item);
        calculateTotal();
    }
    
    public void calculateTotal() {
        this.totalAmount = BigDecimal.ZERO;
        for (TransactionItem item : items) {
            BigDecimal itemTotal = item.getPrice().subtract(
                item.getDiscount() != null ? item.getDiscount() : BigDecimal.ZERO
            );
            this.totalAmount = this.totalAmount.add(itemTotal);
        }
    }
    
    public boolean isPending() {
        return paymentStatus == PaymentStatus.PENDING;
    }
    
    public boolean isPaid() {
        return paymentStatus == PaymentStatus.PAID;
    }
    
    public boolean isExpired() {
        if (expiredAt == null) return false;
        return new Timestamp(System.currentTimeMillis()).after(expiredAt) 
               && paymentStatus == PaymentStatus.PENDING;
    }
    
    public void markAsPaid() {
        this.paymentStatus = PaymentStatus.PAID;
        this.paidAt = new Timestamp(System.currentTimeMillis());
    }
    
    public void markAsExpired() {
        this.paymentStatus = PaymentStatus.EXPIRED;
    }
    
    public void markAsFailed() {
        this.paymentStatus = PaymentStatus.FAILED;
    }
    
    public String getPaymentMethodDisplayName() {
        switch (paymentMethod) {
            case BANK_TRANSFER: return "Transfer Bank";
            case E_WALLET: return "E-Wallet";
            case CREDIT_CARD: return "Kartu Kredit";
            case BALANCE: return "Saldo";
            default: return "Unknown";
        }
    }
    
    public String getPaymentStatusDisplayName() {
        switch (paymentStatus) {
            case PENDING: return "Menunggu Pembayaran";
            case PAID: return "Lunas";
            case FAILED: return "Gagal";
            case REFUNDED: return "Dikembalikan";
            case EXPIRED: return "Kadaluarsa";
            default: return "Unknown";
        }
    }
    
    public String getStatusBadgeClass() {
        switch (paymentStatus) {
            case PENDING: return "bg-warning";
            case PAID: return "bg-success";
            case FAILED: return "bg-danger";
            case REFUNDED: return "bg-info";
            case EXPIRED: return "bg-secondary";
            default: return "bg-secondary";
        }
    }
    
    @Override
    public String toString() {
        return "Transaction{" +
                "transactionId=" + transactionId +
                ", transactionCode='" + transactionCode + '\'' +
                ", totalAmount=" + totalAmount +
                ", paymentStatus=" + paymentStatus +
                '}';
    }
}
