<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String id = request.getParameter("id");

    if (id != null && !id.isEmpty()) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.jdbc.Driver"); // or "com.mysql.cj.jdbc.Driver" for MySQL 8+
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/computer", "root", "ishini2003");

            String sql = "DELETE FROM register WHERE idregister = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(id));

            int rows = pstmt.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("Registeraccount.jsp");
            } else {
                out.println("<script>alert('User not found!'); window.location='Registeraccount.jsp';</script>");
            }

        } catch (Exception e) {
            out.println("<script>alert('Error: " + e.getMessage() + "'); window.location='Registeraccount.jsp';</script>");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    } else {
        out.println("<script>alert('Invalid user ID.'); window.location='Registeraccount.jsp';</script>");
    }
%>
