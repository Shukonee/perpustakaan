<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="model.Buku" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.File" %>
<%
    List<Buku> books = (List<Buku>) request.getAttribute("books");
    String searchQuery = (String) request.getAttribute("searchQuery");
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
                transition: transform 0.2s;
            }
            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
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
            .search-container {
                background: rgba(255, 255, 255, 0.9);
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            .header-margin {
                margin-top: 56px; /* Adjust based on your navbar height */
            }
        </style>
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp" />
        <header class="bg-dark py-5 header-margin">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">PERPUSTAKAAN JAYA ABADI</h1>
                    <p class="lead fw-normal text-white-50 mb-0">Selamat datang di Perpustakaan Jaya Abadi!</p>
                </div>
            </div>
        </header>
        
        <div class="container my-5">
            <div class="row mb-4">
                <div class="col-md-8 mx-auto">
                    <div class="search-container">
                        <form action="home" method="get" class="d-flex">
                            <input type="text" name="search" class="form-control me-2" 
                                   placeholder="Cari buku berdasarkan nama, tipe, jenis, atau penulis..." 
                                   value="${param.search}">
                            <button type="submit" class="btn btn-primary">Cari</button>
                        </form>
                    </div>
                </div>
            </div>

            <h2 class="text-center mb-4">Daftar Buku</h2>
            <% if (books != null && !books.isEmpty()) { %>
                <div class="row">
                    <% for (Buku book : books) { %>
                    <div class="col-md-4">
                        <div class="card h-100">
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
                                } else {
                                    fileToUse = "assets/default.jpg";
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
                                    <strong class="<%= book.getstatus_booking() ? "text-danger" : "text-success" %>">
                                        Status: <%= book.getstatus_booking() ? "Tidak Tersedia" : "Tersedia" %>
                                    </strong>
                                </p>
                            </div>
                            <div class="card-footer bg-transparent border-top-0">
                                <% if (!book.getstatus_booking()) { %>
                                    <a href="${pageContext.request.contextPath}/Booking?buku_id=<%= book.getbuku_id() %>" 
                                       class="btn btn-primary w-100">Booking</a>
                                <% } else { %>
                                    <button class="btn btn-secondary w-100" disabled>Tidak Tersedia</button>
                                <% } %>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
            <% } else { %>
                <div class="alert alert-info text-center">
                    Tidak ada buku yang ditemukan.
                </div>
            <% } %>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
