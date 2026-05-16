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
  <title>Bride & Groom Styling - Eventastic</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #fdf8f5; color: #333; line-height: 1.6; }

    nav { background-color: #b48c8c; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; position: sticky; top: 0; z-index: 1000; }
    .logo { font-size: 24px; font-weight: bold; font-family: 'Playfair Display', serif; }
    nav ul { list-style: none; display: flex; gap: 20px; }
    nav ul li a { color: white; text-decoration: none; padding: 8px 12px; display: block; transition: 0.3s; }
    nav ul li a:hover { background: rgba(255,255,255,0.2); border-radius: 5px; }

    .packages { padding: 60px 20px; text-align: center; }
    .packages h2 { font-size: 32px; margin-bottom: 20px; }
    .package-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; max-width: 1000px; margin: auto; }
    .package-card { background: white; padding: 25px; border-radius: 12px; text-align: center; box-shadow: 0 4px 10px rgba(0,0,0,0.1); transition: 0.3s; }
    .package-card:hover { transform: translateY(-5px); box-shadow: 0 8px 16px rgba(0,0,0,0.2); }
    .package-card i { font-size: 45px; color: #b48c8c; margin-bottom: 15px; }
    .package-card h3 { margin-bottom: 10px; }
    .package-card p { color: #666; font-size: 15px; margin-bottom: 15px; }
    .price { font-size: 20px; font-weight: bold; color: #9c6d6d; margin-bottom: 15px; }
    .btn { display: inline-block; padding: 10px 20px; background: #b48c8c; color: white; border-radius: 8px; text-decoration: none; transition: 0.3s; }
    .btn:hover { background: #9c6d6d; }

    footer { background: #333; color: white; text-align: center; padding: 20px; margin-top: 40px; }
    footer a { color: #b48c8c; margin: 0 10px; text-decoration: none; }
    footer a:hover { text-decoration: underline; }

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

  <!-- Styling Packages -->
  <section class="packages">
    <h2>Choose Your Bride & Groom Styling Package</h2>
    <div class="package-grid">

      <!-- Basic Styling -->
      <div class="package-card">
        <i class="fas fa-user-tie"></i>
        <h3>Basic Styling</h3>
        <p>Simple makeup & hair for bride, minimal grooming for groom.</p>
        <div class="price">5,000</div>
        <form action="StylingServlet" method="post">
          <input type="hidden" name="package" value="Basic">
          <input type="hidden" name="price" value="5000">
          <button type="submit" class="btn">Book Now</button>
        </form>
      </div>

      <!-- Premium Styling -->
      <div class="package-card">
        <i class="fas fa-user-tie"></i>
        <h3>Premium Styling</h3>
        <p>Professional makeup & hair, grooming for groom, trial session included.</p>
        <div class="price">12,000</div>
        <form action="StylingServlet" method="post">
          <input type="hidden" name="package" value="Premium">
          <input type="hidden" name="price" value="12000">
          <button type="submit" class="btn">Book Now</button>
        </form>
      </div>

      <!-- Deluxe Styling -->
      <div class="package-card">
        <i class="fas fa-user-tie"></i>
        <h3>Deluxe Styling</h3>
        <p>Full-day styling, bridal & groom, multiple looks, photo-ready makeup.</p>
        <div class="price">20,000</div>
        <form action="StylingServlet" method="post">
          <input type="hidden" name="package" value="Deluxe">
          <input type="hidden" name="price" value="20000">
          <button type="submit" class="btn">Book Now</button>
        </form>
      </div>

    </div>
  </section>

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
    toggle.addEventListener("click", () => {
      menu.classList.toggle("show");
    });
  </script>

</body>
</html>
