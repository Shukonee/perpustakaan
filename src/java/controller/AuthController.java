/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import db.JDBC;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author maxeef
 */
@WebServlet(name = "AuthController", urlPatterns = {"/Authentication"})
public class AuthController extends HttpServlet {
    @Override
    protected void doGet (HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("login".equals(action)) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }else if ("register".equals(action)) {
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost (HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("login".equals(action)) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            JDBC db = new JDBC();

            if (!db.isConnected) {
                response.sendRedirect("login.jsp?error=2"); // Koneksi gagal
                return;
            }

            try {
                String sql = "SELECT user_id FROM account WHERE email = ? AND password = SHA2(?, 256)";
                PreparedStatement stmt = db.getConnection().prepareStatement(sql);
                stmt.setString(1, email);
                stmt.setString(2, password);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    int userId = rs.getInt("user_id");
                    HttpSession session = request.getSession();
                    session.setAttribute("userId", userId);
                    session.setAttribute("isLoggedIn", true);

                    String role; 

                    sql = "SELECT * FROM admin WHERE account_id_fk = ?";
                    stmt = db.getConnection().prepareStatement(sql);
                    stmt.setInt(1, userId);
                    ResultSet adminResult = stmt.executeQuery();

                    if (adminResult.next()) {
                        role = "admin"; 
                    } else {
                        role = "member";
                    }

                    session.setAttribute("role", role);

                    if ("admin".equals(role)) {
                        response.sendRedirect("dashboard");
                    } else {
                        response.sendRedirect("home"); // jika user
                    }
                } else {
                    response.sendRedirect("login.jsp?error=1"); 
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("login.jsp?error=2"); 
            } finally {
                db.disconnect(); 
            }
        }else if ("register".equals(action)) {
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
    
}
