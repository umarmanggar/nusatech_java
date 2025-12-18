/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;
import dao.UserDAO;
import model.User;
import util.PasswordUtil;
import util.ValidationUtil;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author user
 */
@WebServlet(name = "AuthController", urlPatterns = {"/login", "/logout", "/register"})
public class AuthController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        
        // Check if user already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            redirectToDashboard(response, request, user);
            return;
        }
        
        switch (path) {
            case "/login":
                request.getRequestDispatcher("/pages/auth/login.jsp").forward(request, response);
                break;
            case "/register":
                request.getRequestDispatcher("/pages/auth/register.jsp").forward(request, response);
                break;
            case "/logout":
                doLogout(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        
        switch (path) {
            case "/login":
                doLogin(request, response);
                break;
            case "/register":
                doRegister(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/");
        }
    }
    
    /**
     * Handle login
     */
    private void doLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");
        
        // Validate input
        if (ValidationUtil.isEmpty(email) || ValidationUtil.isEmpty(password)) {
            request.setAttribute("error", "Email dan password harus diisi");
            request.getRequestDispatcher("/pages/auth/login.jsp").forward(request, response);
            return;
        }
        
        try {
            User user = userDAO.authenticate(email, password);
            
            if (user != null) {
                // Create session
                HttpSession session = request.getSession(true);
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getUserId());
                session.setAttribute("userName", user.getName());
                session.setAttribute("userRole", user.getRole().name());
                
                // Set session timeout (30 minutes by default, 7 days if remember)
                if ("on".equals(remember)) {
                    session.setMaxInactiveInterval(7 * 24 * 60 * 60);
                } else {
                    session.setMaxInactiveInterval(30 * 60);
                }
                
                // Redirect to stored URL or dashboard
                String redirectUrl = (String) session.getAttribute("redirectUrl");
                if (redirectUrl != null) {
                    session.removeAttribute("redirectUrl");
                    response.sendRedirect(redirectUrl);
                } else {
                    redirectToDashboard(response, request, user);
                }
            } else {
                request.setAttribute("error", "Email atau password salah");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/pages/auth/login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Terjadi kesalahan sistem. Silakan coba lagi.");
            request.getRequestDispatcher("/pages/auth/login.jsp").forward(request, response);
        }
    }
    
    /**
     * Handle register
     */
    private void doRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = request.getParameter("role");
        String phone = request.getParameter("phone");
        
        // Validate input
        if (ValidationUtil.isEmpty(name) || ValidationUtil.isEmpty(email) || 
            ValidationUtil.isEmpty(password) || ValidationUtil.isEmpty(role)) {
            request.setAttribute("error", "Semua field wajib harus diisi");
            preserveFormData(request, name, email, phone, role);
            request.getRequestDispatcher("/pages/auth/register.jsp").forward(request, response);
            return;
        }
        
        if (!ValidationUtil.isValidName(name)) {
            request.setAttribute("error", "Nama tidak valid (minimal 2 karakter)");
            preserveFormData(request, name, email, phone, role);
            request.getRequestDispatcher("/pages/auth/register.jsp").forward(request, response);
            return;
        }
        
        if (!ValidationUtil.isValidEmail(email)) {
            request.setAttribute("error", "Format email tidak valid");
            preserveFormData(request, name, email, phone, role);
            request.getRequestDispatcher("/pages/auth/register.jsp").forward(request, response);
            return;
        }
        
        if (!ValidationUtil.isValidPassword(password)) {
            request.setAttribute("error", "Password minimal 8 karakter dengan kombinasi huruf dan angka");
            preserveFormData(request, name, email, phone, role);
            request.getRequestDispatcher("/pages/auth/register.jsp").forward(request, response);
            return;
        }
        
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Konfirmasi password tidak cocok");
            preserveFormData(request, name, email, phone, role);
            request.getRequestDispatcher("/pages/auth/register.jsp").forward(request, response);
            return;
        }
        
        if (!role.equals("STUDENT") && !role.equals("LECTURER")) {
            request.setAttribute("error", "Role tidak valid");
            preserveFormData(request, name, email, phone, role);
            request.getRequestDispatcher("/pages/auth/register.jsp").forward(request, response);
            return;
        }
        
        try {
            // Check if email exists
            if (userDAO.emailExists(email)) {
                request.setAttribute("error", "Email sudah terdaftar");
                preserveFormData(request, name, email, phone, role);
                request.getRequestDispatcher("/pages/auth/register.jsp").forward(request, response);
                return;
            }
            
            // Create user
            User user = new User();
            user.setName(name);
            user.setEmail(email);
            user.setPassword(PasswordUtil.hashPassword(password));
            user.setRole(User.Role.valueOf(role));
            user.setPhone(phone);
            
            int userId = userDAO.create(user);
            
            if (userId > 0) {
                // Auto login
                user.setUserId(userId);
                HttpSession session = request.getSession(true);
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getUserId());
                session.setAttribute("userName", user.getName());
                session.setAttribute("userRole", user.getRole().name());
                
                // Set success message
                session.setAttribute("successMessage", "Registrasi berhasil! Selamat datang di NusaTech.");
                
                redirectToDashboard(response, request, user);
            } else {
                request.setAttribute("error", "Registrasi gagal. Silakan coba lagi.");
                preserveFormData(request, name, email, phone, role);
                request.getRequestDispatcher("/pages/auth/register.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Terjadi kesalahan sistem. Silakan coba lagi.");
            preserveFormData(request, name, email, phone, role);
            request.getRequestDispatcher("/pages/auth/register.jsp").forward(request, response);
        }
    }
    
    /**
     * Handle logout
     */
    private void doLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/login?logout=success");
    }
    
    /**
     * Redirect to appropriate dashboard based on role
     */
    private void redirectToDashboard(HttpServletResponse response, HttpServletRequest request, User user)
            throws IOException {
        
        String contextPath = request.getContextPath();
        
        switch (user.getRole()) {
            case ADMIN:
                response.sendRedirect(contextPath + "/admin/dashboard");
                break;
            case LECTURER:
                response.sendRedirect(contextPath + "/lecturer/dashboard");
                break;
            case STUDENT:
                response.sendRedirect(contextPath + "/student/dashboard");
                break;
            default:
                response.sendRedirect(contextPath + "/");
        }
    }
    
    /**
     * Preserve form data on error
     */
    private void preserveFormData(HttpServletRequest request, String name, String email, 
                                   String phone, String role) {
        request.setAttribute("name", name);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);
        request.setAttribute("selectedRole", role);
    }
}
