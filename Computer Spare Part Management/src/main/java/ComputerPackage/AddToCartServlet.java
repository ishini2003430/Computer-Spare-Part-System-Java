package ComputerPackage;


import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Retrieve or create cart
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // Read item details from request
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        String image = request.getParameter("image");

        // Check if item already exists in cart
        boolean found = false;
        for (CartItem item : cart) {
            if (item.getId() == id) {
                item.setQuantity(item.getQuantity() + 1); // increment quantity
                found = true;
                break;
            }
        }

        if (!found) {
            cart.add(new CartItem(id, name, price, image, 1));
        }

        // Save updated cart back to session
        session.setAttribute("cart", cart);

        // Redirect back to laptops page or wherever you want
        response.sendRedirect("Laptops.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
