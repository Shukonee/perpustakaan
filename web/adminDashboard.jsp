<%
        if (session == null || session.getAttribute("isLoggedIn") == null || !(Boolean) session.getAttribute("isLoggedIn")) {
        response.sendRedirect("login.jsp?error=notLoggedIn");
        return;
    }
    
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("index.jsp?error=notAuthorized");
        return;
    }else if (role.equals("user")){
        response.sendRedirect("home.jsp?error=notAuthorized");
        return;
    }
%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.Buku" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h1>Admin Dashboard</h1>
        <a href="addBook.jsp" class="btn btn-primary mb-4">Tambah Buku</a>

        <!-- Tampilkan Daftar Buku -->
        <h3>Daftar Buku</h3>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Nama Buku</th>
                    <th>Tipe Buku</th>
                    <th>Jenis Buku</th>
                    <th>Tanggal Terbit</th>
                    <th>Author</th>
                    <th>Rak Buku</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Ambil daftar buku dari database
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
                                    <a href="editBook.jsp?bukuId=<%= buku.getBukuId() %>" class="btn btn-warning btn-sm">Edit</a>
                                    <a href="deleteBookController?bukuId=<%= buku.getBukuId() %>" class="btn btn-danger btn-sm">Hapus</a>
                                </td>
                            </tr>
                <%
                        }
                    } else {
                %>
                        <tr>
                            <td colspan="7">Tidak ada buku di dalam daftar.</td>
                        </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>

