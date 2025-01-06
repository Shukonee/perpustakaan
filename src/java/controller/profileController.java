/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import db.JDBC;
import model.Buku;
import java.util.HashSet;
import java.util.Set;
import java.util.Objects;
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
import javax.servlet.http.HttpSession;
import model.Member;
import model.Booking;

/**
 *
 * @author dipa
 */
@WebServlet("/profileController")

public class profileController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }   

        Member memberObj = new Member();
        memberObj.where("account_id_fk = " + userId);
        ArrayList<Member> members = memberObj.get();

        if (!members.isEmpty()) {
            Member member = members.get(0);

            // Get booked books
            Booking bookingObj = new Booking();
            bookingObj.where("member_id_fk = " + member.getMember_id()+" ORDER BY booking_date DESC");
            ArrayList<Booking> bookings = bookingObj.get();
            ArrayList<Booking> bookingsActive = new ArrayList();
            Set<Integer> uniqueBookings = new HashSet<>();
            for (Booking booking : bookings) {
                if (booking.getBukuDetail().getStatus() == 0) {
                    // Create a unique identifier for each booking based on its key attributes
                    int uniqueKey = Objects.hash(booking.getBukuDetails_id_fk(), booking.getMember_id_fk());

                    // Check if this booking is already in the active list
                    if (!uniqueBookings.contains(uniqueKey)) {
                        bookingsActive.add(booking);
                        uniqueBookings.add(uniqueKey); // Mark this booking as added
                    }
                }
            }

            request.setAttribute("member", member);
            request.setAttribute("bookings", bookingsActive);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else {
           response.sendRedirect("login.jsp");
        }
    }
}
