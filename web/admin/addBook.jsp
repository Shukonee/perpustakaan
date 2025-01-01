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
    <title>Tambah Buku</title>
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
        .btn-secondary{
            border-radius: 10px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        h3 {
            color: #007bff;
            text-align: center;
            margin-bottom: 30px;
        }
        select.form-control {
            appearance: none;
            background-color: #ffffff;
            padding: 10px;
            border-radius: 10px;
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
            <h3>Tambah Buku Baru</h3>
            <form action="/perpustakaan/addBookController" method="post">
                <div class="form-group">
                    <label for="namaBuku">Nama Buku</label>
                    <input type="text" name="namaBuku" id="namaBuku" class="form-control" required placeholder="Masukkan nama buku">
                </div>
                <div class="form-group">
                    <label for="tipeBuku">Tipe Buku</label>
                    <select name="tipeBuku" id="tipeBuku" class="form-control" required>
                        <option value="fisik">Fisik</option>
                        <option value="online">Online</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="jenisBuku">Jenis Buku</label>
                    <input type="text" name="jenisBuku" id="jenisBuku" class="form-control" required placeholder="Masukkan jenis buku">
                </div>
                <div class="form-group">
                    <label for="tglTerbit">Tanggal Terbit</label>
                    <input type="date" name="tglTerbit" id="tglTerbit" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="author">Penulis</label>
                    <input type="text" name="author" id="author" class="form-control" required placeholder="Masukkan nama penulis">
                </div>
                <div class="form-group">
                    <label for="rakbuku">Rak Buku</label>
                    <select name="rakbuku" id="rakbuku" class="form-control" required>
                        <option value="">Pilih Rak Buku</option>
                        <% 
                            JDBC db = new JDBC();
                            ResultSet rs = null;
                            String sql = "SELECT rakbuku_id, jenis_rak FROM rakbuku";
                            try {
                                rs = db.getData(sql);
                                while (rs.next()) {
                                    int rakbukuId = rs.getInt("rakbuku_id");
                                    String jenisRak = rs.getString("jenis_rak");
                        %>
                                    <option value="<%= rakbukuId %>"><%= jenisRak %></option>
                        <% 
                                }
                            } catch (SQLException e) {
                                out.println("<p>Error loading racks: " + e.getMessage() + "</p>");
                            }
                        %>
                    </select>
                </div>
                <div class="button-group">
                    <button type="submit" class="btn btn-primary w-48">Tambah Buku</button>
                    <a href="/perpustakaan/dashboard" class="btn btn-secondary w-48">Kembali</a>
                </div>
            </form>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
