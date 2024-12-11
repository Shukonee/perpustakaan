import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logoutController")
public class logoutController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Ambil session yang ada
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // Menghapus session
            session.invalidate();
        }

        // Redirect ke halaman login setelah logout
        response.sendRedirect("index.jsp");
    }
}
