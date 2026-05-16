package com.eventastic;

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

@WebServlet("/DateServlet")
public class DateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the session and check user login
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect("index.html");
            return;
        }

        String userEmail = (String) session.getAttribute("userEmail");
        String newDate = request.getParameter("edate"); // yyyy-MM-dd

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "manager");

            String sql = "UPDATE registration SET edate = TO_DATE(?, 'YYYY-MM-DD') WHERE email = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, newDate);
            ps.setString(2, userEmail);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                // Successfully updated, redirect to events.jsp
                response.sendRedirect("events.jsp");
            } else {
                response.getWriter().println("No record found to update.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error updating date: " + e.getMessage());
        } finally {
            try { if(ps != null) ps.close(); } catch(Exception e) {}
            try { if(conn != null) conn.close(); } catch(Exception e) {}
        }
    }
}
