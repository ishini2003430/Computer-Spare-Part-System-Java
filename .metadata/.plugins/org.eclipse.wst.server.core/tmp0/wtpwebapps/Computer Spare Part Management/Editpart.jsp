<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String idStr = request.getParameter("id");
    int id = 0;
    if(idStr != null) {
        id = Integer.parseInt(idStr);
    } else {
        response.sendRedirect("Viewpart.jsp"); // Redirect if no id provided
        return;
    }

    String partName = "";
    String category = "";
    String supplier = "";
    int quantity = 0;
    int minStock = 0;
    double price = 0.0;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/computer", "root", "ishini2003");
        String sql = "SELECT part_name, category, supplier, quantity, min_stock, price FROM parts WHERE id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();
        if(rs.next()) {
            partName = rs.getString("part_name");
            category = rs.getString("category");
            supplier = rs.getString("supplier");
            quantity = rs.getInt("quantity");
            minStock = rs.getInt("min_stock");
            price = rs.getDouble("price");
        } else {
            response.sendRedirect("Viewpart.jsp"); // Redirect if id not found
            return;
        }
        rs.close();
        pstmt.close();
        conn.close();
    } catch(Exception e) {
        out.println("<p style='color:red;'>Error loading part data: " + e.getMessage() + "</p>");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Edit Part - TechParts</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 30px;
            color: #333;
        }
        form {
            background: white;
            padding: 25px;
            border-radius: 10px;
            max-width: 500px;
            margin: auto;
            box-shadow: 0 6px 18px rgba(0,0,0,0.1);
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
        }
        input[type="text"],
        input[type="number"],
        input[type="decimal"] {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 18px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 1rem;
        }
        button {
            background-color: #65a30d;
            border: none;
            color: white;
            padding: 12px 20px;
            font-size: 1rem;
            border-radius: 6px;
            cursor: pointer;
        }
        button:hover {
            background-color: #4d7c0f;
        }
        a {
            display: inline-block;
            margin-top: 15px;
            text-decoration: none;
            color: #4c5c7a;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h2 style="text-align:center;">Edit Part</h2>
    <form action="UpdatePartServlet" method="post">
        <input type="hidden" name="id" value="<%= id %>"/>
        
        <label for="part_name">Part Name:</label>
        <input type="text" id="part_name" name="part_name" required value="<%= partName %>" />
        
        <label for="category">Category:</label>
        <input type="text" id="category" name="category" required value="<%= category %>" />
        
        <label for="supplier">Supplier:</label>
        <input type="text" id="supplier" name="supplier" required value="<%= supplier %>" />
        
        <label for="quantity">Quantity:</label>
        <input type="number" id="quantity" name="quantity" required min="0" value="<%= quantity %>" />
        
        <label for="min_stock">Minimum Stock:</label>
        <input type="number" id="min_stock" name="min_stock" required min="0" value="<%= minStock %>" />
        
        <label for="price">Price ($):</label>
        <input type="text" id="price" name="price" required pattern="^\d+(\.\d{1,2})?$" title="Enter a valid price with up to 2 decimals" value="<%= price %>" />
        
        <button type="submit">Update Part</button>
    </form>
    <div style="text-align:center;">
        <a href="ViewPart.jsp">Back to Parts List</a>
    </div>
</body>
</html>
