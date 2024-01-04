package main;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import authentication.VerifyUser;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = "/Login")
public class LoginServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        
        request.getRequestDispatcher("login.jsp").forward(request, response);

    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        boolean authenticated;
        try {
            
            authenticated = VerifyUser.authenticate(username, password);
            
        } catch (ClassNotFoundException | SQLException ex) {
            authenticated = false;
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        if(authenticated){
            try {
                HttpSession session = request.getSession();
                String rolename = GetUserInfo.userRole(username);
                session.setAttribute("username", username);
                session.setAttribute("role", rolename);
                
                if(null != rolename)
                    switch (rolename) {
                    case "admin":
                        response.sendRedirect("Admin");
                        break;
                    case "employee":
                        response.sendRedirect("Employee");
                        break;
                    case "support":
                        response.sendRedirect("Support");
                        break;
                    default:
                        break;
                }
                
            } catch (ClassNotFoundException | SQLException ex) {
                Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        else{
            String errorMessage = "Please enter the correct username and password for a staff account. Note that both fields may be case-sensitive.";
            request.setAttribute("error-message", errorMessage);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }

    }
}
