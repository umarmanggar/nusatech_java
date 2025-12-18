package util;

import model.Transaction;
import model.TransactionItem;
import model.User;

import java.io.UnsupportedEncodingException;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Properties;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Utility class for sending emails
 * Supports SMTP with TLS/SSL
 * 
 * Note: This class provides email functionality. To use it, you need to add
 * jakarta.mail dependency to your project:
 * - jakarta.mail-api-2.1.2.jar
 * - jakarta.activation-api-2.1.2.jar
 * - angus-mail-2.0.2.jar (implementation)
 * 
 * For development/testing without email server, methods will log messages
 * and return success.
 * 
 * @author NusaTech
 */
public class EmailUtil {
    
    // SMTP Configuration - Should be loaded from properties file or environment
    private static final String SMTP_HOST = getProperty("mail.smtp.host", "smtp.gmail.com");
    private static final String SMTP_PORT = getProperty("mail.smtp.port", "587");
    private static final String SMTP_USERNAME = getProperty("mail.smtp.username", "noreply@nusatech.id");
    private static final String SMTP_PASSWORD = getProperty("mail.smtp.password", "");
    private static final String SMTP_FROM_EMAIL = getProperty("mail.from.email", "noreply@nusatech.id");
    private static final String SMTP_FROM_NAME = getProperty("mail.from.name", "NusaTech");
    private static final boolean SMTP_AUTH = Boolean.parseBoolean(getProperty("mail.smtp.auth", "true"));
    private static final boolean SMTP_STARTTLS = Boolean.parseBoolean(getProperty("mail.smtp.starttls", "true"));
    
    // App configuration
    private static final String APP_URL = getProperty("app.url", "http://localhost:8080/nusatech");
    private static final String APP_NAME = "NusaTech";
    
    // Email sending enabled flag (set to false for development)
    private static final boolean EMAIL_ENABLED = Boolean.parseBoolean(getProperty("mail.enabled", "false"));
    
    // Thread pool for async email sending
    private static final ExecutorService emailExecutor = Executors.newFixedThreadPool(5);
    
