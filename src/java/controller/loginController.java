import java.io.IOException;
import java.sql.ResultSet;
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
            String sql = "SELECT user_id FROM account WHERE email = '" + email + "' AND password = SHA2('" + password + "', 256)";
            ResultSet rs = db.getData(sql);

            if (rs.next()) {
                // Login berhasil
                int userId = rs.getInt("user_id");
                HttpSession session = request.getSession();
                session.setAttribute("userId", userId);
                session.setAttribute("isLoggedIn", true);
                response.sendRedirect("home.jsp");
            } else {
                // Login gagal
                response.sendRedirect("login.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=2");
        } finally {
            db.disconnect();
        }
    }
}
