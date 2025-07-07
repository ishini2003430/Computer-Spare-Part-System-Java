package ComputerPackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/DeleteAccessoryServlet")
public class DeleteAccessoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String id = request.getParameter("id");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/computer", "root", "ishini2003");

            String sql = "DELETE FROM computeraccess WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(id));

            int deleted = stmt.executeUpdate();

            if (deleted > 0) {
                out.println("<script>alert('Accessory deleted successfully!'); window.location='viewAccessories.jsp';</script>");
            } else {
                out.println("<script>alert('Failed to delete accessory.'); history.back();</script>");
            }

            conn.close();
        } catch (Exception e) {
            out.println("<script>alert('Error: " + e.getMessage() + "'); history.back();</script>");
            e.printStackTrace();
        }
    }
}
