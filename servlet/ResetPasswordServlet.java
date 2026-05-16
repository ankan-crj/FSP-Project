import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private String jdbcURL = "jdbc:oracle:thin:@localhost:1521:XE";
    private String jdbcUsername = "system";
    private String jdbcPassword = "manager";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("fpEmail") == null) {
            response.sendRedirect("fp.jsp");
            return;
        }

        String email = (String) session.getAttribute("fpEmail");

        if (!newPassword.equals(confirmPassword)) {
            response.getWriter().println("Passwords do not match! <a href='fp3.jsp'>Try again</a>");
            return;
        }

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
                String sql = "UPDATE registration SET password=? WHERE email=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, newPassword);
                ps.setString(2, email);
                int rows = ps.executeUpdate();

                if (rows > 0) {
                    session.invalidate();
                    response.sendRedirect("login.jsp"); // Redirect directly to login page
                } else {
                    response.getWriter().println("Failed to update password! <a href='fp3.jsp'>Try again</a>");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
