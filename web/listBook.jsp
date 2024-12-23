<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList,java.sql.ResultSet, model.Buku, db.JDBC" %>
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
            max-width: 800px;
            margin-top: 50px;
            padding-top: 80px; 
        }
        h1 {
            color: #007bff;
            text-align: center;
        }
        .card {
            padding: 30px;
        }
        .table th, .table td {
            vertical-align: middle;
        }
    </style>
</head>
<body>
    <!--Start Header-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
          <div class="container-fluid">
            <a class="navbar-brand" href="home.jsp">Perpustakaan</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
              <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                  <a class="nav-link active" aria-current="page" href="home.jsp">Beranda</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link active" href="listBook.jsp">Daftar Buku</a>
                </li>
<!--                <li class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    Dropdown
                  </a>
                  <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <li><a class="dropdown-item" href="#">Action</a></li>
                    <li><a class="dropdown-item" href="#">Another action</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="#">Something else here</a></li>
                  </ul>
                </li>-->
              </ul>
              <form class="d-flex p-1">
                <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success" type="submit">Search</button>
              </form>
              <div class="btn-group">
                <a href="logoutController" class="btn btn-outline-danger">Logout</a>
              </div>
            </div>
          </div>
        </nav>
    <!--End Header-->
    
    <div class="container">
        <div class="card shadow-sm rounded">
            <h1>Daftar Buku</h1>
            <table class="table table-bordered table-striped">
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
                                <td colspan="6" class="text-center">Tidak ada buku tersedia.</td>
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
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
