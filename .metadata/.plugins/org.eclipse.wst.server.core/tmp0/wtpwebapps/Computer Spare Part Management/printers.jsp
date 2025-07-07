<%@ page import="java.sql.*, java.util.*, ComputerPackage.CartItem" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Printers - TechParts</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f9fafb;
            margin: 0;
            padding: 0;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 40px;
            background: white;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logo h2 {
            margin: 0;
            color: #2563eb;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 25px;
        }

        .nav-links a {
            text-decoration: none;
            color: #374151;
            font-weight: 500;
        }

        .nav-links a.active-link {
            color: #2563eb;
            font-weight: bold;
        }

        .dropdown {
            position: relative;
        }

        .dropbtn {
            cursor: pointer;
            color: #374151;
            font-weight: 500;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: white;
            min-width: 220px;
            top: 30px;
            left: 0;
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.15);
            z-index: 999;
            border-radius: 6px;
        }

        .dropdown-content a {
            color: #333;
            padding: 12px 16px;
            display: block;
            text-decoration: none;
            font-size: 14px;
        }

        .dropdown-content a:hover {
            background-color: #f1f1f1;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        .content {
            max-width: 1200px;
            margin: 30px auto 50px;
            padding: 0 20px;
        }

        h2 {
            text-align: center;
            color: #1f2937;
            margin-bottom: 30px;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
        }

        .card {
            background: #fff;
            border-radius: 12px;
            padding: 15px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .card img {
            width: 100%;
            height: 160px;
            object-fit: contain;
            margin-bottom: 15px;
            border-radius: 6px;
            background: #f0f0f0;
        }

        .card h3 {
            font-size: 18px;
            margin: 10px 0 5px;
            color: #111827;
        }

        .card p {
            font-size: 14px;
            margin: 4px 0;
            color: #374151;
        }

        .price {
            color: #e11d48;
            font-weight: bold;
        }

        .cash-price {
            color: #16a34a;
            font-weight: bold;
        }

        .buttons {
            margin-top: 15px;
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        .buttons form, .buttons a {
            flex: 1;
        }

        .buttons button, .buttons a {
            padding: 7px 14px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 13px;
            color: white;
            display: inline-block;
            text-align: center;
            text-decoration: none;
        }

        .add-cart { background-color: #6b7280; }
        .view-more { background-color: #2563eb; }
        .buy-now { background-color: #dc2626; }

        .add-cart:hover { background-color: #4b5563; }
        .view-more:hover { background-color: #1d4ed8; }
        .buy-now:hover { background-color: #b91c1c; }
    </style>
</head>
<body>

<!-- Navbar -->
<div class="header">
    <div class="logo">
        <img src="images/logo.png" alt="logo" width="40" height="40" />
        <h2>TechParts</h2>
    </div>
    <div class="nav-links">
        <a href="Home.jsp">Home</a>
        <a href="AboutUs.jsp">About Us</a>
        <div class="dropdown">
            <span class="dropbtn">All Products</span>
            <div class="dropdown-content">
                <a href="Laptops.jsp">Laptops</a>
                <a href="LaptopAccessories.jsp">Laptop Accessories</a>
                <a href="computerAccessories.jsp">Desktop & Accessories</a>
                <a href="cctvcamera.jsp">CCTV Camera & Accessories</a>
                <a href="printers.jsp" class="active-link">Printers</a>
            </div>
        </div>
        <a href="Services.jsp">Services</a>
        <a href="Paymentmethod.jsp">Payment Methods</a>
        <a href="Contactus.jsp">Contact Us</a>
    </div>
</div>

<div class="content">
    <h2>All Printers</h2>
    <div class="grid">
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/computer", "root", "ishini2003");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM printers");

                while (rs.next()) {
        %>
        <div class="card">
            <img src="<%= rs.getString("image_url") %>" alt="Printer Image" />
            <h3><%= rs.getString("model_name") %></h3>
            <p><strong>Brand:</strong> <%= rs.getString("brand") %></p>
            <p><strong>Item Code:</strong> <%= rs.getString("item_code") %></p>
            <p><strong>Type:</strong> <%= rs.getString("type") %></p>
            <p class="price">Rs. <%= String.format("%.2f", rs.getDouble("price")) %></p>
            <p class="cash-price">Cash: Rs. <%= String.format("%.2f", rs.getDouble("cash_price")) %></p>
            <p><strong>Status:</strong> <%= rs.getString("status") %></p>
            <div class="buttons">
                <form action="AddToCartServlet" method="post">
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>" />
                    <input type="hidden" name="name" value="<%= rs.getString("model_name") %>" />
                    <input type="hidden" name="price" value="<%= rs.getDouble("price") %>" />
                    <input type="hidden" name="quantity" value="1" />
                    <button type="submit" class="add-cart">Add to Cart</button>
                </form>
                <a href="ViewPrintersDetails.jsp?id=<%= rs.getInt("id") %>" class="view-more">View More</a>
                <form action="Checkout.jsp" method="post">
                    <input type="hidden" name="quickBuyId" value="<%= rs.getInt("id") %>" />
                    <button type="submit" class="buy-now">Buy Now</button>
                </form>
            </div>
        </div>
        <%
                }
                conn.close();
            } catch (Exception e) {
                out.print("<p style='color:red; text-align:center;'>Error: " + e.getMessage() + "</p>");
            }
        %>
    </div>
</div>

</body>
</html>
