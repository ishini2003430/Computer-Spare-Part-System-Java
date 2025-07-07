<!DOCTYPE html>
<html>
<head>
    <title>Order Confirmation - TechParts</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f9fafb;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .confirmation-container {
            background: white;
            padding: 40px 60px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            text-align: center;
            max-width: 450px;
            width: 100%;
        }
        h1 {
            color: #2563eb;
            margin-bottom: 20px;
        }
        p {
            font-size: 18px;
            color: #333;
            margin-bottom: 30px;
        }
        a.button {
            background-color: #2563eb;
            color: white;
            padding: 12px 30px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }
        a.button:hover {
            background-color: #1e40af;
        }
    </style>
</head>
<body>
    <div class="confirmation-container">
        <h1>Thank You for Your Order!</h1>
        <p>Your order has been successfully placed. We will process it soon and keep you updated.</p>
        <a href="Home.jsp" class="button">Back to Home</a>
    </div>
</body>
</html>
