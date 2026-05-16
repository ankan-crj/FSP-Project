import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/StylingServlet")
public class StylingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect("index.html");
            return;
        }

        String userEmail = (String) session.getAttribute("userEmail");
        String packageName = request.getParameter("package");
        String packagePrice = request.getParameter("price");

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "manager");

            String sql = "UPDATE registration SET spk = ?, spr = ? WHERE email = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, packageName);
            ps.setString(2, packagePrice);
            ps.setString(3, userEmail);

            int updated = ps.executeUpdate();
            if (updated > 0) {
                response.sendRedirect("events.jsp"); // Redirect after booking
            } else {
                response.getWriter().println("Error: Could not update styling package. Please try again.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        } finally {
            if (ps != null) try { ps.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }
    }
}
