<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, db.JDBC, java.sql.ResultSet, java.sql.SQLException" %>\
<%
    if (session == null || session.getAttribute("isLoggedIn") == null || !(Boolean) session.getAttribute("isLoggedIn")) {
        response.sendRedirect("login.jsp?error=notLoggedIn");
        return;
    }
    
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp?error=notAuthorized");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Buku</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h3>Tambah Buku Baru</h3>
        <form action="addRak" method="post">
            <div class="form-group">
                <label for="input-jenis_rak">Jenis Rak</label>
                <input type="text" name="input-jenis_rak" id="jenisRak" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="input-lokasi_rak">Lokasi Rak</label>
                <input type="text" name="input-lokasi_rak" id="Lokasi Rak" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary">Tambah Rak</button>
        </form>
    </div>
</body>
</html>
