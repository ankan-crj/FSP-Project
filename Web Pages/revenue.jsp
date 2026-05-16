<%@ page import="java.sql.*" %>
<%
    if (session == null || session.getAttribute("adminEmail") == null) {
        response.sendRedirect("adminlogin.jsp?error=2");
        return;
    }
    String adminEmail = (String) session.getAttribute("adminEmail");

    int totalRevenue = 0;
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "manager");

        // Sum total revenue
        String sqlRevenue = "SELECT SUM(NVL(cfp,0) + NVL(vprice,0) + NVL(dpr,0) + NVL(spr,0)) AS totalRevenue " +
                            "FROM registration WHERE payment='paid'";
        ps = conn.prepareStatement(sqlRevenue);
        rs = ps.executeQuery();
        if (rs.next()) {
            totalRevenue = rs.getInt("totalRevenue");
        }
        rs.close();
        ps.close();

        // Get all paid bookings with package details
        String sqlBookings = "SELECT name, email, cfi, vname, event, cfp, vprice, dpr, spr " +
                             "FROM registration WHERE payment='paid'";
        ps = conn.prepareStatement(sqlBookings);
        rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Revenue Report</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f6f9; margin: 0; padding: 0; }
        .navbar {
            background: #2c3e50; color: white; padding: 15px 30px;
            display: flex; justify-content: space-between; align-items: center;
        }
        .navbar h1 { margin: 0; font-size: 20px; }
        .container { max-width: 1000px; margin: 80px auto; background: white; padding: 30px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        h2 { margin-bottom: 20px; color: #333; }
        .total { font-size: 28px; font-weight: bold; color: #27ae60; margin-bottom: 30px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 12px 15px; border: 1px solid #ddd; text-align: center; }
        th { background: #3498db; color: white; }
        tr:nth-child(even) { background: #f9f9f9; }
        .back-btn {
            display: inline-block; margin-top: 20px; padding: 10px 20px;
            background: #3498db; color: white; text-decoration: none;
            border-radius: 6px;
        }
        .back-btn:hover { background: #2980b9; }
    </style>
</head>
<body>

    <div class="navbar">
        <h1>Admin - Revenue</h1>
        <a href="adminuserhome.jsp" style="color:white; text-decoration:none;">Back to Dashboard</a>
    </div>

    <div class="container">
        <h2>Revenue Summary</h2>
        <div class="total">Total Revenue: &#8377; <%= totalRevenue %></div>

        <h2>Bookings Details</h2>
        <table>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Food Package</th>
                <th>Food Price (CFP)</th>
                <th>Venue</th>
                <th>Venue Price (VPRICE)</th>
                <th>Decoration Price (DPR)</th>
                <th>Styling Package Price (SPR)</th>
                <th>Event Type</th>
                <th>Total Price</th>
            </tr>
<%
        while(rs.next()) {
            String name = rs.getString("name");
            String email = rs.getString("email");
            String cfi = rs.getString("cfi");
            String vname = rs.getString("vname");
            String event = rs.getString("event");
            int cfp = rs.getInt("cfp");
            int vprice = rs.getInt("vprice");
            int dpr = rs.getInt("dpr");
            int spr = rs.getInt("spr");
            int total = cfp + vprice + dpr + spr;
%>
            <tr>
                <td><%= name %></td>
                <td><%= email %></td>
                <td><%= cfi %></td>
                <td>&#8377; <%= cfp %></td>
                <td><%= vname %></td>
                <td>&#8377; <%= vprice %></td>
                <td>&#8377; <%= dpr %></td>
                <td>&#8377; <%= spr %></td>
                <td><%= event %></td>
                <td>&#8377; <%= total %></td>
            </tr>
<%
        }
%>
        </table>
        <a href="adminuserhome.jsp" class="back-btn">Back</a>
    </div>

</body>
</html>

<%
        rs.close();
        ps.close();
        conn.close();
    } catch(Exception e) {
        e.printStackTrace();
    }
%>
