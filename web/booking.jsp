<%-- 
    Document   : booking
    Created on : 2 Jan 2025, 19.31.37
    Author     : farre
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Buku" %>
<%@ page import="model.BukuDetails" %>
<%@ page import="java.io.File" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <title>Booking</title>
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp" />
        <!-- Content -->
        <div class="container mt-5 pt-5">
            <%
                Buku buku = (Buku) request.getAttribute("buku");
                BukuDetails bukuDetails = (BukuDetails) request.getAttribute("bukuDetails");
                
            %>
            <%
                String bookId = String.valueOf(buku.getbuku_id());
                String filePathJpg = "assets/book" + bookId + ".jpg";
                String filePathJpeg = "assets/book" + bookId + ".jpeg";
                String filePathPng = "assets/book" + bookId + ".png";

                File fileJpg = new File(application.getRealPath("/") + filePathJpg);
                File fileJpeg = new File(application.getRealPath("/") + filePathJpeg);
                File filePng = new File(application.getRealPath("/") + filePathPng);

                String fileToUse;
                if (fileJpg.exists()) {
                    fileToUse = filePathJpg;
                } else if (fileJpeg.exists()) {
                    fileToUse = filePathJpeg;
                } else if (filePng.exists()){
                    fileToUse = filePathPng;
                }else {
                    fileToUse = "assets/default.jpg"; // Fallback jika file tidak ditemukan
                }
            %>
            <div class="card mb-4">
                <div class="row g-0">
                    <div class="col-md-4">
                        <div class = "card">
                            <img src="<%= fileToUse %>" class="img-fluid rounded-start" alt="Gambar Buku">
                        </div>
<!--                        <img src=<%= fileToUse %>" class="img-fluid rounded-start" alt="Gambar Buku">
                        <img src="<%= fileToUse %>" alt="Cover Buku" class="card-img-top book-cover">-->
                    </div>
                    <div class="col-md-8">
                        <div class="card-body">
                            <h5 class="card-title"><%=buku.getnama_buku()%></h5>
                            <p class="card-text">description</p>
                            <p class="card-text">Keluhan Buku <%=bukuDetails.getId()%>: <%=bukuDetails.getKeluhan()%></p>
                        </div>
                    </div>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/Booking?bukuDetails=<%= bukuDetails.getId() %>" method="post">
                <input type="hidden" name="bookId" value="">
                <div class="mb-3">
                    <label for="deadline" class="form-label">Tanggal Deadline</label>
                    <input type="date" class="form-control" id="deadline" name="deadline" required>
                </div>
                <button type="submit" class="btn btn-primary">Booking</button>
            </form>
            
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    </body>
</html>
