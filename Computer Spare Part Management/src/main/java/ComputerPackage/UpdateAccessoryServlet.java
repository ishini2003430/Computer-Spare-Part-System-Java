package ComputerPackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/UpdateAccessoryServlet")
public class UpdateAccessoryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String itemCode = request.getParameter("item_code");
        String price = request.getParameter("price");
        String cashPrice = request.getParameter("cash_price");
        String stockStatus = request.getParameter("stock_status");
        String imageUrl = request.getParameter("image_url");
        String description = request.getParameter("description");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/computer", "root", "ishini2003");

            String sql = "UPDATE computeraccess SET name=?, category=?, item_code=?, price=?, cash_price=?, stock_status=?, image_url=?, description=? WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, name);
            stmt.setString(2, category);
            stmt.setString(3, itemCode);
            stmt.setDouble(4, Double.parseDouble(price));
            stmt.setDouble(5, Double.parseDouble(cashPrice));
            stmt.setString(6, stockStatus);
            stmt.setString(7, imageUrl);
            stmt.setString(8, description);
            stmt.setInt(9, Integer.parseInt(id));

            int updated = stmt.executeUpdate();

            if (updated > 0) {
                out.println("<script>alert('Accessory updated successfully!'); window.location='viewAccessories.jsp';</script>");
            } else {
                out.println("<script>alert('Failed to update accessory.'); history.back();</script>");
            }

            conn.close();
        } catch (Exception e) {
            out.println("<script>alert('Error: " + e.getMessage() + "'); history.back();</script>");
            e.printStackTrace();
        }
    }
}
