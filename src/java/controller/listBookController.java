import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Buku;
import db.JDBC;

@WebServlet("/listBookController")
public class listBookController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Ambil data buku dari database
        JDBC db = new JDBC();
        List<Buku> bukuList = new ArrayList<>();
        String sql = "SELECT b.buku_id, b.nama_buku, b.tipe_buku, b.jenis_buku, b.tgl_terbit, b.author, r.jenis_rak "
                + "FROM buku b JOIN rakbuku r ON b.rakbuku_id_fk = r.rakbuku_id";

        try {
            ResultSet rs = db.getData(sql);
            while (rs.next()) {
                int bukuId = rs.getInt("buku_id");
                String namaBuku = rs.getString("nama_buku");
                String tipeBuku = rs.getString("tipe_buku");
                String jenisBuku = rs.getString("jenis_buku");
                String tglTerbit = rs.getString("tgl_terbit");
                String author = rs.getString("author");
                String jenisRak = rs.getString("jenis_rak");
                Buku buku = new Buku(bukuId, namaBuku, tipeBuku, jenisBuku, tglTerbit, author, jenisRak);
                bukuList.add(buku);
            }
            request.setAttribute("bukuList", bukuList);  // Kirim data buku ke JSP
            request.getRequestDispatcher("listBook.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboard.jsp?error=1");
        } finally {
            db.disconnect();
        }
    }
}
