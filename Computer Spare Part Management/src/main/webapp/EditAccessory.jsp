<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String url = "jdbc:mysql://localhost:3306/computer";
    String user = "root";
    String pass = "ishini2003";

    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(url, user, pass);

    ps = conn.prepareStatement("SELECT * FROM computeraccess WHERE id = ?");
    ps.setInt(1, id);
    rs = ps.executeQuery();

    if (!rs.next()) {
        out.println("<h3>Accessory not found!</h3>");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Accessory</title>
    <style>
        body {
            font-family: Arial;
            background-color: #f4f4f4;
        }

        form {
            background: #fff;
            padding: 20px;
            margin: 50px auto;
            width: 500px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }

        input, select, textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            margin-top: 20px;
            padding: 10px 20px;
            background: #111827;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background: #1e293b;
        }

        a.back-btn {
            display: inline-block;
            margin-bottom: 15px;
            padding: 8px 14px;
            background-color: #6b7280;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-size: 14px;
        }

        a.back-btn:hover {
            background-color: #4b5563;
        }
    </style>
</head>
<body>
<a href="viewAccessories.jsp" class="back-btn">Back</a>

<form action="UpdateAccessoryServlet" method="post">
    <h2>Edit Accessory</h2>
    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">

    <label>Name</label>
    <input type="text" name="name" value="<%= rs.getString("name") %>" required>

    <label>Category</label>
    <input type="text" name="category" value="<%= rs.getString("category") %>" required>

    <label>Item Code</label>
    <input type="text" name="item_code" value="<%= rs.getString("item_code") %>" required>

    <label>Price</label>
    <input type="number" step="0.01" name="price" value="<%= rs.getDouble("price") %>" required>

    <label>Cash Price</label>
    <input type="number" step="0.01" name="cash_price" value="<%= rs.getDouble("cash_price") %>" required>

    <label>Stock Status</label>
    <select name="stock_status">
        <option value="In Stock" <%= rs.getString("stock_status").equals("In Stock") ? "selected" : "" %>>In Stock</option>
        <option value="Low Stock" <%= rs.getString("stock_status").equals("Low Stock") ? "selected" : "" %>>Low Stock</option>
        <option value="Out of Stock" <%= rs.getString("stock_status").equals("Out of Stock") ? "selected" : "" %>>Out of Stock</option>
    </select>

    <label>Image URL</label>
    <input type="text" name="image_url" value="<%= rs.getString("image_url") %>" required>

    <label>Description</label>
    <textarea name="description" rows="4"><%= rs.getString("description") %></textarea>

    <button type="submit">Update</button>
</form>

<%
    conn.close();
%>
</body>
</html>
