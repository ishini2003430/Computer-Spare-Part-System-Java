package ComputerPackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/DeletePartServlet")
public class DeletePartServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        int id = 0;

        if (idParam != null && !idParam.isEmpty()) {
            try {
                id = Integer.parseInt(idParam);
            } catch (NumberFormatException e) {
                response.getWriter().println("Invalid part ID.");
                return;
            }
        } else {
            response.getWriter().println("Part ID is missing.");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/computer", "root", "ishini2003");

            String sql = "DELETE FROM parts WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);

            int rows = pstmt.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("Viewpart.jsp");
            } else {
                response.getWriter().println("Part not found or already deleted.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error deleting part: " + e.getMessage());
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception ignore) {}
            try { if (conn != null) conn.close(); } catch (Exception ignore) {}
        }
    }
}
