<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Contact</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <!-- Font Awesome CDN for social/icons -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
  <style>
    /* FIXED NAVBAR WITH LEFT AND RIGHT ALIGNMENTS */
    .navbar {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      background: #b48c8c;
      padding: 12px 60px;
      box-sizing: border-box;
      z-index: 1000;
      display: flex;
      justify-content: center;
    }
    .nav-container {
      max-width: 1740px;
      width: 100%;
      display: flex;
      justify-content: space-between;
      align-items: center;
      flex-wrap: nowrap; /* prevent wrapping */
    }
    .nav-title {
      font-family: 'Playfair Display', serif;
      font-size: 24px;
      font-weight: bold;
      color: #fff;
      white-space: nowrap;
      flex-shrink: 0;
    }
    .nav-links {
      display: flex;
      gap: 20px;
      white-space: nowrap;
      flex-shrink: 0;
    }
    .nav-links a {
      color: #fff;
      font-family: 'Arial', sans-serif;
      font-size: 17px;
      font-weight: normal;
      text-decoration: none;
      transition: color 0.18s;
    }
    .nav-links a:hover {
      color: #e0e0e0;
    }
    /* Push main content down so navbar doesn't cover it */
    body > .contact-header {
      padding-top: 105px;
    }
    /* General body and content styles */
    body {
      font-family: 'Montserrat', 'Arial', sans-serif;
      margin: 0;
      background: #fff;
    }
    .contact-header {
      /* Remove background image and gradient */
      color: #b48c8c;
      padding: 3.5rem 5vw 2rem 5vw;
      text-align: left;
      position: relative;
      max-width: 1450px;
      margin: 0 auto;
      box-sizing: border-box;
      background: none;
    }
    .contact-header h1 {
      font-size: 2.7rem;
      font-weight: bold;
      margin-bottom: 1rem;
      max-width: 700px;
    }
    .contact-header p {
      font-size: 1.15rem;
      margin-bottom: 0.4rem;
      max-width: 700px;
      color: black; /* changed from white */
    }
    .main-content {
      display: flex;
      justify-content: center;
      align-items: flex-start;
      gap: 3vw;
      max-width: 1100px;
      margin: 0 auto;
      padding: 3.5rem 5vw 2rem 5vw;
      box-sizing: border-box;
      flex-wrap: wrap;
    }
    .contact-info, .contact-form {
      min-width: 300px;
      flex: 1 1 46%;
      box-sizing: border-box;
    }
    .contact-info img {
      width: 10.5rem;
      margin-bottom: 0.7rem;
    }
    .contact-info h2 {
      font-size: 2rem;
      margin-top: 1rem;
      margin-bottom: 1.5rem;
      font-weight: bold;
      letter-spacing: 1px;
      color: #b48c8c;
    }
    .contact-row {
      display: flex;
      align-items: center;
      margin-bottom: 1rem;
    }
    .contact-row i {
      font-size: 2rem;
      color: #673ab7;
      margin-right: 1rem;
      min-width: 2rem;
    }
    .contact-label {
      font-size: 1rem;
      color: #555;
      margin-bottom: 0.2rem;
    }
    .contact-value {
      font-size: 1.07rem;
      font-weight: bold;
      color: #000;
    }
    .contact-email {
      font-weight: bold;
      color: #000;
      font-size: 1.07rem;
    }
    .social-row {
      margin-top: 1rem;
    }
    .social-row a {
      display: inline-block;
      margin-right: 1rem;
      width: 2.25rem;
      height: 2.25rem;
      text-align: center;
      border-radius: 50%;
      background: #efefef;
      color: #fff;
      font-size: 1.4rem;
      line-height: 2.25rem;
      transition: box-shadow 0.2s;
    }
    .social-row a:nth-child(1) { background: #C13584; }
    .social-row a:nth-child(2) { background: #FF0000; }
    .social-row a:nth-child(3) { background: #4267B2; }
    .social-row a:nth-child(4) { background: #0077b5; }
    .social-row a:nth-child(5) { background: #1da1f2; }
    .social-row a:hover { box-shadow: 0 3px 12px rgba(100,50,100,0.18); }
    .contact-form .form-group {
      margin-bottom: 1.4rem;
    }
    .contact-form input,
    .contact-form textarea {
      width: 100%;
      padding: 0.75rem 1rem;
      font-size: 1rem;
      border: 1px solid #d0cfcf;
      border-radius: 6px;
      background: #fafafa;
      transition: border-color 0.2s;
      margin-top: 0.4rem;
      box-sizing: border-box;
    }
    .contact-form input:focus,
    .contact-form textarea:focus {
      border-color: #925eab;
      outline: none;
    }
    .contact-form label {
      font-size: 1.09rem;
      color: #2a2a2a;
      font-weight: 500;
    }
    .contact-form textarea {
      resize: none;
    }
    .submit-btn {
      background: #6c4789;
      color: #fff;
      border: none;
      font-weight: 600;
      padding: 0.75rem 3.25rem;
      border-radius: 6px;
      font-size: 1.07rem;
      cursor: pointer;
      margin-top: 0.5rem;
      transition: background-color 0.3s;
    }
    .submit-btn:hover {
      background: #43235a;
    }
    @media (max-width: 900px) {
      .main-content {
        flex-direction: column;
        align-items: center;
        gap: 1.5rem;
        padding: 2rem 3vw 1.5rem 3vw;
      }
      .contact-info, .contact-form {
        width: 96%;
        min-width: auto;
      }
      .contact-header h1, .contact-header p {
        margin-left: 3vw;
        max-width: 100%;
      }
      .navbar {
        padding: 12px 20px !important;
      }
    }
    @media (max-width: 550px) {
      .contact-header h1 {
        font-size: 2rem;
      }
      .contact-info h2 {
        font-size: 1.4rem;
      }
      .main-content {
        padding-top: 1.75rem;
        gap: 1rem;
      }
      .nav-title {
        font-size: 1.4rem !important;
      }
      .nav-links a {
        font-size: 1rem !important;
      }
    }
  </style>
</head>
<body>
    
    <nav style="background: #b48c8c; width: 94.09%; margin: 40px auto 0 auto; box-sizing: border-box; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center;">
       <div style="font-size: 24px; font-weight: bold; color: #fff; font-family: 'Playfair Display', serif;"><a href="start_page.html" style="color: white; text-decoration: none;">Eventastic</a></div>
       <ul style="display: flex; gap: 19.58px; list-style: none; margin: 0; padding: 0;">
        <li><a href="index.html" style="font-size: 17.70px; color: white; text-decoration: none;">Home</a></li>
        <li><a href="services.jsp" style="font-size: 17.70px; color: white; text-decoration: none;">Services</a></li>
        <li><a href="gallery.jsp" style="font-size: 17.70px; color: white; text-decoration: none;">Gallery</a></li>
        <li><a href="contact.jsp" style="font-size: 17.70px; color: white; text-decoration: none;">Contact</a></li>
        <li><a href="login.jsp" style="font-size: 17.70px; color: white; text-decoration: none;">Login</a></li>
       </ul>
    </nav>
  <div class="contact-header">
    <h1>Contact Us</h1>
    <p>Need help planning your next event? Look no further than Eventastic!</p>
    <p>We can provide everything you need to ensure your event is a success.</p>
  </div>
  <div class="main-content">
    <div class="contact-info">
      <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxNAypBqeUnHtcF8zmsSFyEJSpOsCTZjEk0g&s" alt="Eventastic Logo" />
      <h2>WANT TO WORK WITH US?</h2>
      <div class="contact-row">
        <i class="fas fa-phone-volume"></i>
        <div>
          <div class="contact-label">TALK TO OUR CLIENT SUPPORT TEAM</div>
          <div class="contact-value">+91-859-001-0011</div>
        </div>
      </div>
      <div class="contact-row">
        <i class="fas fa-envelope"></i>
        <div>
          <div class="contact-label">WRITE TO US ABOUT YOUR NEEDS</div>
          <div class="contact-email">eventastic092@gmail.com</div>
        </div>
      </div>
      <div class="social-row">
        <a href="https://www.instagram.com/" title="Instagram"><i class="fab fa-instagram"></i></a>
        <a href="https://www.facebook.com/" title="Facebook"><i class="fab fa-facebook"></i></a>
      </div>
    </div>
    <div class="contact-form">
      <form action="sendMessage.jsp" method="post">
        <div class="form-group">
          <label for="fullname">Enter your Full Name</label>
          <input type="text" id="fullname" name="fullname" placeholder="Enter your Full Name" required />
        </div>
        <div class="form-group">
          <label for="phone">Enter your Phone Number</label>
          <input type="tel" id="phone" name="phone" placeholder="Enter your Phone Number" required />
        </div>
        <div class="form-group">
          <label for="email">Enter your Email ID</label>
          <input type="email" id="email" name="email" placeholder="Enter your Email ID" required />
        </div>
        <div class="form-group">
          <label for="message">Message</label>
          <textarea id="message" name="message" rows="4" placeholder="Message" required></textarea>
        </div>
        <button type="submit" class="submit-btn">SUBMIT</button>
      </form>
    </div>
  </div>
</body>
</html>