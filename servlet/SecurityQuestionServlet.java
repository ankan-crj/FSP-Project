import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/SecurityQuestionServlet")
public class SecurityQuestionServlet extends HttpServlet {
    private String jdbcURL = "jdbc:oracle:thin:@localhost:1521:XE";
    private String jdbcUsername = "system";
    private String jdbcPassword = "manager";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String answer = request.getParameter("answer");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("fpEmail") == null) {
            response.sendRedirect("forgotPassword.jsp");
            return;
        }

        String email = (String) session.getAttribute("fpEmail");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
                String sql = "SELECT seqa FROM registration WHERE email=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, email);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    String correctAnswer = rs.getString("seqa");
                    if (correctAnswer.equalsIgnoreCase(answer.trim())) {
                        response.sendRedirect("fp3.jsp");
                    } else {
                        response.getWriter().println("Incorrect answer! <a href='fp2.jsp'>Try again</a>");
                    }
                } else {
                    response.getWriter().println("Email not found! <a href='forgotPassword.jsp'>Go back</a>");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
