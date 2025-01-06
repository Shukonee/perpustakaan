    /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import db.JDBC;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Buku;
import model.RakBuku;

/**
 *
 * @author maxeef
 */
@WebServlet("/dashboard")
public class dashboardController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JDBC db = new JDBC();
        ArrayList<RakBuku> listRak = new ArrayList<>();
        ArrayList<Buku> listBuku = new ArrayList<>();

        String search = request.getParameter("search");

        if (db.isConnected) {
            try {
                // Query untuk daftar rak buku
                String sql = "SELECT * FROM rakbuku";
                ResultSet rs = db.getData(sql);

                while (rs.next()) {
                    RakBuku rak = new RakBuku(
                        rs.getInt("rakbuku_id"),
                        rs.getString("jenis_rak"),
                        rs.getString("lokasi_rak")
                    );
                    listRak.add(rak);
                }
                rs.close();

                // Query untuk daftar buku dengan pencarian otomatis
                if (search != null && !search.isEmpty()) {
                    sql = "SELECT * FROM buku WHERE nama_buku LIKE ? OR tipe_buku LIKE ? OR jenis_buku LIKE ? OR author LIKE ?";
                    var stmt = db.getConnection().prepareStatement(sql);
                    stmt.setString(1, "%" + search + "%");
                    stmt.setString(2, "%" + search + "%");
                    stmt.setString(3, "%" + search + "%");
                    stmt.setString(4, "%" + search + "%");
                    rs = stmt.executeQuery();
                } else {
                    // Query default jika tidak ada pencarian
                    sql = "SELECT * FROM buku";
                    rs = db.getData(sql);
                }

                while (rs.next()) {
                    Buku buku = new Buku(
                        rs.getInt("buku_id"),
                        rs.getString("nama_buku"),
                        rs.getString("tipe_buku"),
                        rs.getString("jenis_buku"),
                        rs.getString("tgl_terbit"),
                        rs.getString("author"),
                        rs.getInt("rakbuku_id_fk"),
                        rs.getBoolean("status_booking")
                    );
                    listBuku.add(buku);
                }
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                db.disconnect();
            }
        }

        // Simpan daftar buku dan rak di request scope
        request.setAttribute("listBuku", listBuku);
        request.setAttribute("listRak", listRak);
        request.setAttribute("search", search);

        // Redirect ke adminDashboard.jsp
        request.getRequestDispatcher("admin/adminDashboard.jsp").forward(request, response);
    }

}
