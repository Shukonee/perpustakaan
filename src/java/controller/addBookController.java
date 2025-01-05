package controller;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import db.JDBC;

@WebServlet("/addBookController")
public class addBookController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nama_buku = request.getParameter("nama_buku");
        String tipe_buku = request.getParameter("tipe_buku");
        String jenis_buku = request.getParameter("jenis_buku");
        String tgl_terbit = request.getParameter("tgl_terbit");
        String author = request.getParameter("author");
        String rakbuku_idStr = request.getParameter("rakbuku_id");
        System.out.println("Rak Buku ID: "+rakbuku_idStr);
        // Cek apakah rak buku terpilih
        if (rakbuku_idStr == null || rakbuku_idStr.isEmpty()) {
            response.sendRedirect("admin/addBook.jsp?error=rakbuku_idEmpty"); 
            return;
        }

        int rakbuku_id = 0;
        try {
            rakbuku_id = Integer.parseInt(rakbuku_idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("admin/addBook.jsp?error=invalidrakbuku_id_fk"); 
            return;
        }

        // Cek apakah user adalah admin
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        if (role == null || !role.equals("admin")) {
            response.sendRedirect("login.jsp?error=notLoggedIn");
            return;
        }
        
        JDBC db = new JDBC();
        if (!db.isConnected) {
            response.sendRedirect("admin/addBook.jsp?error=2"); 
            return;
        }

        try {
            String sql = "INSERT INTO buku (nama_buku, tipe_buku, jenis_buku, tgl_terbit, author, rakbuku_id_fk) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setString(1, nama_buku);
            stmt.setString(2, tipe_buku);
            stmt.setString(3, jenis_buku);
            stmt.setString(4, tgl_terbit);
            stmt.setString(5, author);
            stmt.setInt(6, rakbuku_id);

            System.out.println("Executing query: " + sql);
            System.out.println("Parameters: " + nama_buku + ", " + tipe_buku + ", " + jenis_buku + ", " + tgl_terbit + ", " + author + ", " + rakbuku_id);

            int result = stmt.executeUpdate();
            if (result > 0) {
                System.out.println("Redirecting to listBookController...");
                response.sendRedirect("dashboard");
            } else {
                response.sendRedirect("admin/addBook.jsp?error=1");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin/addBook.jsp?error=2"); 
        } finally {
            db.disconnect(); 
        }
    }
}
