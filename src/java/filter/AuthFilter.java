/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package filter;
import model.User;

import jakarta.servlet.*;
import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;

/**
 *
 * @author user
 */
@WebFilter(filterName = "AuthFilter", urlPatterns = {"/*"})
public class AuthFilter implements Filter {

    private static final List<String> PUBLIC_PATHS = Arrays.asList(
        "/", "/index.jsp", "/home",
        "/login", "/register", "/logout",
        "/courses", "/course/",
        "/categories", "/category/",
        "/search",
        "/about", "/contact", "/faq",
        "/assets/", "/uploads/"
    );
    
    // Halaman khusus admin
    private static final List<String> ADMIN_PATHS = Arrays.asList(
        "/admin"
    );
    
    // Halaman khusus lecturer
    private static final List<String> LECTURER_PATHS = Arrays.asList(
        "/lecturer", "/instructor"
    );
    
    // Halaman khusus student
    private static final List<String> STUDENT_PATHS = Arrays.asList(
        "/student", "/my-learning", "/wishlist", "/cart", "/checkout"
    );
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization if needed
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
        HttpSession session = httpRequest.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;
        
        // Check if path is public
        if (isPublicPath(path)) {
            chain.doFilter(request, response);
            return;
        }
        
        // Check if user is logged in
        if (currentUser == null) {
            // Store the requested URL for redirect after login
            session = httpRequest.getSession(true);
            session.setAttribute("redirectUrl", httpRequest.getRequestURI());
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }
        
        // Check role-based access
        if (isAdminPath(path) && !currentUser.isAdmin()) {
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            return;
        }
        
        if (isLecturerPath(path) && !currentUser.isLecturer() && !currentUser.isAdmin()) {
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            return;
        }
        
        if (isStudentPath(path) && !currentUser.isStudent() && !currentUser.isAdmin()) {
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            return;
        }
        
        // Set user attribute for JSP
        request.setAttribute("currentUser", currentUser);
        
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        // Cleanup if needed
    }
    
    private boolean isPublicPath(String path) {
        for (String publicPath : PUBLIC_PATHS) {
            if (path.equals(publicPath) || path.startsWith(publicPath)) {
                return true;
            }
        }
        return false;
    }
    
    private boolean isAdminPath(String path) {
        for (String adminPath : ADMIN_PATHS) {
            if (path.startsWith(adminPath)) {
                return true;
            }
        }
        return false;
    }
    
    private boolean isLecturerPath(String path) {
        for (String lecturerPath : LECTURER_PATHS) {
            if (path.startsWith(lecturerPath)) {
                return true;
            }
        }
        return false;
    }
    
    private boolean isStudentPath(String path) {
        for (String studentPath : STUDENT_PATHS) {
            if (path.startsWith(studentPath)) {
                return true;
            }
        }
        return false;
    }
}
