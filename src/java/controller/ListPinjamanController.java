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
import java.util.List;
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
        

        Booking bookingModel = new Booking();
        
        // Ambil semua data booking
        ArrayList<Booking> bookingList = bookingModel.get();
        
        // Simpan data ke request attribute
        request.setAttribute("bookingList", bookingList);
        System.out.println(bookingList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin/listPinjaman.jsp");
        dispatcher.forward(request, response);
    }
}
