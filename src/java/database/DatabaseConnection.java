package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    public static Connection initializeDatabase() throws ClassNotFoundException, SQLException
    {
        String dbDriver = "com.mysql.cj.jdbc.Driver";
        String dbURL = "jdbc:mysql://localhost:3306/";
        String dbName = "service_now";
        String dbUsername = "servicenow_user";
        String dbPassword = "servicenow1234";
        
        Class.forName(dbDriver);
        Connection con = DriverManager.getConnection(dbURL+dbName, dbUsername, dbPassword);
        return con;
    }
    
}
