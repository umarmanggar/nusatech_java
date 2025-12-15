<%-- 
    Document   : 403
    Created on : Dec 15, 2025
    Author     : NusaTech
    Description: Forbidden Error Page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>403 - Akses Ditolak - NusaTech</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body style="min-height: 100vh; display: flex; align-items: center; justify-content: center; background: var(--gray-50);">
    <div style="text-align: center; padding: 2rem;">
        <div style="font-size: 8rem; color: var(--error); margin-bottom: 1rem;">
            <i class="fas fa-lock"></i>
        </div>
        <h1 style="font-size: 6rem; font-weight: 800; color: var(--gray-900); margin-bottom: 0;">403</h1>
        <h2 style="font-size: 1.5rem; color: var(--gray-600); margin-bottom: 1rem;">Akses Ditolak</h2>
        <p style="color: var(--gray-500); margin-bottom: 2rem; max-width: 400px;">
            Maaf, Anda tidak memiliki izin untuk mengakses halaman ini. 
            Silakan hubungi administrator jika Anda merasa ini adalah kesalahan.
        </p>
        <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;">
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-lg">
                <i class="fas fa-home"></i> Kembali ke Beranda
            </a>
            <a href="javascript:history.back()" class="btn btn-outline btn-lg">
                <i class="fas fa-arrow-left"></i> Kembali
            </a>
        </div>
    </div>
</body>
</html>
