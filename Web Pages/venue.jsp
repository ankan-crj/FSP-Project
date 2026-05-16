<%
    HttpSession session1 = request.getSession(false);
    if(session1 == null || session1.getAttribute("userEmail") == null) {
        response.sendRedirect("index.html");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Wedding Venues - Eventastic</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #fdf8f5; color: #333; }

    nav {
      background-color: #b48c8c;
      color: white;
      padding: 15px 30px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      position: sticky;
      top: 0;
      z-index: 1000;
    }
    .logo { font-size: 24px; font-weight: bold; font-family: 'Playfair Display', serif; }
    nav ul { list-style: none; display: flex; gap: 20px; }
    nav ul li a { color: white; text-decoration: none; padding: 8px 12px; display: block; transition: 0.3s; }
    nav ul li a:hover { background: rgba(255,255,255,0.2); border-radius: 5px; }

    .menu-toggle { display: none; font-size: 24px; cursor: pointer; }
    @media (max-width: 768px) {
      nav ul { display: none; flex-direction: column; background: #b48c8c; position: absolute; top: 60px; right: 0; width: 200px; padding: 10px; }
      nav ul.show { display: flex; }
      .menu-toggle { display: block; }
    }

    /* Hero Banner */
    .hero {
      background: url('https://d12m9erqbesehq.cloudfront.net/wp-content/uploads/sites/2/2023/11/12193749/Types-of-social-events-wedding-celebrations.jpg') no-repeat center center/cover;
      height: 60vh;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-direction: column;
      text-align: center;
      color: #fff;
      padding: 20px;
    }
    .hero h1 { font-size: 40px; margin-bottom: 15px; text-shadow: 1px 1px 4px rgba(0,0,0,0.5); }
    .hero p { font-size: 18px; max-width: 700px; margin: auto; margin-bottom: 20px; text-shadow: 1px 1px 4px rgba(0,0,0,0.5); }
    .hero .btn { background: purple; color: #fff; padding: 12px 25px; margin: 5px; border-radius: 5px; text-decoration: none; font-size: 16px; }

    /* Venues Section */
    .venues-section { padding: 60px 20px; text-align: center; }
    .venues-section h2 { font-size: 32px; margin-bottom: 20px; }
    .venue-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; max-width: 1000px; margin: auto; }

    .venue-card {
      background: white; padding: 25px; border-radius: 12px; text-align: center;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1); transition: 0.3s;
    }
    .venue-card:hover { transform: translateY(-5px); box-shadow: 0 8px 16px rgba(0,0,0,0.2); }
    .venue-card img { width: 100%; height: 180px; object-fit: cover; border-radius: 8px; margin-bottom: 15px; }
    .venue-card h3 { margin-bottom: 10px; }
    .venue-card p { color: #666; font-size: 15px; margin-bottom: 10px; }
    .price { font-size: 20px; font-weight: bold; color: #9c6d6d; margin-bottom: 15px; }
    .btn { display: inline-block; padding: 10px 20px; background: #b48c8c; color: white; border-radius: 8px; text-decoration: none; transition: 0.3s; border: none; cursor: pointer; }
    .btn:hover { background: #9c6d6d; }

    footer { background: #333; color: white; text-align: center; padding: 20px; margin-top: 40px; }
    footer a { color: #b48c8c; margin: 0 10px; text-decoration: none; }
    footer a:hover { text-decoration: underline; }
  </style>
</head>
<body>

  <!-- Navbar -->
  <nav>
    <div class="logo">Eventastic</div>
    <span class="menu-toggle"><i class="fas fa-bars"></i></span>
    <ul>
      <li><a href="index.html">Home</a></li>
      <li><a href="services.jsp">Services</a></li>
      <li><a href="gallery.jsp">Gallery</a></li>
      <li><a href="contact.jsp">Contact</a></li>
      <li>
        <form action="LogoutServlet" method="post">
          <input type="submit" value="Logout">
        </form>
      </li>
    </ul>
  </nav>

  <!-- Hero Banner -->
  <section class="hero">
    <h1>Discover the Perfect Wedding Venue</h1>
    <p>Choose from our curated list of venues in West Bengal for your dream wedding. Book instantly online!</p>
    <a href="#venues" class="btn">View Venues</a>
  </section>

  <!-- Venues Section -->
  <section class="venues-section" id="venues">
    <h2>Choose Your Venue</h2>
    <div class="venue-grid">

      <div class="venue-card">
        <img src="https://cdn0.weddingwire.in/vendor/6909/3_2/960/jpg/banquet-hall-hotel-the-signature-asansol-banquet-hall1_15_316909-159780973314288.webp" alt="The Signature">
        <h3>The Signature</h3>
        <p>Asansol</p>
        <div class="price">80,000</div>
        <form action="VenueServlet" method="post">
          <input type="hidden" name="vname" value="The Signature">
          <input type="hidden" name="vprice" value="80000">
          <button type="submit" class="btn">Book Now</button>
        </form>
      </div>

      <div class="venue-card">
        <img src="https://cdn0.weddingwire.in/vendor/0315/3_2/960/jpg/gallery-celebration-14_15_150315-160681367882879.webp" alt="Celebrations Banquet Hall">
        <h3>Celebrations Banquet Hall</h3>
        <p>Barakar, Kulti</p>
        <div class="price">68,000</div>
        <form action="VenueServlet" method="post">
          <input type="hidden" name="vname" value="Celebrations Banquet Hall">
          <input type="hidden" name="vprice" value="68000">
          <button type="submit" class="btn">Book Now</button>
        </form>
      </div>

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

  <script>
    const toggle = document.querySelector(".menu-toggle");
    const menu = document.querySelector("nav ul");
    toggle.addEventListener("click", () => { menu.classList.toggle("show"); });
  </script>

</body>
</html>
