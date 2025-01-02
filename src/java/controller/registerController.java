package controller;

import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import db.JDBC;

@WebServlet("/register")
public class registerController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String namaDepan = request.getParameter("namaDepan");
        String namaBelakang = request.getParameter("namaBelakang");
        String tanggalLahir = request.getParameter("tanggalLahir");

        // Validasi password
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("register.jsp?error=2"); 
            return;
        }

        JDBC db = new JDBC();

        if (!db.isConnected) {
            response.sendRedirect("register.jsp?error=3"); 
            return;
        }

        try {
            // Cek apakah email sudah terdaftar
            String checkEmailSql = "SELECT user_id FROM account WHERE email = '" + email + "'";
            ResultSet rs = db.getData(checkEmailSql);
            if (rs.next()) {
                response.sendRedirect("register.jsp?error=1"); 
                return;
            }

            // Insert akun baru
            String insertAccountSql = "INSERT INTO account (email, password) VALUES ('" + email + "', SHA2('" + password + "', 256))";
            db.runQuery(insertAccountSql);  

            // Ambil ID akun yang baru saja dimasukkan
            rs = db.getData("SELECT user_id FROM account WHERE email = '" + email + "'");
            rs.next();
            int userId = rs.getInt("user_id");

            // Insert data member
            String insertMemberSql = "INSERT INTO member (nama_depan, nama_belakang, tanggal_lahir, account_id_fk) "
                    + "VALUES ('" + namaDepan + "', '" + namaBelakang + "', '" + tanggalLahir + "', " + userId + ")";
            db.runQuery(insertMemberSql);  

            response.sendRedirect("login.jsp"); 
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=3");  
        } finally {
            db.disconnect();  
        }

    }
}
