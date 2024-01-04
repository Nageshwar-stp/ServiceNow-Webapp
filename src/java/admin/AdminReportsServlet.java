package admin;

import database.DatabaseConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Admin-reports")
public class AdminReportsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("admin/Reports.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            String username = request.getParameter("username");
            String report_name = request.getParameter("report_name");
            
            Connection con = DatabaseConnection.initializeDatabase();
            String sql = String.format("select user_id from user where username='%s'", username);
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet resultset = st.executeQuery();
            resultset.next();
            
            int user_id = resultset.getInt("user_id");
            Date date = new Date(System.currentTimeMillis());
            
            String query;
            query = "insert into report (report_name, user_id, generated_on) values (?,?,?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, report_name);
            ps.setInt(2, user_id);
            ps.setDate(3, date);
           
            
            ps.executeUpdate();
            con.close();
            ps.close();
            
            response.sendRedirect("Admin-reports");
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(AdminReportsServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
