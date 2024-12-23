/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import db.JDBC;
import java.io.IOException;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author farre
 */
@WebServlet("/editBook")
public class editBookController extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String bukuId = request.getParameter("bukuId");
        String namaBuku = request.getParameter("nama_buku");
        String tipeBuku = request.getParameter("tipe_buku");
        String jenisBuku = request.getParameter("jenis_buku");
        String tglTerbit = request.getParameter("tgl_terbit");
        String author = request.getParameter("author");
        String rakbukuId = request.getParameter("rakbuku_id");
        
        if (bukuId == null || namaBuku == null || tipeBuku == null || 
            jenisBuku == null || tglTerbit == null || author == null || rakbukuId == null) {
            response.sendRedirect("dashboard?error=missingFields");
            return;
        }
        
        JDBC db = new JDBC();
        boolean success = false;
        
        if (db.isConnected) {
            try {
                String query = "UPDATE buku SET nama_buku=?, tipe_buku=?, jenis_buku=?, " +
                             "tgl_terbit=?, author=?, rakbuku_id_fk=? WHERE buku_id=?";
                             
                PreparedStatement pstmt = db.getConnection().prepareStatement(query);
                pstmt.setString(1, namaBuku);
                pstmt.setString(2, tipeBuku);
                pstmt.setString(3, jenisBuku);
                pstmt.setString(4, tglTerbit);
                pstmt.setString(5, author);
                pstmt.setInt(6, Integer.parseInt(rakbukuId));
                pstmt.setInt(7, Integer.parseInt(bukuId));
                
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
            response.sendRedirect("dashboard?success=bookUpdated");
        } else {
            response.sendRedirect("editBook.jsp?bukuId=" + bukuId + "&error=updateFailed");
        }
    }
}
