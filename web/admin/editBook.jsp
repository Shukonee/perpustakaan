<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="db.JDBC" %>
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
    <title>Edit Buku</title>
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
            <h3>Edit Buku</h3>
            <%
                String buku_id = request.getParameter("buku_id");
                JDBC db = new JDBC();
                ResultSet rs = null;
                ResultSet rakResultSet = null;
                
                try {
                    rs = db.getData("SELECT * FROM buku WHERE buku_id = " + buku_id);
                    if (rs.next()) {
                        // Store the book data in variables
                        String nama_buku = rs.getString("nama_buku");
                        String tipe_buku = rs.getString("tipe_buku");
                        String jenis_buku = rs.getString("jenis_buku");
                        String tgl_terbit = rs.getString("tgl_terbit");
                        String author = rs.getString("author");
                        int currentRakId = rs.getInt("rakbuku_id_fk");
                        
                        // Close the first ResultSet
                        rs.close();
                        
                        // Get rak data
                        rakResultSet = db.getData("SELECT * FROM rakbuku");
            %>
            <form action="/perpustakaan/editBook" method="POST">
                <input type="hidden" name="buku_id" value="<%= buku_id %>">

                <div class="form-group">
                    <label for="nama_buku">Nama Buku</label>
                    <input type="text" name="nama_buku" id="nama_buku" class="form-control" 
                           value="<%= nama_buku %>" required>
                </div>

                <div class="form-group">
                    <label for="tipe_buku">Tipe Buku</label>
                    <select name="tipe_buku" id="tipe_buku" class="form-control" required>
                        <option value="Fisik" <%= tipe_buku.equals("Fisik") ? "selected" : "" %>>Fisik</option>
                        <option value="Online" <%= tipe_buku.equals("Online") ? "selected" : "" %>>Online</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="jenis_buku">Jenis Buku</label>
                    <input type="text" name="jenis_buku" id="jenis_buku" class="form-control" 
                           value="<%= jenis_buku %>" required>
                </div>

                <div class="form-group">
                    <label for="tgl_terbit">Tanggal Terbit</label>
                    <input type="date" name="tgl_terbit" id="tgl_terbit" class="form-control" 
                           value="<%= tgl_terbit %>" required>
                </div>

                <div class="form-group">
                    <label for="author">Penulis</label>
                    <input type="text" name="author" id="author" class="form-control" 
                           value="<%= author %>" required>
                </div>

                <div class="form-group">
                    <label for="rakbuku_id">Rak Buku</label>
                    <select name="rakbuku_id" id="rakbuku_id" class="form-control" required>
                        <%
                            while (rakResultSet.next()) {
                                int rakId = rakResultSet.getInt("rakbuku_id");
                        %>
                        <option value="<%= rakId %>" <%= currentRakId == rakId ? "selected" : "" %>>
                            <%= rakResultSet.getString("jenis_rak") %>
                        </option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <div class="button-group">
                    <button type="submit" class="btn btn-primary w-48">Perbarui Buku</button>
                    <a href="/perpustakaan/dashboard" class="btn btn-secondary w-48">Kembali</a>
                </div>
            </form>
            <%
                    } else {
            %>
            <p class="text-danger text-center">Buku dengan ID <%= buku_id %> tidak ditemukan.</p>
            <%
                    }
                } catch (SQLException e) {
                    out.println("<p class='text-danger text-center'>Error: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    try {
                        if (rakResultSet != null) rakResultSet.close();
                        if (rs != null) rs.close();
                        if (db != null) db.disconnect();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>