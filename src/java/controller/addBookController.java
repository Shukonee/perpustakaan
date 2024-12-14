import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import db.JDBC;

@WebServlet("/addBookController")
public class addBookController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String namaBuku = request.getParameter("namaBuku");
        String tipeBuku = request.getParameter("tipeBuku");
        String jenisBuku = request.getParameter("jenisBuku");
        String tglTerbit = request.getParameter("tglTerbit");
        String author = request.getParameter("author");
        String rakbukuIdStr = request.getParameter("rakbuku");

        // Cek apakah rak buku terpilih
        if (rakbukuIdStr == null || rakbukuIdStr.isEmpty()) {
            response.sendRedirect("addBook.jsp?error=rakbukuEmpty");  // Rak buku harus dipilih
            return;
        }

        int rakbukuId = 0;
        try {
            rakbukuId = Integer.parseInt(rakbukuIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("addBook.jsp?error=invalidRakbukuId");  // Jika parsing gagal
            return;
        }

        // Cek apakah user adalah admin
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        if (role == null || !role.equals("admin")) {
            response.sendRedirect("login.jsp?error=notLoggedIn");
            return;
        }
        
        JDBC db = new JDBC();
        if (!db.isConnected) {
            response.sendRedirect("addBook.jsp?error=2"); 
            return;
        }

        try {
            String sql = "INSERT INTO buku (nama_buku, tipe_buku, jenis_buku, tgl_terbit, author, rakbuku_id_fk) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setString(1, namaBuku);
            stmt.setString(2, tipeBuku);
            stmt.setString(3, jenisBuku);
            stmt.setString(4, tglTerbit);
            stmt.setString(5, author);
            stmt.setInt(6, rakbukuId);

            System.out.println("Executing query: " + sql);
            System.out.println("Parameters: " + namaBuku + ", " + tipeBuku + ", " + jenisBuku + ", " + tglTerbit + ", " + author + ", " + rakbukuId);

            int result = stmt.executeUpdate();
            if (result > 0) {
                // Jika berhasil, redirect ke halaman daftar buku
                System.out.println("Redirecting to listBookController...");
                response.sendRedirect("listBookController?success=bookAdded");
            } else {
                // Jika gagal, redirect kembali ke halaman tambah buku
                response.sendRedirect("addBook.jsp?error=1");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("addBook.jsp?error=2");  // Jika terjadi kesalahan dalam query
        } finally {
            db.disconnect(); 
        }
    }
}
