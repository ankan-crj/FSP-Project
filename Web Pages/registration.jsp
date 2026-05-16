<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Eventastic - Registration</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, sans-serif; }
    body { background: #fff; color: #333; }

    /* Navbar */
    nav {
      background-color: #b48c8c;
      color: white;
      padding: 15px 30px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      position: sticky;
      top: 0;
      z-index: 1000;
    }
    nav .logo {
      font-size: 24px;
      font-weight: bold;
      font-family: 'Playfair Display', serif;
    }
    nav ul {
      list-style: none;
      display: flex;
      gap: 20px;
    }
    nav ul li a {
      color: white;
      text-decoration: none;
      padding: 8px 12px;
    }
    nav ul li a:hover {
      background: rgba(255, 255, 255, 0.2);
      border-radius: 5px;
    }

    /* Hero Section */
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
    .hero h1 { font-size: 40px; margin-bottom: 10px; }
    .hero p { font-size: 18px; max-width: 600px; margin: auto; }

    /* Registration Form */
    .form-section {
      padding: 50px 10%;
      display: flex;
      justify-content: center;
      align-items: center;
      background: #f9f9f9;
    }
    .form-container {
      width: 500px;
      background: #fff;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }
    .form-container h2 {
      text-align: center;
      margin-bottom: 20px;
      color: #b48c8c;
    }
    .form-group {
      margin-bottom: 18px;
    }
    label {
      display: block;
      margin-bottom: 6px;
      font-weight: bold;
      color: #444;
    }
    input, select, textarea {
      width: 100%;
      padding: 12px;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 14px;
    }
    input:focus, select:focus, textarea:focus {
      border-color: #b48c8c;
      outline: none;
    }
    .note {
      font-size: 12px;
      color: gray;
      margin-top: 4px;
    }
    button {
      width: 100%;
      padding: 14px;
      background: purple;
      color: #fff;
      border: none;
      border-radius: 6px;
      font-size: 16px;
      font-weight: bold;
      cursor: pointer;
      transition: 0.3s;
    }
    button:hover {
      background: #b48c8c;
    }
  </style>
</head>
<body>

  <!-- Navbar -->
  <nav>
    <div class="logo">Eventastic</div>
    <ul>
      <li><a href="home.jsp">Home</a></li>
      <li><a href="gallery.jsp">Gallery</a></li>
      <li><a href="contact.jsp">Contact</a></li>
    </ul>
  </nav>

  <!-- Hero -->
  <section class="hero">
    <h1>Register with Eventastic</h1>
    <p>Create your account and start planning your dream events with us!</p>
  </section>

  <!-- Registration Form -->
  <section class="form-section">
    <div class="form-container">
      <h2>Create Account</h2>
      <form action="RegistrationServlet" method="post">
        <div class="form-group">
          <label for="name">Full Name</label>
          <input type="text" id="name" name="name" required>
        </div>

        <div class="form-group">
          <label for="email">Email Address</label>
          <input type="email" id="email" name="email" required>
        </div>

        <div class="form-group">
          <label for="mobile">Mobile Number</label>
          <input type="tel" id="mobile" name="mobile" pattern="[0-9]{10}" maxlength="10" required>
        </div>

        <div class="form-group">
          <label for="address">Address</label>
          <textarea id="address" name="address" rows="2" required></textarea>
        </div>

        <div class="form-group">
          <label for="seq">Security Question</label>
          <select id="seq" name="seq" required>
            <option value="">-- Select a Question --</option>
            <option value="What is your first pet?s name?">What is your first pet?s name?</option>
            <option value="What is the name of your first school?">What is the name of your first school?</option>
            <option value="In which city were you born?">In which city were you born?</option>
          </select>
        </div>

        <div class="form-group">
          <label for="seqa">Security Answer</label>
          <input type="text" id="seqa" name="seqa" required>
        </div>

        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" name="password" minlength="8" maxlength="8" required>
          <div class="note">Password must be exactly 8 characters</div>
        </div>

        <button type="submit">Register</button>
      </form>
      <p style="text-align:center; margin-top:15px; font-size:14px;">
  Already have an account? <a href="login.jsp" style="color:purple; font-weight:bold; text-decoration:none;">Login here</a>
</p>

    </div>
      
  </section>
  

</body>
</html>
