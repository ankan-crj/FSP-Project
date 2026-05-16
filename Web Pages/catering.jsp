<%
    if (session == null || session.getAttribute("userEmail") == null) {
        response.sendRedirect("index.html");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catering Services - Eventastic</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, sans-serif; }
        body { background: #fdf8f5; color: #333; }

        nav { background-color: #b48c8c; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; position: sticky; top: 0; z-index: 1000; }
        .logo { font-size: 24px; font-weight: bold; font-family: 'Playfair Display', serif; }
        nav ul { list-style: none; display: flex; gap: 20px; }
        nav ul li a { color: white; text-decoration: none; padding: 8px 12px; display: block; }
        nav ul li a:hover { background: rgba(255,255,255,0.2); border-radius: 5px; }

        .hero { background: url('https://cdn.pixabay.com/photo/2017/08/07/07/11/food-2607400_1280.jpg') no-repeat center center/cover; height: 60vh; display: flex; align-items: center; justify-content: center; text-align: center; color: #fff; }
        .hero h1 { font-size: 40px; background: rgba(0,0,0,0.5); padding: 20px; border-radius: 10px; }

        .section { padding: 50px 10%; text-align: center; }
        .section h2 { font-size: 32px; margin-bottom: 20px; }

        .guests-input { margin-bottom: 30px; }
        .guests-input label { font-size: 18px; margin-right: 10px; }
        .guests-input input { width: 80px; padding: 8px; border-radius: 5px; border: 1px solid #ccc; }

        .food-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; }

        .food-card { background: white; border-radius: 10px; padding: 20px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); text-align: center; transition: 0.3s; }
        .food-card:hover { transform: translateY(-5px); box-shadow: 0 8px 16px rgba(0,0,0,0.2); }
        .food-card h3 { margin-bottom: 10px; font-size: 20px; }
        .food-card p { font-size: 14px; margin-bottom: 10px; color: gray; }
        .food-card input[type="checkbox"] { margin-right: 10px; }

        .btn { display: inline-block; padding: 10px 25px; background: #b48c8c; color: white; border-radius: 8px; text-decoration: none; margin-top: 20px; transition: 0.3s; border: none; cursor: pointer; }
        .btn:hover { background: #9c6d6d; }
    </style>
</head>
<body>

<nav>
    <div class="logo">Eventastic</div>
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

<section class="hero">
    <h1>Catering Services</h1>
</section>

<section class="section">
    <h2>Select Your Food Items</h2>
    <form action="CateringServlet" method="post">

        <!-- Number of Guests -->
        <div class="guests-input">
            <label for="guests">Number of Guests:</label>
            <input type="number" name="guests" id="guests" min="1" value="1" required>
        </div>

        <div class="food-grid">
            <%
                String[][] foods = {
                    {"Paneer Butter Masala", "250"}, {"Dal Makhani", "200"}, {"Veg Biryani", "300"}, {"Chicken Curry", "350"}, 
                    {"Naan", "50"}, {"Gulab Jamun", "100"}, {"Chole Bhature", "180"}, {"Paneer Tikka", "220"}, {"Rogan Josh", "400"}, {"Mutton Biryani", "380"},
                    {"Butter Naan", "60"}, {"Lassi", "80"}, {"Veg Hakka Noodles", "250"}, {"Manchurian", "200"}, {"Spring Roll", "150"}, {"Idli", "50"},
                    {"Dosa", "70"}, {"Sambar", "40"}, {"Vada", "30"}, {"Pongal", "60"}, {"Pav Bhaji", "120"}, {"Masala Dosa", "80"}, {"Pani Puri", "90"},
                    {"Sev Puri", "100"}, {"Bhel Puri", "90"}, {"Rajma Chawal", "150"}, {"Aloo Gobi", "130"}, {"Baingan Bharta", "140"}, {"Kadai Paneer", "250"},
                    {"Malai Kofta", "220"}, {"Paneer Lababdar", "260"}, {"Veg Kolhapuri", "230"}, {"Chicken Tikka Masala", "400"}, {"Butter Chicken", "450"},
                    {"Fish Curry", "350"}, {"Prawn Masala", "500"}, {"Egg Curry", "180"}, {"Mutton Korma", "420"}, {"Dal Fry", "150"}, {"Jeera Rice", "80"},
                    {"Veg Pulao", "200"}, {"Gobi Manchurian", "210"}, {"Hakka Noodles", "250"}, {"Fried Rice", "220"}, {"Schezwan Noodles", "280"},
                    {"Schezwan Fried Rice", "300"}, {"Momos", "120"}, {"Chicken Momos", "150"}, {"Veg Momos", "120"}, {"Ice Cream", "90"}, {"Rasgulla", "100"},
                    {"Jalebi", "80"}, {"Kulfi", "120"}, {"Lemonade", "50"}, {"Paneer Chilli", "240"}, {"Veg Spring Roll", "150"}, {"Chicken Fried Rice", "350"},
                    {"Mixed Veg Curry", "200"}, {"Tandoori Chicken", "420"}, {"Malai Paneer Tikka", "230"}, {"Veg Manchurian Dry", "210"}
                };
                for(int i=0; i<foods.length; i++){
            %>
            <div class="food-card">
                <h3><%= foods[i][0] %></h3>
                <p>Price: <%= foods[i][1] %></p>
                <input type="checkbox" name="food" value="<%= foods[i][0] %>:<%= foods[i][1] %>">
            </div>
            <% } %>
        </div>

        <button type="submit" class="btn">Book Catering</button>
    </form>
</section>

</body>
</html>
