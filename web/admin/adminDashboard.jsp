<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.Buku, model.RakBuku" %>
<%
    if (session == null || session.getAttribute("isLoggedIn") == null || !(Boolean) session.getAttribute("isLoggedIn")) {
        response.sendRedirect("/perpustakaan/login.jsp?error=notLoggedIn");
        return;
    }
    
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("/perpustakaan/index.jsp?error=notAuthorized");
        return;
    } else if (role.equals("user")) {
        response.sendRedirect("/perpustakaan/home.jsp?error=notAuthorized");
        return;
    }
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
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
/*        .table th, .table td {
            border-radius: 10px;
        }*/
        .table-dark {
            background-color: #343a40;
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
    <div class="container">
        <div class="text-center mb-4">
            <h1>Admin Dashboard</h1>
            <p class="lead text-secondary">Kelola Buku dan Rak Buku Perpustakaan</p>
            <div class="buttonn-group">
                <a href="home" class="btn btn-primary">Beranda</a>
                <a href="logoutController" class="btn btn-danger">Keluar</a>
            </div>
        </div>
        
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="text-secondary">Daftar Buku</h3>
            <form action="dashboard" method="get" class="d-flex mb-4 w-50">
                <input type="text" name="search" class="form-control me-2" 
                       placeholder="Cari buku berdasarkan nama, tipe, jenis, atau author..." value="${param.search}">
                <button type="submit" class="btn btn-primary">Cari</button>
            </form>
            <a href="admin/addBook.jsp" class="btn btn-primary">Tambah Buku</a>
        </div>

        <div class="card mb-4">
            <table class="table table-striped table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>Nama Buku</th>
                        <th>Tipe Buku</th>
                        <th>Jenis Buku</th>
                        <th>Tanggal Terbit</th>
                        <th>Author</th>
                        <th>Rak Buku</th>
                        <th>Status Buku</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Buku> listBuku = (List<Buku>) request.getAttribute("listBuku");
                        if (listBuku != null && !listBuku.isEmpty()) {
                            for (Buku buku : listBuku) {
                    %>
                    <tr>
                        <td><%= buku.getNamaBuku() %></td>
                        <td><%= buku.getTipeBuku() %></td>
                        <td><%= buku.getJenisBuku() %></td>
                        <td><%= buku.getTglTerbit() %></td>
                        <td><%= buku.getAuthor() %></td>
                        <td><%= buku.getJenisRak() %></td>
                        <td>
                            <%= buku.getStatusBuku() ? "Tidak Tersedia" : "Tersedia" %>
                        </td>
                        <td>
                            <a href="admin/editBook.jsp?bukuId=<%= buku.getBukuId() %>" class="btn btn-warning btn-sm">Edit</a>
                            <a href="deleteBook?bukuId=<%= buku.getBukuId() %>" 
                               onclick="return confirm('Apakah Anda yakin ingin menghapus buku ini?')" 
                               class="btn btn-danger btn-sm">Hapus</a>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="7" class="text-center">Tidak ada buku di dalam daftar.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="text-secondary">Daftar Rak Buku</h3>
            <a href="admin/addRak.jsp" class="btn btn-primary">Tambah Rak Buku</a>
        </div>

        <div class="card mb-4">
            <table class="table table-striped table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>ID Rak</th>
                        <th>Jenis Rak</th>
                        <th>Lokasi</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<RakBuku> listRak = (List<RakBuku>) request.getAttribute("listRak");
                        if (listRak != null && !listRak.isEmpty()) {
                            for (RakBuku rak : listRak) {
                    %>
                    <tr>
                        <td><%= rak.getRakbuku_id() %></td>
                        <td><%= rak.getJenis_rak() %></td>
                        <td><%= rak.getLokasi_rak() %></td>
                        <td>
                            <a href="admin/editRak.jsp?rakId=<%= rak.getRakbuku_id() %>" class="btn btn-warning btn-sm">Edit</a>
                            <a href="deleteRak?rakId=<%= rak.getRakbuku_id() %>" 
                               onclick="return confirm('Apakah Anda yakin ingin menghapus rak ini? \n\
                                Buku pada rak ini akan terhapus otomatis jika anda menghapus rak ini.')" 
                               class="btn btn-danger btn-sm">Hapus</a>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="4" class="text-center">Tidak ada rak di dalam daftar.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
