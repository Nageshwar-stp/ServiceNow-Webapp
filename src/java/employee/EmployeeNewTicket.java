package employee;

import database.DatabaseConnection;
import java.io.IOException;
import java.sql.Connection;
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
import javax.servlet.http.HttpSession;
import java.sql.Date;

@WebServlet("/Employee-new-ticket")
public class EmployeeNewTicket extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("employee/NewTicket.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("username");

            Connection con = DatabaseConnection.initializeDatabase();
            String sql = String.format("select user_id from user where username='%s'", username);
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet resultset = st.executeQuery();
            resultset.next();

            int user_id = resultset.getInt("user_id");
            String category = request.getParameter("category");
            String subcategory = request.getParameter("subcategory");
            String description = request.getParameter("description");

            Date date = new Date(System.currentTimeMillis());

            String query;
            query = "insert into ticket (user_id, created_by, created_date, ticket_category, ticket_subcategory, ticket_description) values (?,?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, user_id);
            ps.setString(2, username);
            ps.setDate(3, date);
            ps.setString(4, category);
            ps.setString(5, subcategory);
            ps.setString(6, description);

            ps.executeUpdate();
            con.close();
            ps.close();
            response.sendRedirect("Employee");

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(EmployeeNewTicket.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
