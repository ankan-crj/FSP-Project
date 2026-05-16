import java.io.*;
import java.sql.*; 
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    public void doPost(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {

        res.setContentType("text/html");
        PrintWriter out = res.getWriter();

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            // Load Oracle Driver
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:XE", "system", "manager"
            );

            Statement stmt = con.createStatement();
            String q1 = "select * from registration where email='" + email + 
                        "' and password='" + password + "'";

            ResultSet rs = stmt.executeQuery(q1);

            if (rs.next()) {
                // ✅ Create session on successful login
                HttpSession session = req.getSession();
                session.setAttribute("userEmail", email);
                session.setAttribute("userName", rs.getString(2)); // assuming column 2 = name

                // Redirect to user home page
                res.sendRedirect("userhome.jsp");
            } else {
                // If login fails, show message + link back
                out.println("<h3>Email or Password does not match</h3>");
                out.println("<a href='login.jsp'>Try Again</a>");
            }

            con.close();

        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
}
