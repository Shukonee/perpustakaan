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
/**
 *
 * @author farre
 */
@WebServlet("/deleteRak")
public class deleteRakController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("rakId");

        if (id != null && id.matches("\\d+")) { 
            JDBC db = new JDBC();
            if (db.isConnected) {
                try {
                    String sql = "DELETE FROM rakbuku WHERE rakbuku_id = ?";
                    PreparedStatement stmt = db.getConnection().prepareStatement(sql);
                    stmt.setInt(1, Integer.parseInt(id));
                    int rowsDeleted = stmt.executeUpdate(); 
                    stmt.close();

                    if (rowsDeleted > 0) {
                        System.out.println("Rak berhasil dihapus: ID " + id);
                    } else {
                        System.out.println("Tidak ada rak yang dihapus: ID " + id);
                    }

                    response.sendRedirect("dashboard");
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("error.jsp"); 
                } finally {
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


