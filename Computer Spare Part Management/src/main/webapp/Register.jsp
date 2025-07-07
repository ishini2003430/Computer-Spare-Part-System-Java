<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <title>Register - TechParts</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f0f4f8;
            margin: 0;
            padding: 0;
        }

        .register-container {
            width: 100%;
            max-width: 450px;
            margin: 80px auto;
            background: white;
            padding: 40px 30px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .logo {
            width: 60px;
            margin-bottom: 15px;
        }

        h2 {
            color: #1d4ed8;
            margin-bottom: 30px;
        }

        label {
            display: block;
            text-align: left;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
        }

        .btn-register {
            width: 100%;
            padding: 12px;
            background-color: #1d4ed8;
            color: white;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn-register:hover {
            background-color: #1743b3;
        }

        .link {
            margin-top: 15px;
        }

        .link a {
            color: #1d4ed8;
            text-decoration: none;
        }

        .link a:hover {
            text-decoration: underline;
        }

        .error-msg {
            color: red;
            font-size: 14px;
            margin-bottom: 10px;
            text-align: left;
        }
    </style>

    <script>
    function validateForm() {
        const fullName = document.getElementById("fullname").value.trim();
        const email = document.getElementById("email").value.trim();
        const username = document.getElementById("username").value.trim();
        const password = document.getElementById("password").value;

        const errorElement = document.getElementById("form-error");
        let errorMessage = "";

        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=!]).{6,}$/;

        // General empty field check
        if (fullName === "" || email === "" || username === "" || password === "") {
            errorMessage = "All fields are required.";
        }
        // Email validation
        else if (!emailRegex.test(email)) {
            errorMessage = "Please enter a valid email address.";
        }
        // Password strength validation
        else if (!passwordRegex.test(password)) {
            errorMessage = "Password must be at least 6 characters and include uppercase, lowercase, number, and special character.";
        }

        // Show error or submit form
        if (errorMessage !== "") {
            errorElement.innerText = errorMessage;
            return false;
        } else {
            errorElement.innerText = "";
            return true;
        }
    }
</script>

</head>
<body>

    <div class="register-container">
        <img src="images/logo.png" alt="TechParts Logo" class="logo">
        <h2>Create an Account</h2>
        
        <!-- Error message placeholder -->
        <div id="form-error" class="error-msg"></div>

        <form action="registerinsertservlet" method="post" onsubmit="return validateForm();">
            <label for="fullname">Full Name:</label>
            <input type="text" name="fullname" id="fullname" required>

            <label for="email">Email:</label>
            <input type="email" name="email" id="email" required>

            <label for="username">Username:</label>
            <input type="text" name="username" id="username" required>

            <label for="password">Password:</label>
            <input type="password" name="password" id="password" required>

            <button type="submit" class="btn-register">Register</button>
        </form>

        <div class="link">
            Already have an account? <a href="Login.jsp">Login Here</a>
        </div>
    </div>

</body>
</html>
