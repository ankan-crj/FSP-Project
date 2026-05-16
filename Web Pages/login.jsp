<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <title>Login - Event Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: #f0f0f0;
        }

        .login-container {
            width: 320px;
            margin: 100px auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
            text-align: center;
        }

        .login-container i.user-icon {
            font-size: 40px;
            color: #007bff;
            margin-bottom: 10px;
        }

        h2 {
            margin-bottom: 25px;
            font-size: 24px;
        }

        .input-group {
            position: relative;
            margin: 15px 0;
        }

        .input-group i {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
        }

        .input-group input {
            width: 100%;
            padding: 10px 10px 10px 35px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .link {
            margin-top: 10px;
            display: block;
            font-size: 14px;
        }
    </style>
</head>
<body>

    <div class="login-container">
        <i class="fas fa-user-circle user-icon"></i>
        <h2>Login</h2>

        <form action="LoginServlet" method="post">
            <div class="input-group">
                <i class="fas fa-envelope"></i>
                <input type="text" name="email" placeholder="Enter Email" required>
            </div>

            <div class="input-group">
                <i class="fas fa-lock"></i>
                <input type="password" name="password" placeholder="Enter Password" required>
            </div>

            <input type="submit" value="Login">
        </form>

        <a class="link" href="registration.jsp">Don't have an account? Register</a>
        <a class="link" href="fp.jsp">Forgot Password?</a>

    </div>

    <% 
        String error = request.getParameter("error");
        if ("1".equals(error)) { 
    %>
        <script>
            alert("Invalid Email or Password!");
        </script>
    <% } %>

</body>
</html>