<%-- 
    Document   : profile
    Created on : Jan 6, 2025, 7:11:38 PM
    Author     : dipa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp" />
        <div class="container mt-5">
            <% Member member = (Member)request.getAttribute("member"); %>
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">Member Details</h5>
                    <p>Name: <%= member.getNama_depan() + " " + member.getNama_belakang() %></p>
                    <p>Birth Date: <%= member.getTanggal_lahir() %></p>
                </div>
            </div>

            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Booked Books</h5>
                    <% List<Booking> bookings = (List<Booking>)request.getAttribute("bookings"); %>
                    <% if (bookings != null && !bookings.isEmpty()) { %>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Book Name</th>
                                    <th>Expiry Date</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Booking booking : bookings) { %>
                                    <tr>
                                        <td><%= booking.getBukuDetail().getBuku().getnama_buku() %><%= booking.getBooking_id() %></td>
                                        <td><%= booking.getExpired_date() %></td>
                                        <td>
                                            <form action="Booking" method="POST">
                                            <input type="hidden" name="return" value="true">
                                            <input type="hidden" name="bukuDetails" value="<%= booking.getBukuDetails_id_fk() %>">
                                            <button class="btn btn-warning">Kembalikan Buku</button>
                                        </form>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    <% } else { %>
                        <p>No books currently booked.</p>
                    <% } %>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
