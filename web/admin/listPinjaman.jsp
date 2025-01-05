<%-- 
    Document   : listPinjaman
    Created on : 6 Jan 2025, 03.16.25
    Author     : alfin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Booking" %>
<%@ page import="java.util.ArrayList" %>
<%
    ArrayList<Booking> bookings = (ArrayList<Booking>) request.getAttribute("bookingList");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Daftar Booking</h1>
    
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Tanggal Booking</th>
            <th>Tanggal Expired</th>
            <th>Member ID</th>
            <th>Buku Detail ID</th>
            <th>Aksi</th>
        </tr>
        <% for (Booking booking : bookings) { %>
            <tr>
                <td><%= booking.getBooking_id()%></td>
                <td><%=booking.getBooking_date()%></td>
                <td><%=booking.getExpired_date()%></td>
                <td><%=booking.getMember()%> </td>
                <td><%=booking.getBukuDetail().getBuku().getnama_buku()%></td>
                <td>
                    <a href="booking/edit?id=${booking.booking_id}">Edit</a>
                    <a href="booking/delete?id=${booking.booking_id}" onclick="return confirm('Yakin ingin menghapus?')">Hapus</a>
                </td>
            </tr>
        <% } %>
    </table>
    
    <a href="booking/create">Tambah Booking Baru</a>
</body>
</html>
