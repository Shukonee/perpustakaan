<!DOCTYPE html>
<html>
<head>
    <title>Halaman Registrasi</title>
</head>
<body>
    <h1>Formulir Registrasi</h1>
    <form action="registerController" method="post">
        <label for="email">Email:</label><br>
        <input type="email" id="email" name="email" required><br><br>

        <label for="password">Password:</label><br>
        <input type="password" id="password" name="password" required><br><br>

        <label for="confirmPassword">Konfirmasi Password:</label><br>
        <input type="password" id="confirmPassword" name="confirmPassword" required><br><br>

        <label for="namaDepan">Nama Depan:</label><br>
        <input type="text" id="namaDepan" name="namaDepan" required><br><br>

        <label for="namaBelakang">Nama Belakang:</label><br>
        <input type="text" id="namaBelakang" name="namaBelakang" required><br><br>

        <label for="tanggalLahir">Tanggal Lahir:</label><br>
        <input type="date" id="tanggalLahir" name="tanggalLahir" required><br><br>

        <button type="submit">Daftar</button>
    </form>

    <% 
        String error = request.getParameter("error");
        if ("1".equals(error)) {
            out.println("<p style='color:red;'>Email sudah terdaftar!</p>");
        } else if ("2".equals(error)) {
            out.println("<p style='color:red;'>Password tidak cocok!</p>");
        }
    %>
</body>
</html>
