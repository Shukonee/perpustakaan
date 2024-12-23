package controller;

import db.JDBC;
import java.io.IOException;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author farre
 */
@WebServlet("/editRak")
public class editRakController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String rakId = request.getParameter("rakId");
        String jenisRak = request.getParameter("jenis_rak");
        String lokasiRak = request.getParameter("lokasi_rak");
        
        if (rakId == null || jenisRak == null || lokasiRak == null) {
            response.sendRedirect("dashboard?error=missingFields");
            return;
        }
        
        JDBC db = new JDBC();
        boolean success = false;
        
        if (db.isConnected) {
            try {
                String query = "UPDATE rakbuku SET jenis_rak=?, lokasi_rak=? WHERE rakbuku_id=?";
                             
                PreparedStatement pstmt = db.getConnection().prepareStatement(query);
                pstmt.setString(1, jenisRak);
                pstmt.setString(2, lokasiRak);
                pstmt.setInt(3, Integer.parseInt(rakId));
                
                int rowsUpdated = pstmt.executeUpdate();
                success = (rowsUpdated > 0);
                
                pstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
                success = false;
            } finally {
                db.disconnect();
            }
        }
        
        if (success) {
            response.sendRedirect("dashboard?success=rakUpdated");
        } else {
            response.sendRedirect("editRak.jsp?rakId=" + rakId + "&error=updateFailed");
        }
    }
}