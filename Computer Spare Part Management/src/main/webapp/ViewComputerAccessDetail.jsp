<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Computer Accessory Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f3f4f6;
            padding: 30px;
        }
        .details-container {
            max-width: 700px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        img {
            width: 100%;
            max-height: 300px;
            object-fit: contain;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        h2 {
            color: #2563eb;
            margin-bottom: 10px;
        }
        .info p {
            margin: 8px 0;
            font-size: 16px;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 8px 16px;
            background: #2563eb;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }
    </style>
</head>
<body>
<%
    try {
        Class.forName("com.mysql.jdbc.Driver"); // Or "com.mysql.cj.jdbc.Driver" for MySQL 8+
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/computer", "root", "ishini2003");
        pstmt = conn.prepareStatement("SELECT * FROM computeraccess WHERE id = ?");
        pstmt.setInt(1, id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
%>
    <div class="details-container">
        <img src="<%= rs.getString("image_url") %>" alt="Accessory Image" />
        <h2><%= rs.getString("name") %></h2>
        <div class="info">
            <p><strong>Category:</strong> <%= rs.getString("category") %></p>
            <p><strong>Item Code:</strong> <%= rs.getString("item_code") %></p>
            <p><strong>Price:</strong> Rs. <%= rs.getDouble("price") %></p>
            <p><strong>Cash Price:</strong> Rs. <%= rs.getDouble("cash_price") %></p>
            <p><strong>Status:</strong> <%= rs.getString("stock_status") %></p>
            <p><strong>Description:</strong> <%= rs.getString("description") %></p>
        </div>
        <a href="computerAccessories.jsp" class="back-link">Back to Accessories</a>
    </div>
<%
        } else {
            out.print("<p>Accessory not found!</p>");
        }
    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
</body>
</html>
