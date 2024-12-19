<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 500px;
            margin-top: 100px;
        }
        .card {
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        h3 {
            color: #007bff;
        }
        .btn {
            border-radius: 5px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .alert {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
            <div class="card p-4 shadow-sm rounded">
                <h3 class="text-center">Login</h3>
                <form action="loginController" method="post">
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Login</button>
                </form>
                <div class="text-center">
                    <p class="card-text mb-2">Belum mempunyai akun?</p>
                    <a href="register.jsp" class="btn btn-warning w-100">Daftar</a>
                </div>
            </div>
        </div>

        <%
            String error = request.getParameter("error");
            if ("1".equals(error)) {
        %>
        <div class="alert alert-danger mt-3" role="alert">
            Invalid email or password!
        </div>
        <% 
            } else if ("2".equals(error)) {
        %>
        <div class="alert alert-danger mt-3" role="alert">
            Database connection failed. Please try again later.
        </div>
        <% 
            } else if ("notLoggedIn".equals(error)) {
        %>
        <div class="alert alert-danger mt-3" role="alert">
            You need to login first.
        </div>
        <% 
            }
        %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
