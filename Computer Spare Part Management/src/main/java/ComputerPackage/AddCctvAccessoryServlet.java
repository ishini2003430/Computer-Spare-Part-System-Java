package ComputerPackage;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/AddCctvAccessoryServlet")
public class AddCctvAccessoryServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/computer";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "ishini2003";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String name = request.getParameter("name");
        String itemCode = request.getParameter("item_code");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String cashPriceStr = request.getParameter("cash_price");
        String stockStatus = request.getParameter("stock_status");
        String imageUrl = request.getParameter("image_url");
        String description = request.getParameter("description");
        String brand = request.getParameter("brand");

        // Convert price values
        double price = 0;
        double cashPrice = 0;

        try {
            price = Double.parseDouble(priceStr);
            cashPrice = Double.parseDouble(cashPriceStr);
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid price or cash price format.");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Load driver and connect
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "INSERT INTO cctvaccess (name, item_code, category, price, cash_price, stock_status, image_url, description, brand) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, itemCode);
            stmt.setString(3, category);
            stmt.setDouble(4, price);
            stmt.setDouble(5, cashPrice);
            stmt.setString(6, stockStatus);
            stmt.setString(7, imageUrl);
            stmt.setString(8, description);
            stmt.setString(9, brand);

            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                response.sendRedirect("ViewCctvAccess.jsp"); // Redirect after success
            } else {
                response.getWriter().println("Failed to add the accessory.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }
}
