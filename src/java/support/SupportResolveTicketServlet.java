package support;

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
import javax.servlet.http.HttpSession;

@WebServlet("/Support-resolve-ticket")
public class SupportResolveTicketServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            int ticket_id = Integer.parseInt(request.getParameter("ticket_id"));
            int assignment_id = Integer.parseInt(request.getParameter("assignment_id"));
            
            Connection con = DatabaseConnection.initializeDatabase();
            
            String sql;
            sql = String.format("update ticket set status='CLOSE' where ticket_id=%d",ticket_id);
            Statement st = con.createStatement();
            st.executeUpdate(sql);
            
            
            sql = String.format("delete from assigned_ticket where id=%d",assignment_id);
            st = con.createStatement();
            st.executeUpdate(sql);
            
            HttpSession session = request.getSession();
            String support_user = (String) session.getAttribute("username");
            
            sql = String.format("insert into support_log (ticket_id, response, ticket_description, support_user) values(%d, 'Resolved', 'Null', '%s')", ticket_id, support_user);
            st = con.createStatement();
            st.executeUpdate(sql);
            response.sendRedirect("Support");
            
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(SupportResolveTicketServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
