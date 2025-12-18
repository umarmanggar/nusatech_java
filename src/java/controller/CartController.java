/*
 * CartController.java
 * Handles shopping cart routes
 */
package controller;

import dao.CartDAO;
import dao.CourseDAO;
import dao.EnrollmentDAO;
import dao.WishlistDAO;
import model.Cart;
import model.CartItem;
import model.Course;
import model.User;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Controller for shopping cart
 * @author user
 */
@WebServlet(name = "CartController", urlPatterns = {"/cart/*"})
public class CartController extends HttpServlet {

    private CartDAO cartDAO;
    private CourseDAO courseDAO;
    private EnrollmentDAO enrollmentDAO;
    private WishlistDAO wishlistDAO;

    @Override
    public void init() throws ServletException {
        cartDAO = new CartDAO();
        courseDAO = new CourseDAO();
        enrollmentDAO = new EnrollmentDAO();
        wishlistDAO = new WishlistDAO();
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
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Hanya student yang dapat mengakses keranjang");
            return;
        }

        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("")) {
                // View cart
                viewCart(request, response, user);
            } else if (pathInfo.equals("/count")) {
                // Get cart count (for AJAX)
                getCartCount(request, response, user);
            } else {
                viewCart(request, response, user);
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
            // For AJAX requests, return JSON error
            String accept = request.getHeader("Accept");
            if (accept != null && accept.contains("application/json")) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.setContentType("application/json");
                response.getWriter().write("{\"success\":false,\"message\":\"Silakan login terlebih dahulu\"}");
            } else {
                response.sendRedirect(request.getContextPath() + "/login");
            }
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!user.isStudent()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo == null || pathInfo.equals("/add")) {
                addToCart(request, response, user);
            } else if (pathInfo.startsWith("/remove/")) {
                int courseId = Integer.parseInt(pathInfo.substring("/remove/".length()));
                removeFromCart(request, response, user, courseId);
            } else if (pathInfo.equals("/remove")) {
                String courseIdStr = request.getParameter("courseId");
                if (courseIdStr != null) {
                    removeFromCart(request, response, user, Integer.parseInt(courseIdStr));
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                }
            } else if (pathInfo.equals("/clear")) {
                clearCart(request, response, user);
            } else if (pathInfo.equals("/move-from-wishlist")) {
                moveFromWishlist(request, response, user);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID tidak valid");
        } catch (SQLException e) {
            e.printStackTrace();
            String accept = request.getHeader("Accept");
            if (accept != null && accept.contains("application/json")) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.setContentType("application/json");
                response.getWriter().write("{\"success\":false,\"message\":\"Terjadi kesalahan\"}");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        }
    }

    /**
     * View cart page
     */
    private void viewCart(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        Cart cart = cartDAO.getCart(user.getUserId());
        BigDecimal totalPrice = cartDAO.getCartTotal(user.getUserId());
        
        // Calculate original price (without discount)
        BigDecimal originalPrice = BigDecimal.ZERO;
        for (CartItem item : cart.getItems()) {
            if (item.getCourse() != null) {
                originalPrice = originalPrice.add(item.getCourse().getPrice());
            }
        }
        
        BigDecimal discount = originalPrice.subtract(totalPrice);

        request.setAttribute("cart", cart);
        request.setAttribute("cartItems", cart.getItems());
        request.setAttribute("totalPrice", totalPrice);
        request.setAttribute("originalPrice", originalPrice);
        request.setAttribute("totalDiscount", discount);
        request.setAttribute("itemCount", cart.getItems().size());

        request.getRequestDispatcher("/pages/cart/view.jsp").forward(request, response);
    }

    /**
     * Get cart count for AJAX
     */
    private void getCartCount(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        int count = cartDAO.getItemCount(user.getUserId());
        
        response.setContentType("application/json");
        response.getWriter().write("{\"count\":" + count + "}");
    }

    /**
     * Add course to cart
     */
    private void addToCart(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        String courseIdStr = request.getParameter("courseId");
        if (courseIdStr == null || courseIdStr.isEmpty()) {
            sendJsonResponse(response, false, "Course ID diperlukan");
            return;
        }

        int courseId = Integer.parseInt(courseIdStr);
        
        // Check if course exists
        Course course = courseDAO.findById(courseId);
        if (course == null) {
            sendJsonResponse(response, false, "Kursus tidak ditemukan");
            return;
        }

        // Check if already enrolled
        if (enrollmentDAO.isEnrolled(user.getUserId(), courseId)) {
            sendJsonResponse(response, false, "Anda sudah terdaftar di kursus ini");
            return;
        }

        // Check if already in cart
        if (cartDAO.isInCart(user.getUserId(), courseId)) {
            sendJsonResponse(response, false, "Kursus sudah ada di keranjang");
            return;
        }

        // Add to cart
        boolean success = cartDAO.addItem(user.getUserId(), courseId);
        int cartCount = cartDAO.getItemCount(user.getUserId());

        String accept = request.getHeader("Accept");
        if (accept != null && accept.contains("application/json")) {
            response.setContentType("application/json");
            if (success) {
                response.getWriter().write("{\"success\":true,\"message\":\"Kursus ditambahkan ke keranjang\",\"cartCount\":" + cartCount + "}");
            } else {
                response.getWriter().write("{\"success\":false,\"message\":\"Gagal menambahkan ke keranjang\"}");
            }
        } else {
            HttpSession session = request.getSession();
            if (success) {
                session.setAttribute("successMessage", "Kursus ditambahkan ke keranjang");
            } else {
                session.setAttribute("errorMessage", "Gagal menambahkan ke keranjang");
            }
            
            String referer = request.getHeader("Referer");
            if (referer != null) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect(request.getContextPath() + "/cart");
            }
        }
    }

    /**
     * Remove course from cart
     */
    private void removeFromCart(HttpServletRequest request, HttpServletResponse response, 
                                User user, int courseId)
            throws ServletException, IOException, SQLException {
        
        boolean success = cartDAO.removeItem(user.getUserId(), courseId);
        int cartCount = cartDAO.getItemCount(user.getUserId());
        BigDecimal newTotal = cartDAO.getCartTotal(user.getUserId());

        String accept = request.getHeader("Accept");
        if (accept != null && accept.contains("application/json")) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\":" + success + 
                                       ",\"cartCount\":" + cartCount + 
                                       ",\"newTotal\":" + newTotal + "}");
        } else {
            HttpSession session = request.getSession();
            if (success) {
                session.setAttribute("successMessage", "Kursus dihapus dari keranjang");
            }
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }

    /**
     * Clear entire cart
     */
    private void clearCart(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        cartDAO.clearCart(user.getUserId());

        String accept = request.getHeader("Accept");
        if (accept != null && accept.contains("application/json")) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\":true,\"message\":\"Keranjang dikosongkan\"}");
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Keranjang dikosongkan");
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }

    /**
     * Move item from wishlist to cart
     */
    private void moveFromWishlist(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        String courseIdStr = request.getParameter("courseId");
        if (courseIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        int courseId = Integer.parseInt(courseIdStr);
        
        // Check if already enrolled
        if (enrollmentDAO.isEnrolled(user.getUserId(), courseId)) {
            sendJsonResponse(response, false, "Anda sudah terdaftar di kursus ini");
            return;
        }

        boolean success = wishlistDAO.moveToCart(user.getUserId(), courseId);

        String accept = request.getHeader("Accept");
        if (accept != null && accept.contains("application/json")) {
            response.setContentType("application/json");
            int cartCount = cartDAO.getItemCount(user.getUserId());
            response.getWriter().write("{\"success\":" + success + ",\"cartCount\":" + cartCount + "}");
        } else {
            HttpSession session = request.getSession();
            if (success) {
                session.setAttribute("successMessage", "Kursus dipindahkan ke keranjang");
            }
            response.sendRedirect(request.getContextPath() + "/wishlist");
        }
    }

    /**
     * Helper to send JSON response
     */
    private void sendJsonResponse(HttpServletResponse response, boolean success, String message)
            throws IOException {
        response.setContentType("application/json");
        response.getWriter().write("{\"success\":" + success + ",\"message\":\"" + message + "\"}");
    }
}
