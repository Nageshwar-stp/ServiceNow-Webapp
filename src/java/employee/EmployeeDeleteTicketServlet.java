package employee;

import database.DatabaseConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Employee-delete-ticket")
public class EmployeeDeleteTicketServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int ticket_id = Integer.parseInt(request.getParameter("ticket_id"));
            Connection con = DatabaseConnection.initializeDatabase();
            String sql = null;
            
            sql = String.format("delete from ticket where ticket_id=%d", ticket_id);
            
            Statement st = con.createStatement();
            st.executeUpdate(sql);
            response.sendRedirect("Employee");
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(EmployeeDeleteTicketServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
