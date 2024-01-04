package admin;

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

@WebServlet("/Admin-unassign-ticket")
public class AdminUnassignTicketServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        try {
            int assignment_id = Integer.parseInt(request.getParameter("assignment_id"));
            
            Connection con = DatabaseConnection.initializeDatabase();
            String query = String.format("delete from assigned_ticket where id=%d", assignment_id);
            Statement st = con.createStatement();
            st.executeUpdate(query);
            response.sendRedirect("Admin");
            
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(AdminUnassignTicketServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
