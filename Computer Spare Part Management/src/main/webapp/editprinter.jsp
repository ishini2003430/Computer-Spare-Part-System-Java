<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/computer", "root", "ishini2003");
    PreparedStatement ps = con.prepareStatement("SELECT * FROM printers WHERE id = ?");
    ps.setInt(1, id);
    ResultSet rs = ps.executeQuery();
    rs.next();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Printer</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f4f4;
            padding: 40px;
        }
        form {
            width: 400px;
            margin: auto;
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        input[type="text"], input[type="number"], textarea, select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #0066cc;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #004d99;
        }
    </style>
</head>
<body>
    <h2>Edit Printer</h2>
    <form action="UpdatePrinterServlet" method="post">
        <input type="hidden" name="id" value="<%= rs.getInt("id") %>">

        <label>Model Name:</label>
        <input type="text" name="model_name" value="<%= rs.getString("model_name") %>" required>

        <label>Item Code:</label>
        <input type="text" name="item_code" value="<%= rs.getString("item_code") %>" required>

        <label>Brand:</label>
        <input type="text" name="brand" value="<%= rs.getString("brand") %>" required>

        <label>Type:</label>
        <input type="text" name="type" value="<%= rs.getString("type") %>" required>

        <label>Price (LKR):</label>
        <input type="number" step="0.01" name="price" value="<%= rs.getDouble("price") %>" required>

        <label>Cash Price (LKR):</label>
        <input type="number" step="0.01" name="cash_price" value="<%= rs.getDouble("cash_price") %>" required>

        <label>Status:</label>
        <select name="status" required>
            <option value="In Stock" <%= "In Stock".equals(rs.getString("status")) ? "selected" : "" %>>In Stock</option>
            <option value="Low Stock" <%= "Low Stock".equals(rs.getString("status")) ? "selected" : "" %>>Low Stock</option>
            <option value="Out of Stock" <%= "Out of Stock".equals(rs.getString("status")) ? "selected" : "" %>>Out of Stock</option>
        </select>

        <label>Description:</label>
        <textarea name="description" rows="4"><%= rs.getString("description") %></textarea>

        <label>Image URL:</label>
        <input type="text" name="image_url" value="<%= rs.getString("image_url") %>" required>

        <input type="submit" value="Update Printer">
    </form>
</body>
</html>
