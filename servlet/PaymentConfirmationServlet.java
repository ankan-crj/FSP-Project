package com.eventastic.servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/PaymentConfirmationServlet")
public class PaymentConfirmationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userEmail = (String) session.getAttribute("userEmail");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:XE", "system", "manager");

            // Update payment status to 'paid'
            String sql = "UPDATE registration SET payment='paid' WHERE email=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userEmail);
            int rowsUpdated = ps.executeUpdate();

            ps.close();
            conn.close();

            if(rowsUpdated > 0) {
                response.sendRedirect("BookingConfirmation.jsp");
            } else {
                response.getWriter().println("<h2 style='color:red;text-align:center;margin-top:50px;'>Payment failed or no booking found!</h2>");
            }

        } catch(Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h2 style='color:red;text-align:center;margin-top:50px;'>Error processing payment!</h2>");
        }
    }
}
