import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database configuration
    private String jdbcURL = "jdbc:oracle:thin:@localhost:1521:XE"; // Oracle DB URL
    private String jdbcUsername = "system";  
    private String jdbcPassword = "manager"; 

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get data from form
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String mobile = request.getParameter("mobile");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String seq = request.getParameter("seq");
        String seqa = request.getParameter("seqa");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Load Oracle JDBC driver
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Connect to Oracle database
            conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            // SQL Insert statement (set extra fields to NULL or 0)
            String sql = "INSERT INTO registration " +
                         "(EMAIL, NAME, MOBILE, ADDRESS, PASSWORD, SEQ, SEQA, " +
                         "PPK, PPR, VNAME, VPRICE, DPK, DPR, SPK, SPR, CFP, CFI, EVENT) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, name);
            stmt.setString(3, mobile);
            stmt.setString(4, address);
            stmt.setString(5, password);
            stmt.setString(6, seq);
            stmt.setString(7, seqa);

            // Set extra columns to null or 0
            stmt.setString(8, null); // PPK
            stmt.setInt(9, 0);       // PPR
            stmt.setString(10, null); // VNAME
            stmt.setInt(11, 0);      // VPRICE
            stmt.setString(12, null); // DPK
            stmt.setInt(13, 0);       // DPR
            stmt.setString(14, null); // SPK
            stmt.setInt(15, 0);       // SPR
            stmt.setInt(16, 0);       // CFP
            stmt.setString(17, null); // CFI
            stmt.setString(18, null); // EVENT

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("login.jsp");
            } else {
                response.getWriter().println("Registration failed, please try again.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
