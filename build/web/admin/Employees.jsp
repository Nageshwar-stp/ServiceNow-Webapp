<%@page import="java.sql.PreparedStatement"%>
<%@page import="database.DatabaseConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

        <title>Employees | Admin | Service Now</title>
    </head>
    <body>
       <%
            if (session.getAttribute("username") == null || !(session.getAttribute("role").equals("admin"))) {
                response.sendRedirect("Login");
            }
        %>
        <jsp:include page="Navbar.jsp"/>

        <section class="container" style="margin-top: 40px;">
            <h4>All Employees <a href="Admin-add-employee" class="btn btn-warning btn-sm" style="float: right">+ Add new</a> </h4><hr>

            <div class="table-responsive" style="margin-bottom:40px">
                <table class="table table-striped table-sm">
                    <thead>
                        <tr>
                            <th scope="col">Id</th>
                            <th scope="col">Name</th>
                            <th scope="col">Email</th>
                            <th scope="col">Phone</th>
                            <th scope="col">Department</th>
                            <th scope="col">Employee Type</th>

                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Connection con = DatabaseConnection.initializeDatabase();

                            String sql = "select * from employee";
                            PreparedStatement st = con.prepareStatement(sql);
                            ResultSet resultset = st.executeQuery();
                            while (resultset.next()) {
                                String employeeid = resultset.getString("employee_id");
                                String firstname = resultset.getString("firstname");
                                String middlename = resultset.getString("middlename");
                                String lastname = resultset.getString("lastname");
                                String email = resultset.getString("email");
                                String mobile = resultset.getString("mobile");
                                String department = resultset.getString("department");
                                String employee_type = resultset.getString("employee_type");
                        %>

                        <tr>
                            <td><% out.print(employeeid); %></td>
                            <td>
                                <a href="Admin-edit-employee?edit_employee=<%= employeeid %>">
                                    <%

                                        String name;
                                        if (middlename == null) {
                                            middlename = "";
                                        }
                                        name = firstname + " " + middlename + " " + lastname;
                                        out.print(name);
                                    %>
                                </a>
                            </td>
                            <td><% out.print(email); %></td>
                            <td><% out.print(mobile); %></td>
                            <td><% out.print(department); %></td>
                            <td><% out.print(employee_type); %></td>
                        </tr>

                        <%
                            }
                        %>

                    </tbody>
                </table>
            </div>
                        <hr>
                        

        </section>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>