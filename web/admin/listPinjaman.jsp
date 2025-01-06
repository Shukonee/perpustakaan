<%-- 
    Document   : listPinjaman
    Created on : 6 Jan 2025, 03.16.25
    Author     : alfin
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="model.Booking" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    ArrayList<Booking> bookings = (ArrayList<Booking>) request.getAttribute("bookingList");
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMMM yyyy");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <title>Daftar Booking</title>
        <style>
            body {
                background-color: #f8f9fa;
                padding-top: 60px;
            }
            .card {
                margin-bottom: 20px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                transition: transform 0.2s;
            }
            .card:hover {
                transform: translateY(-5px);
            }
            .status-badge {
                padding: 5px 10px;
                border-radius: 20px;
                font-size: 14px;
                font-weight: 500;
            }
            .status-active {
                background-color: #d4edda;
                color: #155724;
            }
            .status-expired {
                background-color: #f8d7da;
                color: #721c24;
            }
            .dates-section {
                background-color: #f8f9fa;
                padding: 10px;
                border-radius: 8px;
                margin: 10px 0;
            }
            .book-title {
                color: #0d6efd;
                font-weight: 600;
            }
            .member-name {
                font-size: 0.9rem;
                color: #6c757d;
            }
        </style>
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
            <div class="container">
                <a class="navbar-brand" href="#">Perpustakaan</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="home">Beranda</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="listBooks">Daftar Buku</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="ListPinjamanController">Daftar Pinjaman</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Header -->
        <div class="bg-dark text-white py-5 mb-4">
            <div class="container">
                <h1 class="text-center">Daftar Booking</h1>
            </div>
        </div>

        <!-- Content -->
        <div class="container">
            <div class="row">
                <div class="col-12 mb-3">
                    <a href="booking/create" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Tambah Booking Baru
                    </a>
                </div>
            </div>
            
            <div class="row">
                <% for (Booking booking : bookings) { 
                    boolean isExpired = booking.getExpired_date().isBefore(java.time.LocalDate.now());
                %>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="book-title mb-2">
                                <i class="fas fa-book me-2"></i>
                                <%= booking.getBukuDetail().getBuku().getnama_buku() %>
                            </h5>
                            
                            <p class="member-name mb-3">
                                <i class="fas fa-user me-2"></i>
                                <%= booking.getMember().getNama_depan() %> <%= booking.getMember().getNama_belakang() %>
                            </p>
                            
                            <div class="dates-section">
                                <div class="mb-2">
                                    <small class="text-muted">Tanggal Booking:</small><br>
                                    <i class="far fa-calendar-alt me-2"></i>
                                    <%= booking.getBooking_date().format(formatter) %>
                                </div>
                                <div>
                                    <small class="text-muted">Tanggal Expired:</small><br>
                                    <i class="far fa-calendar-times me-2"></i>
                                    <%= booking.getExpired_date().format(formatter) %>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <span class="status-badge <%= isExpired ? "status-expired" : "status-active" %>">
                                    <i class="fas <%= isExpired ? "fa-exclamation-circle" : "fa-check-circle" %> me-1"></i>
                                    <%= isExpired ? "Expired" : "Active" %>
                                </span>
                            </div>
                            
                            <div class="d-flex gap-2">
                                <a href="booking/edit?id=<%= booking.getBooking_id() %>" class="btn btn-primary">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <a href="booking/delete?id=<%= booking.getBooking_id() %>" 
                                   class="btn btn-danger"
                                   onclick="return confirm('Apakah Anda yakin ingin menghapus data ini?')">
                                    <i class="fas fa-trash"></i> Hapus
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>