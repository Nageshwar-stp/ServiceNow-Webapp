package admin;

import database.DatabaseConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Admin-delete-category")
public class AdminDeleteCategory extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            String category = request.getParameter("category");
            int id = Integer.parseInt(request.getParameter("id"));

            Connection con = DatabaseConnection.initializeDatabase();
            String sql = null;
            if (category.equals("category")) {
                sql = String.format("delete from ticket_category where id=%d", id);
            } else if (category.equals("subcategory")) {
                sql = String.format("delete from ticket_subcategory where id=%d", id);
            }
            Statement st = con.createStatement();
            st.executeUpdate(sql);

            response.sendRedirect("Admin-ticket-categories");
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(AdminDeleteCategory.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
