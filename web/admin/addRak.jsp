<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, db.JDBC, java.sql.ResultSet, java.sql.SQLException" %>
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
    <title>Tambah Rak Buku</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 600px;
            margin-top: 50px;
        }
        .form-control {
            border-radius: 10px;
        }
        .btn-primary {
            border-radius: 10px;
        }
        .btn-secondary {
            border-radius: 10px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        h3 {
            color: #007bff;
            text-align: center;
        }
        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .button-group .btn {
            width: auto;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card p-4 shadow-sm rounded">
            <h3>Tambah Rak Buku Baru</h3>
            <form action="/perpustakaan/addRak" method="post">
                <div class="form-group">
                    <label for="jenisRak">Jenis Rak</label>
                    <input type="text" name="input-jenis_rak" id="jenisRak" class="form-control" required placeholder="Masukkan jenis rak">
                </div>
                <div class="form-group">
                    <label for="lokasiRak">Lokasi Rak</label>
                    <input type="text" name="input-lokasi_rak" id="lokasiRak" class="form-control" required placeholder="Masukkan lokasi rak">
                </div>
                <div class="button-group">
                    <button type="submit" class="btn btn-primary w-48">Tambah Rak</button>
                    <a href="/perpustakaan/dashboard" class="btn btn-secondary w-48">Kembali</a>
                </div>
            </form>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
