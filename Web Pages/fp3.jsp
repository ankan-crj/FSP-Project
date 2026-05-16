<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("fpEmail") == null) {
        response.sendRedirect("forgotPassword.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Set New Password</title>
    <style>
        body { font-family:sans-serif; background:#f4f4f4; display:flex; justify-content:center; align-items:center; height:100vh; }
        .container { background:white; padding:40px; border-radius:10px; box-shadow:0 4px 8px rgba(0,0,0,0.1); text-align:center; }
        input[type="password"], button { padding:10px; margin:10px 0; width:250px; }
        button { background:#28a745; color:white; border:none; cursor:pointer; border-radius:5px; }
    </style>
</head>
<body>
<div class="container">
    <h2>Set New Password</h2>
    <form action="ResetPasswordServlet" method="post">
        <input type="password" name="newPassword" placeholder="Enter new password" required><br>
        <input type="password" name="confirmPassword" placeholder="Confirm new password" required><br>
        <button type="submit">Reset Password</button>
    </form>
</div>
</body>
</html>
