package ComputerPackage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.DriverManager;

public class RegisterController {

    // Database connection details
    private static String url = "jdbc:mysql://localhost:3306/computer";
    private static String user = "root";
    private static String pass = "ishini2003";

    // Insert Register Method
    public static boolean insertregister(String fullname, String email, String username, String password) {
        boolean isSuccess = false;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, pass);

            String query = "INSERT INTO register (fullname, email, username, password) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setString(1, fullname);
            ps.setString(2, email);
            ps.setString(3, username);
            ps.setString(4, password);

            int result = ps.executeUpdate();
            if (result > 0) {
                isSuccess = true;
            }

            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return isSuccess;
    }

    // ✅ Update Register Method
    public static boolean updateRegister(int idregister, String fullname, String email, String username, String password) {
        boolean isSuccess = false;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, pass);

            String query = "UPDATE register SET fullname = ?, email = ?, username = ?, password = ? WHERE idregister = ?";
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setString(1, fullname);
            ps.setString(2, email);
            ps.setString(3, username);
            ps.setString(4, password);
            ps.setInt(5, idregister);

            int result = ps.executeUpdate();
            if (result > 0) {
                isSuccess = true;
            }

            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return isSuccess;
    }
}
