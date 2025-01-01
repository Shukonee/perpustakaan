/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import db.JDBC;
import model.Buku;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ghifary Ahmad
 */
@WebServlet("/listBooks")
public class listBookController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the search parameter
        String search = request.getParameter("search");

        // Get the books from the database
        List<Buku> books = getBooks(search);

        // Set the books and search term as request attributes
        request.setAttribute("books", books);
        request.setAttribute("search", search);

        // Forward to the listBook.jsp page for display
        request.getRequestDispatcher("listBook.jsp").forward(request, response);
    }

    public List<Buku> getBooks(String search) {
        List<Buku> books = new ArrayList<>();
        JDBC db = new JDBC();

        if (db.isConnected) {
            String sql = "SELECT * FROM buku";
            if (search != null && !search.isEmpty()) {
                sql = "SELECT * FROM buku WHERE nama_buku LIKE ? OR tipe_buku LIKE ? OR jenis_buku LIKE ? OR author LIKE ?";
            }

            try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
                if (search != null && !search.isEmpty()) {
                    String searchPattern = "%" + search + "%";
                    stmt.setString(1, searchPattern);
                    stmt.setString(2, searchPattern);
                    stmt.setString(3, searchPattern);
                    stmt.setString(4, searchPattern);
                }

                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        Buku book = new Buku(
                                rs.getInt("buku_id"),
                                rs.getString("nama_buku"),
                                rs.getString("tipe_buku"),
                                rs.getString("jenis_buku"),
                                rs.getString("tgl_terbit"),
                                rs.getString("author"),
                                rs.getInt("rakbuku_id_fk")
                        );
                        books.add(book);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                db.disconnect();
            }
        }

        return books;
    }
}
