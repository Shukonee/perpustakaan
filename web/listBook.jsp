<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, db.JDBC, model.Buku" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daftar Buku</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h3>Daftar Buku</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>Nama Buku</th>
                    <th>Tipe Buku</th>
                    <th>Jenis Buku</th>
                    <th>Tanggal Terbit</th>
                    <th>Penulis</th>
                    <th>Rak Buku</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Buku> bukuList = (List<Buku>) request.getAttribute("bukuList");
                    for (Buku buku : bukuList) {
                %>
                <tr>
                    <td><%= buku.getNamaBuku() %></td>
                    <td><%= buku.getTipeBuku() %></td>
                    <td><%= buku.getJenisBuku() %></td>
                    <td><%= buku.getTglTerbit() %></td>
                    <td><%= buku.getAuthor() %></td>
                    <td><%= buku.getJenisRak() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
