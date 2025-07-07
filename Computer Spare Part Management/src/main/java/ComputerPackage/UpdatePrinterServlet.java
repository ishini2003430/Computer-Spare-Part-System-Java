package ComputerPackage;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/UpdatePrinterServlet")
public class UpdatePrinterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String model = request.getParameter("model_name");
        String itemCode = request.getParameter("item_code");
        String brand = request.getParameter("brand");
        String type = request.getParameter("type");
        double price = Double.parseDouble(request.getParameter("price"));
        double cashPrice = Double.parseDouble(request.getParameter("cash_price"));
        String status = request.getParameter("status");
        String desc = request.getParameter("description");
        String imageUrl = request.getParameter("image_url");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/computer", "root", "ishini2003");

            String sql = "UPDATE printers SET model_name=?, item_code=?, brand=?, type=?, price=?, cash_price=?, status=?, description=?, image_url=? WHERE id=?";
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
            ps.setInt(10, id);

            ps.executeUpdate();
            con.close();

            response.sendRedirect("viewprinters.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
