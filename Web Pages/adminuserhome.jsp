<%@ page import="java.sql.*" %>
<%
    // Use the implicit session object
    if (session == null || session.getAttribute("adminEmail") == null) {
        response.sendRedirect("adminlogin.jsp?error=2");
        return;
    }
    String adminEmail = (String) session.getAttribute("adminEmail");

    int totalUsers = 0;
    int totalBookings = 0;
    int totalFeedbacks = 0;
    int totalRevenue = 0;

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "manager");

        // Count total users
        String sqlUsers = "SELECT COUNT(email) AS totalUsers FROM registration";
        ps = conn.prepareStatement(sqlUsers);
        rs = ps.executeQuery();
        if (rs.next()) {
            totalUsers = rs.getInt("totalUsers");
        }
        rs.close();
        ps.close();

        // Count bookings (assuming bookings are identified by EVENT column not null)
        String sqlBookings = "SELECT COUNT(EVENT) AS totalBookings FROM registration WHERE PAYMENT='paid'";
        ps = conn.prepareStatement(sqlBookings);
        rs = ps.executeQuery();
        if (rs.next()) {
            totalBookings = rs.getInt("totalBookings");
        }
        rs.close();
        ps.close();

        // Count feedbacks (assuming feedback exists if CFI column not null)
        String sqlFeedback = "SELECT COUNT(FEEDBACK) AS totalFeedbacks FROM feedback";
        ps = conn.prepareStatement(sqlFeedback);
        rs = ps.executeQuery();
        if (rs.next()) {
            totalFeedbacks = rs.getInt("totalFeedbacks");
        }
        rs.close();
        ps.close();

        // Sum revenue (cfp + vprice + dpr + spr) where PAYMENT='paid'
        String sqlRevenue = "SELECT SUM(NVL(cfp,0) + NVL(vprice,0) + NVL(dpr,0) + NVL(spr,0)) AS totalRevenue FROM registration WHERE PAYMENT='paid'";
        ps = conn.prepareStatement(sqlRevenue);
        rs = ps.executeQuery();
        if (rs.next()) {
            totalRevenue = rs.getInt("totalRevenue");
        }

    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        if(rs != null) try { rs.close(); } catch(Exception e){}
        if(ps != null) try { ps.close(); } catch(Exception e){}
        if(conn != null) try { conn.close(); } catch(Exception e){}
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f8f9fa; margin: 0; padding: 0; }
        .navbar {
            background-color: #2c3e50; color: white; padding: 15px 30px;
            display: flex; justify-content: space-between; align-items: center;
            font-size: 18px; box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        .navbar h1 { margin: 0; font-size: 20px; }
        .dashboard-title { text-align: center; margin: 30px 0; font-size: 28px; font-weight: bold; }
        .cards {
            display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px;
            max-width: 800px; margin: 0 auto; padding: 0 20px;
        }
        .card {
            background: white; padding: 30px; border-radius: 16px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1); text-align: center;
            transition: all 0.3s ease-in-out; cursor: pointer;
        }
        .card h3 { font-size: 20px; margin-bottom: 10px; color: #333; }
        .card p { font-size: 28px; font-weight: bold; margin: 0; color: #2c3e50; }
        .card:hover {
            transform: translateY(-5px) scale(1.03);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            background: linear-gradient(135deg, #ffffff, #f0f0f0);
        }
        a { text-decoration: none; color: inherit; }
        .logout {
            margin-left: 20px; background: #e74c3c;
            padding: 6px 12px; border-radius: 4px; cursor: pointer;
        }
        .logout a { color: white; }
    </style>
</head>
<body>

    <!-- Navbar -->
    <div class="navbar">
        <h1>Admin Dashboard</h1>
        <span>Welcome, <%= adminEmail %></span>
        <span class="logout"><a href="AdminLogoutServlet">Logout</a></span>
    </div>

    <!-- Dashboard Title -->
    <div class="dashboard-title">Dashboard</div>

    <!-- Cards -->
    <div class="cards">
        <a href="user.jsp"><div class="card"><h3>Total Users</h3><p><%= totalUsers %></p></div></a>
        <a href="booking.jsp"><div class="card"><h3>Bookings</h3><p><%= totalBookings %></p></div></a>
        <a href="feedback.jsp"><div class="card"><h3>Feedbacks</h3><p><%= totalFeedbacks %></p></div></a>
        <a href="revenue.jsp"><div class="card"><h3>Revenue</h3><p><%= totalRevenue %></p></div></a>
    </div>

</body>
</html>
