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
        
        String buku_id = request.getParameter("buku_id");
        String nama_buku = request.getParameter("nama_buku");
        String tipe_buku = request.getParameter("tipe_buku");
        String jenis_buku = request.getParameter("jenis_buku");
        String tgl_terbit = request.getParameter("tgl_terbit");
        String author = request.getParameter("author");
        String rakbuku_id_fk = request.getParameter("rakbuku_id");
        
        if (buku_id == null || nama_buku == null || tipe_buku == null || 
            jenis_buku == null || tgl_terbit == null || author == null || rakbuku_id_fk == null) {
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
                pstmt.setString(1, nama_buku);
                pstmt.setString(2, tipe_buku);
                pstmt.setString(3, jenis_buku);
                pstmt.setString(4, tgl_terbit);
                pstmt.setString(5, author);
                pstmt.setInt(6, Integer.parseInt(rakbuku_id_fk));
                pstmt.setInt(7, Integer.parseInt(buku_id));
                
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
            response.sendRedirect("admin/editBook.jsp?buku_id=" + buku_id + "&error=updateFailed");
        }
    }
}
