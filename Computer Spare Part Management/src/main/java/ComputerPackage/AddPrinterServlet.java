package ComputerPackage;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/AddPrinterServlet")
public class AddPrinterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String model = request.getParameter("model_name");
        String itemCode = request.getParameter("item_code");
        String brand = request.getParameter("brand");
        String type = request.getParameter("type");
        String priceStr = request.getParameter("price");
        String cashPriceStr = request.getParameter("cash_price");
        String status = request.getParameter("stock_status");
        String desc = request.getParameter("description");
        String imageUrl = request.getParameter("image_url");

        try {
            double price = Double.parseDouble(priceStr);
            double cashPrice = Double.parseDouble(cashPriceStr);

            // Load JDBC driver and connect to database
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/computer", "root", "ishini2003");

            // Insert printer record with item_code and image_url
            String sql = "INSERT INTO printers (model_name, item_code, brand, type, price, cash_price, status, description, image_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, model);
            ps.setString(2, itemCode);
            ps.setString(3, brand);
            ps.setString(4, type);
            ps.setDouble(5, price);
            ps.setDouble(6, cashPrice);
            ps.setString(7, status);
            ps.setString(8, desc);
            ps.setString(9, imageUrl);

            ps.executeUpdate();
            con.close();

            // Redirect to view page
            response.sendRedirect("viewprinters.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<h3>Error: " + e.getMessage() + "</h3>");
        }
    }
}
