<%@ page import="java.sql.*" %>
<%
    if (session == null || session.getAttribute("adminEmail") == null) {
        response.sendRedirect("adminlogin.jsp?error=2");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Bookings</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f6f9; margin: 0; padding: 0; }
        .navbar {
            background: #2c3e50; color: white; padding: 15px 30px;
            display: flex; justify-content: space-between; align-items: center;
            box-shadow: 0 2px 6px rgba(0,0,0,0.2);
        }
        .navbar h1 { margin: 0; font-size: 20px; }
        .container { max-width: 1400px; margin: 40px auto; background: white;
            padding: 20px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); overflow-x:auto; }
        h2 { text-align: center; margin-bottom: 20px; color: #333; }
        table {
            width: 100%; border-collapse: collapse; margin-top: 20px;
        }
        th, td {
            padding: 12px 15px; border: 1px solid #ddd; text-align: center;
            font-size: 14px;
        }
        th {
            background: #34495e; color: white; font-size: 15px;
        }
        tr:nth-child(even) { background: #f9f9f9; }
        tr:hover { background: #f1f1f1; }
        .back-btn {
            display: inline-block; margin-top: 20px; padding: 10px 20px;
            background: #3498db; color: white; text-decoration: none;
            border-radius: 6px; transition: 0.3s;
        }
        .back-btn:hover { background: #2980b9; }
    </style>
</head>
<body>

    <div class="navbar">
        <h1>Admin - Bookings</h1>
        <a href="adminuserhome.jsp" style="color:white; text-decoration:none;">Back to Dashboard</a>
    </div>

    <div class="container">
        <h2>All Bookings</h2>
        <table>
            <tr>
                <th>Email</th>
                <th>Name</th>
                <th>Mobile</th>
                <th>Address</th>
                <th>Event</th>
                <th>Venue</th>
                <th>Venue Price</th>
                <th>Decoration</th>
                <th>Decoration Price</th>
                <th>Styling Package</th>
                <th>Styling Price</th>
                <th>Catering Items</th>
                <th>Catering Price</th>
                <th>Guests</th>
                <th>Payment Status</th>
            </tr>
            <%
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "manager");

                    String sql = "SELECT email, name, mobile, address, event, vname, vprice, dpk, dpr, spk, spr, cfi, cfp, guests, payment FROM registration";
                    ps = conn.prepareStatement(sql);
                    rs = ps.executeQuery();
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("mobile") %></td>
                <td><%= rs.getString("address") %></td>
                <td><%= rs.getString("event") %></td>
                <td><%= rs.getString("vname") %></td>
                <td><%= rs.getInt("vprice") %></td>
                <td><%= rs.getString("dpk") %></td>
                <td><%= rs.getInt("dpr") %></td>
                <td><%= rs.getString("spk") %></td>
                <td><%= rs.getInt("spr") %></td>
                <td><%= rs.getString("cfi") %></td>
                <td><%= rs.getInt("cfp") %></td>
                <td><%= rs.getInt("guests") %></td>
                <td><%= rs.getString("payment") %></td>
            </tr>
            <%
                    }
                } catch(Exception e) {
                    e.printStackTrace();
                } finally {
                    if(rs != null) try { rs.close(); } catch(Exception e){}
                    if(ps != null) try { ps.close(); } catch(Exception e){}
                    if(conn != null) try { conn.close(); } catch(Exception e){}
                }
            %>
        </table>
        <a href="adminuserhome.jsp" class="back-btn">Back</a>
    </div>

</body>
</html>