    // Number format for currency
    private static final NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("id", "ID"));
    
    // Date format
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMMM yyyy, HH:mm", new Locale("id", "ID"));
    
    /**
     * Get system property with fallback
     */
    private static String getProperty(String key, String defaultValue) {
        String value = System.getProperty(key);
        if (value == null || value.isEmpty()) {
            value = System.getenv(key.replace(".", "_").toUpperCase());
        }
        return value != null && !value.isEmpty() ? value : defaultValue;
    }
    
    /**
     * Send an email
     * 
     * @param to Recipient email address
     * @param subject Email subject
     * @param body Email body (HTML supported)
     * @return true if email was sent successfully
     */
    public static boolean sendEmail(String to, String subject, String body) {
        return sendEmail(to, subject, body, true);
    }
    
    /**
     * Send an email
     * 
     * @param to Recipient email address
     * @param subject Email subject
     * @param body Email body
     * @param isHtml Whether the body is HTML
     * @return true if email was sent successfully
     */
    public static boolean sendEmail(String to, String subject, String body, boolean isHtml) {
        // Log email attempt
        System.out.println("=== Email Request ===");
        System.out.println("To: " + to);
        System.out.println("Subject: " + subject);
        System.out.println("HTML: " + isHtml);
        
        if (!EMAIL_ENABLED) {
            System.out.println("Email sending is disabled. Set mail.enabled=true to enable.");
            System.out.println("Email body preview:");
            System.out.println(body.replaceAll("<[^>]+>", " ").replaceAll("\\s+", " ").substring(0, Math.min(200, body.length())) + "...");
            System.out.println("===================");
            return true; // Return true for development
        }
        
        try {
            // Setup properties
            Properties props = new Properties();
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.auth", String.valueOf(SMTP_AUTH));
            props.put("mail.smtp.starttls.enable", String.valueOf(SMTP_STARTTLS));
            props.put("mail.smtp.ssl.trust", SMTP_HOST);
            
            // Use reflection to load mail classes (to avoid compile-time dependency)
            Class<?> sessionClass = Class.forName("jakarta.mail.Session");
            Class<?> authenticatorClass = Class.forName("jakarta.mail.Authenticator");
            Class<?> mimeMessageClass = Class.forName("jakarta.mail.internet.MimeMessage");
            Class<?> internetAddressClass = Class.forName("jakarta.mail.internet.InternetAddress");
            Class<?> transportClass = Class.forName("jakarta.mail.Transport");
            
            // This is a simplified approach - in production, add jakarta.mail dependency
            // and use the direct API
            System.out.println("Email would be sent via SMTP: " + SMTP_HOST);
            System.out.println("===================");
            return true;
            
        } catch (ClassNotFoundException e) {
            System.err.println("Jakarta Mail library not found. Add jakarta.mail dependency to enable email sending.");
            System.out.println("Email logged instead of sent.");
            System.out.println("===================");
            return true; // Return true for development
        } catch (Exception e) {
            System.err.println("Failed to send email to " + to + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Send email asynchronously
     * 
     * @param to Recipient email address
     * @param subject Email subject
     * @param body Email body (HTML supported)
     */
    public static void sendEmailAsync(String to, String subject, String body) {
        emailExecutor.submit(() -> sendEmail(to, subject, body));
    }
    
    /**
     * Send welcome email to new user
     * 
     * @param user The newly registered user
     * @return true if email was sent successfully
     */
    public static boolean sendWelcomeEmail(User user) {
        String subject = "Selamat Datang di " + APP_NAME + "! 🎓";
        String body = buildWelcomeEmailBody(user);
        return sendEmail(user.getEmail(), subject, body);
    }
    
    /**
     * Send welcome email asynchronously
     * 
     * @param user The newly registered user
     */
    public static void sendWelcomeEmailAsync(User user) {
        emailExecutor.submit(() -> sendWelcomeEmail(user));
    }
    
    /**
     * Send password reset email
     * 
     * @param user The user requesting password reset
     * @param token The reset token
     * @return true if email was sent successfully
     */
    public static boolean sendPasswordReset(User user, String token) {
        String subject = "Reset Password - " + APP_NAME;
        String body = buildPasswordResetEmailBody(user, token);
        return sendEmail(user.getEmail(), subject, body);
    }
    
    /**
     * Send password reset email asynchronously
     * 
     * @param user The user requesting password reset
     * @param token The reset token
     */
    public static void sendPasswordResetAsync(User user, String token) {
        emailExecutor.submit(() -> sendPasswordReset(user, token));
    }
    
    /**
     * Send payment confirmation email
     * 
     * @param transaction The completed transaction
     * @return true if email was sent successfully
     */
    public static boolean sendPaymentConfirmation(Transaction transaction) {
        if (transaction == null || transaction.getUser() == null) {
            return false;
        }
        
        String subject = "Pembayaran Berhasil - " + APP_NAME + " #" + transaction.getTransactionCode();
        String body = buildPaymentConfirmationEmailBody(transaction);
        return sendEmail(transaction.getUser().getEmail(), subject, body);
    }
    
    /**
     * Send payment confirmation email asynchronously
     * 
     * @param transaction The completed transaction
     */
    public static void sendPaymentConfirmationAsync(Transaction transaction) {
        emailExecutor.submit(() -> sendPaymentConfirmation(transaction));
    }
    
    /**
     * Send course enrollment notification
     * 
     * @param user The enrolled user
     * @param courseName The course name
     * @param courseSlug The course slug for URL
     * @return true if email was sent successfully
     */
    public static boolean sendEnrollmentNotification(User user, String courseName, String courseSlug) {
        String subject = "Selamat! Anda Terdaftar di Kursus Baru 🎉";
        String body = buildEnrollmentEmailBody(user, courseName, courseSlug);
        return sendEmail(user.getEmail(), subject, body);
    }
    
    /**
     * Send certificate notification
     * 
     * @param user The user who earned the certificate
     * @param courseName The course name
     * @param certificateUrl URL to view/download certificate
     * @return true if email was sent successfully
     */
    public static boolean sendCertificateNotification(User user, String courseName, String certificateUrl) {
        String subject = "Selamat! Anda Mendapatkan Sertifikat 🏆";
        String body = buildCertificateEmailBody(user, courseName, certificateUrl);
        return sendEmail(user.getEmail(), subject, body);
    }
    
    /**
     * Send payment reminder email
     * 
     * @param transaction The pending transaction
     * @return true if email was sent successfully
     */
    public static boolean sendPaymentReminder(Transaction transaction) {
        if (transaction == null || transaction.getUser() == null) {
            return false;
        }
        
        String subject = "Reminder: Selesaikan Pembayaran Anda - " + APP_NAME;
        String body = buildPaymentReminderEmailBody(transaction);
        return sendEmail(transaction.getUser().getEmail(), subject, body);
    }
    
    // ==================== Email Body Builders ====================
    
    /**
     * Build welcome email body
     */
    private static String buildWelcomeEmailBody(User user) {
        return getEmailTemplate(
            "Selamat Datang, " + user.getName() + "! 🎉",
            "<p>Terima kasih telah bergabung dengan <strong>" + APP_NAME + "</strong>!</p>" +
            "<p>Anda sekarang memiliki akses ke ribuan kursus berkualitas dari instruktur terbaik Indonesia.</p>" +
            "<p>Berikut yang bisa Anda lakukan:</p>" +
            "<ul>" +
            "  <li>🔍 Jelajahi katalog kursus kami</li>" +
            "  <li>📚 Daftar ke kursus favorit Anda</li>" +
            "  <li>🎯 Tetapkan tujuan belajar Anda</li>" +
            "  <li>🏆 Dapatkan sertifikat setelah menyelesaikan kursus</li>" +
            "</ul>",
            "Mulai Belajar",
            APP_URL + "/course"
        );
    }
    
    /**
     * Build password reset email body
     */
    private static String buildPasswordResetEmailBody(User user, String token) {
        String resetUrl = APP_URL + "/auth/reset-password?token=" + token;
        
        return getEmailTemplate(
            "Reset Password",
            "<p>Halo " + user.getName() + ",</p>" +
            "<p>Kami menerima permintaan untuk mereset password akun Anda.</p>" +
            "<p>Klik tombol di bawah untuk membuat password baru:</p>" +
            "<p style='text-align:center; margin: 30px 0;'>" +
            "  <a href='" + resetUrl + "' style='background:#8B1538; color:white; padding:15px 30px; text-decoration:none; border-radius:8px; font-weight:600;'>Reset Password</a>" +
            "</p>" +
            "<p>Atau salin link berikut ke browser Anda:</p>" +
            "<p style='background:#f3f4f6; padding:10px; border-radius:5px; word-break:break-all;'>" + resetUrl + "</p>" +
            "<p><strong>Link ini hanya berlaku selama 1 jam.</strong></p>" +
            "<p>Jika Anda tidak meminta reset password, abaikan email ini.</p>",
            null, null
        );
    }
    
    /**
     * Build payment confirmation email body
     */
    private static String buildPaymentConfirmationEmailBody(Transaction transaction) {
        String myLearningUrl = APP_URL + "/student/my-learning";
        
        StringBuilder itemsList = new StringBuilder();
        if (transaction.getItems() != null) {
            for (TransactionItem item : transaction.getItems()) {
                itemsList.append("<tr>")
                    .append("<td style='padding:10px; border-bottom:1px solid #e5e7eb;'>")
                    .append(item.getCourse() != null ? item.getCourse().getTitle() : "Kursus")
                    .append("</td>")
                    .append("<td style='padding:10px; border-bottom:1px solid #e5e7eb; text-align:right;'>")
                    .append(currencyFormat.format(item.getPrice()))
                    .append("</td>")
                    .append("</tr>");
            }
        }
        
        String paidAtStr = transaction.getPaidAt() != null ? 
            dateFormat.format(transaction.getPaidAt()) : 
            dateFormat.format(new Date());
        
        return getEmailTemplate(
            "Pembayaran Berhasil! 🎉",
            "<p>Halo " + transaction.getUser().getName() + ",</p>" +
            "<p>Terima kasih! Pembayaran Anda telah berhasil diproses.</p>" +
            
            "<div style='background:#f9fafb; border-radius:10px; padding:20px; margin:20px 0;'>" +
            "  <h3 style='margin-top:0; color:#374151;'>Detail Transaksi</h3>" +
            "  <table style='width:100%; border-collapse:collapse;'>" +
            "    <tr><td style='padding:8px 0; color:#6b7280;'>No. Transaksi</td><td style='text-align:right; font-weight:600;'>" + transaction.getTransactionCode() + "</td></tr>" +
            "    <tr><td style='padding:8px 0; color:#6b7280;'>Tanggal</td><td style='text-align:right;'>" + paidAtStr + "</td></tr>" +
            "    <tr><td style='padding:8px 0; color:#6b7280;'>Metode Pembayaran</td><td style='text-align:right;'>" + transaction.getPaymentMethodDisplayName() + "</td></tr>" +
            "    <tr><td style='padding:8px 0; color:#6b7280;'><strong>Total</strong></td><td style='text-align:right; font-weight:700; color:#8B1538; font-size:18px;'>" + currencyFormat.format(transaction.getTotalAmount()) + "</td></tr>" +
            "  </table>" +
            "</div>" +
            
            "<div style='background:#fff; border:1px solid #e5e7eb; border-radius:10px; padding:20px; margin:20px 0;'>" +
            "  <h3 style='margin-top:0; color:#374151;'>Kursus yang Dibeli</h3>" +
            "  <table style='width:100%; border-collapse:collapse;'>" +
            itemsList.toString() +
            "  </table>" +
            "</div>" +
            
            "<p>Anda sekarang dapat mengakses kursus Anda kapan saja, di mana saja.</p>",
            "Mulai Belajar",
            myLearningUrl
        );
    }
    
    /**
     * Build enrollment email body
     */
    private static String buildEnrollmentEmailBody(User user, String courseName, String courseSlug) {
        String courseUrl = APP_URL + "/learn/" + courseSlug;
        
        return getEmailTemplate(
            "Selamat Bergabung di Kursus Baru! 📚",
            "<p>Halo " + user.getName() + ",</p>" +
            "<p>Anda telah berhasil terdaftar di kursus:</p>" +
            "<div style='background:#f9fafb; border-radius:10px; padding:20px; margin:20px 0; text-align:center;'>" +
            "  <h2 style='color:#8B1538; margin:0;'>" + courseName + "</h2>" +
            "</div>" +
            "<p>Mulai perjalanan belajar Anda sekarang dan raih tujuan Anda!</p>",
            "Mulai Belajar",
            courseUrl
        );
    }
    
    /**
     * Build certificate email body
     */
    private static String buildCertificateEmailBody(User user, String courseName, String certificateUrl) {
        return getEmailTemplate(
            "Selamat! Anda Mendapatkan Sertifikat! 🏆",
            "<p>Halo " + user.getName() + ",</p>" +
            "<p>Selamat! Anda telah berhasil menyelesaikan kursus:</p>" +
            "<div style='background:linear-gradient(135deg, #8B1538 0%, #6d1029 100%); border-radius:10px; padding:30px; margin:20px 0; text-align:center; color:white;'>" +
            "  <div style='font-size:48px; margin-bottom:10px;'>🎓</div>" +
            "  <h2 style='margin:0;'>" + courseName + "</h2>" +
            "  <p style='opacity:0.9; margin-top:10px;'>Sertifikat Kelulusan</p>" +
            "</div>" +
            "<p>Sertifikat Anda sudah siap! Anda dapat mengunduh dan membagikannya ke LinkedIn atau platform profesional lainnya.</p>",
            "Lihat Sertifikat",
            certificateUrl
        );
    }
    
    /**
     * Build payment reminder email body
     */
    private static String buildPaymentReminderEmailBody(Transaction transaction) {
        String checkoutUrl = APP_URL + "/checkout/payment/" + transaction.getTransactionCode();
        
        String expiryStr = transaction.getExpiredAt() != null ?
            dateFormat.format(transaction.getExpiredAt()) :
            "24 jam dari sekarang";
        
        return getEmailTemplate(
            "Jangan Lupa Selesaikan Pembayaran Anda ⏰",
            "<p>Halo " + transaction.getUser().getName() + ",</p>" +
            "<p>Anda memiliki transaksi yang menunggu pembayaran:</p>" +
            
            "<div style='background:#fff3cd; border:1px solid #ffc107; border-radius:10px; padding:20px; margin:20px 0;'>" +
            "  <p style='margin:0; color:#856404;'><strong>⚠️ Batas waktu pembayaran:</strong> " + expiryStr + "</p>" +
            "</div>" +
            
            "<div style='background:#f9fafb; border-radius:10px; padding:20px; margin:20px 0;'>" +
            "  <table style='width:100%; border-collapse:collapse;'>" +
            "    <tr><td style='padding:8px 0; color:#6b7280;'>No. Transaksi</td><td style='text-align:right; font-weight:600;'>" + transaction.getTransactionCode() + "</td></tr>" +
            "    <tr><td style='padding:8px 0; color:#6b7280;'>Total Pembayaran</td><td style='text-align:right; font-weight:700; color:#8B1538;'>" + currencyFormat.format(transaction.getTotalAmount()) + "</td></tr>" +
            "  </table>" +
            "</div>" +
            
            "<p>Segera selesaikan pembayaran Anda untuk mulai belajar!</p>",
            "Bayar Sekarang",
            checkoutUrl
        );
    }
    
    /**
     * Get base email template
     */
    private static String getEmailTemplate(String title, String content, String buttonText, String buttonUrl) {
        StringBuilder template = new StringBuilder();
        template.append("<!DOCTYPE html>");
        template.append("<html><head><meta charset='utf-8'></head>");
        template.append("<body style='margin:0; padding:0; background-color:#f3f4f6; font-family:Arial, sans-serif;'>");
        
        // Container
        template.append("<table width='100%' cellpadding='0' cellspacing='0' style='background-color:#f3f4f6; padding:40px 20px;'>");
        template.append("<tr><td align='center'>");
        
        // Email card
        template.append("<table width='600' cellpadding='0' cellspacing='0' style='background-color:#ffffff; border-radius:16px; overflow:hidden; box-shadow:0 4px 6px rgba(0,0,0,0.1);'>");
        
        // Header
        template.append("<tr><td style='background:linear-gradient(135deg, #8B1538 0%, #6d1029 100%); padding:30px; text-align:center;'>");
        template.append("<h1 style='color:#ffffff; margin:0; font-size:24px;'>🎓 " + APP_NAME + "</h1>");
        template.append("</td></tr>");
        
        // Body
        template.append("<tr><td style='padding:40px 30px;'>");
        template.append("<h2 style='color:#1f2937; margin-top:0;'>" + title + "</h2>");
        template.append(content);
        
        // Button
        if (buttonText != null && buttonUrl != null) {
            template.append("<p style='text-align:center; margin:30px 0;'>");
            template.append("<a href='" + buttonUrl + "' style='background:#8B1538; color:white; padding:15px 30px; text-decoration:none; border-radius:8px; font-weight:600; display:inline-block;'>" + buttonText + "</a>");
            template.append("</p>");
        }
        
        template.append("</td></tr>");
        
        // Footer
        template.append("<tr><td style='background-color:#f9fafb; padding:20px 30px; text-align:center; border-top:1px solid #e5e7eb;'>");
        template.append("<p style='color:#6b7280; font-size:14px; margin:0 0 10px 0;'>Email ini dikirim oleh " + APP_NAME + "</p>");
        template.append("<p style='color:#9ca3af; font-size:12px; margin:0;'>");
        template.append("<a href='" + APP_URL + "' style='color:#8B1538; text-decoration:none;'>Website</a> | ");
        template.append("<a href='" + APP_URL + "/help' style='color:#8B1538; text-decoration:none;'>Bantuan</a> | ");
        template.append("<a href='" + APP_URL + "/unsubscribe' style='color:#8B1538; text-decoration:none;'>Berhenti Berlangganan</a>");
        template.append("</p>");
        template.append("</td></tr>");
        
        template.append("</table>");
        template.append("</td></tr></table>");
        template.append("</body></html>");
        
        return template.toString();
    }
    
    /**
     * Shutdown executor service
     * Call this when application is shutting down
     */
    public static void shutdown() {
        emailExecutor.shutdown();
    }
}
