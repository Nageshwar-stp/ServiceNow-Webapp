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

@WebServlet("/Employee")
public class EmployeeHomeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("employee/Home.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            int ticket_id = Integer.parseInt(request.getParameter("ticket_id"));
            String new_description = request.getParameter("ticket_description");
            String new_category = request.getParameter("category");
            String new_subcategory = request.getParameter("subcategory");
            String new_status = request.getParameter("status");
            String new_feedback = request.getParameter("ticket_feedback");

            if("on".equals(new_status)){
                new_status = "OPEN";
            }
            else{
                new_status = "CLOSE";
            }

            Connection con = DatabaseConnection.initializeDatabase();

            String sql;
            sql = String.format("update ticket set ticket_category='%s', ticket_subcategory='%s', ticket_description='%s', status='%s', feedback='%s' where ticket_id=%d",new_category, new_subcategory, new_description, new_status, new_feedback, ticket_id);
            Statement st = con.createStatement();
            st.executeUpdate(sql);
            response.sendRedirect("Employee");
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(EmployeeHomeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
