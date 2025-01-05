<%-- 
    Document   : navbar
    Created on : Jan 5, 2025, 7:40:43 PM
    Author     : maxeef
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
  <div class="container-fluid">
    <a class="navbar-brand" href="home">Perpustakaan</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link" href="home">Beranda</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="listBooks">Daftar Buku</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="booking.jsp">Booking</a>
        </li>
      </ul>
      <div class="btn-group">
        <a href="logoutController" class="btn btn-danger">Logout</a>
      </div>
    </div>
  </div>
</nav>

