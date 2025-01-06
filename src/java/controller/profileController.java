/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
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
   bookingObj.where("member_id_fk = " + member.getMember_id()); // Use 0 for active bookings
   ArrayList<Booking> bookings = bookingObj.get();
   System.out.println("bakak " + bookings);
   
   request.setAttribute("member", member);
   request.setAttribute("bookings", bookings);
   request.getRequestDispatcher("profile.jsp").forward(request, response);
} else {
   response.sendRedirect("login.jsp");
}
}
}
