<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="model.Buku" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.File" %>
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
        <jsp:include page="includes/navbar.jsp" />
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
                        <%
                            String bookId = String.valueOf(book.getbuku_id());
                            String filePathJpg = "assets/book" + bookId + ".jpg";
                            String filePathJpeg = "assets/book" + bookId + ".jpeg";
                            String filePathPng = "assets/book" + bookId + ".png";

                            File fileJpg = new File(application.getRealPath("/") + filePathJpg);
                            File fileJpeg = new File(application.getRealPath("/") + filePathJpeg);
                            File filePng = new File(application.getRealPath("/") + filePathPng);

                            String fileToUse;
                            if (fileJpg.exists()) {
                                fileToUse = filePathJpg;
                            } else if (fileJpeg.exists()) {
                                fileToUse = filePathJpeg;
                            } else if (filePng.exists()){
                                fileToUse = filePathPng;
                            }else {
                                fileToUse = "assets/default.jpg"; // Fallback jika file tidak ditemukan
                            }
                        %>
                        <img src="<%= fileToUse %>" alt="Cover Buku" class="card-img-top book-cover">
                        <div class="card-body">
                            <h5 class="card-title"><%= book.getnama_buku() %></h5>
                            <h6 class="card-subtitle mb-2 text-muted">Penulis: <%= book.getAuthor() %></h6>
                            <p class="card-text">
                                <strong>Jenis:</strong> <%= book.getjenis_buku() %><br>
                                <strong>Tipe:</strong> <%= book.gettipe_buku() %><br>
                                <strong>Tanggal Terbit:</strong> <%= book.gettgl_terbit() %><br>
                                <strong>Rak:</strong> <%= book.getJenisRak()%><br>
                                <strong>Status:</strong> <%= book.getstatus_booking() ? "Tidak Tersedia" : "Tersedia" %>
                            </p>
                            <% if (!book.getstatus_booking()) { %>
                                <a href="${pageContext.request.contextPath}/Booking?buku_id=<%= book.getbuku_id() %>" class="btn btn-primary" method = "get">Booking</a>
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
