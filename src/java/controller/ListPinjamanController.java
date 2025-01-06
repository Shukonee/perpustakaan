/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import db.JDBC;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Booking;
import model.Buku;
import model.BukuDetails;

/**
 *
 * @author alfin
 */
@WebServlet(name = "ListPinjamanController", urlPatterns = {"/ListPinjamanController"})
public class ListPinjamanController extends HttpServlet {

    @Override
    protected void doGet (HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException{
        
//        Booking bookingObj = new Booking();
//        ArrayList<Booking> bookings = bookingObj.get();
//        ArrayList<Booking> bookingsActive = new ArrayList();
//        for (Booking booking : bookings) {
//            if (booking.getBukuDetail().getStatus() == 0) {
//                bookingsActive.add(booking);
//                System.out.println("BukuDetails"+booking.getBukuDetail().getId()+" Dengan Status: "+booking.getBukuDetail().getStatus());
//            }
//        }
        Booking bookingObj = new Booking();
        bookingObj.addQuery("ORDER BY booking_id DESC");
        ArrayList<Booking> bookings = bookingObj.get();
        BukuDetails obj = new BukuDetails();
        obj.where("status = 0");
        ArrayList<BukuDetails> bukuDtlsBooked = obj.get();
        System.out.println("Yang Statusnya 0: "+bukuDtlsBooked);
        ArrayList<Booking> bookingsActive = new ArrayList<>();
        HashSet<Integer> bukuDtlsIds = new HashSet<>();

        


        Set<Integer> uniqueBukuDetailsId = new HashSet<>();
        for (BukuDetails perBuku : bukuDtlsBooked) {
            for (Booking booked : bookings) {
                if (booked.getBukuDetails_id_fk() == perBuku.getId()) {
                    // Periksa apakah ID sudah ada di bookingsActive
                    if (!uniqueBukuDetailsId.contains(booked.getBukuDetails_id_fk())) {
                        bookingsActive.add(booked);
                        uniqueBukuDetailsId.add(booked.getBukuDetails_id_fk());
                    }
                }
            }
        }
        
        request.setAttribute("bookingList", bookingsActive);
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin/listPinjaman.jsp");
        dispatcher.forward(request, response);
    }
}
