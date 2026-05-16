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

@WebServlet("/VenueServlet")
public class VenueServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect("index.html");
            return;
        }

        String userEmail = (String) session.getAttribute("userEmail");
        String venueName = request.getParameter("vname");
        String venuePrice = request.getParameter("vprice");

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            // Load Oracle JDBC driver
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Connect to the database
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "manager");

            // Update the registration table with the selected venue
            String sql = "UPDATE registration SET vname = ?, vprice = ? WHERE email = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, venueName);
            ps.setString(2, venuePrice);
            ps.setString(3, userEmail);

            int updated = ps.executeUpdate();
            if (updated > 0) {
                // Redirect to events.jsp after successful booking
                response.sendRedirect("events.jsp");
            } else {
                response.getWriter().println("Error: Could not update venue. Please try again.");
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
