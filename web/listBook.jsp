<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList,java.sql.ResultSet, model.Buku, db.JDBC" %>
<!DOCTYPE html>
<html>
<head>
    <title>Daftar Buku</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h1>Daftar Buku</h1>
        <form method="POST" action="listBookController">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Nama Buku</th>
                        <th>Tipe Buku</th>
                        <th>Jenis Buku</th>
                        <th>Tanggal Terbit</th>
                        <th>Author</th>
                        <th>Rak Buku</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        JDBC db = new JDBC();
                        ArrayList<Buku> listBuku = new ArrayList<>();
                        String sql = "SELECT * from buku";

                        ResultSet rs = db.getData(sql);

                        while (rs.next()) {
                            Buku buku = new Buku(
                                rs.getInt("buku_id"),
                                rs.getString("nama_buku"),
                                rs.getString("tipe_buku"),
                                rs.getString("jenis_buku"),
                                rs.getString("tgl_terbit"),
                                rs.getString("author"),
                                rs.getInt("rakbuku_id_fk")
                            );
                            listBuku.add(buku);
                        }
                        rs.close();
                        db.disconnect();
                        if (listBuku == null || listBuku.isEmpty()) {
                    %>
                            <tr>
                                <td colspan="6">Tidak ada buku tersedia.</td>
                            </tr>
                    <%
                        } else {
                            for (Buku buku : listBuku) {
                    %>
                                <tr>
                                    <td><%= buku.getNamaBuku() %></td>
                                    <td><%= buku.getTipeBuku() %></td>
                                    <td><%= buku.getJenisBuku() %></td>
                                    <td><%= buku.getTglTerbit() %></td>
                                    <td><%= buku.getAuthor() %></td>
                                    <td><%= buku.getJenisRak() %></td>
                                </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
        </form>

    </div>
</body>
</html>
