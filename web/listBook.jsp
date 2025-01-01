<%@ page import="controller.listBookController, java.util.List" %>
<%@ page import="model.Buku" %>

<%
    String search = request.getParameter("search");
    listBookController controller = new listBookController();
    List<Buku> books = controller.getBooks(search);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Daftar Buku</title>
    <style>
        .search-box {
            margin-top: 20px;
        }
        .table {
            border-collapse: collapse;
            width: 100%;
        }
        .table th, .table td {
            border: 1px solid black;
            padding: 10px;
            text-align: left;
        }
    </style>
</head>
<body>
    <h1>Daftar Buku</h1>
    
    <!-- Search Box -->
    <div class="search-box">
        <form action="listBook.jsp" method="get">
            <input type="text" name="search" placeholder="Cari buku..." value="<%= search != null ? search : "" %>" />
            <button type="submit">Cari</button>
        </form>
    </div>

    <!-- Table Displaying Book List -->
    <table class="table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nama Buku</th>
                <th>Tipe Buku</th>
                <th>Jenis Buku</th>
                <th>Tanggal Terbit</th>
                <th>Author</th>
                <th>Jenis Rak</th>
            </tr>
        </thead>
        <tbody>
            <% 
                if (books != null && !books.isEmpty()) {
                    for (Buku book : books) { 
            %>
            <tr>
                <td><%= book.getBukuId() %></td>
                <td><%= book.getNamaBuku() %></td>
                <td><%= book.getTipeBuku() %></td>
                <td><%= book.getJenisBuku() %></td>
                <td><%= book.getTglTerbit() %></td>
                <td><%= book.getAuthor() %></td>
                <td><%= book.getJenisRak() %></td>
            </tr>
            <% 
                    }
                } else { 
            %>
            <tr>
                <td colspan="7">Tidak ada buku ditemukan.</td>
            </tr>
            <% 
                } 
            %>
        </tbody>
    </table>
</body>
</html>
