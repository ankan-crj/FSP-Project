<%@ page import="java.sql.*" %>
<%
    if (session == null || session.getAttribute("adminEmail") == null) {
        response.sendRedirect("adminlogin.jsp?error=2");
        return;
    }
    String adminEmail = (String) session.getAttribute("adminEmail");

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "manager");

        String sqlFeedback = "SELECT name, email, feedback FROM feedback"; // replace feedback_table with your actual table
        ps = conn.prepareStatement(sqlFeedback);
        rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Feedback Report</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f6f9; margin: 0; padding: 0; }
        .navbar {
            background: #2c3e50; color: white; padding: 15px 30px;
            display: flex; justify-content: space-between; align-items: center;
        }
        .navbar h1 { margin: 0; font-size: 20px; }
        .container { max-width: 900px; margin: 80px auto; background: white; padding: 30px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        h2 { margin-bottom: 20px; color: #333; }
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
        <h1>Admin - Feedback</h1>
        <a href="adminuserhome.jsp" style="color:white; text-decoration:none;">Back to Dashboard</a>
    </div>

    <div class="container">
        <h2>User Feedback</h2>
        <table>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Feedback</th>
            </tr>
<%
        while(rs.next()) {
            String name = rs.getString("name");
            String email = rs.getString("email");
            String feedback = rs.getString("feedback");
%>
            <tr>
                <td><%= name %></td>
                <td><%= email %></td>
                <td><%= feedback %></td>
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
