package ComputerPackage;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/registerinsertservlet")
public class RegisterInsertServlet extends HttpServlet {
	 private static final long serialVersionUID = 1L;
    

   

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        
        //Insert register data using registerController
        boolean inserted = RegisterController.insertregister(fullname, email, username, password);
        
        if (inserted) {
            // Successful insertion
            response.sendRedirect("Registeraccount.jsp?success=true");
        } else {
            // Failed insertion
            response.sendRedirect("Register.jsp?success=false");
        }
        
        
        
    }
}
