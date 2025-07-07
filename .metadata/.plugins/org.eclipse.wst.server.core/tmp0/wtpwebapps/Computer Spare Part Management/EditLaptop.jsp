<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String brand="", model="", cpu="", gpu="", ram="", storage="", display="", item_code="", image_url="", stock_status="";
    double price = 0, cash_price = 0;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/computer", "root", "ishini2003");
        ps = conn.prepareStatement("SELECT * FROM laptops WHERE id=?");
        ps.setInt(1, id);
        rs = ps.executeQuery();
        if (rs.next()) {
            brand = rs.getString("brand");
            model = rs.getString("model");
            cpu = rs.getString("cpu");
            gpu = rs.getString("gpu");
            ram = rs.getString("ram");
            storage = rs.getString("storage");
            display = rs.getString("display");
            item_code = rs.getString("item_code");
            image_url = rs.getString("image_url");
            stock_status = rs.getString("stock_status");
            price = rs.getDouble("price");
            cash_price = rs.getDouble("cash_price");
        }
        conn.close();
    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Laptop</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f4f6;
            padding: 40px;
        }

        form {
            background-color: #ffffff;
            max-width: 600px;
            margin: 0 auto;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 15px;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        button {
            margin-top: 25px;
            width: 100%;
            padding: 12px;
            background-color: #111827;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        button:hover {
            background-color: #1f2937;
        }
    </style>
</head>
<body>

<form action="UpdateLaptopServlet" method="post">
    <h2>Edit Laptop Details</h2>
    <input type="hidden" name="id" value="<%= id %>">

    <label for="brand">Brand</label>
    <input type="text" name="brand" id="brand" value="<%= brand %>" required>

    <label for="model">Model</label>
    <input type="text" name="model" id="model" value="<%= model %>" required>

    <label for="cpu">Processor (CPU)</label>
    <input type="text" name="cpu" id="cpu" value="<%= cpu %>" required>

    <label for="gpu">Graphics (GPU)</label>
    <input type="text" name="gpu" id="gpu" value="<%= gpu %>" required>

    <label for="ram">RAM</label>
    <input type="text" name="ram" id="ram" value="<%= ram %>" required>

    <label for="storage">Storage</label>
    <input type="text" name="storage" id="storage" value="<%= storage %>" required>

    <label for="display">Display</label>
    <input type="text" name="display" id="display" value="<%= display %>" required>

    <label for="item_code">Item Code</label>
    <input type="text" name="item_code" id="item_code" value="<%= item_code %>" required>

    <label for="image_url">Image URL</label>
    <input type="text" name="image_url" id="image_url" value="<%= image_url %>" required>

    <label for="price">Price (Rs.)</label>
    <input type="number" name="price" id="price" step="0.01" value="<%= price %>" required>

    <label for="cash_price">Cash Price (Rs.)</label>
    <input type="number" name="cash_price" id="cash_price" step="0.01" value="<%= cash_price %>" required>

    <label for="stock_status">Stock Status</label>
    <select name="stock_status" id="stock_status">
        <option <%= stock_status.equals("In Stock") ? "selected" : "" %>>In Stock</option>
        <option <%= stock_status.equals("Low Stock") ? "selected" : "" %>>Low Stock</option>
        <option <%= stock_status.equals("Out of Stock") ? "selected" : "" %>>Out of Stock</option>
    </select>

    <button type="submit">Update Laptop</button>
</form>

</body>
</html>
