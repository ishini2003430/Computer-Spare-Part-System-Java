<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Orders List</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f3f4f6; padding: 30px; }
        table { width: 80%; margin: auto; border-collapse: collapse; background: white; }
        th, td { padding: 12px; border: 1px solid #ccc; text-align: center; }
        th { background-color: #2563eb; color: white; }
        a { color: #2563eb; text-decoration: none; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <h2 style="text-align:center;">Orders List</h2>
    <table>
        <tr>
            <th>Order ID</th>
            <th>Customer Name</th>
            <th>Total Amount (Rs.)</th>
            <th>Order Date</th>
            <th>Details</th>
        </tr>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/computer", "root", "ishini2003");
                stmt = conn.createStatement();
                rs = stmt.executeQuery("SELECT id, name, total_amount, order_date FROM orders ORDER BY order_date DESC");

                while(rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getDouble("total_amount") %></td>
            <td><%= rs.getTimestamp("order_date") %></td>
            <td><a href="ViewOrderDetails.jsp?orderId=<%= rs.getInt("id") %>">View Details</a></td>
        </tr>
        <%
                }
            } catch(Exception e) {
                out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
            } finally {
                if(rs != null) rs.close();
                if(stmt != null) stmt.close();
                if(conn != null) conn.close();
            }
        %>
    </table>
</body>
</html>
