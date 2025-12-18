/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * Model class untuk Cart Item
 * @author user
 */
public class CartItem {
    private int cartItemId;
    private int cartId;
    private int courseId;
    private Timestamp addedAt;
    
    // Related object
    private Course course;
    
    // Default constructor
    public CartItem() {
    }
    
    // Constructor with required fields
    public CartItem(int cartId, int courseId) {
        this.cartId = cartId;
        this.courseId = courseId;
    }
    
    // Full constructor
    public CartItem(int cartItemId, int cartId, int courseId, Timestamp addedAt) {
        this.cartItemId = cartItemId;
        this.cartId = cartId;
        this.courseId = courseId;
        this.addedAt = addedAt;
    }
    
    // Getters and Setters
    public int getCartItemId() { return cartItemId; }
    public void setCartItemId(int cartItemId) { this.cartItemId = cartItemId; }
    
    public int getCartId() { return cartId; }
    public void setCartId(int cartId) { this.cartId = cartId; }
    
    public int getCourseId() { return courseId; }
    public void setCourseId(int courseId) { this.courseId = courseId; }
    
    public Timestamp getAddedAt() { return addedAt; }
    public void setAddedAt(Timestamp addedAt) { this.addedAt = addedAt; }
    
    public Course getCourse() { return course; }
    public void setCourse(Course course) { this.course = course; }
    
    // Helper methods
    
    /**
     * Mendapatkan harga efektif course (dengan diskon jika ada)
     * @return harga efektif
     */
    public BigDecimal getEffectivePrice() {
        if (course != null) {
            return course.getEffectivePrice();
        }
        return BigDecimal.ZERO;
    }
    
    /**
     * Mendapatkan harga original course
     * @return harga original
     */
    public BigDecimal getOriginalPrice() {
        if (course != null) {
            return course.getPrice();
        }
        return BigDecimal.ZERO;
    }
    
    /**
     * Mengecek apakah course memiliki diskon
     * @return true jika ada diskon
     */
    public boolean hasDiscount() {
        if (course != null) {
            return course.hasDiscount();
        }
        return false;
    }
    
    @Override
    public String toString() {
        return "CartItem{" +
                "cartItemId=" + cartItemId +
                ", cartId=" + cartId +
                ", courseId=" + courseId +
                ", addedAt=" + addedAt +
                '}';
    }
}
