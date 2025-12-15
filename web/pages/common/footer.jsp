<%-- 
    Document   : footer
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Public Footer Component
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer class="footer">
    <div class="container">
        <div class="footer-grid">
            <div>
                <div class="footer-brand">
                    <img src="${pageContext.request.contextPath}/assets/image/logo.png" alt="NusaTech" onerror="this.style.display='none'">
                    <span class="footer-brand-text">NUSA<span>TECH</span></span>
                </div>
                <p class="footer-description">
                    Platform pembelajaran coding interaktif untuk generasi muda Indonesia. 
                    Bersama menuju Indonesia Emas 2045 dengan kemampuan teknologi yang mumpuni.
                </p>
                <div class="footer-social">
                    <a href="#" title="Facebook"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" title="Twitter"><i class="fab fa-twitter"></i></a>
                    <a href="#" title="Instagram"><i class="fab fa-instagram"></i></a>
                    <a href="#" title="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                    <a href="#" title="YouTube"><i class="fab fa-youtube"></i></a>
                </div>
            </div>
            
            <div>
                <h4 class="footer-title">Kursus Populer</h4>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/courses?category=web-development">Web Development</a></li>
                    <li><a href="${pageContext.request.contextPath}/courses?category=mobile-development">Mobile Development</a></li>
                    <li><a href="${pageContext.request.contextPath}/courses?category=data-science">Data Science</a></li>
                    <li><a href="${pageContext.request.contextPath}/courses?category=artificial-intelligence">Artificial Intelligence</a></li>
                    <li><a href="${pageContext.request.contextPath}/courses?category=cloud-computing">Cloud Computing</a></li>
                </ul>
            </div>
            
            <div>
                <h4 class="footer-title">Perusahaan</h4>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/about">Tentang Kami</a></li>
                    <li><a href="${pageContext.request.contextPath}/careers">Karir</a></li>
                    <li><a href="${pageContext.request.contextPath}/blog">Blog</a></li>
                    <li><a href="${pageContext.request.contextPath}/partners">Mitra</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">Hubungi Kami</a></li>
                </ul>
            </div>
            
            <div>
                <h4 class="footer-title">Bantuan</h4>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/faq">FAQ</a></li>
                    <li><a href="${pageContext.request.contextPath}/help">Pusat Bantuan</a></li>
                    <li><a href="${pageContext.request.contextPath}/privacy">Kebijakan Privasi</a></li>
                    <li><a href="${pageContext.request.contextPath}/terms">Syarat & Ketentuan</a></li>
                    <li><a href="${pageContext.request.contextPath}/refund">Kebijakan Refund</a></li>
                </ul>
            </div>
        </div>
        
        <div class="footer-bottom">
            <p class="footer-copyright">
                &copy; 2025 Dikoding Muda Nusantara. All rights reserved.
            </p>
            <p style="display: flex; align-items: center; gap: 0.25rem;">
                Made with <i class="fas fa-heart" style="color: var(--primary);"></i> in Indonesia
            </p>
        </div>
    </div>
</footer>
