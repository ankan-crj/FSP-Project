package com.eventastic;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userEmail = (String) session.getAttribute("userEmail");
        String event = request.getParameter("event");

        Connection conn = null;
        PreparedStatement psSelect = null;
        PreparedStatement psInsert = null;
        PreparedStatement psUpdate = null;
        ResultSet rs = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:XE", "system", "manager");

            // 1. Fetch booking details
            String sqlSelect = "SELECT EMAIL, EVENT, VNAME, VPRICE, CFI, CFP, DPK, DPR, SPK, SPR, " +
                               "GUESTS, EDATE, PPK, PPR FROM registration WHERE EMAIL=? AND EVENT=?";
            psSelect = conn.prepareStatement(sqlSelect);
            psSelect.setString(1, userEmail);
            psSelect.setString(2, event);
            rs = psSelect.executeQuery();

            if (!rs.next()) {
                response.getWriter().println("Booking not found for cancellation.");
                return;
            }

            // Extract booking details
            String vname = rs.getString("VNAME");
            int vprice = rs.getInt("VPRICE");
            String cfi = rs.getString("CFI");
            int cfp = rs.getInt("CFP");
            String dpk = rs.getString("DPK");
            int dpr = rs.getInt("DPR");
            String spk = rs.getString("SPK");
            int spr = rs.getInt("SPR");
            int guests = rs.getInt("GUESTS");
            Date edate = rs.getDate("EDATE");
            String ppk = rs.getString("PPK");
            int ppr = rs.getInt("PPR");

            // 2. Insert into cancel table
            String sqlInsert = "INSERT INTO cancel " +
                    "(EMAIL, EVENT, VNAME, VPRICE, CFI, CFP, DPK, DPR, SPK, SPR, GUESTS, EDATE, CANCELLED_ON, PPK, PPR) " +
                    "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            psInsert = conn.prepareStatement(sqlInsert);
            psInsert.setString(1, userEmail);
            psInsert.setString(2, event);
            psInsert.setString(3, vname);
            psInsert.setInt(4, vprice);
            psInsert.setString(5, cfi);
            psInsert.setInt(6, cfp);
            psInsert.setString(7, dpk);
            psInsert.setInt(8, dpr);
            psInsert.setString(9, spk);
            psInsert.setInt(10, spr);
            psInsert.setInt(11, guests);
            psInsert.setDate(12, edate);
            psInsert.setDate(13, java.sql.Date.valueOf(LocalDate.now()));
            psInsert.setString(14, ppk);
            psInsert.setInt(15, ppr);
            psInsert.executeUpdate();

            // 3. Clear booking fields in registration table and reset payment
            String sqlUpdate = "UPDATE registration SET EVENT=NULL, VNAME=NULL, VPRICE=NULL, CFI=NULL, CFP=NULL, " +
                    "DPK=NULL, DPR=NULL, SPK=NULL, SPR=NULL, GUESTS=NULL, EDATE=NULL, PPK=NULL, PPR=NULL, PAYMENT='refunded' " +
                    "WHERE EMAIL=? AND EVENT=?";
            psUpdate = conn.prepareStatement(sqlUpdate);
            psUpdate.setString(1, userEmail);
            psUpdate.setString(2, event);
            psUpdate.executeUpdate();

            // Redirect to confirmation page
            response.sendRedirect("cancelconfirmation.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error cancelling booking: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (psSelect != null) psSelect.close(); } catch (Exception e) {}
            try { if (psInsert != null) psInsert.close(); } catch (Exception e) {}
            try { if (psUpdate != null) psUpdate.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
