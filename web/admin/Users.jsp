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

        <title>Users | Admin | Service Now</title>
    </head>
    <body>
        <%
            if (session.getAttribute("username") == null || !(session.getAttribute("role").equals("admin"))) {
                response.sendRedirect("Login");
            }
        %>
        <jsp:include page="Navbar.jsp"/>

        <section class="container" style="margin-top: 40px;">
            <h4>All Users  <a href="Admin-add-user" class="btn btn-warning btn-sm" style="float: right;">+ Add new</a> </h4><hr>
            <div class="table-responsive" style="margin-bottom:40px">
                <table class="table table-striped table-sm">
                    <thead>
                        <tr>
                            <th scope="col">Id</th>
                            <th scope="col">Username</th>
                            <th scope="col">Password</th>
                            <th scope="col">Employee Id</th>
                            <th scope="col">Role</th>

                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Connection con = DatabaseConnection.initializeDatabase();

                            String sql = "select * from user";
                            PreparedStatement st = con.prepareStatement(sql);
                            ResultSet resultset = st.executeQuery();
                            int role_id;
                            String sql2;
                            String role_name;
                            while (resultset.next()) {
                                String user_id = resultset.getString("user_id");
                                String username = resultset.getString("username");
                                String employee_id = resultset.getString("employee_id");
                                
                                role_id = Integer.parseInt(resultset.getString("role_id"));
                                sql2 = "select * from role where id=?";
                                PreparedStatement st2 = con.prepareStatement(sql2);
                                st2.setInt(1, role_id);
                                ResultSet resultset2 = st2.executeQuery();
                                resultset2.next();
                                role_name = resultset2.getString("rolename");
                        %>

                        <tr>
                            <td><% out.print(user_id);%></td>
                            <td><a href="Admin-edit-user?edit_user=<%= user_id%>"><% out.print(username);%></a></td>
                            <td>**********</td>
                            <td><% out.print(employee_id); %></td>
                            <td><% out.print(role_name); %> (<% out.print(role_id); %>) </td>
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