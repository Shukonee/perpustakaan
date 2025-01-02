<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="model.Buku" %>
<%@ page import="java.util.List" %>
<%
    // Ambil daftar buku dari atribut request
    List<Buku> books = (List<Buku>) request.getAttribute("books");
%>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <title>Home</title>
        <style>
            body {
                background-color: #f8f9fa;
            }
            .card {
                margin-bottom: 20px;
            }
            h2, h3 {
                color: #007bff;
            }
            .book-cover {
                width: 100%;
                height: 200px;
                object-fit: contain;
                margin-bottom: 10px;
                background-color: #f8f9fa;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
            <div class="container-fluid">
                <a class="navbar-brand" href="home">Perpustakaan</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" href="home">Beranda</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="listBooks">Daftar Buku</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="booking.jsp">Booking</a>
                        </li>
                    </ul>
                </div>
                <div class="btn-group">
                    <a href="logoutController" class="btn btn-danger">Logout</a>
                </div>
            </div>
        </nav>
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">PERPUSTAKAAN JAYA ABADI</h1>
                    <p class="lead fw-normal text-white-50 mb-0">Selamat datang di Perpustakaan Jaya Abadi!</p>
                </div>
            </div>
        </header>
        <div class="container my-5">
            <h2 class="text-center mb-4">Daftar Buku</h2>
            <div class="row">
                <% for (Buku book : books) { %>
                <div class="col-md-4">
                    <div class="card">
                        <img src="assets/book<%= book.getBukuId() %>.jpg" alt="Cover Buku" class="card-img-top book-cover">
                        <div class="card-body">
                            <h5 class="card-title"><%= book.getNamaBuku() %></h5>
                            <h6 class="card-subtitle mb-2 text-muted">Penulis: <%= book.getAuthor() %></h6>
                            <p class="card-text">
                                <strong>Jenis:</strong> <%= book.getJenisBuku() %><br>
                                <strong>Tipe:</strong> <%= book.getTipeBuku() %><br>
                                <strong>Tanggal Terbit:</strong> <%= book.getTglTerbit() %><br>
                                <strong>Rak:</strong> <%= book.getJenisRak()%><br>
                                <strong>Status:</strong> <%= book.getStatusBuku() ? "Tidak Tersedia" : "Tersedia" %>
                            </p>
                            <% if (!book.getStatusBuku()) { %>
                                <a href="booking.jsp?bukuId=<%= book.getBukuId() %>" class="btn btn-primary">Booking</a>
                            <% } else { %>
                                <button class="btn btn-secondary" disabled>Tidak Tersedia</button>
                            <% } %>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </body>
</html>
