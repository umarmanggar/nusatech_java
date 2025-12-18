/*
 * CheckoutController.java
 * Handles checkout and payment routes
 */
package controller;

import dao.CartDAO;
import dao.CourseDAO;
import dao.PaymentDAO;
import dao.EnrollmentDAO;
import dao.UserDAO;
import model.Cart;
import model.CartItem;
import model.Course;
import model.Transaction;
import model.TransactionItem;
import model.Enrollment;
import model.User;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Controller for checkout and payment
 * @author user
 */
@WebServlet(name = "CheckoutController", urlPatterns = {"/checkout/*"})
public class CheckoutController extends HttpServlet {

    private CartDAO cartDAO;
    private CourseDAO courseDAO;
    private PaymentDAO paymentDAO;
    private EnrollmentDAO enrollmentDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        cartDAO = new CartDAO();
        courseDAO = new CourseDAO();
        paymentDAO = new PaymentDAO();
        enrollmentDAO = new EnrollmentDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check authentication
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            session = request.getSession(true);
            session.setAttribute("redirectUrl", request.getRequestURI());
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!user.isStudent()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Hanya student yang dapat melakukan checkout");
            return;
        }

        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("")) {
                // Show checkout page
                showCheckoutPage(request, response, user);
            } else if (pathInfo.startsWith("/success/")) {
                // Show success page
                String transactionCode = pathInfo.substring("/success/".length());
                showSuccessPage(request, response, transactionCode, user);
            } else if (pathInfo.startsWith("/detail/")) {
                // Show transaction detail
                String transactionCode = pathInfo.substring("/detail/".length());
                showTransactionDetail(request, response, transactionCode, user);
            } else if (pathInfo.equals("/history")) {
                // Show payment history
                showPaymentHistory(request, response, user);
            } else {
                showCheckoutPage(request, response, user);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/pages/error/500.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check authentication
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!user.isStudent()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo == null || pathInfo.equals("/process") || pathInfo.equals("/")) {
                processCheckout(request, response, user);
            } else if (pathInfo.equals("/pay-with-balance")) {
                payWithBalance(request, response, user);
            } else if (pathInfo.equals("/upload-proof")) {
                uploadPaymentProof(request, response, user);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            HttpSession sess = request.getSession();
            sess.setAttribute("errorMessage", "Terjadi kesalahan saat memproses pembayaran");
            response.sendRedirect(request.getContextPath() + "/checkout");
        }
    }

    /**
     * Show checkout page
     */
    private void showCheckoutPage(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        // Check if direct course checkout
        String courseIdStr = request.getParameter("courseId");
        
        List<CartItem> items;
        BigDecimal totalPrice;
        BigDecimal originalPrice = BigDecimal.ZERO;
        
        if (courseIdStr != null && !courseIdStr.isEmpty()) {
            // Single course checkout
            int courseId = Integer.parseInt(courseIdStr);
            Course course = courseDAO.findById(courseId);
            
            if (course == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Kursus tidak ditemukan");
                return;
            }
            
            // Check if already enrolled
            if (enrollmentDAO.isEnrolled(user.getUserId(), courseId)) {
                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Anda sudah terdaftar di kursus ini");
                response.sendRedirect(request.getContextPath() + "/course/" + course.getSlug());
                return;
            }
            
            CartItem item = new CartItem();
            item.setCourseId(courseId);
            item.setCourse(course);
            
            items = new ArrayList<>();
            items.add(item);
            
            totalPrice = course.getEffectivePrice();
            originalPrice = course.getPrice();
            
            request.setAttribute("singleCourse", course);
        } else {
            // Cart checkout
            Cart cart = cartDAO.getCart(user.getUserId());
            items = cart.getItems();
            
            if (items.isEmpty()) {
                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Keranjang belanja kosong");
                response.sendRedirect(request.getContextPath() + "/courses");
                return;
            }
            
            totalPrice = cartDAO.getCartTotal(user.getUserId());
            for (CartItem item : items) {
                if (item.getCourse() != null) {
                    originalPrice = originalPrice.add(item.getCourse().getPrice());
                }
            }
        }
        
        BigDecimal discount = originalPrice.subtract(totalPrice);
        
        // Get user balance
        User freshUser = userDAO.findById(user.getUserId());
        BigDecimal userBalance = freshUser.getBalance();
        boolean canPayWithBalance = userBalance.compareTo(totalPrice) >= 0;

        request.setAttribute("items", items);
        request.setAttribute("totalPrice", totalPrice);
        request.setAttribute("originalPrice", originalPrice);
        request.setAttribute("totalDiscount", discount);
        request.setAttribute("userBalance", userBalance);
        request.setAttribute("canPayWithBalance", canPayWithBalance);
        request.setAttribute("itemCount", items.size());

        request.getRequestDispatcher("/pages/checkout/checkout.jsp").forward(request, response);
    }

    /**
     * Process checkout
     */
    private void processCheckout(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        String paymentMethodStr = request.getParameter("paymentMethod");
        String courseIdStr = request.getParameter("courseId");
        
        if (paymentMethodStr == null || paymentMethodStr.isEmpty()) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Pilih metode pembayaran");
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }
        
        Transaction.PaymentMethod paymentMethod = Transaction.PaymentMethod.valueOf(paymentMethodStr);
        
        List<CartItem> items;
        BigDecimal totalPrice;
        
        if (courseIdStr != null && !courseIdStr.isEmpty()) {
            // Single course
            int courseId = Integer.parseInt(courseIdStr);
            Course course = courseDAO.findById(courseId);
            
            CartItem item = new CartItem();
            item.setCourseId(courseId);
            item.setCourse(course);
            
            items = new ArrayList<>();
            items.add(item);
            
            totalPrice = course.getEffectivePrice();
        } else {
            // Cart checkout
            Cart cart = cartDAO.getCart(user.getUserId());
            items = cart.getItems();
            totalPrice = cartDAO.getCartTotal(user.getUserId());
        }
        
        if (items.isEmpty()) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Tidak ada item untuk dibayar");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        // Check for free courses
        if (totalPrice.compareTo(BigDecimal.ZERO) == 0) {
            // Free course - enroll directly
            for (CartItem item : items) {
                if (!enrollmentDAO.isEnrolled(user.getUserId(), item.getCourseId())) {
                    Enrollment enrollment = new Enrollment(user.getUserId(), item.getCourseId());
                    enrollmentDAO.create(enrollment);
                }
            }
            
            // Clear cart if cart checkout
            if (courseIdStr == null || courseIdStr.isEmpty()) {
                cartDAO.clearCart(user.getUserId());
            }
            
            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Berhasil mendaftar kursus gratis!");
            response.sendRedirect(request.getContextPath() + "/my-learning");
            return;
        }
        
        // Create transaction
        Transaction transaction = new Transaction(user.getUserId(), paymentMethod);
        transaction.setTotalAmount(totalPrice);
        
        // Set expiry (24 hours)
        transaction.setExpiredAt(new Timestamp(System.currentTimeMillis() + (24 * 60 * 60 * 1000)));
        
        // Create transaction items
        List<TransactionItem> transactionItems = new ArrayList<>();
        for (CartItem cartItem : items) {
            TransactionItem ti = new TransactionItem();
            ti.setCourseId(cartItem.getCourseId());
            ti.setItemType(TransactionItem.ItemType.COURSE);
            ti.setPrice(cartItem.getCourse().getEffectivePrice());
            
            BigDecimal originalPrice = cartItem.getCourse().getPrice();
            BigDecimal effectivePrice = cartItem.getCourse().getEffectivePrice();
            ti.setDiscount(originalPrice.subtract(effectivePrice));
            
            transactionItems.add(ti);
        }
        
        // Save transaction
        int transactionId = paymentDAO.createWithItems(transaction, transactionItems);
        
        if (transactionId > 0) {
            // Get the created transaction
            Transaction createdTransaction = paymentDAO.findById(transactionId);
            
            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Transaksi berhasil dibuat. Silakan lakukan pembayaran.");
            
            response.sendRedirect(request.getContextPath() + "/checkout/detail/" + 
                                createdTransaction.getTransactionCode());
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Gagal membuat transaksi");
            response.sendRedirect(request.getContextPath() + "/checkout");
        }
    }

    /**
     * Pay with balance
     */
    private void payWithBalance(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        String transactionCodeOrCourseId = request.getParameter("transactionCode");
        String courseIdStr = request.getParameter("courseId");
        
        BigDecimal totalPrice;
        List<Integer> courseIds = new ArrayList<>();
        Transaction transaction = null;
        
        if (transactionCodeOrCourseId != null && !transactionCodeOrCourseId.isEmpty()) {
            // Existing transaction
            transaction = paymentDAO.findByTransactionCode(transactionCodeOrCourseId);
            if (transaction == null || transaction.getUserId() != user.getUserId()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            totalPrice = transaction.getTotalAmount();
            for (TransactionItem item : transaction.getItems()) {
                if (item.getCourseId() != null) {
                    courseIds.add(item.getCourseId());
                }
            }
        } else if (courseIdStr != null && !courseIdStr.isEmpty()) {
            // Direct course purchase
            int courseId = Integer.parseInt(courseIdStr);
            Course course = courseDAO.findById(courseId);
            totalPrice = course.getEffectivePrice();
            courseIds.add(courseId);
        } else {
            // Cart purchase
            totalPrice = cartDAO.getCartTotal(user.getUserId());
            Cart cart = cartDAO.getCart(user.getUserId());
            for (CartItem item : cart.getItems()) {
                courseIds.add(item.getCourseId());
            }
        }
        
        // Check balance
        User freshUser = userDAO.findById(user.getUserId());
        if (freshUser.getBalance().compareTo(totalPrice) < 0) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Saldo tidak mencukupi");
            response.sendRedirect(request.getHeader("Referer"));
            return;
        }
        
        // Deduct balance
        boolean balanceUpdated = userDAO.updateBalance(user.getUserId(), totalPrice, false);
        if (!balanceUpdated) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Gagal memproses pembayaran");
            response.sendRedirect(request.getHeader("Referer"));
            return;
        }
        
        // Create enrollments
        for (Integer courseId : courseIds) {
            if (!enrollmentDAO.isEnrolled(user.getUserId(), courseId)) {
                Enrollment enrollment = new Enrollment(user.getUserId(), courseId);
                enrollmentDAO.create(enrollment);
            }
        }
        
        // Update transaction if exists
        if (transaction != null) {
            paymentDAO.updateStatus(transaction.getTransactionId(), Transaction.PaymentStatus.PAID);
        } else {
            // Create transaction record
            Transaction newTransaction = new Transaction(user.getUserId(), Transaction.PaymentMethod.BALANCE);
            newTransaction.setTotalAmount(totalPrice);
            newTransaction.setPaymentStatus(Transaction.PaymentStatus.PAID);
            newTransaction.setPaidAt(new Timestamp(System.currentTimeMillis()));
            
            List<TransactionItem> items = new ArrayList<>();
            for (Integer courseId : courseIds) {
                Course course = courseDAO.findById(courseId);
                TransactionItem ti = new TransactionItem();
                ti.setCourseId(courseId);
                ti.setItemType(TransactionItem.ItemType.COURSE);
                ti.setPrice(course.getEffectivePrice());
                items.add(ti);
            }
            
            paymentDAO.createWithItems(newTransaction, items);
        }
        
        // Clear cart
        cartDAO.clearCart(user.getUserId());
        
        // Update session user
        freshUser = userDAO.findById(user.getUserId());
        HttpSession session = request.getSession();
        session.setAttribute("user", freshUser);
        session.setAttribute("successMessage", "Pembayaran berhasil! Selamat belajar.");
        
        response.sendRedirect(request.getContextPath() + "/my-learning");
    }

    /**
     * Upload payment proof
     */
    private void uploadPaymentProof(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        String transactionCode = request.getParameter("transactionCode");
        String proofUrl = request.getParameter("proofUrl"); // In real app, handle file upload
        
        Transaction transaction = paymentDAO.findByTransactionCode(transactionCode);
        if (transaction == null || transaction.getUserId() != user.getUserId()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        paymentDAO.updatePaymentProof(transaction.getTransactionId(), proofUrl);
        
        HttpSession session = request.getSession();
        session.setAttribute("successMessage", "Bukti pembayaran berhasil diupload. Menunggu verifikasi.");
        response.sendRedirect(request.getContextPath() + "/checkout/detail/" + transactionCode);
    }

    /**
     * Show success page
     */
    private void showSuccessPage(HttpServletRequest request, HttpServletResponse response, 
                                 String transactionCode, User user)
            throws ServletException, IOException, SQLException {
        
        Transaction transaction = paymentDAO.findByTransactionCode(transactionCode);
        if (transaction == null || transaction.getUserId() != user.getUserId()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        request.setAttribute("transaction", transaction);
        request.getRequestDispatcher("/pages/checkout/success.jsp").forward(request, response);
    }

    /**
     * Show transaction detail
     */
    private void showTransactionDetail(HttpServletRequest request, HttpServletResponse response,
                                       String transactionCode, User user)
            throws ServletException, IOException, SQLException {
        
        Transaction transaction = paymentDAO.findByTransactionCode(transactionCode);
        if (transaction == null || transaction.getUserId() != user.getUserId()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        request.setAttribute("transaction", transaction);
        request.getRequestDispatcher("/pages/checkout/detail.jsp").forward(request, response);
    }

    /**
     * Show payment history
     */
    private void showPaymentHistory(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        List<Transaction> transactions = paymentDAO.findByStudent(user.getUserId(), page, 20);
        int totalTransactions = paymentDAO.countByUser(user.getUserId());
        int totalPages = (int) Math.ceil((double) totalTransactions / 20);

        request.setAttribute("transactions", transactions);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/pages/checkout/history.jsp").forward(request, response);
    }
}
