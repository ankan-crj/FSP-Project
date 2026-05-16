<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Booking Confirmation</title>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background: #f5f7fa;
      margin: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }

    .confirmation-container {
      background: #fff;
      padding: 40px;
      border-radius: 20px;
      box-shadow: 0px 6px 25px rgba(0,0,0,0.15);
      width: 400px;
      text-align: center;
      animation: fadeIn 0.5s ease;
    }

    .tick {
      width: 100px;
      height: 100px;
      border-radius: 50%;
      border: 6px solid #4CAF50;
      display: flex;
      justify-content: center;
      align-items: center;
      margin: 0 auto 20px auto;
      position: relative;
      animation: popIn 0.6s ease-out;
    }

    .tick::after {
      content: "";
      width: 30px;
      height: 60px;
      border-right: 6px solid #4CAF50;
      border-bottom: 6px solid #4CAF50;
      transform: rotate(45deg);
      position: absolute;
      top: 10px;
      animation: draw 0.8s ease forwards;
    }

    h2 {
      color: #333;
      margin-bottom: 10px;
    }

    p {
      color: #555;
      font-size: 16px;
      margin-bottom: 25px;
    }

    .btn {
      padding: 12px 25px;
      background: #4a90e2;
      color: white;
      border-radius: 10px;
      text-decoration: none;
      transition: 0.3s;
    }

    .btn:hover {
      background: #357abd;
    }

    @keyframes popIn {
      from { transform: scale(0.5); opacity: 0; }
      to { transform: scale(1); opacity: 1; }
    }

    @keyframes draw {
      from { height: 0; width: 0; }
      to { height: 60px; width: 30px; }
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }
  </style>
</head>
<body>
  <div class="confirmation-container">
    <div class="tick"></div>
    <h2>Payment Successful!</h2>
    <p>Your Event has been booked successfully.</p>
    <a href="userhome.jsp" class="btn">Go to Home</a>
  </div>
</body>
</html>
