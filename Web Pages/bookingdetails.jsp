<%@ page import="java.sql.*" %>
<%
    if(session == null || session.getAttribute("userEmail") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String userEmail = (String) session.getAttribute("userEmail");

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Booking Tickets - Eventastic</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #fdf8f5; margin: 0; color: #333; }
    .container { max-width: 1000px; margin: 30px auto; padding: 0 15px; }
    .ticket { background: #fff; border-radius: 15px; margin-bottom: 30px; padding: 20px 30px; box-shadow: 0 6px 20px rgba(0,0,0,0.1); position: relative; }
    .ticket-header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px dashed #b48c8c; padding-bottom: 10px; margin-bottom: 15px; }
    .ticket-header h2 { margin: 0; font-size: 22px; color: #b48c8c; }
    .ticket-body { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
    .ticket-body div { padding: 10px; background: #f9f0f0; border-radius: 10px; }
    .ticket-body div h4 { margin: 0 0 5px 0; color: #b48c8c; font-size: 14px; }
    .ticket-body div p { margin: 0; font-size: 16px; font-weight: 600; }
    .ticket-footer { text-align: right; margin-top: 15px; font-size: 18px; font-weight: 700; color: #b48c8c; }
    .no-booking { text-align: center; padding: 50px; font-size: 22px; color: #b48c8c; }
    .back-btn { display: inline-block; margin: 20px auto; padding: 10px 25px; background: #b48c8c; color: white; border-radius: 5px; text-decoration: none; text-align: center; }
    .back-btn:hover { background: #9c6d6d; }
</style>
</head>
<body>

<div class="container">
<%
    boolean hasBooking = false;
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","manager");

        String sql = "SELECT event, vname, vprice, cfi, cfp, dpk, dpr, spk, spr, guests, edate " +
                     "FROM registration WHERE email=? AND payment='paid'";
        ps = conn.prepareStatement(sql);
        ps.setString(1, userEmail);
        rs = ps.executeQuery();

        if(rs.next()){ 
            hasBooking = true;
            do{
                String event = rs.getString("event");
                String vname = rs.getString("vname");
                int vprice = rs.getInt("vprice");
                String cfi = rs.getString("cfi");
                int guests = rs.getInt("guests");
                int cfp = rs.getInt("cfp")/guests;
                String dpk = rs.getString("dpk");
                int dpr = rs.getInt("dpr");
                String spk = rs.getString("spk");
                int spr = rs.getInt("spr");
                Date edate = rs.getDate("edate");
                int totalPrice = vprice + (cfp*guests) + dpr + spr;
%>

<div class="ticket">
    <div class="ticket-header">
        <h2>Event: <%= event %></h2>
        <span>Guests: <%= guests %></span>
    </div>

    <div class="ticket-body">
        <div>
            <h4>Venue</h4>
            <p><%= vname %> (<%= vprice %>)</p>
        </div>
        <div>
            <h4>Food</h4>
            <p><%= cfi %> (<%= cfp %> per guest)</p>
        </div>
        <div>
            <h4>Decoration</h4>
            <p><%= dpk %> (<%= dpr %>)</p>
        </div>
        <div>
            <h4>Photography</h4>
            <p><%= spk %> (<%= spr %>)</p>
        </div>
        <div>
            <h4>Event Date</h4>
            <p><%= edate != null ? new java.text.SimpleDateFormat("dd-MM-yyyy").format(edate) : "Not Set" %></p>
        </div>
        <div>
            <h4>Total Price</h4>
            <p><%= totalPrice %></p>
        </div>
    </div>

    <form action="CancelBookingServlet" method="post" style="margin-top:10px; text-align:right;">
        <input type="hidden" name="event" value="<%= event %>">
        <input type="submit" value="Cancel Booking" style="background:#b48c8c;">
    </form>
</div>

<%
            } while(rs.next());
        }

        if(!hasBooking){
%>
<div class="no-booking">You have not booked any event yet.</div>
<%
        }
    } catch(Exception e){
        e.printStackTrace();
%>
<div class="no-booking">Error fetching booking details.</div>
<%
    } finally{
        if(rs!=null) try{ rs.close(); }catch(Exception e){}
        if(ps!=null) try{ ps.close(); }catch(Exception e){}
        if(conn!=null) try{ conn.close(); }catch(Exception e){}
    }
%>
<a href="userhome.jsp" class="back-btn">Back</a>
</div>

</body>
</html>
