/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import db.JDBC;
import java.util.ArrayList;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Buku;
import model.BukuDetails;
import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import model.Booking;
import model.Member;

/**
 *
 * @author maxeef
 */
@WebServlet(name = "BookingController", urlPatterns = {"/Booking"})
public class BookingController extends HttpServlet {

    @Override
    protected void doGet (HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
        String buku_idParam = request.getParameter("buku_id");

        if (buku_idParam == null || buku_idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parameter 'buku_id' tidak ditemukan.");
            return;
        }

        try {
            int buku_id = Integer.parseInt(buku_idParam);

            Buku bukuModel = new Buku();
            Buku buku = bukuModel.getBukuById(buku_id);



            if (buku != null) {
                BukuDetails bukuDetailsModel = new BukuDetails();
                bukuDetailsModel.where("buku_id_fk = " + buku_id + " AND status = true");
                ArrayList<BukuDetails> availableDetails = bukuDetailsModel.get();
                
                if (!availableDetails.isEmpty()) {
                    BukuDetails selectedDetail = availableDetails.get(0);
                    
                    request.setAttribute("buku", buku);
                    request.setAttribute("bukuDetails", selectedDetail);
                    request.getRequestDispatcher("booking.jsp").forward(request, response);
                } else {
                    response.getWriter().println("Tidak ada buku tersedia dengan status aktif.");
                }
            } else {
                response.getWriter().println("Buku tidak ditemukan.");
            }
        } catch (NumberFormatException e) {
            response.getWriter().println("ID Buku tidak valid.");
        } catch (Exception e) {
            response.getWriter().println("Terjadi kesalahan: " + e.getMessage());
        }
    }
    @Override
    protected void doPost (HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Anda harus login untuk melakukan booking.");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        
    if (request.getParameter("return") != null) {
        int bukuDetailsId = Integer.parseInt(request.getParameter("bukuDetails"));
        JDBC db = new JDBC();

        try {
            // Start transaction
            db.getConnection().setAutoCommit(false);

            // Update BukuDetails status
            String queryBukuDetails = "UPDATE BukuDetails SET status = 1 WHERE id = ?";
            PreparedStatement pstmtBukuDetails = db.getPreparedStatement(queryBukuDetails);
            pstmtBukuDetails.setInt(1, bukuDetailsId);
            pstmtBukuDetails.executeUpdate();

            // Get buku_id from BukuDetails
            String queryGetBukuId = "SELECT buku_id_fk FROM BukuDetails WHERE id = ?";
            PreparedStatement pstmtGetBukuId = db.getPreparedStatement(queryGetBukuId);
            pstmtGetBukuId.setInt(1, bukuDetailsId);
            ResultSet rs = pstmtGetBukuId.executeQuery();

            if (rs.next()) {
                int bukuId = rs.getInt("buku_id_fk");
                // Update Buku status_booking
                String queryBuku = "UPDATE buku SET status_booking = 0 WHERE buku_id = ?";
                PreparedStatement pstmtBuku = db.getPreparedStatement(queryBuku);
                pstmtBuku.setInt(1, bukuId);
                pstmtBuku.executeUpdate();
            }

            // Commit transaction
            db.getConnection().commit();

        } catch (SQLException e) {
            try {
                db.getConnection().rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                db.getConnection().setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            db.disconnect();
        }

        response.sendRedirect("profileController");
        return;
    }
        
        String bukuDetailsStr = request.getParameter("bukuDetails");
        if (bukuDetailsStr == null || bukuDetailsStr.isEmpty()){
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parameter tidak lengkap.");
            return;
        }
        int bukuDetailsId = Integer.parseInt(bukuDetailsStr);
        BukuDetails obj = new BukuDetails();
        BukuDetails bukuDetails = obj.getBukuDetailsById(bukuDetailsId);
        
        bukuDetails.where("buku_id_fk = " + bukuDetails.getBuku().getbuku_id() + " AND status = true");
        ArrayList<BukuDetails> availableDetails = bukuDetails.get();
        
        if (availableDetails.size() == 1) {
            bukuDetails.getBuku().setStatus_booking(true);
            bukuDetails.getBuku().update();
            System.out.println("Buku "+bukuDetails.getBuku().getnama_buku()+" Berhasil di NonAktifkan");
        }
        
        
        String expiredDateStr = request.getParameter("deadline");
        LocalDate expired_date = LocalDate.parse(expiredDateStr);
        LocalDate bookingDate = LocalDate.now();
        Booking booking = new Booking();
        
        Member memberObj = new Member();
        memberObj.where("account_id_fk = " + userId);
        ArrayList<Member> members = memberObj.get();
        Member member = members.get(0);
        
        booking.setMember_id_fk(member.getMember_id());
        booking.setBukuDetails_id_fk(bukuDetailsId);
        booking.setExpired_date(expired_date);
        booking.setBooking_date(bookingDate);
        booking.insert();
        
        
        JDBC db = new JDBC();
        if (db.isConnected) {
            try {
                // Membuat query dengan parameter
                String query = "UPDATE BukuDetails SET status = 0 WHERE id = ?";

                // Membuat prepared statement
                PreparedStatement pstmt = db.getPreparedStatement(query);

                // Mengisi parameter
                pstmt.setInt(1, bukuDetailsId);

                // Menjalankan query
                int rowsAffected = pstmt.executeUpdate();

                // Output hasil
                System.out.println("Rows affected: " + rowsAffected);
            } catch (SQLException e) {
                // Menangani error SQL
                System.err.println("Error executing query: " + e.getMessage());
            } finally {
                // Pastikan koneksi ditutup jika ada metode untuk itu
                db.disconnect();
            }
        } else {
            System.err.println("Database connection not available.");
        }
        
        
        response.sendRedirect("home");
        
    }
    
}
