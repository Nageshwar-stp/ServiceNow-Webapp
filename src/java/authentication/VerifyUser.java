package authentication;

import database.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class VerifyUser {
    public static boolean authenticate(String username, String password) throws ClassNotFoundException, SQLException{
        
        System.out.println("authenticate called!!");

        Connection con = DatabaseConnection.initializeDatabase();
        
        String sql = "select * from user where username = ? and password = ?";
        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, username);
        st.setString(2, password);
        
        ResultSet resultset = st.executeQuery();
        System.out.println("authenticate end!");

        if(resultset.next()){
            return true;
        }
        return false;
        
        
    }
}
