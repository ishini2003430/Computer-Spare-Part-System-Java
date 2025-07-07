package ComputerPackage;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

	private static String url="jdbc:mysql://localhost:3306/computer";
	private static String user ="root";
	private static String pass ="ishini2003";

	
	public static Connection getConnection () {
		 Connection connection = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(url, user, pass);
		}
		catch (ClassNotFoundException | SQLException e) {
			 e.printStackTrace();
		}
		return connection;
	}
	
	// Close connection
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
	
	
	
	
}
