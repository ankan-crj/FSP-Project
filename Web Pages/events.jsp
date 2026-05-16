<%@ page import="java.sql.*,java.text.SimpleDateFormat" %>
<%
    // Check user session
    if (session == null || session.getAttribute("userEmail") == null) {
        response.sendRedirect("index.html");
        return;
    }

    String userEmail = (String) session.getAttribute("userEmail");
    String eventName = "No Event Selected";

    String bookedPhotography = null, bookedPhotographyPrice = null;
    String bookedCatering = null, bookedCateringPrice = null;
    String bookedDecoration = null, bookedDecorationPrice = null;
    String bookedVenue = null, bookedVenuePrice = null;
    String bookedStyling = null, bookedStylingPrice = null;
    java.sql.Date bookedDate = null;

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","manager");

        ps = conn.prepareStatement("SELECT event, ppk, ppr, cfi, cfp, dpk, dpr, vname, vprice, spk, spr, edate FROM registration WHERE email = ?");
        ps.setString(1, userEmail);
        rs = ps.executeQuery();

        if (rs.next()) {
            String dbEvent = rs.getString("event");
            if (dbEvent != null && !dbEvent.trim().isEmpty()) eventName = dbEvent;

            bookedPhotography = rs.getString("ppk");
            bookedPhotographyPrice = rs.getString("ppr");

            bookedCatering = rs.getString("cfi");
            bookedCateringPrice = rs.getString("cfp");

            bookedDecoration = rs.getString("dpk");
            bookedDecorationPrice = rs.getString("dpr");

            bookedVenue = rs.getString("vname");
            bookedVenuePrice = rs.getString("vprice");

            bookedStyling = rs.getString("spk");
            bookedStylingPrice = rs.getString("spr");

            bookedDate = rs.getDate("edate");
        }
    } catch(Exception e) { e.printStackTrace(); }
    finally {
        if(rs!=null) try{rs.close();}catch(Exception e){}
        if(ps!=null) try{ps.close();}catch(Exception e){}
        if(conn!=null) try{conn.close();}catch(Exception e){}
    }

    double totalPrice = 0;
    if(bookedPhotographyPrice!=null && !bookedPhotographyPrice.isEmpty()) totalPrice += Double.parseDouble(bookedPhotographyPrice);
    if(bookedCateringPrice!=null && !bookedCateringPrice.isEmpty()) totalPrice += Double.parseDouble(bookedCateringPrice);
    if(bookedDecorationPrice!=null && !bookedDecorationPrice.isEmpty()) totalPrice += Double.parseDouble(bookedDecorationPrice);
    if(bookedVenuePrice!=null && !bookedVenuePrice.isEmpty()) totalPrice += Double.parseDouble(bookedVenuePrice);
    if(bookedStylingPrice!=null && !bookedStylingPrice.isEmpty()) totalPrice += Double.parseDouble(bookedStylingPrice);
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Eventastic - Your Event</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
/* Include your original CSS here (same as before) */
* { margin:0; padding:0; box-sizing:border-box; }
body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background:#fdf8f5; color:#333; line-height:1.6; }
nav { background-color:#b48c8c; color:white; padding:15px 30px; display:flex; justify-content:space-between; align-items:center; position:sticky; top:0; z-index:1000; }
.logo { font-size:24px; font-weight:bold; font-family:'Playfair Display', serif; }
nav ul { list-style:none; display:flex; gap:20px; }
nav ul li a { color:white; text-decoration:none; padding:8px 12px; display:block; }
nav ul li a:hover { background: rgba(255,255,255,0.2); border-radius:5px; }
.dropdown-menu { display:none; position:absolute; top:100%; left:0; background:#fff; min-width:160px; box-shadow:0px 8px 16px rgba(0,0,0,0.2); border-radius:6px; z-index:1000; }
nav ul li:hover .dropdown-menu { display:block; }
.hero { background: url('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxNAypBqeUnHtcF8zmsSFyEJSpOsCTZjEk0g&s') no-repeat center center/cover; height:50vh; display:flex; justify-content:center; align-items:center; text-align:center; color:white; position:relative; }
.hero::after { content:""; position:absolute; top:0; left:0; right:0; bottom:0; background:rgba(0,0,0,0.5); }
.hero-content { position:relative; z-index:1; }
.hero h1 { font-size:40px; margin-bottom:10px; text-shadow:2px 2px 5px rgba(0,0,0,0.7); }
.services { padding:60px 20px; }
.services h2 { text-align:center; font-size:32px; margin-bottom:30px; }
.service-grid { display:flex; gap:20px; overflow-x:auto; }
.service-card { flex:0 0 auto; width:250px; background:white; padding:25px; border-radius:12px; text-align:center; box-shadow:0 4px 8px rgba(0,0,0,0.1); transition:0.3s; }
.service-card:hover { transform:translateY(-5px); box-shadow:0 8px 16px rgba(0,0,0,0.2); }
.service-card i { font-size:40px; color:#b48c8c; margin-bottom:15px; }
.book-now-btn { display:block; width:200px; margin:30px auto 0 auto; text-align:center; padding:12px 0; background:#28a745; color:#fff; font-size:16px; border-radius:8px; border:none; cursor:pointer; }
.total-price { text-align:center; font-size:22px; color:#b48c8c; margin-top:20px; }
footer { background:#333; color:white; text-align:center; padding:20px; margin-top:40px; }
footer a { color:#b48c8c; margin:0 10px; text-decoration:none; }
footer a:hover { text-decoration:underline; }
.menu-toggle { display:none; font-size:24px; cursor:pointer; }
@media (max-width:768px) { 
    nav ul { display:none; flex-direction:column; background:#b48c8c; position:absolute; top:60px; right:0; width:200px; padding:10px; } 
    nav ul.show { display:flex; } 
    .menu-toggle { display:block; } 
}
</style>
</head>
<body>

<nav>
    <div class="logo">Eventastic</div>
    <span class="menu-toggle"><i class="fas fa-bars"></i></span>
    <ul>
        <li><a href="index.html">Home</a></li>
        <li>
            <a href="#">Services</a>
            <div class="dropdown-menu">
                <ul>
                    <li><a href="#">Wedding Planning</a></li>
                    <li><a href="#">Engagement Planning</a></li>
                    <li><a href="#">Birthday Party</a></li>
                    <li><a href="#">Rice Ceremony</a></li>
                    <li><a href="#">Anniversary Celebration</a></li>
                    <li><a href="#">Photography</a></li>
                    <li><a href="#">Catering</a></li>
                    <li><a href="#">Decoration</a></li>
                </ul>
            </div>
        </li>
        <li><a href="gallery.jsp">Gallery</a></li>
        <li><a href="contact.jsp">Contact</a></li>
        <li>
            <form action="LogoutServlet" method="post">
                <input type="submit" value="Logout">
            </form>
        </li>
    </ul>
</nav>

<section class="hero">
    <div class="hero-content">
        <h1>Your Selected Event</h1>
        <h2><%= eventName %></h2>
        <form action="DateServlet" method="post">
            <label for="edate" style="color:white;">Select Event Date: </label>
            <input type="date" id="edate" name="edate" value="<%= bookedDate != null ? new SimpleDateFormat("yyyy-MM-dd").format(bookedDate) : "" %>">
            <button type="submit" class="book-now-btn" style="margin-top:10px;">Update Date</button>
        </form>
    </div>
</section>



<section class="services">
    <h2>Your Booked Services</h2>
    <div class="service-grid">

        <div class="service-card">
            <i class="fas fa-camera"></i>
            <h3>Photography</h3>
            <p><%= (bookedPhotography != null && !bookedPhotography.isEmpty()) ? bookedPhotography : "Not Booked" %></p>
            <p>Price: <%= (bookedPhotographyPrice != null) ? bookedPhotographyPrice : "0" %></p>
        </div>

        <div class="service-card">
            <i class="fas fa-utensils"></i>
            <h3>Catering</h3>
            <p><%= (bookedCatering != null && !bookedCatering.isEmpty()) ? bookedCatering : "Not Booked" %></p>
            <p>Price: <%= (bookedCateringPrice != null) ? bookedCateringPrice : "0" %></p>
        </div>

        <div class="service-card">
            <i class="fas fa-palette"></i>
            <h3>Decoration</h3>
            <p><%= (bookedDecoration != null && !bookedDecoration.isEmpty()) ? bookedDecoration : "Not Booked" %></p>
            <p>Price: <%= (bookedDecorationPrice != null) ? bookedDecorationPrice : "0" %></p>
        </div>

        <div class="service-card">
            <i class="fas fa-house"></i>
            <h3>Venue</h3>
            <p><%= (bookedVenue != null && !bookedVenue.isEmpty()) ? bookedVenue : "Not Booked" %></p>
            <p>Price: <%= (bookedVenuePrice != null) ? bookedVenuePrice : "0" %></p>
        </div>

        <div class="service-card">
            <i class="fas fa-spa"></i>
            <h3>Styling</h3>
            <p><%= (bookedStyling != null && !bookedStyling.isEmpty()) ? bookedStyling : "Not Booked" %></p>
            <p>Price: <%= (bookedStylingPrice != null) ? bookedStylingPrice : "0" %></p>
        </div>

    </div>

    <div class="total-price">
        Total Amount: <%= totalPrice %>
    </div>

    <form action="payment.jsp" method="get" style="text-align:center; margin-top:20px;">
        <input type="hidden" name="price" value="<%= totalPrice %>">
        <button type="submit" class="book-now-btn">Book Now</button>
    </form>
</section>

<footer>
    <p>© 2025 Eventastic. All Rights Reserved.</p>
</footer>

<script>
const toggle = document.querySelector(".menu-toggle");
const menu = document.querySelector("nav ul");
toggle.addEventListener("click", () => { menu.classList.toggle("show"); });
</script>

</body>
</html>
