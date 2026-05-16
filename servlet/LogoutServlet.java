import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get session if it exists
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();  // End session
        }

        // Redirect back to login page
        response.sendRedirect("index.html");
    }
}
