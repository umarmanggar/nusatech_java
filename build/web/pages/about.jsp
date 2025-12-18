<%-- 
    Document   : about
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: About Us Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tentang Kami - NusaTech</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <jsp:include page="/pages/common/navbar.jsp"/>
    
    <!-- Hero Section -->
    <section style="background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%); padding: 6rem 0; color: white; text-align: center;">
        <div class="container">
            <h1 style="font-size: 3rem; font-weight: 800; margin-bottom: 1rem;">Tentang NusaTech</h1>
            <p style="font-size: 1.25rem; opacity: 0.9; max-width: 600px; margin: 0 auto;">
                Platform pembelajaran coding terdepan untuk mempersiapkan generasi Indonesia Emas 2045
            </p>
        </div>
    </section>
    
    <!-- About Content -->
    <section class="section" style="padding: 5rem 0;">
        <div class="container">
            <div class="grid" style="grid-template-columns: 1fr 1fr; gap: 4rem; align-items: center;">
                <div>
                    <h2 style="font-size: 2rem; font-weight: 700; color: var(--gray-900); margin-bottom: 1.5rem;">
                        Misi Kami
                    </h2>
                    <p style="color: var(--gray-600); line-height: 1.8; margin-bottom: 1.5rem;">
                        NusaTech didirikan dengan satu tujuan besar: <strong>mencerdaskan bangsa melalui teknologi</strong>. 
                        Kami percaya bahwa setiap orang Indonesia berhak mendapatkan akses ke pendidikan teknologi berkualitas tinggi, 
                        tanpa batasan geografis maupun ekonomi.
                    </p>
                    <p style="color: var(--gray-600); line-height: 1.8; margin-bottom: 1.5rem;">
                        Dengan kurikulum yang dirancang oleh para praktisi industri dan akademisi terbaik, 
                        kami berkomitmen untuk menghasilkan talenta digital yang siap bersaing di kancah global.
                    </p>
                    <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
                        <a href="${pageContext.request.contextPath}/courses" class="btn btn-primary btn-lg">
                            <i class="fas fa-graduation-cap"></i> Mulai Belajar
                        </a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-outline btn-lg">
                            Daftar Gratis
                        </a>
                    </div>
                </div>
                <div style="text-align: center;">
                    <img src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=600&h=400&fit=crop" 
                         alt="Team NusaTech" 
                         style="border-radius: var(--radius-xl); box-shadow: var(--shadow-xl); width: 100%;">
                </div>
            </div>
        </div>
    </section>
    
    <!-- Values Section -->
    <section style="background: var(--gray-50); padding: 5rem 0;">
        <div class="container">
            <div style="text-align: center; margin-bottom: 3rem;">
                <h2 style="font-size: 2rem; font-weight: 700; color: var(--gray-900); margin-bottom: 0.5rem;">Nilai-Nilai Kami</h2>
                <p style="color: var(--gray-600);">Prinsip yang menjadi fondasi setiap langkah kami</p>
            </div>
            
            <div class="grid grid-3">
                <div class="card" style="text-align: center; padding: 2rem;">
                    <div style="width: 80px; height: 80px; background: var(--primary-light); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem;">
                        <i class="fas fa-lightbulb" style="font-size: 2rem; color: var(--primary);"></i>
                    </div>
                    <h3 style="font-size: 1.25rem; font-weight: 600; margin-bottom: 0.75rem;">Inovasi</h3>
                    <p style="color: var(--gray-600);">Selalu menghadirkan metode pembelajaran terbaru dan teknologi terkini untuk pengalaman belajar terbaik.</p>
                </div>
                
                <div class="card" style="text-align: center; padding: 2rem;">
                    <div style="width: 80px; height: 80px; background: var(--secondary-light); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem;">
                        <i class="fas fa-users" style="font-size: 2rem; color: var(--secondary);"></i>
                    </div>
                    <h3 style="font-size: 1.25rem; font-weight: 600; margin-bottom: 0.75rem;">Inklusivitas</h3>
                    <p style="color: var(--gray-600);">Pendidikan untuk semua. Kami menyediakan berbagai opsi agar semua orang bisa belajar.</p>
                </div>
                
                <div class="card" style="text-align: center; padding: 2rem;">
                    <div style="width: 80px; height: 80px; background: #dcfce7; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem;">
                        <i class="fas fa-medal" style="font-size: 2rem; color: var(--success);"></i>
                    </div>
                    <h3 style="font-size: 1.25rem; font-weight: 600; margin-bottom: 0.75rem;">Kualitas</h3>
                    <p style="color: var(--gray-600);">Standar tinggi dalam setiap kursus. Materi dikurasi dan divalidasi oleh para expert.</p>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Stats Section -->
    <section style="padding: 5rem 0;">
        <div class="container">
            <div class="grid grid-4" style="text-align: center;">
                <div>
                    <div style="font-size: 3.5rem; font-weight: 800; color: var(--primary);">100+</div>
                    <div style="color: var(--gray-600); font-size: 1.125rem;">Kursus Tersedia</div>
                </div>
                <div>
                    <div style="font-size: 3.5rem; font-weight: 800; color: var(--primary);">5,000+</div>
                    <div style="color: var(--gray-600); font-size: 1.125rem;">Pelajar Aktif</div>
                </div>
                <div>
                    <div style="font-size: 3.5rem; font-weight: 800; color: var(--primary);">50+</div>
                    <div style="color: var(--gray-600); font-size: 1.125rem;">Instruktur Expert</div>
                </div>
                <div>
                    <div style="font-size: 3.5rem; font-weight: 800; color: var(--primary);">98%</div>
                    <div style="color: var(--gray-600); font-size: 1.125rem;">Tingkat Kepuasan</div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Team Section -->
    <section style="background: var(--gray-50); padding: 5rem 0;">
        <div class="container">
            <div style="text-align: center; margin-bottom: 3rem;">
                <h2 style="font-size: 2rem; font-weight: 700; color: var(--gray-900); margin-bottom: 0.5rem;">Tim Kami</h2>
                <p style="color: var(--gray-600);">Orang-orang hebat di balik NusaTech</p>
            </div>
            
            <div>
                <!-- Row 1: 4 Team Members -->
                <div style="display: flex; flex-wrap: wrap; justify-content: center; gap: 3rem; padding: 2rem;">
                    <div style="text-align: center;">
                        <img src="https://ui-avatars.com/api/?name=Gabriel+Edbert+Liandrew&background=8B1538&color=fff&size=150" 
                             alt="CEO" style="border-radius: 50%; margin-bottom: 1rem;">
                        <h4 style="font-weight: 600; margin-bottom: 0.25rem;">Gabriel Edbert Liandrew</h4>
                        <p style="color: var(--gray-500); font-size: 0.875rem;">CEO & Founder</p>
                    </div>
                    <div style="text-align: center;">
                        <img src="https://ui-avatars.com/api/?name=Muhammad+Umar&background=D4AF37&color=fff&size=150" 
                             alt="CTO" style="border-radius: 50%; margin-bottom: 1rem;">
                        <h4 style="font-weight: 600; margin-bottom: 0.25rem;">Muhammad Umar</h4>
                        <p style="color: var(--gray-500); font-size: 0.875rem;">CTO</p>
                    </div>
                    <div style="text-align: center;">
                        <img src="https://ui-avatars.com/api/?name=Hanif+Imaddudin&background=3498db&color=fff&size=150" 
                             alt="Head of Content" style="border-radius: 50%; margin-bottom: 1rem;">
                        <h4 style="font-weight: 600; margin-bottom: 0.25rem;">Hanif Imaddudin</h4>
                        <p style="color: var(--gray-500); font-size: 0.875rem;">Head of Content</p>
                    </div>
                    <div style="text-align: center;">
                        <img src="https://ui-avatars.com/api/?name=Naufal+Arkan+Wahib&background=27ae60&color=fff&size=150" 
                             alt="Head of Marketing" style="border-radius: 50%; margin-bottom: 1rem;">
                        <h4 style="font-weight: 600; margin-bottom: 0.25rem;">Naufal Arkan Wahib</h4>
                        <p style="color: var(--gray-500); font-size: 0.875rem;">Head of Marketing</p>
                    </div>
                </div>
                <!-- Row 2: 1 Team Member (Centered) -->
                <div style="display: flex; justify-content: center; padding: 1rem 2rem 2rem 2rem;">
                    <div style="text-align: center;">
                        <img src="https://ui-avatars.com/api/?name=Putu+Padmanaba&background=9B59B6&color=fff&size=150" 
                             alt="Head of Product" style="border-radius: 50%; margin-bottom: 1rem;">
                        <h4 style="font-weight: 600; margin-bottom: 0.25rem;">Putu Padmanaba</h4>
                        <p style="color: var(--gray-500); font-size: 0.875rem;">Head of Product</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- CTA Section -->
    <section class="cta-section" style="background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%); padding: 5rem 0; text-align: center; color: white;">
        <div class="container">
            <h2 style="font-size: 2.5rem; font-weight: 800; margin-bottom: 1rem;">Siap Memulai Perjalanan Belajar?</h2>
            <p style="font-size: 1.125rem; opacity: 0.9; margin-bottom: 2rem; max-width: 600px; margin-left: auto; margin-right: auto;">
                Bergabung dengan ribuan pelajar lainnya dan mulai tingkatkan skill Anda hari ini.
            </p>
            <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;">
                <a href="${pageContext.request.contextPath}/register" class="btn btn-secondary btn-lg">
                    <i class="fas fa-user-plus"></i> Daftar Sekarang
                </a>
                <a href="${pageContext.request.contextPath}/courses" class="btn btn-outline-white btn-lg">
                    Lihat Kursus
                </a>
            </div>
        </div>
    </section>
    
    <jsp:include page="/pages/common/footer.jsp"/>
</body>
</html>
