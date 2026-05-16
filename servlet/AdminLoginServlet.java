package com.example.event;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // ✅ Load Oracle JDBC Driver
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "system", "manager");

            // ✅ Check credentials
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM ADMIN WHERE EMAIL=? AND PASSWORD=?");
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // ✅ Successful login → create session
                HttpSession session = request.getSession();
                session.setAttribute("adminEmail", email);

                response.sendRedirect("adminuserhome.jsp"); // Go to dashboard
            } else {
                // ❌ Invalid login
                response.sendRedirect("adminlogin.jsp?error=1");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminlogin.jsp?error=3");
        }
    }
}
