<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Edit Supplier - TechParts</title>
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
    <h2>Edit Supplier</h2>

    <%
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            out.println("<p style='color:red;'>Supplier ID is missing.</p>");
        } else {
            int id = Integer.parseInt(idStr);

            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/computer", "root", "ishini2003");
                ps = conn.prepareStatement("SELECT * FROM suppliers WHERE id = ?");
                ps.setInt(1, id);
                rs = ps.executeQuery();

                if (rs.next()) {
    %>

    <form action="UpdateSupplierServlet" method="post">
        <input type="hidden" name="id" value="<%= id %>" />
        
        <label for="name">Name</label>
        <input type="text" id="name" name="name" value="<%= rs.getString("name") %>" required />

        <label for="email">Email</label>
        <input type="email" id="email" name="email" value="<%= rs.getString("email") %>" required />

        <label for="phone">Phone</label>
        <input type="text" id="phone" name="phone" value="<%= rs.getString("phone") %>" required />

        <label for="company">Company</label>
        <input type="text" id="company" name="company" value="<%= rs.getString("company") %>" required />

        <label for="address">Address</label>
        <textarea id="address" name="address" rows="4" required><%= rs.getString("address") %></textarea>

        <button type="submit">Update Supplier</button>
    </form>

    <a href="SupplierDetails.jsp" class="back-link">&larr; Back to Supplier List</a>

    <%
                } else {
                    out.println("<p style='color:red;'>Supplier not found.</p>");
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            }
        }
    %>
</div>

</body>
</html>
