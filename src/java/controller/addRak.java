/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import db.JDBC;
import java.sql.PreparedStatement;

/**
 *
 * @author maxeef
 */
@WebServlet("/addRak")
public class addRak extends HttpServlet {
    @Override
    protected void doGet (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        response.sendRedirect("admin/addRak.jsp");
    }
    @Override
    protected void doPost (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        JDBC db = new JDBC();
        
        if (db.isConnected) {
            String jenis_rak = request.getParameter("input-jenis_rak");
            String lokasi_rak = request.getParameter("input-lokasi_rak");
            try{
                String query = "insert into rakbuku(jenis_rak, lokasi_rak) values (?,?)";
                PreparedStatement stmt = db.getConnection().prepareStatement(query);
                stmt.setString(1, jenis_rak);
                stmt.setString(2, lokasi_rak);
                
                int result = stmt.executeUpdate();
                response.sendRedirect("dashboard?success=bookAdded");
            }catch(Exception e){
                
            }
        }else{
            
        }
    }
}
