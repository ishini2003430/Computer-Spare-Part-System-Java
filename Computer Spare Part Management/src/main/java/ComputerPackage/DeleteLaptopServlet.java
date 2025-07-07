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

@WebServlet("/DeleteLaptopServlet")
public class DeleteLaptopServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/computer", "root", "ishini2003");
            PreparedStatement ps = conn.prepareStatement("DELETE FROM laptops WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            conn.close();
            response.sendRedirect("ViewLaptop.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Delete error: " + e.getMessage());
        }
    }
}


