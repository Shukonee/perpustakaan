/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package controller;

import db.JDBC;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Buku;
import model.RakBuku;
/**
 *
 * @author farre
 */

@WebServlet("/home")
public class homeController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchQuery = request.getParameter("search");
        JDBC db = new JDBC();
        List<Buku> books = new ArrayList<>();

        try {
            String query = "SELECT buku_id, nama_buku, tipe_buku, jenis_buku, tgl_terbit, author, status_booking, rakbuku_id_fk FROM buku";
            if (searchQuery != null && !searchQuery.isEmpty()) {
                query += " WHERE nama_buku LIKE ? OR author LIKE ? OR jenis_buku LIKE ?";
            }

            PreparedStatement pstmt = db.getConnection().prepareStatement(query);
            if (searchQuery != null && !searchQuery.isEmpty()) {
                pstmt.setString(1, "%" + searchQuery + "%");
                pstmt.setString(2, "%" + searchQuery + "%");
                pstmt.setString(3, "%" + searchQuery + "%");
            }

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Buku book = new Buku(
                    rs.getInt("buku_id"),
                    rs.getString("nama_buku"),
                    rs.getString("tipe_buku"),
                    rs.getString("jenis_buku"),
                    rs.getString("tgl_terbit"),
                    rs.getString("author"),
                    rs.getInt("rakbuku_id_fk"),
                    rs.getBoolean("status_booking")
                );
                books.add(book);
            }
            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.disconnect();
        }

        // Kirim data buku ke home.jsp
        request.setAttribute("books", books);
        RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
        dispatcher.forward(request, response);
    }
}


