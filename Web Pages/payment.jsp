<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session == null || session.getAttribute("userEmail") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String userEmail = (String) session.getAttribute("userEmail");

    // Service selections and prices
    String bookedPhotography = "", bookedCatering = "", bookedDecoration = "", bookedVenue = "", bookedStyling = "";
    double pricePhotography = 0, priceCatering = 0, priceDecoration = 0, priceVenue = 0, priceStyling = 0;
    double totalPrice = 0;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","manager");
        PreparedStatement ps = conn.prepareStatement(
            "SELECT ppk, ppr, cfi, cfp, dpk, dpr, vname, vprice, spk, spr FROM registration WHERE email = ?");
        ps.setString(1, userEmail);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            bookedPhotography = rs.getString("ppk") != null ? rs.getString("ppk") : "";
            pricePhotography = rs.getString("ppr") != null ? Double.parseDouble(rs.getString("ppr")) : 0;

            bookedCatering = rs.getString("cfi") != null ? rs.getString("cfi") : "";
            priceCatering = rs.getString("cfp") != null ? Double.parseDouble(rs.getString("cfp")) : 0;

            bookedDecoration = rs.getString("dpk") != null ? rs.getString("dpk") : "";
            priceDecoration = rs.getString("dpr") != null ? Double.parseDouble(rs.getString("dpr")) : 0;

            bookedVenue = rs.getString("vname") != null ? rs.getString("vname") : "";
            priceVenue = rs.getString("vprice") != null ? Double.parseDouble(rs.getString("vprice")) : 0;

            bookedStyling = rs.getString("spk") != null ? rs.getString("spk") : "";
            priceStyling = rs.getString("spr") != null ? Double.parseDouble(rs.getString("spr")) : 0;

            totalPrice = pricePhotography + priceCatering + priceDecoration + priceVenue + priceStyling;
            session.setAttribute("totalPrice", totalPrice);
        }
        rs.close(); ps.close(); conn.close();
    } catch(Exception e){ e.printStackTrace(); }
%>

