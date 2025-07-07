package ComputerPackage;



import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.HashMap;

@WebServlet("/ProcessOrderServlet")
public class ProcessOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get customer details from form
        String customerName = request.getParameter("customerName");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        // Get cart from session
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("Laptops.jsp");
            return;
        }

        List<HashMap<String, Object>> cart = (List<HashMap<String, Object>>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            // No cart or empty cart, redirect back to products
            response.sendRedirect("Laptops.jsp");
            return;
        }

        // Calculate total amount
        double totalAmount = 0;
        for (HashMap<String, Object> item : cart) {
            double price = 0;
            int quantity = 0;
            try {
                price = (Double) item.get("price");
            } catch (Exception e) {
                price = ((Number) item.get("price")).doubleValue();
            }
            try {
                quantity = (Integer) item.get("quantity");
            } catch (Exception e) {
                quantity = ((Number) item.get("quantity")).intValue();
            }
            totalAmount += price * quantity;
        }

        // TODO: Save order details to database here
        // For now, just print to console
        System.out.println("New Order Received:");
        System.out.println("Customer: " + customerName);
        System.out.println("Email: " + email);
        System.out.println("Address: " + address);
        System.out.println("Total: " + totalAmount);
        System.out.println("Items:");
        for (HashMap<String, Object> item : cart) {
            System.out.println("- " + item.get("name") + " x" + item.get("quantity"));
        }

        // Clear cart after order placed
        session.removeAttribute("cart");

        // Redirect to a simple order confirmation page (you need to create it)
        response.sendRedirect("OrderConfirmation.jsp");
    }
}
