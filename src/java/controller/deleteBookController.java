/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import db.JDBC;
import java.io.*;
import java.sql.PreparedStatement;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/deleteBook")
public class deleteBookController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("buku_id");

        if (id != null && id.matches("\\d+")) { 
            JDBC db = new JDBC();
            if (db.isConnected) {
                try {
                    db.getConnection().setAutoCommit(false);
                    
                    String sqlBooking = "DELETE FROM booking WHERE bukuDetails_id_fk IN " +
                                      "(SELECT id FROM bukudetails WHERE buku_id_fk = ?)";
                    PreparedStatement stmtBooking = db.getConnection().prepareStatement(sqlBooking);
                    stmtBooking.setInt(1, Integer.parseInt(id));
                    stmtBooking.executeUpdate();
                    stmtBooking.close();

                    String sqlDetails = "DELETE FROM bukudetails WHERE buku_id_fk = ?";
                    PreparedStatement stmtDetails = db.getConnection().prepareStatement(sqlDetails);
                    stmtDetails.setInt(1, Integer.parseInt(id));
                    stmtDetails.executeUpdate();
                    stmtDetails.close();

                    String sqlBuku = "DELETE FROM buku WHERE buku_id = ?";
                    PreparedStatement stmtBuku = db.getConnection().prepareStatement(sqlBuku);
                    stmtBuku.setInt(1, Integer.parseInt(id));
                    int rowsDeleted = stmtBuku.executeUpdate();
                    stmtBuku.close();

                    db.getConnection().commit();

                    if (rowsDeleted > 0) {
                        System.out.println("Buku dan semua data terkait berhasil dihapus: ID " + id);
                        response.sendRedirect("dashboard?success=delete");
                    } else {
                        System.out.println("Tidak ada buku yang dihapus: ID " + id);
                        response.sendRedirect("dashboard?error=not_found");
                    }

                } catch (Exception e) {
                    try {
                        db.getConnection().rollback();
                    } catch (Exception re) {
                        re.printStackTrace();
                    }
                    e.printStackTrace();
                    response.sendRedirect("dashboard?error=constraint");
                } finally {
                    try {
                        db.getConnection().setAutoCommit(true);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    db.disconnect();
                }
            } else {
                response.sendRedirect("dashboard?error=db_connection");
            }
        } else {
            System.out.println("Invalid ID: " + id);
            response.sendRedirect("dashboard?error=invalid_id");
        }
    }
}