<html>
<head>
    <title>Payment</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { box-sizing: border-box; margin:0; padding:0; }
        body { font-family: 'Montserrat', sans-serif; background:#f4f4f4; display:flex; justify-content:center; align-items:flex-start; padding:30px; }
        .checkout-panel { display:flex; flex-direction:column; width:940px; background:#fff; box-shadow:0 1px 10px rgba(0,0,0,.2); border-radius:12px; }
        .panel-body { padding:45px 80px 0; flex:1; }
        .title { font-weight:700; margin-bottom:40px; color:#2e2e2e; }
        .service-list { display:flex; flex-direction:column; gap:15px; margin-bottom:30px; }
        .service-item { display:flex; justify-content:space-between; background:#f9f9f9; padding:15px 20px; border-radius:6px; align-items:center; }
        .service-item i { margin-right:10px; color:#f62f5e; }

        .progress-bar { display:flex; margin-bottom:30px; justify-content:space-between; }
        .step { position: relative; width:25px; height:25px; border:4px solid #fff; border-radius:50%; background:#efefef; z-index:1; }
        .step:after { content:''; position:absolute; top:5px; left:22px; width:225px; height:6px; background:#efefef; z-index:-1; }
        .step:last-child:after { content:none; }
        .step.active { background:#f62f5e; }
        .step.active:after { background:#f62f5e; }

        .payment-method { display:flex; margin-bottom:60px; justify-content:space-between; }
        .method { display:flex; flex-direction:column; width:382px; height:122px; padding-top:20px; cursor:pointer; border:1px solid transparent; border-radius:2px; background:#f9f9f9; justify-content:center; align-items:center; }
        .method .card-logos { display:flex; width:150px; justify-content:space-between; align-items:center; }
        .radio-input { margin-top:20px; }
        input[type='radio'] { display:inline-block; }

        .input-fields { display:flex; justify-content:space-between; margin-bottom:30px; }
        .input-fields label { display:block; margin-bottom:10px; color:#b4b4b4; }
        .input-fields input[type=text], .input-fields input[type=password] { font-size:16px; width:100%; height:50px; padding:0 16px; border:1px solid #e1e1e1; border-radius:4px; outline:none; }
        .input-fields input:focus { border-color:#77db77; }

        .small-inputs { display:flex; margin-top:20px; justify-content:space-between; }
        .small-inputs div { width:182px; }

        .panel-footer { display:flex; width:100%; height:96px; padding:0 80px; background:#efefef; justify-content:space-between; align-items:center; }
        .btn { font-size:16px; width:163px; height:48px; cursor:pointer; border:none; border-radius:23px; transition:0.2s; }
        .back-btn { color:#f62f5e; background:#fff; }
        .next-btn { color:#fff; background:#f62f5e; }
        .btn:hover { transform:scale(1.1); }
        .total { text-align:right; font-weight:700; font-size:18px; margin-bottom:20px; }
    </style>
</head>
<body>
<div class="checkout-panel">
    <div class="panel-body">
        <h2 class="title">Checkout</h2>

        <div class="progress-bar">
            <div class="step active"></div>
            <div class="step active"></div>
            <div class="step"></div>
            <div class="step"></div>
        </div>

        <div class="service-list">
            <% if(!bookedPhotography.isEmpty()) { %>
                <div class="service-item"><i class="fas fa-camera"></i> Photography: <%= bookedPhotography %> <span>₹<%= pricePhotography %></span></div>
            <% } %>
            <% if(!bookedCatering.isEmpty()) { %>
                <div class="service-item"><i class="fas fa-utensils"></i> Catering: <%= bookedCatering %> <span>₹<%= priceCatering %></span></div>
            <% } %>
            <% if(!bookedDecoration.isEmpty()) { %>
                <div class="service-item"><i class="fas fa-palette"></i> Decoration: <%= bookedDecoration %> <span>₹<%= priceDecoration %></span></div>
            <% } %>
            <% if(!bookedVenue.isEmpty()) { %>
                <div class="service-item"><i class="fas fa-house"></i> Venue: <%= bookedVenue %> <span>₹<%= priceVenue %></span></div>
            <% } %>
            <% if(!bookedStyling.isEmpty()) { %>
                <div class="service-item"><i class="fas fa-spa"></i> Styling: <%= bookedStyling %> <span>₹<%= priceStyling %></span></div>
            <% } %>
        </div>

        <div class="total">Total: ₹<%= totalPrice %></div>

        <div class="payment-method">
            <label class="method card">
                <div class="card-logos">
                    <img src="visa.avif" alt="Visa Logo" width="60"/>
                </div>
                <div class="radio-input">
                    <input type="radio" name="payment" checked /> Pay ₹<%= totalPrice %> with Visa
                </div>
            </label>
            <label class="method paypal">
                <img src="img/paypal_logo.png" alt="Rupay Logo" width="60"/>
                <div class="radio-input">
                    <input type="radio" name="payment" /> Pay ₹<%= totalPrice %> with Rupay
                </div>
            </label>
        </div>

        <div class="input-fields">
            <div class="column-1">
                <label>Cardholder's Name</label>
                <input type="text" name="cardholder" />
                <div class="small-inputs">
                    <div>
                        <label>Valid thru</label>
                        <input type="text" placeholder="MM / YY" />
                    </div>
                    <div>
                        <label>CVV / CVC *</label>
                        <input type="password" />
                    </div>
                </div>
            </div>
            <div class="column-2">
                <label>Card Number</label>
                <input type="password" />
            </div>
        </div>

    </div>

    <div class="panel-footer">
        <button class="btn back-btn" onclick="history.back()">Back</button>
        <form action="PaymentConfirmationServlet" method="post">
    <input type="hidden" name="totalPrice" value="<%= totalPrice %>" />
    <button type="submit" class="btn next-btn">Pay Now</button>
</form>

    </div>
</div>
</body>
</html>
