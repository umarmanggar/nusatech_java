/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.math.BigDecimal;
/**
 *
 * @author user
 */
public class TransactionItem {
    public enum ItemType { COURSE, SUBSCRIPTION }
    
    private int itemId;
    private int transactionId;
    private Integer courseId;
    private Integer planId;
    private ItemType itemType;
    private BigDecimal price;
    private BigDecimal discount = BigDecimal.ZERO;
    
    // TODO: Add getters and setters
    public int getItemId() { return itemId; }
    public void setItemId(int id) { this.itemId = id; }
    public ItemType getItemType() { return itemType; }
    public void setItemType(ItemType type) { this.itemType = type; }  
}
