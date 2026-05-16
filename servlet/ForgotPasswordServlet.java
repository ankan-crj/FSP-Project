import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
    private String jdbcURL = "jdbc:oracle:thin:@localhost:1521:XE";
    private String jdbcUsername = "system";
    private String jdbcPassword = "manager";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        if (email == null || email.trim().isEmpty()) {
            response.getWriter().println("Please enter your email! <a href='forgotPassword.jsp'>Go back</a>");
            return;
        }

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
                String sql = "SELECT seq FROM registration WHERE email=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, email);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    String question = rs.getString("seq"); // security question column
                    HttpSession session = request.getSession();
                    session.setAttribute("fpEmail", email);
                    session.setAttribute("securityQuestion", question);
                    response.sendRedirect("fp2.jsp");
                } else {
                    response.getWriter().println("Email not registered! <a href='forgotPassword.jsp'>Try again</a>");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
