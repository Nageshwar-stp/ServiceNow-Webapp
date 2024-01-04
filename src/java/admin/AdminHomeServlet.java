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

@WebServlet("/Admin")
public class AdminHomeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("admin/Home.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String assign_to = (String) request.getParameter("assign_to");
            int ticket_id = Integer.parseInt(request.getParameter("ticket_id"));
            String assign_by = (String) request.getParameter("assign_by");
            
            Connection con = DatabaseConnection.initializeDatabase();
            
            String sql = String.format("insert into assigned_ticket (ticket_id, assigned_by, assigned_to) values(%d, '%s', '%s')",ticket_id, assign_by, assign_to);
            Statement st = con.createStatement();
            
            st.executeUpdate(sql);
            response.sendRedirect("Admin");
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(AdminHomeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
