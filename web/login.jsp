<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <title>Login Page</title>
</head>
<body>
    <div class="container">
        <div class="row text-center align-items-center">
            <div class="col align-self-center">
                <div class="card text-center">
                    <div class="card-header">
                        Masuk
                    </div>
                    <div class="card-body ">
                        <form action="loginController" method="post">
                            <div class="form-group">
                                <label for="email">Email:</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                            <div class="form-group">
                                <label for="password">Password:</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Login</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <% 
        String error = request.getParameter("error");
        if ("1".equals(error)) {
            out.println("<p style='color:red;'>Invalid email or password!</p>");
        } else if ("2".equals(error)) {
            out.println("<p style='color:red;'>Database connection failed. Please try again later.</p>");
        } else if ("notLoggedIn".equals(error)) {
            out.println("<p style='color:red;'>You need to login first.</p>");
        }
    %>

</body>
</html>
