package ComputerPackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/AddAccessoryServlet")
public class AddAccessoryServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set response type
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get form data
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String itemCode = request.getParameter("item_code");
        String price = request.getParameter("price");
        String cashPrice = request.getParameter("cash_price");
        String stockStatus = request.getParameter("stock_status");
        String imageUrl = request.getParameter("image_url");
        String description = request.getParameter("description");

        // DB connection parameters
        String jdbcURL = "jdbc:mysql://localhost:3306/computer";
        String dbUser = "root";
        String dbPassword = "ishini2003";

        try {
            // Load JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Connect to DB
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // SQL insert
            String sql = "INSERT INTO computeraccess (name, category, item_code, price, cash_price, stock_status, image_url, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, name);
            stmt.setString(2, category);
            stmt.setString(3, itemCode);
            stmt.setDouble(4, Double.parseDouble(price));
            stmt.setDouble(5, Double.parseDouble(cashPrice));
            stmt.setString(6, stockStatus);
            stmt.setString(7, imageUrl);
            stmt.setString(8, description);

            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                out.println("<script>alert('Accessory added successfully!'); window.location='viewAccessories.jsp';</script>");
            } else {
                out.println("<script>alert('Failed to add accessory.'); window.history.back();</script>");
            }

            // Close connection
            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Error: " + e.getMessage() + "'); window.history.back();</script>");
        }
    }
}
