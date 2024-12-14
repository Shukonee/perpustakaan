import db.JDBC;
import model.Buku;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/listBookController")
public class listBookController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JDBC db = new JDBC();
        ArrayList<Buku> listBuku = new ArrayList<>();

        if (db.isConnected) {
            try {
                String sql = "SELECT b.buku_id, b.nama_buku, b.tipe_buku, b.jenis_buku, b.tgl_terbit, b.author, r.jenis_rak " +
                "FROM buku b JOIN rakbuku r ON b.rakbuku_id_fk = r.rakbuku_id";

                ResultSet rs = db.getData(sql);

                while (rs.next()) {
                    Buku buku = new Buku(
                        rs.getInt("buku_id"),
                        rs.getString("nama_buku"),
                        rs.getString("tipe_buku"),
                        rs.getString("jenis_buku"),
                        rs.getString("tgl_terbit"),
                        rs.getString("author"),
                        rs.getString("jenis_rak")
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

        // Simpan daftar buku di request scope
        request.setAttribute("listBuku", listBuku);

        // Redirect ke halaman listBook.jsp
        request.getRequestDispatcher("listBook.jsp").forward(request, response);
        
        System.out.println("Jumlah buku yang ditemukan: " + listBuku.size());
        for (Buku buku : listBuku) {
            System.out.println(buku.getNamaBuku());
        }

    }
}
