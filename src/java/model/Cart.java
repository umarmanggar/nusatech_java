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
 * Model class untuk Shopping Cart
 * @author user
 */
public class Cart {
    private int cartId;
    private int studentId;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Related objects
    private User student;
    private List<CartItem> items;
    
    // Default constructor
    public Cart() {
        this.items = new ArrayList<>();
    }
    
    // Constructor with studentId
    public Cart(int studentId) {
        this();
        this.studentId = studentId;
    }
    
    // Full constructor
    public Cart(int cartId, int studentId, Timestamp createdAt, Timestamp updatedAt) {
        this();
        this.cartId = cartId;
        this.studentId = studentId;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    // Getters and Setters
    public int getCartId() { return cartId; }
    public void setCartId(int cartId) { this.cartId = cartId; }
    
    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
    
    public User getStudent() { return student; }
    public void setStudent(User student) { this.student = student; }
    
    public List<CartItem> getItems() { return items; }
    public void setItems(List<CartItem> items) { this.items = items; }
    
    // Cart operation methods
    
    /**
     * Menambahkan item ke cart
     * @param item CartItem yang akan ditambahkan
     * @return true jika berhasil ditambahkan, false jika course sudah ada di cart
     */
    public boolean addItem(CartItem item) {
        if (item == null) return false;
        
        // Check if course already exists in cart
        for (CartItem existingItem : items) {
            if (existingItem.getCourseId() == item.getCourseId()) {
                return false; // Course already in cart
            }
        }
        
        item.setCartId(this.cartId);
        items.add(item);
        return true;
    }
    
    /**
     * Menambahkan course ke cart berdasarkan courseId
     * @param courseId ID course yang akan ditambahkan
     * @return true jika berhasil ditambahkan
     */
    public boolean addItem(int courseId) {
        CartItem item = new CartItem(this.cartId, courseId);
        return addItem(item);
    }
    
    /**
     * Menghapus item dari cart berdasarkan cartItemId
     * @param cartItemId ID item yang akan dihapus
     * @return true jika berhasil dihapus
     */
    public boolean removeItem(int cartItemId) {
        return items.removeIf(item -> item.getCartItemId() == cartItemId);
    }
    
    /**
     * Menghapus item dari cart berdasarkan courseId
     * @param courseId ID course yang akan dihapus
     * @return true jika berhasil dihapus
     */
    public boolean removeItemByCourseId(int courseId) {
        return items.removeIf(item -> item.getCourseId() == courseId);
    }
    
    /**
     * Mengosongkan semua item di cart
     */
    public void clear() {
        items.clear();
    }
    
    /**
     * Menghitung total harga semua item di cart
     * @return total harga dengan mempertimbangkan diskon
     */
    public BigDecimal getTotalPrice() {
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : items) {
            if (item.getCourse() != null) {
                total = total.add(item.getCourse().getEffectivePrice());
            }
        }
        return total;
    }
    
    /**
     * Menghitung total harga original (tanpa diskon)
     * @return total harga original
     */
    public BigDecimal getTotalOriginalPrice() {
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : items) {
            if (item.getCourse() != null) {
                total = total.add(item.getCourse().getPrice());
            }
        }
        return total;
    }
    
    /**
     * Menghitung total diskon
     * @return total diskon
     */
    public BigDecimal getTotalDiscount() {
        return getTotalOriginalPrice().subtract(getTotalPrice());
    }
    
    /**
     * Mendapatkan jumlah item di cart
     * @return jumlah item
     */
    public int getItemCount() {
        return items.size();
    }
    
    /**
     * Mengecek apakah cart kosong
     * @return true jika cart kosong
     */
    public boolean isEmpty() {
        return items.isEmpty();
    }
    
    /**
     * Mengecek apakah course sudah ada di cart
     * @param courseId ID course yang akan dicek
     * @return true jika course sudah ada di cart
     */
    public boolean containsCourse(int courseId) {
        for (CartItem item : items) {
            if (item.getCourseId() == courseId) {
                return true;
            }
        }
        return false;
    }
    
    @Override
    public String toString() {
        return "Cart{" +
                "cartId=" + cartId +
                ", studentId=" + studentId +
                ", itemCount=" + getItemCount() +
                ", totalPrice=" + getTotalPrice() +
                '}';
    }
}
