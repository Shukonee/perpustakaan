<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
</head>
<body>
    <h1>Login</h1>
    <form action="loginController" method="post">
        <label>Email:</label><br>
        <input type="email" name="email" required><br>
        <label>Password:</label><br>
        <input type="password" name="password" required><br>
        <button type="submit">Login</button>
    </form>
    <% 
        String error = request.getParameter("error");
        if ("1".equals(error)) {
            out.println("<p style='color:red;'>Invalid email or password!</p>");
        } else if ("2".equals(error)) {
            out.println("<p style='color:red;'>Database connection failed. Please try again later.</p>");
        }
    %>
</body>
</html>
