package main;

import database.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class GetUserInfo {
    public static String userRole(String username) throws ClassNotFoundException, SQLException{
        
        Connection con = DatabaseConnection.initializeDatabase();
        
        String sql = "select * from user where username = ?";
        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, username);
        ResultSet resultset = st.executeQuery();
        
        resultset.next();
        String role_id = resultset.getString("role_id");
        
        sql = "select * from role where id = ?";
        st = con.prepareStatement(sql);
        st.setString(1, role_id);
       resultset = st.executeQuery();
        
        resultset.next();
        String rolename = resultset.getString("rolename");
        
        System.out.println("Role name: " + rolename);
        
        
        return rolename;
    }
}
