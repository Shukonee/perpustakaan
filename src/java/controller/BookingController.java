/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

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
        
        String bukuDetailsStr = request.getParameter("bukuDetails");
        if (bukuDetailsStr == null || bukuDetailsStr.isEmpty()){
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parameter tidak lengkap.");
            return;
        }
        
        int bukuDetailsId = Integer.parseInt(bukuDetailsStr);
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
        
        BukuDetails obj = new BukuDetails();
        BukuDetails bukuDetails = obj.getBukuDetailsById(bukuDetailsId);
        bukuDetails.setStatus(0);
        bukuDetails.update();
        
        
        response.sendRedirect("home");
        
    }
    
}
