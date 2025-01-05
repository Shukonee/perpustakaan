<%@ page import="controller.listBookController, java.util.List" %>
<%@ page import="model.Buku" %>

<%
    String search = request.getParameter("search");
    listBookController controller = new listBookController();
    List<Buku> books = controller.getBooks(search);
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daftar Buku</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 1200px;
            margin-top: 50px;
        }
        .card {
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        h1, h3 {
            color: #007bff;
        }
        .btn {
            border-radius: 5px;
        }
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #f9f9f9;
        }
        .table-bordered {
            border: 1px solid #dee2e6;
        }
        .table td, .table th {
            padding: 15px;
        }
    </style>
</head>
<body>
<!--Start Header-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
          <div class="container-fluid">
            <a class="navbar-brand" href="home">Perpustakaan</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
              <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                  <a class="nav-link" href="home">Beranda</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link active" aria-current="page" href="listBooks">Daftar Buku</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="booking.jsp">Booking</a>
                </li>
              </ul>
              <div class="btn-group">
                <a href="logoutController" class="btn btn-danger">Logout</a>
              </div>
            </div>
          </div>
        </nav>
        <!--End Header-->
    <div class="container">
        <div class="text-center mb-4">
            <h1>Daftar Buku</h1>
            <p class="lead text-secondary">Kelola daftar buku perpustakaan</p>
        </div>

        <div class="d-flex justify-content-between align-items-center mb-4">
            <form action="listBook.jsp" method="get" class="d-flex w-50">
                <input type="text" name="search" class="form-control me-2" placeholder="Cari buku berdasarkan nama, tipe, jenis, atau author..." value="<%= search != null ? search : "" %>">
                <button type="submit" class="btn btn-primary">Cari</button>
            </form>
        </div>

        <div class="card mb-4">
            <table class="table table-striped table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nama Buku</th>
                        <th>Tipe Buku</th>
                        <th>Jenis Buku</th>
                        <th>Tanggal Terbit</th>
                        <th>Author</th>
                        <th>Jenis Rak</th>
                        <th>Status Buku</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        if (books != null && !books.isEmpty()) {
                            for (Buku book : books) { 
                    %>
                    <tr>
                        <td><%= book.getbuku_id() %></td>
                        <td><%= book.getnama_buku() %></td>
                        <td><%= book.gettipe_buku() %></td>
                        <td><%= book.getjenis_buku() %></td>
                        <td><%= book.gettgl_terbit() %></td>
                        <td><%= book.getAuthor() %></td>
                        <td><%= book.getJenisRak() %></td>
                        <td>
                            <%--<%= book.getstatus_booking() ? "Tidak Tersedia" : "Tersedia" %>--%>
                            <% if (book.getstatus_booking()) { %>
                            <p>Tidak Tersedia</p>
                            <% }else{ %>
                            <button class = "btn btn-secondary" href = "">Booking</button>
                            <% } %>
                        </td>
                    </tr>
                    <% 
                            }
                        } else { 
                    %>
                    <tr>
                        <td colspan="7" class="text-center">Tidak ada buku ditemukan.</td>
                    </tr>
                    <% 
                        } 
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
