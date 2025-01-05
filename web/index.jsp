<% String error = request.getParameter("error"); %>
<% if ("notAuthorized".equals(error)) { %>
    <div class="alert alert-danger text-center mt-3">Anda tidak memiliki izin untuk mengakses halaman ini.</div>
<% } %>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 600px;
            margin-top: 100px;
            text-align: center;
        }
        h1 {
            color: #007bff;
            margin-bottom: 20px;
        }
        .btn {
            border-radius: 5px;
            margin-top: 10px;
        }
        .alert {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Selamat Datang di Perpustakaan Jaya Abadi</h1>
        <p>Silakan login untuk melanjutkan.</p>

<!--        <a href="login.jsp"><button class="btn btn-primary w-100">Login</button></a>
        <a href="/register"><button class="btn btn-warning w-100 mt-3">Register</button></a>-->
        <!--<form action="${pageContext.request.contextPath}/AuthController" method="GET">-->
        <form action="${pageContext.request.contextPath}/Authentication" method="GET">
            <input type="hidden" name="action" value="login">
            <button class="btn btn-primary w-100">Login</button>
        </form>
        <form action="${pageContext.request.contextPath}/Authentication" method="GET">
            <input type="hidden" name="action" value="register">
            <button class="btn btn-warning w-100 mt-3">Register</button>
        </form>
</div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
