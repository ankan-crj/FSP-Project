<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("fpEmail") == null) {
        response.sendRedirect("forgotPassword.jsp");
        return;
    }
    String securityQuestion = (String) session.getAttribute("securityQuestion");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Security Question</title>
    <style>
        body { font-family:sans-serif; background:#f4f4f4; display:flex; justify-content:center; align-items:center; height:100vh; }
        .container { background:white; padding:40px; border-radius:10px; box-shadow:0 4px 8px rgba(0,0,0,0.1); text-align:center; }
        input[type="text"], button { padding:10px; margin:10px 0; width:250px; }
        button { background:#b48c8c; color:white; border:none; cursor:pointer; border-radius:5px; }
    </style>
</head>
<body>
<div class="container">
    <h2>Security Question</h2>
    <p><strong><%= securityQuestion %></strong></p>
    <form action="SecurityQuestionServlet" method="post">
        <input type="text" name="answer" placeholder="Enter your answer" required><br>
        <button type="submit">Next</button>
    </form>
</div>
</body>
</html>
