<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Inventory Summary - TechParts</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 40px;
            color: #333;
        }
        h1 {
            text-align: center;
            margin-bottom: 40px;
            color: #2e3b4e;
        }
        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            max-width: 1000px;
            margin: 0 auto;
        }
        .card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.1);
            padding: 25px 20px;
            text-align: center;
        }
        .card h3 {
            font-size: 1.25rem;
            font-weight: 600;
            color: #4c5c7a;
            margin-bottom: 12px;
        }
        .card .number {
            font-size: 3rem;
            font-weight: 700;
            color: #2563eb; /* blue */
        }
        .card small {
            display: block;
            margin-top: 8px;
            font-weight: 600;
        }
        .low-stock {
            color: #e74c3c; /* red */
        }
    </style>
</head>
<body>
    <h1>Inventory Summary</h1>
    <section class="cards">
    <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // Variables for all categories
        int laptopCount = 0;
        int laptopAccCount = 0;
        int compAccCount = 0;
        int cctvAccCount = 0;
        int printerCount = 0;

        int laptopLowStock = 0;
        int laptopAccLowStock = 0;
        int compAccLowStock = 0;
        int cctvAccLowStock = 0;
        int printerLowStock = 0;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/computer", "root", "ishini2003");

            // Tables to check
            String[] tables = {"laptops", "laptop_accessories", "computer_accessories", "cctv_accessories", "printers"};
            int[] counts = new int[tables.length];
            int[] lowStocks = new int[tables.length];

            for (int i = 0; i < tables.length; i++) {
                String sqlCount = "SELECT quantity, min_stock FROM " + tables[i];
                pstmt = conn.prepareStatement(sqlCount);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    counts[i]++;
                    int quantity = rs.getInt("quantity");
                    int minStock = rs.getInt("min_stock");
                    if (quantity <= minStock) {
                        lowStocks[i]++;
                    }
                }

                rs.close();
                pstmt.close();
            }

            laptopCount = counts[0];
            laptopAccCount = counts[1];
            compAccCount = counts[2];
            cctvAccCount = counts[3];
            printerCount = counts[4];

            laptopLowStock = lowStocks[0];
            laptopAccLowStock = lowStocks[1];
            compAccLowStock = lowStocks[2];
            cctvAccLowStock = lowStocks[3];
            printerLowStock = lowStocks[4];

    %>
        <div class="card">
            <h3>Laptops</h3>
            <div class="number"><%= laptopCount %></div>
            <% if(laptopLowStock > 0) { %>
                <small class="low-stock"><%= laptopLowStock %> Low Stock</small>
            <% } %>
        </div>

        <div class="card">
            <h3>Laptop Accessories</h3>
            <div class="number"><%= laptopAccCount %></div>
            <% if(laptopAccLowStock > 0) { %>
                <small class="low-stock"><%= laptopAccLowStock %> Low Stock</small>
            <% } %>
        </div>

        <div class="card">
            <h3>Computer Accessories</h3>
            <div class="number"><%= compAccCount %></div>
            <% if(compAccLowStock > 0) { %>
                <small class="low-stock"><%= compAccLowStock %> Low Stock</small>
            <% } %>
        </div>

        <div class="card">
            <h3>CCTV Accessories</h3>
            <div class="number"><%= cctvAccCount %></div>
            <% if(cctvAccLowStock > 0) { %>
                <small class="low-stock"><%= cctvAccLowStock %> Low Stock</small>
            <% } %>
        </div>

        <div class="card">
            <h3>Printers</h3>
            <div class="number"><%= printerCount %></div>
            <% if(printerLowStock > 0) { %>
                <small class="low-stock"><%= printerLowStock %> Low Stock</small>
            <% } %>
        </div>
    <%
        } catch(Exception e) {
            out.println("<p style='color:red;'>Error loading inventory summary: " + e.getMessage() + "</p>");
        } finally {
            if(rs != null) try { rs.close(); } catch(Exception ignore){}
            if(pstmt != null) try { pstmt.close(); } catch(Exception ignore){}
            if(conn != null) try { conn.close(); } catch(Exception ignore){}
        }
    %>
    </section>
</body>
</html>
