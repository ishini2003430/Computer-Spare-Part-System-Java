package ComputerPackage;

import java.io.IOException;

import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String action = request.getParameter("action");

        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart != null) {
            for (CartItem item : cart) {
                if (item.getId() == id) {
                    if ("increment".equals(action)) {
                        item.setQuantity(item.getQuantity() + 1);
                    } else if ("decrement".equals(action) && item.getQuantity() > 1) {
                        item.setQuantity(item.getQuantity() - 1);
                    }
                    break;
                }
            }
        }

        response.sendRedirect("ViewCart.jsp");
    }
}
