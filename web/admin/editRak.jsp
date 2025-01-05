<%-- 
    Document   : editRak
    Created on : 23 Dec 2024, 17.10.42
    Author     : farre
--%>

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
    <title>Edit Rak Buku</title>
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
            <h3>Edit Rak Buku</h3>
            <%
                String rakId = request.getParameter("rakId");
                JDBC db = new JDBC();
                ResultSet rs = null;
                
                try {
                    rs = db.getData("SELECT * FROM rakbuku_id_fk WHERE rakbuku_id_fk = " + rakId);
                    if (rs.next()) {
                        String jenisRak = rs.getString("jenis_rak");
                        String lokasiRak = rs.getString("lokasi_rak");
            %>
            <form action="/perpustakaan/editRak" method="POST">
                <input type="hidden" name="rakId" value="<%= rakId %>">

                <div class="form-group">
                    <label for="jenis_rak">Jenis Rak</label>
                    <input type="text" name="jenis_rak" id="jenis_rak" class="form-control" 
                           value="<%= jenisRak %>" required>
                </div>

                <div class="form-group">
                    <label for="lokasi_rak">Lokasi Rak</label>
                    <input type="text" name="lokasi_rak" id="lokasi_rak" class="form-control" 
                           value="<%= lokasiRak %>" required>
                </div>

                <div class="button-group">
                    <button type="submit" class="btn btn-primary w-48">Perbarui Rak</button>
                    <a href="/perpustakaan/dashboard" class="btn btn-secondary w-48">Kembali</a>
                </div>
            </form>
            <%
                    } else {
            %>
            <p class="text-danger text-center">Rak Buku dengan ID <%= rakId %> tidak ditemukan.</p>
            <%
                    }
                } catch (SQLException e) {
                    out.println("<p class='text-danger text-center'>Error: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    try {
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
