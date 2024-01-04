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

@WebServlet("/Admin-ticket-categories")
public class AdminTicketCategories extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("admin/TicketCategories.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String category = request.getParameter("category");
            String category_name = request.getParameter("category_name");

            Connection con = DatabaseConnection.initializeDatabase();
            String sql = null;
            if (category.equals("category")) {
                sql = String.format("insert into ticket_category (category_name) values('%s')", category_name);

            } else if (category.equals("subcategory")) {
                sql = String.format("insert into ticket_subcategory (subcategory_name) values('%s')", category_name);

            }

            Statement st = con.createStatement();
            st.executeUpdate(sql);
            response.sendRedirect("Admin-ticket-categories");
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(AdminTicketCategories.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
