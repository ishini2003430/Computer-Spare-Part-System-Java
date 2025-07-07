<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Laptop Accesorries</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f9f9f9;
            padding: 20px;
        }

        h2 {
            margin-bottom: 10px;
        }

        a.back-btn, a.add-btn {
            display: inline-block;
            margin-bottom: 15px;
            padding: 8px 14px;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-size: 14px;
        }

        a.back-btn {
            background-color: #6b7280;
        }

        a.back-btn:hover {
            background-color: #4b5563;
        }

        a.add-btn {
            background-color: #2563eb;
            margin-left: 10px;
            padding: 10px 15px;
        }

        a.add-btn:hover {
            background-color: #1d4ed8;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
            vertical-align: top;
        }

        th {
            background: #111827;
            color: white;
        }

        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
        }

        .btn-edit {
            background-color: #10b981; /* green */
            color: white;
        }

        .btn-edit:hover {
            background-color: #059669;
        }

        .btn-delete {
            background-color: #ef4444; /* red */
            color: white;
        }

        .btn-delete:hover {
            background-color: #dc2626;
        }

        img.product-image {
            width: 100px;
            height: auto;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <a href="Categories.jsp" class="back-btn">Back</a>
    <a href="Addlaptopproducts.jsp" class="add-btn">+ Add New Product</a>

    <h2>All Laptop Accessories</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Category</th>
            <th>Item Code</th>
            <th>Price (Rs.)</th>
            <th>Cash Price (Rs.)</th>
            <th>Stock Status</th>
            <th>Image</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/computer", "root", "ishini2003");
                Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM products");

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("category") %></td>
            <td><%= rs.getString("item_code") %></td>
            <td><%= String.format("%.2f", rs.getDouble("price")) %></td>
            <td><%= String.format("%.2f", rs.getDouble("cash_price")) %></td>
            <td><%= rs.getString("stock_status") %></td>
            <td>
                <img src="<%= rs.getString("image_url") %>" alt="Product Image" class="product-image" />
            </td>
            <td><%= rs.getString("description") %></td>
            <td>
                <a href="EditLaptopAccess.jsp?id=<%= rs.getInt("id") %>" class="btn btn-edit">Edit</a>
                <a href="DeleteLaptopAccessServlet?id=<%= rs.getInt("id") %>" class="btn btn-delete" onclick="return confirm('Are you sure you want to delete this product?')">Delete</a>
            </td>
        </tr>
        <%
                }
                conn.close();
            } catch (Exception e) {
                out.print("Error: " + e.getMessage());
            }
        %>
    </table>
</body>
</html>
