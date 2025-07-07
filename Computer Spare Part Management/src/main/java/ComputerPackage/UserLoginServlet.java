package ComputerPackage;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/UserLoginServlet")
public class UserLoginServlet extends HttpServlet {

    private final String dbURL = "jdbc:mysql://localhost:3306/computer";
    private final String dbUser = "root";
    private final String dbPassword = "ishini2003";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // load driver
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // User found, create session and redirect to dashboard
                HttpSession session = request.getSession();
                session.setAttribute("userEmail", email);
                session.setAttribute("userName", rs.getString("fullname")); // assuming column fullname

                response.sendRedirect("UserDashboard.jsp");
            } else {
                // Invalid login, back to login page with error
                request.setAttribute("errorMessage", "Invalid email or password");
                RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
                rd.forward(request, response);
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // you can make a simple error.jsp page
        }
    }
}
