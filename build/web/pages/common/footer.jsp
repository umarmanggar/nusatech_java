<%-- 
    Document   : footer
    Created on : Dec 10, 2025, 4:40:22 PM
    Author     : user
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer class="footer">
    <div class="container">
        <div class="footer-grid">
            <div>
                <div class="footer-brand">
                    <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="NusaTech">
                    <span class="footer-brand-text">NUSA<span>TECH</span></span>
                </div>
                <p class="footer-description">Platform pembelajaran coding interaktif untuk generasi muda Indonesia. Bersama menuju Indonesia Emas 2045.</p>
                <div class="footer-social">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                    <a href="#"><i class="fab fa-youtube"></i></a>
                </div>
            </div>
            <div>
                <h4 class="footer-title">Kursus</h4>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/courses?category=web-development">Web Development</a></li>
                    <li><a href="${pageContext.request.contextPath}/courses?category=mobile-development">Mobile Development</a></li>
                    <li><a href="${pageContext.request.contextPath}/courses?category=data-science">Data Science</a></li>
                    <li><a href="${pageContext.request.contextPath}/courses?category=artificial-intelligence">Artificial Intelligence</a></li>
                </ul>
            </div>
            <div>
                <h4 class="footer-title">Perusahaan</h4>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/about">Tentang Kami</a></li>
                    <li><a href="#">Karir</a></li>
                    <li><a href="#">Blog</a></li>
                    <li><a href="#">Kontak</a></li>
                </ul>
            </div>
            <div>
                <h4 class="footer-title">Bantuan</h4>
                <ul class="footer-links">
                    <li><a href="#">FAQ</a></li>
                    <li><a href="#">Pusat Bantuan</a></li>
                    <li><a href="#">Kebijakan Privasi</a></li>
                    <li><a href="#">Syarat & Ketentuan</a></li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <p class="footer-copyright">&copy; 2025 Dikoding Muda Nusantara. All rights reserved.</p>
            <p>Made with <i class="fas fa-heart" style="color: var(--primary)"></i> in Indonesia</p>
        </div>
    </div>
</footer>
