<%
    if(session == null || session.getAttribute("userEmail") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String eventName = request.getParameter("event");
    if(eventName == null || eventName.trim().isEmpty()){
        eventName = "No Event Selected";
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Eventastic - Event Management</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #fdf8f5; color: #333; line-height: 1.6; }

    /* Navbar */
    nav { background-color: #b48c8c; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; position: sticky; top: 0; z-index: 1000; }
    .logo { font-size: 24px; font-weight: bold; font-family: 'Playfair Display', serif; }
    nav ul { list-style: none; display: flex; gap: 20px; }
    nav ul li { position: relative; }
    nav ul li a { color: white; text-decoration: none; padding: 8px 12px; transition: 0.3s; display: block; }
    nav ul li a:hover { background: rgba(255, 255, 255, 0.2); border-radius: 5px; }
    .dropdown-menu { display: none; position: absolute; top: 100%; left: 0; background: #fff; min-width: 160px; box-shadow: 0px 8px 16px rgba(0,0,0,0.2); border-radius: 6px; z-index: 1000; }
    .dropdown-menu ul { list-style: none; padding: 0; margin: 0; display: block; }
    .dropdown-menu ul li { display: block; width: 100%; }
    .dropdown-menu ul li a { color: #333; padding: 12px 16px; display: block; text-decoration: none; }
    .dropdown-menu ul li a:hover { background: #f0f0f0; border-radius: 4px; }
    nav ul li:hover .dropdown-menu { display: block; }

    /* Hero */
    .hero { background: url('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxNAypBqeUnHtcF8zmsSFyEJSpOsCTZjEk0g&s') no-repeat center center/cover; height: 80vh; display: flex; justify-content: center; align-items: center; text-align: center; color: white; position: relative; }
    .hero::after { content: ""; position: absolute; top: 0; left: 0; right: 0; bottom: 0; background: rgba(0,0,0,0.5); }
    .hero-content { position: relative; z-index: 1; }
    .hero h1 { font-size: 50px; margin-bottom: 15px; text-shadow: 2px 2px 5px rgba(0,0,0,0.7); }
    .hero p { font-size: 18px; margin-bottom: 20px; text-shadow: 1px 1px 3px rgba(0,0,0,0.6); }
    .btn { display: inline-block; padding: 12px 25px; background: #b48c8c; color: white; text-decoration: none; border-radius: 8px; transition: 0.3s; }
    .btn:hover { background: #9c6d6d; }

    /* About */
    .about { padding: 60px 20px; text-align: center; }
    .about h2 { font-size: 32px; margin-bottom: 20px; }
    .about p { max-width: 800px; margin: auto; font-size: 18px; color: #555; }

    /* Services */
    .services { padding: 60px 20px; }
    .services h2 { text-align: center; font-size: 32px; margin-bottom: 30px; }
    .service-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; }
    .service-card { background: white; padding: 25px; border-radius: 12px; text-align: center; box-shadow: 0 4px 10px rgba(0,0,0,0.1); transition: 0.3s; }
    .service-card:hover { transform: translateY(-5px); box-shadow: 0 8px 16px rgba(0,0,0,0.2); }
    .service-card i { font-size: 40px; color: #b48c8c; margin-bottom: 15px; }
    .service-card a { text-decoration: none; color: inherit; }

    /* Testimonials */
    .testimonials { padding: 60px 20px; background: #f4eaea; }
    .testimonials h2 { text-align: center; font-size: 32px; margin-bottom: 30px; }
    .testimonial-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; max-width: 1000px; margin: auto; }
    .testimonial { background: white; padding: 20px; border-radius: 12px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
    .testimonial p { font-style: italic; margin-bottom: 10px; }
    .testimonial h4 { text-align: right; font-size: 16px; color: #555; }

    /* Contact */
    .contact { padding: 60px 20px; text-align: center; }
    .contact h2 { font-size: 32px; margin-bottom: 20px; }
    form { max-width: 600px; margin: auto; display: flex; flex-direction: column; gap: 15px; }
    form input, form textarea, form select { padding: 12px; border: 1px solid #ccc; border-radius: 8px; font-size: 16px; }
    form button { padding: 12px; background: #b48c8c; color: white; border: none; border-radius: 8px; cursor: pointer; font-size: 18px; }
    form button:hover { background: #9c6d6d; }

    /* Footer */
    footer { background: #333; color: white; text-align: center; padding: 20px; margin-top: 40px; }
    footer a { color: #b48c8c; margin: 0 10px; text-decoration: none; }
    footer a:hover { text-decoration: underline; }

    /* Mobile */
    .menu-toggle { display: none; font-size: 24px; cursor: pointer; }
    @media (max-width: 768px) {
      nav ul { display: none; flex-direction: column; background: #b48c8c; position: absolute; top: 60px; right: 0; width: 200px; padding: 10px; }
      nav ul.show { display: flex; }
      .menu-toggle { display: block; }
    }
  </style>
</head>
<body>

  <!-- Navbar -->
  <nav>
    <div class="logo">Eventastic</div>
    <span class="menu-toggle"><i class="fas fa-bars"></i></span>
    <ul>
      <li><a href="index.html">Home</a></li>
      <li><a href="bookingdetails.jsp">Bookings</a></li>
      <li>
        <a href="#">Services</a>
        <div class="dropdown-menu">
          <ul>
            <li><a href="events.jsp?event=<%=java.net.URLEncoder.encode("Wedding Planning","UTF-8")%>">Wedding Planning</a></li>
            <li><a href="events.jsp?event=<%=java.net.URLEncoder.encode("Engagement Planning","UTF-8")%>">Engagement Planning</a></li>
            <li><a href="events.jsp?event=<%=java.net.URLEncoder.encode("Birthday Party","UTF-8")%>">Birthday Party</a></li>
            <li><a href="events.jsp?event=<%=java.net.URLEncoder.encode("Rice Ceremony","UTF-8")%>">Rice Ceremony</a></li>
            <li><a href="events.jsp?event=<%=java.net.URLEncoder.encode("Anniversary Celebration","UTF-8")%>">Anniversary Celebration</a></li>
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

  <!-- Hero -->
  <section class="hero">
    <div class="hero-content">
      <h1>Making Your Events Memorable</h1>
      
    </div>
  </section>

  <!-- About -->
  <section class="about">
    <h2>About Us</h2>
    <p>At Eventastic, we specialize in creating unforgettable experiences. From weddings and birthdays to corporate events, our team ensures every detail is perfect. With creative planning and flawless execution, we turn your dreams into reality.</p>
  </section>

  <!-- Services -->
  <section class="services">
    <h2>Book Services</h2>
    <div class="service-grid">
      <div class="service-card"><a href="EventServlet?event=<%=java.net.URLEncoder.encode("Wedding Planning","UTF-8")%>"><i class="fas fa-heart"></i><h3>Wedding Planning</h3></a></div>
      <div class="service-card"><a href="EventServlet?event=<%=java.net.URLEncoder.encode("Engagement Planning","UTF-8")%>"><i class="fas fa-heart"></i><h3>Engagement Planning</h3></a></div>
      <div class="service-card"><a href="EventServlet?event=<%=java.net.URLEncoder.encode("Birthday Party","UTF-8")%>"><i class="fas fa-birthday-cake"></i><h3>Birthday Party</h3></a></div>
      <div class="service-card"><a href="EventServlet?event=<%=java.net.URLEncoder.encode("Rice Ceremony","UTF-8")%>"><i class="fas fa-baby"></i><h3>Rice Ceremony</h3></a></div>
      <div class="service-card"><a href="EventServlet?event=<%=java.net.URLEncoder.encode("Anniversary Celebration","UTF-8")%>"><i class="fas fa-glass-cheers"></i><h3>Anniversary Celebration</h3></a></div>
      <div class="service-card"><a href="photography.jsp"><i class="fas fa-camera"></i><h3>Photography</h3></a></div>
      <div class="service-card"><a href="catering.jsp"><i class="fas fa-utensils"></i><h3>Catering</h3></a></div>
      <div class="service-card"><a href="decoration.jsp"><i class="fas fa-palette"></i><h3>Decoration</h3></a></div>
      <div class="service-card"><a href="venue.jsp"><i class="fas fa-house"></i><h3>Venue</h3></a></div>
    </div>
  </section>

  <!-- Testimonials -->
  <section class="testimonials">
    <h2>What Our Clients Say</h2>
    <div class="testimonial-grid">
      <div class="testimonial"><p>"Eventastic made our wedding unforgettable! The decoration was magical and everything was perfectly organized."</p><h4>- Priya & Arjun</h4></div>
      <div class="testimonial"><p>"The birthday party for my son was amazing. From food to games, everything was top notch!"</p><h4>- Ramesh Gupta</h4></div>
      <div class="testimonial"><p>"We hired them for our anniversary celebration and it was flawless. Highly recommended!"</p><h4>- Sneha & Rohit</h4></div>
    </div>
  </section>

  

  <!-- Footer -->
  <footer>
    <p>© 2025 Eventastic. All Rights Reserved.</p>
    <p>
      <a href="#"><i class="fab fa-facebook"></i></a>
      <a href="#"><i class="fab fa-instagram"></i></a>
      <a href="#"><i class="fab fa-whatsapp"></i></a>
    </p>
  </footer>

  <!-- JS for mobile menu -->
  <script>
    const toggle = document.querySelector(".menu-toggle");
    const menu = document.querySelector("nav ul");
    toggle.addEventListener("click", () => {
      menu.classList.toggle("show");
    });
  </script>

</body>
</html>
