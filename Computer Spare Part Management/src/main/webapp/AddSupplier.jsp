<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Supplier - TechParts</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f9fafb;
            padding: 40px;
        }
        .form-container {
            max-width: 600px;
            margin: auto;
            background-color: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 25px;
            font-size: 24px;
            color: #111827;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #374151;
        }
        input, textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 18px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
        }
        button {
            background-color: #2563eb;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            width: 100%;
        }
        button:hover {
            background-color: #1d4ed8;
        }
        .back-link {
            display: inline-block;
            margin-top: 15px;
            text-decoration: none;
            color: #2563eb;
            font-weight: 500;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Add New Supplier</h2>
    <form action="AddSupplierServlet" method="post">
        <label for="name">Name</label>
        <input type="text" id="name" name="name" required>

        <label for="email">Email</label>
        <input type="email" id="email" name="email" required>

        <label for="phone">Phone</label>
        <input type="text" id="phone" name="phone" required>

        <label for="company">Company</label>
        <input type="text" id="company" name="company" required>

        <label for="address">Address</label>
        <textarea id="address" name="address" rows="4" required></textarea>

        <button type="submit">Add Supplier</button>
    </form>
    <a href="SupplierDetails.jsp" class="back-link">&larr; Back to Supplier List</a>
</div>
</body>
</html>
