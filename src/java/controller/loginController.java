import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import db.JDBC;

@WebServlet("/loginController")
public class loginController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        JDBC db = new JDBC();

        if (!db.isConnected) {
            response.sendRedirect("login.jsp?error=2"); // Koneksi gagal
            return;
        }

        try {
            String sql = "SELECT user_id FROM account WHERE email = ? AND password = SHA2(?, 256)";
            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("user_id");
                HttpSession session = request.getSession();
                session.setAttribute("userId", userId);
                session.setAttribute("isLoggedIn", true);

                String role; 
                
                sql = "SELECT * FROM admin WHERE account_id_fk = ?";
                stmt = db.getConnection().prepareStatement(sql);
                stmt.setInt(1, userId);
                ResultSet adminResult = stmt.executeQuery();
                
                if (adminResult.next()) {
                    role = "admin"; 
                } else {
                    role = "member";
                }

                session.setAttribute("role", role);

                if ("admin".equals(role)) {
                    response.sendRedirect("adminDashboard.jsp");
                } else {
                    response.sendRedirect("home.jsp"); // jika user
                }
            } else {
                response.sendRedirect("login.jsp?error=1"); 
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=2"); 
        } finally {
            db.disconnect(); 
        }
    }
}
