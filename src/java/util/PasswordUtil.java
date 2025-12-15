/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;
/**
 *
 * @author user
 */
public class PasswordUtil {
    private static final String ALGORITHM = "SHA-256";
    private static final int SALT_LENGTH = 16;
    
    /**
     * Hash password dengan salt
     */
    public static String hashPassword(String password) {
        try {
            // Generate random salt
            SecureRandom random = new SecureRandom();
            byte[] salt = new byte[SALT_LENGTH];
            random.nextBytes(salt);
            
            // Hash password dengan salt
            MessageDigest md = MessageDigest.getInstance(ALGORITHM);
            md.update(salt);
            byte[] hashedPassword = md.digest(password.getBytes());
            
            // Encode salt dan hash ke Base64
            String saltBase64 = Base64.getEncoder().encodeToString(salt);
            String hashBase64 = Base64.getEncoder().encodeToString(hashedPassword);
            
            return saltBase64 + ":" + hashBase64;
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
    
    /**
     * Verifikasi password
     */
    public static boolean verifyPassword(String password, String storedHash) {
        try {
            // Split salt dan hash
            String[] parts = storedHash.split(":");
            if (parts.length != 2) {
                return false;
            }
            
            byte[] salt = Base64.getDecoder().decode(parts[0]);
            byte[] storedHashBytes = Base64.getDecoder().decode(parts[1]);
            
            // Hash password dengan salt yang sama
            MessageDigest md = MessageDigest.getInstance(ALGORITHM);
            md.update(salt);
            byte[] hashedPassword = md.digest(password.getBytes());
            
            // Bandingkan
            return MessageDigest.isEqual(hashedPassword, storedHashBytes);
        } catch (Exception e) {
            return false;
        }
    }
    
    /**
     * Generate random token untuk reset password
     */
    public static String generateToken() {
        SecureRandom random = new SecureRandom();
        byte[] bytes = new byte[32];
        random.nextBytes(bytes);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
    }
    
    /**
     * Generate kode transaksi
     */
    public static String generateTransactionCode() {
        SecureRandom random = new SecureRandom();
        long timestamp = System.currentTimeMillis();
        int randomNum = random.nextInt(9999);
        return String.format("TRX%d%04d", timestamp, randomNum);
    }
    
    /**
     * Generate nomor sertifikat
     */
    public static String generateCertificateNumber() {
        SecureRandom random = new SecureRandom();
        long timestamp = System.currentTimeMillis();
        int randomNum = random.nextInt(999999);
        return String.format("CERT-%d-%06d", timestamp / 1000, randomNum);
    }
}
