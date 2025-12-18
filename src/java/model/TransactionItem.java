/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;

/**
 * Model class untuk Transaction Item
 * @author user
 */
public class TransactionItem {
    public enum ItemType { 
        COURSE, SUBSCRIPTION 
    }
    
    private int itemId;
    private int transactionId;
    private Integer courseId;
    private Integer planId;
    private ItemType itemType;
    private BigDecimal price;
    private BigDecimal discount;
    
    // Related objects
    private Transaction transaction;
    private Course course;
    
    // Default constructor
    public TransactionItem() {
        this.discount = BigDecimal.ZERO;
    }
    
    // Constructor for course item
    public TransactionItem(int transactionId, int courseId, BigDecimal price) {
        this();
        this.transactionId = transactionId;
        this.courseId = courseId;
        this.itemType = ItemType.COURSE;
        this.price = price;
    }
    
    // Constructor for subscription item
    public TransactionItem(int transactionId, int planId, BigDecimal price, boolean isSubscription) {
        this();
        this.transactionId = transactionId;
        this.planId = planId;
        this.itemType = ItemType.SUBSCRIPTION;
        this.price = price;
    }
    
    // Full constructor
    public TransactionItem(int itemId, int transactionId, Integer courseId, Integer planId,
                           ItemType itemType, BigDecimal price, BigDecimal discount) {
        this.itemId = itemId;
        this.transactionId = transactionId;
        this.courseId = courseId;
        this.planId = planId;
        this.itemType = itemType;
        this.price = price;
        this.discount = discount;
    }
    
    // Getters and Setters
    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }
    
    public int getTransactionId() { return transactionId; }
    public void setTransactionId(int transactionId) { this.transactionId = transactionId; }
    
    public Integer getCourseId() { return courseId; }
    public void setCourseId(Integer courseId) { this.courseId = courseId; }
    
    public Integer getPlanId() { return planId; }
    public void setPlanId(Integer planId) { this.planId = planId; }
    
    public ItemType getItemType() { return itemType; }
    public void setItemType(ItemType itemType) { this.itemType = itemType; }
    
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    
    public BigDecimal getDiscount() { return discount; }
    public void setDiscount(BigDecimal discount) { this.discount = discount; }
    
    public Transaction getTransaction() { return transaction; }
    public void setTransaction(Transaction transaction) { this.transaction = transaction; }
    
    public Course getCourse() { return course; }
    public void setCourse(Course course) { this.course = course; }
    
    // Helper methods
    public BigDecimal getFinalPrice() {
        if (discount == null) return price;
        return price.subtract(discount);
    }
    
    public boolean isCourseItem() {
        return itemType == ItemType.COURSE;
    }
    
    public boolean isSubscriptionItem() {
        return itemType == ItemType.SUBSCRIPTION;
    }
    
    @Override
    public String toString() {
        return "TransactionItem{" +
                "itemId=" + itemId +
                ", itemType=" + itemType +
                ", price=" + price +
                '}';
    }
}
