package ComputerPackage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



@WebServlet("/DeleteCctvAccessServlet")
public class DeleteCctvAccessServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Change these as per your DB config
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/computer";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "ishini2003";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("ViewCctvAccess.jsp");
            return;
        }

        int id = 0;
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("ViewCctvAccess.jsp");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.jdbc.Driver"); // or com.mysql.cj.jdbc.Driver for newer versions
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            String sql = "DELETE FROM cctvaccess WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);

            int rowsDeleted = pstmt.executeUpdate();

            // You can optionally check if rowsDeleted > 0 to confirm delete

            response.sendRedirect("ViewCctvAccess.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            // Optionally forward to an error page or show error message
            response.getWriter().println("Error deleting record: " + e.getMessage());
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
