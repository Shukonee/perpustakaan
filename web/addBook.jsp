<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, db.JDBC, java.sql.ResultSet, java.sql.SQLException" %>
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
        <form action="addBookController" method="post">
            <div class="form-group">
                <label for="namaBuku">Nama Buku</label>
                <input type="text" name="namaBuku" id="namaBuku" class="form-control" required>
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
                <input type="text" name="jenisBuku" id="jenisBuku" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="tglTerbit">Tanggal Terbit</label>
                <input type="date" name="tglTerbit" id="tglTerbit" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="author">Penulis</label>
                <input type="text" name="author" id="author" class="form-control" required>
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
            <button type="submit" class="btn btn-primary">Tambah Buku</button>
        </form>
    </div>
</body>
</html>
