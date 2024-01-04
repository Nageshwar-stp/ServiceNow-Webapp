<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="database.DatabaseConnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

        <title>Add User | Admin | Service Now</title>
    </head>
    <body>
       <%
            if (session.getAttribute("username") == null || !(session.getAttribute("role").equals("admin"))) {
                response.sendRedirect("Login");
            }
        %>
        <jsp:include page="Navbar.jsp"/>

        <section class="container" style="margin-top: 40px;">
            <h1>Add New User</h1>

            <form class="mt-4" method="post" action="Admin-add-user">
                <div class="mb-3">
                    <label for="emailEntry" class="form-label" >Username</label>
                    <input type="text" name="username" placeholder="username" class="form-control" id="emailEntry" aria-describedby="emailHelp" maxlength="32" required>
                </div>
                <div class="mb-3">
                    <label for="emailEntry" class="form-label" >Password</label>
                    <input type="password" name="password" placeholder="password" class="form-control" id="emailEntry" aria-describedby="emailHelp" maxlength="32" required>
                </div>
                <div class="mb-3">
                    <label for="employee" class="form-label">Employee</label>
                    <select id="employee" class="form-control" name="employee_id">
                        <%
                            Connection con = DatabaseConnection.initializeDatabase();

                            String sql = "select * from employee";
                            PreparedStatement st = con.prepareStatement(sql);
                            ResultSet resultset = st.executeQuery();
                            while (resultset.next()) {
                                String employeeid = resultset.getString("employee_id");
                                String firstname = resultset.getString("firstname");
                        %>
                        <option value="<%=employeeid%>"><%=firstname%></option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="role" class="form-label">Role</label>
                    <select id="role" class="form-control" name="role_id">
                        <%

                            String sql2 = "select * from role";
                            PreparedStatement st2 = con.prepareStatement(sql2);
                            ResultSet resultset2 = st2.executeQuery();
                            while (resultset2.next()) {
                                int role_id = resultset2.getInt("id");
                                String rolename = resultset2.getString("rolename");
                        %>
                        <option value="<%=role_id%>"><%=rolename%></option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <button type="submit" class="btn btn-warning mt-3" >Add</button>
            </form>
        </section>
        <br><br><br>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>