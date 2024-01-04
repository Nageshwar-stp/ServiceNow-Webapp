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

@WebServlet("/Admin-add-user")
public class AdminAddUserServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getRequestDispatcher("admin/AddUser.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            int employee_id = Integer.parseInt( request.getParameter("employee_id"));
            int role_id = Integer.parseInt( request.getParameter("role_id"));

            Connection con = DatabaseConnection.initializeDatabase();

            String sql = String.format("insert into user(username, password, employee_id, role_id) values ('%s','%s','%d','%d')", username, password, employee_id, role_id);
            Statement st = con.createStatement();
            st.executeUpdate(sql);
            response.sendRedirect("Admin-users");
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(AdminAddEmployeeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
}
