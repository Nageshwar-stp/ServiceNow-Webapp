
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

@WebServlet("/Admin-add-employee")
public class AdminAddEmployeeServlet extends HttpServlet{
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        
       request.getRequestDispatcher("admin/AddEmployee.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        
        try {
            String firstname = request.getParameter("firstname");
            String middlename = request.getParameter("middlename");
            String lastname = request.getParameter("lastname");
            String email = request.getParameter("email");
            String mobile = request.getParameter("mobile");
            String department = request.getParameter("department");
            String employee_type = request.getParameter("employee_type");
            
            Connection con = DatabaseConnection.initializeDatabase();
            
            String sql = String.format("insert into employee(firstname, middlename, lastname, email, mobile, department,employee_type) values ('%s','%s','%s','%s','%s','%s','%s')", firstname, middlename, lastname, email, mobile, department, employee_type);
            Statement st = con.createStatement();
            st.executeUpdate(sql);
            response.sendRedirect("Admin-employees");
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(AdminAddEmployeeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
       
    }
}
