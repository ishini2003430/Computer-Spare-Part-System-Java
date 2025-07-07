package ComputerPackage;

import java.io.IOException;
import java.sql.*;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get user input
        String name = request.getParameter("fullname");  // note: 'fullname' to match JSP
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String totalStr = request.getParameter("total");

        if (totalStr == null || totalStr.trim().isEmpty()) {
            throw new ServletException("Total amount is missing.");
        }

        double total = 0;
        try {
            total = Double.parseDouble(totalStr.trim());
        } catch (NumberFormatException e) {
            throw new ServletException("Invalid total amount.");
        }

        // Get cart from session
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        Connection conn = null;
        PreparedStatement psOrder = null;
        PreparedStatement psItem = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/computer", "root", "ishini2003");

            // Insert order into orders table
            String orderSQL = "INSERT INTO orders (name, email, phone, address, total_amount) VALUES (?, ?, ?, ?, ?)";
            psOrder = conn.prepareStatement(orderSQL, Statement.RETURN_GENERATED_KEYS);
            psOrder.setString(1, name);
            psOrder.setString(2, email);
            psOrder.setString(3, phone);
            psOrder.setString(4, address);
            psOrder.setDouble(5, total);

            int affectedRows = psOrder.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating order failed, no rows affected.");
            }

            // Get generated order ID
            ResultSet generatedKeys = psOrder.getGeneratedKeys();
            int orderId = 0;
            if (generatedKeys.next()) {
                orderId = generatedKeys.getInt(1);
            } else {
                throw new SQLException("Creating order failed, no ID obtained.");
            }

            // Insert order items
            if (cart != null && !cart.isEmpty()) {
                String itemSQL = "INSERT INTO order_items (order_id, product_id, product_name, price, quantity) VALUES (?, ?, ?, ?, ?)";
                psItem = conn.prepareStatement(itemSQL);

                for (CartItem item : cart) {
                    psItem.setInt(1, orderId);
                    psItem.setInt(2, item.getId());
                    psItem.setString(3, item.getName());
                    psItem.setDouble(4, item.getPrice());
                    psItem.setInt(5, item.getQuantity());

                    psItem.executeUpdate();
                }
            }

            // Clear the cart
            session.removeAttribute("cart");

            // Redirect to order success page
            response.sendRedirect("OrderSuccess.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error placing order: " + e.getMessage());
        } finally {
            try {
                if (psOrder != null) psOrder.close();
                if (psItem != null) psItem.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
