<% String error = request.getParameter("error"); %>
<% if ("notAuthorized".equals(error)) { %>
    <div class="alert alert-danger">Anda tidak memiliki izin untuk mengakses halaman ini.</div>
<% } %>
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    
    <title>Welcome</title>
</head>
<body>
    <h1>Selamat Datang diPerpustakaan Jaya Abadi</h1>
    <p>Silakan login untuk melanjutkan.</p>
    <a href="login.jsp"><button>Masuk</button></a>
    <a href="register.jsp"><button>Daftar</button></a>
</body>
</html>
