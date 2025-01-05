/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import db.JDBC;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import db.JDBC;
import model.BukuDetails;
import java.io.File;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author maxeef
 */
@WebServlet("/TambahBukuController")
@MultipartConfig(
    fileSizeThreshold = 0,
    maxFileSize = 10485760,  // Maksimal ukuran file 10 MB
    maxRequestSize = 20971520  // Maksimal ukuran request 20 MB
)
public class TambahBukuController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uploadDirek = getServletContext().getRealPath("/") + "assets/";
        System.out.println("Direktori Assets: "+uploadDirek);
        // Ambil data dari form
        String nama_buku = request.getParameter("nama_buku");
        String tipe_buku = request.getParameter("tipe_buku");
        String jenis_buku = request.getParameter("jenis_buku");
        String tgl_terbit = request.getParameter("tgl_terbit");
        String author = request.getParameter("author");
        String rakbuku_idStr = request.getParameter("rakbuku_id");
        String jumlahStr = request.getParameter("jumlah");

        if (rakbuku_idStr == null || rakbuku_idStr.isEmpty()) {
            response.sendRedirect("admin/addBook.jsp?error=rakbuku_id_fkEmpty");
            return;
        }
        
        int rakbuku_id_fk = 0;
        int jumlah = 0;
        try {
            rakbuku_id_fk = Integer.parseInt(rakbuku_idStr);
            jumlah = Integer.parseInt(jumlahStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("admin/addBook.jsp?error=invalidrakbuku_id_fk");
            return;
        }

        Part gambarBukuPart = request.getPart("gambarBuku");
        String fileName = gambarBukuPart.getSubmittedFileName();

        JDBC db = new JDBC();
        if (!db.isConnected) {
            response.sendRedirect("admin/addBook.jsp?error=2");
            return;
        }

        try {
            // Simpan data buku ke database tanpa nama file dulu
            String sql = "INSERT INTO buku (nama_buku, tipe_buku, jenis_buku, tgl_terbit, author, rakbuku_id_fk, jumlah) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = db.getConnection().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, nama_buku);
            stmt.setString(2, tipe_buku);
            stmt.setString(3, jenis_buku);
            stmt.setString(4, tgl_terbit);
            stmt.setString(5, author);
            stmt.setInt(6, rakbuku_id_fk);
            stmt.setInt(7, jumlah);
            
            int result = stmt.executeUpdate();
            if (result > 0) {
                // Dapatkan ID buku yang baru saja dibuat
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int bookId = generatedKeys.getInt(1);
                    
                    BukuDetails bukuDetails = new BukuDetails();
                    bukuDetails.tambahBukuDetails(bookId, jumlah); //Untuk Nambah quantity buku terdaftar ke tabel BukuDetails
                    
                    // Rename file menjadi "Cover Buku <id>.ext"
                    String newFileName = "book" + bookId + fileName.substring(fileName.lastIndexOf("."));
                    String uploadDir = getServletContext().getRealPath("/") + "assets/";
                    File uploadDirFile = new File(uploadDir);
                    if (!uploadDirFile.exists()) {
                        uploadDirFile.mkdirs();  // Buat folder jika belum ada
                    }
                    String filePath = uploadDir + File.separator + newFileName;

                    // Simpan file dengan nama baru
                    gambarBukuPart.write(filePath);

                    // Perbarui database dengan nama file yang baru
//                    String updateSql = "UPDATE buku SET gambar_buku = ? WHERE buku_id = ?";
//                    PreparedStatement updateStmt = db.getConnection().prepareStatement(updateSql);
//                    updateStmt.setString(1, newFileName);
//                    updateStmt.setInt(2, bookId);
//                    updateStmt.executeUpdate();

                    response.sendRedirect("dashboard");
                }
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

