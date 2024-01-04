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

@WebServlet("/Admin-edit-employee")
public class AdminEditEmployeeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getRequestDispatcher("admin/EditEmployee.jsp").forward(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            int edit_employee = Integer.parseInt(request.getParameter("edit_employee")) ;
            String firstname = request.getParameter("firstname");
            String middlename = request.getParameter("middlename");
            String lastname = request.getParameter("lastname");
            String email = request.getParameter("email");
            String mobile = request.getParameter("mobile");
            String department = request.getParameter("department");
            String employee_type = request.getParameter("employee_type");

            Connection con = DatabaseConnection.initializeDatabase();

            String sql;
            sql = String.format("update employee set firstname='%s', middlename='%s', lastname='%s', email='%s', mobile='%s', department='%s', employee_type='%s' where employee_id = %d", firstname, middlename, lastname, email, mobile, department, employee_type, edit_employee);
            Statement st = con.createStatement();
            st.executeUpdate(sql);
            response.sendRedirect("Admin-employees");
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(AdminAddEmployeeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
}
