/*
 * ForumController.java
 * Handles forum/discussion routes
 */
package controller;

import dao.ForumDAO;
import dao.PostDAO;
import dao.CourseDAO;
import dao.EnrollmentDAO;
import model.Forum;
import model.ForumPost;
import model.Course;
import model.User;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Controller for forum/discussion features
 * @author user
 */
@WebServlet(name = "ForumController", urlPatterns = {"/forum/*"})
public class ForumController extends HttpServlet {

    private ForumDAO forumDAO;
    private PostDAO postDAO;
    private CourseDAO courseDAO;
    private EnrollmentDAO enrollmentDAO;

    @Override
    public void init() throws ServletException {
        forumDAO = new ForumDAO();
        postDAO = new PostDAO();
        courseDAO = new CourseDAO();
        enrollmentDAO = new EnrollmentDAO();
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
        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // List all accessible forums
                listForums(request, response, user);
                return;
            }
            String[] parts = pathInfo.substring(1).split("/");

            if (parts[0].equals("thread") && parts.length >= 2) {
                // View thread: /forum/thread/{postId}
                int postId = Integer.parseInt(parts[1]);
                viewThread(request, response, postId, user);
            } else {
                // List discussions: /forum/{courseId}
                int courseId = Integer.parseInt(parts[0]);
                listDiscussions(request, response, courseId, user);
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID tidak valid");
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
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        User user = (User) session.getAttribute("user");
        String pathInfo = request.getPathInfo();

        if (pathInfo == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            if (pathInfo.equals("/create")) {
                createPost(request, response, user);
            } else if (pathInfo.equals("/reply")) {
                replyToPost(request, response, user);
            } else if (pathInfo.startsWith("/upvote/")) {
                int postId = Integer.parseInt(pathInfo.substring("/upvote/".length()));
                upvotePost(request, response, postId, user);
            } else if (pathInfo.equals("/mark-answered")) {
                markAsAnswered(request, response, user);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID tidak valid");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * List all accessible forums
     */
    private void listForums(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        List<Forum> forums = forumDAO.findAllActive();
        request.setAttribute("forums", forums);
        request.getRequestDispatcher("/pages/forum/list.jsp").forward(request, response);
    }

    /**
     * List discussions in a course forum
     */
    private void listDiscussions(HttpServletRequest request, HttpServletResponse response, 
                                  int courseId, User user)
            throws ServletException, IOException, SQLException {
        
        // Get course
        Course course = courseDAO.findById(courseId);
        if (course == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Kursus tidak ditemukan");
            return;
        }

        // Check access (must be enrolled or lecturer/admin)
        boolean hasAccess = user.isAdmin() || user.isLecturer();
        if (!hasAccess && user.isStudent()) {
            hasAccess = enrollmentDAO.isEnrolled(user.getUserId(), courseId);
        }

        if (!hasAccess) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Anda tidak memiliki akses ke forum ini");
            return;
        }

        // Get forum
        Forum forum = forumDAO.findByCourse(courseId);
        if (forum == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Forum tidak ditemukan");
            return;
        }

        // Get page parameter
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        // Get posts
        List<ForumPost> posts = postDAO.findByForum(forum.getForumId(), page, 20);

        // Get replies for each post
        for (ForumPost post : posts) {
            List<ForumPost> replies = postDAO.findReplies(post.getPostId());
            post.setReplies(replies);
        }

        int totalPosts = forumDAO.countMainPosts(forum.getForumId());
        int totalPages = (int) Math.ceil((double) totalPosts / 20);

        request.setAttribute("course", course);
        request.setAttribute("forum", forum);
        request.setAttribute("posts", posts);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/pages/forum/discussions.jsp").forward(request, response);
    }

    /**
     * View single thread/post
     */
    private void viewThread(HttpServletRequest request, HttpServletResponse response, 
                            int postId, User user)
            throws ServletException, IOException, SQLException {
        
        ForumPost post = postDAO.findById(postId);
        if (post == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Diskusi tidak ditemukan");
            return;
        }

        // Get forum and course
        Forum forum = forumDAO.findById(post.getForumId());
        Course course = courseDAO.findById(forum.getCourseId());

        // Check access
        boolean hasAccess = user.isAdmin() || user.isLecturer();
        if (!hasAccess && user.isStudent()) {
            hasAccess = enrollmentDAO.isEnrolled(user.getUserId(), course.getCourseId());
        }

        if (!hasAccess) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        // Get replies
        List<ForumPost> replies = postDAO.findReplies(postId);
        post.setReplies(replies);

        // Check if user is the post owner or lecturer
        boolean canMarkAnswered = (user.getUserId() == post.getUserId()) || 
                                  user.isLecturer() || user.isAdmin();

        request.setAttribute("post", post);
        request.setAttribute("forum", forum);
        request.setAttribute("course", course);
        request.setAttribute("canMarkAnswered", canMarkAnswered);

        request.getRequestDispatcher("/pages/forum/thread.jsp").forward(request, response);
    }

    /**
     * Create new post
     */
    private void createPost(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        String forumIdStr = request.getParameter("forumId");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        if (forumIdStr == null || title == null || content == null ||
            title.trim().isEmpty() || content.trim().isEmpty()) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Judul dan isi diskusi harus diisi");
            response.sendRedirect(request.getHeader("Referer"));
            return;
        }

        int forumId = Integer.parseInt(forumIdStr);
        
        // Check forum access
        Forum forum = forumDAO.findById(forumId);
        if (forum == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        boolean hasAccess = user.isAdmin() || user.isLecturer();
        if (!hasAccess && user.isStudent()) {
            hasAccess = enrollmentDAO.isEnrolled(user.getUserId(), forum.getCourseId());
        }

        if (!hasAccess) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        // Create post
        ForumPost post = new ForumPost(forumId, user.getUserId(), title.trim(), content.trim());
        int postId = postDAO.create(post);

        HttpSession session = request.getSession();
        if (postId > 0) {
            session.setAttribute("successMessage", "Diskusi berhasil dibuat");
            response.sendRedirect(request.getContextPath() + "/forum/thread/" + postId);
        } else {
            session.setAttribute("errorMessage", "Gagal membuat diskusi");
            response.sendRedirect(request.getContextPath() + "/forum/" + forum.getCourseId());
        }
    }

    /**
     * Reply to a post
     */
    private void replyToPost(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        String postIdStr = request.getParameter("postId");
        String content = request.getParameter("content");

        if (postIdStr == null || content == null || content.trim().isEmpty()) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Isi balasan harus diisi");
            response.sendRedirect(request.getHeader("Referer"));
            return;
        }

        int parentId = Integer.parseInt(postIdStr);
        
        // Get parent post
        ForumPost parentPost = postDAO.findById(parentId);
        if (parentPost == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Check access
        Forum forum = forumDAO.findById(parentPost.getForumId());
        boolean hasAccess = user.isAdmin() || user.isLecturer();
        if (!hasAccess && user.isStudent()) {
            hasAccess = enrollmentDAO.isEnrolled(user.getUserId(), forum.getCourseId());
        }

        if (!hasAccess) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        // Create reply
        ForumPost reply = new ForumPost(parentPost.getForumId(), user.getUserId(), parentId, content.trim());
        int replyId = postDAO.create(reply);

        HttpSession session = request.getSession();
        if (replyId > 0) {
            session.setAttribute("successMessage", "Balasan berhasil dikirim");
        } else {
            session.setAttribute("errorMessage", "Gagal mengirim balasan");
        }

        response.sendRedirect(request.getContextPath() + "/forum/thread/" + parentId);
    }

    /**
     * Upvote a post
     */
    private void upvotePost(HttpServletRequest request, HttpServletResponse response, 
                            int postId, User user)
            throws ServletException, IOException, SQLException {
        
        postDAO.upvote(postId, user.getUserId());

        // Return JSON for AJAX
        String accept = request.getHeader("Accept");
        if (accept != null && accept.contains("application/json")) {
            ForumPost post = postDAO.findById(postId);
            response.setContentType("application/json");
            response.getWriter().write("{\"success\":true,\"upvotes\":" + post.getUpvotes() + "}");
        } else {
            response.sendRedirect(request.getHeader("Referer"));
        }
    }

    /**
     * Mark post as answered
     */
    private void markAsAnswered(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        
        String postIdStr = request.getParameter("postId");
        if (postIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        int postId = Integer.parseInt(postIdStr);
        ForumPost post = postDAO.findById(postId);

        if (post == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Only post owner, lecturer, or admin can mark as answered
        if (user.getUserId() != post.getUserId() && !user.isLecturer() && !user.isAdmin()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        postDAO.markAsAnswered(postId);

        HttpSession session = request.getSession();
        session.setAttribute("successMessage", "Diskusi ditandai sebagai terjawab");
        response.sendRedirect(request.getContextPath() + "/forum/thread/" + postId);
    }
}
