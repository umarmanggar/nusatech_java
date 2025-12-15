<%-- 
    Document   : 404
    Created on : Dec 10, 2025, 4:41:31 PM
    Author     : user
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Halaman Tidak Ditemukan</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <div style="min-height: 100vh; display: flex; align-items: center; justify-content: center; text-align: center; padding: 2rem;">
        <div>
            <div style="font-size: 8rem; font-weight: 800; color: var(--primary); line-height: 1;">404</div>
            <h1 style="font-size: 2rem; margin-bottom: 1rem;">Halaman Tidak Ditemukan</h1>
            <p style="color: var(--gray-500); margin-bottom: 2rem; max-width: 400px;">Maaf, halaman yang Anda cari tidak ditemukan atau telah dipindahkan.</p>
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-lg"><i class="fas fa-home"></i> Kembali ke Beranda</a>
        </div>
    </div>
</body>
</html>
