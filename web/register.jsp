<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Halaman Registrasi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 500px;
            margin-top: 50px;
        }
        .card {
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        .card-body {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        h3 {
            color: #007bff;
            margin-bottom: 20px;
        }
        .btn {
            border-radius: 5px;
        }
        .form-group {
            margin-bottom: 15px;
            width: 100%;
        }
        .alert {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card p-4 shadow-sm rounded">
            <h3 class="text-center">Formulir Registrasi</h3>
            <form action="registerController" method="post" class="w-100">
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Konfirmasi Password:</label>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                </div>
                <div class="form-group">
                    <label for="namaDepan">Nama Depan:</label>
                    <input type="text" class="form-control" id="namaDepan" name="namaDepan" required>
                </div>
                <div class="form-group">
                    <label for="namaBelakang">Nama Belakang:</label>
                    <input type="text" class="form-control" id="namaBelakang" name="namaBelakang" required>
                </div>
                <div class="form-group">
                    <label for="tanggalLahir">Tanggal Lahir:</label>
                    <input type="date" class="form-control" id="tanggalLahir" name="tanggalLahir" required>
                </div>
                <button type="submit" class="btn btn-primary w-100 mt-3">Daftar</button>
            </form>
            <div class="text-center">
                <p class="card-text mb-2">Sudah mempunyai akun?</p>
                <a href="login.jsp" class="btn btn-warning w-100">Masuk</a>
            </div>
        </div>

        <%
            String error = request.getParameter("error");
            if ("1".equals(error)) {
        %>
        <div class="alert alert-danger mt-3" role="alert">
            Email sudah terdaftar!
        </div>
        <% 
            } else if ("2".equals(error)) {
        %>
        <div class="alert alert-danger mt-3" role="alert">
            Password tidak cocok!
        </div>
        <% 
            }
        %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
