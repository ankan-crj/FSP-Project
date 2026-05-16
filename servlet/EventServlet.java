import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/EventServlet")
public class EventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private String jdbcURL = "jdbc:oracle:thin:@localhost:1521:XE";
    private String jdbcUsername = "system";
    private String jdbcPassword = "manager";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userEmail = (String) session.getAttribute("userEmail");
        String eventName = request.getParameter("event");
        if (eventName == null || eventName.trim().isEmpty()) {
            eventName = "No Event Selected";
        }

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {

                // 1. Update selected event
                String sqlUpdate = "UPDATE registration SET EVENT = ? WHERE EMAIL = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sqlUpdate)) {
                    stmt.setString(1, eventName);
                    stmt.setString(2, userEmail);
                    stmt.executeUpdate();
                }

                // 2. Calculate total price of all booked services
                String sqlPrice = "SELECT ppr, cfp, dpr, vprice, spr FROM registration WHERE email = ?";
                double totalPrice = 0;
                try (PreparedStatement stmtPrice = conn.prepareStatement(sqlPrice)) {
                    stmtPrice.setString(1, userEmail);
                    ResultSet rs = stmtPrice.executeQuery();
                    if (rs.next()) {
                        totalPrice += rs.getString("ppr") != null ? Double.parseDouble(rs.getString("ppr")) : 0;
                        totalPrice += rs.getString("cfp") != null ? Double.parseDouble(rs.getString("cfp")) : 0;
                        totalPrice += rs.getString("dpr") != null ? Double.parseDouble(rs.getString("dpr")) : 0;
                        totalPrice += rs.getString("vprice") != null ? Double.parseDouble(rs.getString("vprice")) : 0;
                        totalPrice += rs.getString("spr") != null ? Double.parseDouble(rs.getString("spr")) : 0;
                    }
                    rs.close();
                }

                // 3. Store totalPrice in session for payment.jsp
                session.setAttribute("totalPrice", totalPrice);

                // 4. Redirect to events page
                response.sendRedirect("events.jsp?event=" + java.net.URLEncoder.encode(eventName, "UTF-8"));

            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
