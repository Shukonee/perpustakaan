<%-- 
    Document   : home
    Created on : 8 Dec 2024, 00.33.29
    Author     : farre
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session == null || session.getAttribute("isLoggedIn") == null || !(Boolean) session.getAttribute("isLoggedIn")) {
        response.sendRedirect("login.jsp?error=notLoggedIn");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
           
        <title>Home</title>
    </head>
    <body>
        <!--Start Header-->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Perpustakaan Jaya Abadi</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                  <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                  <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                      <a class="nav-link active" aria-current="page" href="welcome.jsp">Home</a> <!--testing link-->
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" href="/about/">About</a>
                    </li>
                    <li class="nav-item dropdown">
                      <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Other
                      </a>
                      <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#">Contact</a></li>
                        <li><a class="dropdown-item" href="#">Galery</a></li> 
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="#">Sosmed</a></li>
                      </ul>
                    </li> 
                  </ul>
                  <form class="d-flex justify-content-center py-3" style="padding:10px;">
                    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-light" type="submit">Search</button>
                  </form>
                  <div class="btn-group">
                    <a href="logoutController" class="btn btn-outline-danger">Logout</a>
                  </div>
                </div>
            </div>
        </nav>
        <!--End Header-->
        
        <!--Start Carroussel-->
        <div class="container-fluid bg-dark text-light" style="height: 100vh ;">
          <!-- Carousel Image Start-->
          <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-indicators">
              <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
              <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
              <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>
            <div class="carousel-inner">
              <div class="carousel-item active">
                <img src="assets/ac7fc4b4-be72-48f1-a208-192fa8ae5753.jpg" class="d-block w-100" alt="Error Load Image" style="height: 500px;">
                <div class="carousel-caption" style="text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.5);">
                  <h5>Carrera GT engine made for race not street</h5>
                  <p>The Carrera GT is powered by a 5.7-liter V10 engine originally designed for a Le Mans racing program. This engine produces around 603 hp and allows the car to reach a top speed of 330 km/h (205 mph).</p>
                </div>
              </div>
              <div class="carousel-item">
                <img src="assets/Porche Carrera.jpg" class="d-block w-100" alt="Error Load Image" style="height: 500px;">
                <div class="carousel-caption" style="text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.5);">
                  <h5>Challenging to Drive</h5>
                  <p>It’s often described as one of the most demanding supercars to drive. With immense power, rear-wheel drive, and the lack of advanced electronic aids like modern traction control, it's a car meant for skilled drivers.</p>
                </div>
              </div>
              <div class="carousel-item">
                <img src="assets/Porsche.jpg" class="d-block w-100" alt="Error Load Image" style="height: 500px;">
                <div class="carousel-caption" style="text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.5);">
                  <h5>Tragic Controversy</h5>
                  <p>The Carrera GT gained global attention following the tragic accident involving actor Paul Walker in 2013. This incident highlighted the car's immense power and potential danger when mishandled.</p>
                </div>
              </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
              <span class="carousel-control-prev-icon" aria-hidden="true"></span>
              <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
              <span class="carousel-control-next-icon" aria-hidden="true"></span>
              <span class="visually-hidden">Next</span>
            </button>
          </div>
            <!--End Carrousel-->
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    </body>
</html>
