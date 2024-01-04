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

        <title>Edit User | Admin | Service Now</title>
    </head>
    <body>
        <%
            if (session.getAttribute("username") == null || !(session.getAttribute("role").equals("admin"))) {
                response.sendRedirect("Login");
            }
        %>
        <jsp:include page="Navbar.jsp"/>
        <%
            Connection con = DatabaseConnection.initializeDatabase();
            int edit_user = Integer.parseInt(request.getParameter("edit_user"));

            String sql = "select * from user where user_id = ?";
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, edit_user);
            ResultSet resultset = st.executeQuery();
            resultset.next();
            String username = resultset.getString("username");
            String password = resultset.getString("password");
            String employee_id = resultset.getString("employee_id");
            String role_id = resultset.getString("role_id");

        %>
        <section class="container" style="margin-top: 40px;">
            <h3>Edit User Details</h3>

            <form class="mt-4" method="post" action="Admin-edit-user?edit_user=<%=edit_user%>">
                <div class="mb-3">
                    <label for="emailEntry" class="form-label" >Username</label>
                    <input value="<%=username%>" type="text" name="username" placeholder="username" class="form-control" id="emailEntry" aria-describedby="emailHelp" maxlength="32" required>
                </div>
                <div class="mb-3">
                    <label for="emailEntry" class="form-label" >Password</label>
                    <input value="<%=password%>" type="password" name="password" placeholder="password" class="form-control" id="emailEntry" aria-describedby="emailHelp" maxlength="32" required>
                </div>
                <div class="mb-3">
                    <label for="employee" class="form-label">Employee</label>
                    <select id="employee" class="form-control" name="employee_id">
                        <%

                            String sql2 = "select * from employee";
                            PreparedStatement st2 = con.prepareStatement(sql2);
                            ResultSet resultset2 = st2.executeQuery();
                            while (resultset2.next()) {
                                String employeeid = resultset2.getString("employee_id");
                                String firstname = resultset2.getString("firstname");
                                if (employee_id.equals(employeeid)) {


                        %>
                        <option value="<%=employeeid%>" selected><%=firstname%></option>
                        <%
                        } else {
                        %>
                        <option value="<%=employeeid%>"><%=firstname%></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="role" class="form-label">Role</label>
                    <select id="role" class="form-control" name="role_id">
                        <%
                            String sql3 = "select * from role";
                            PreparedStatement st3 = con.prepareStatement(sql3);
                            ResultSet resultset3 = st3.executeQuery();
                            while (resultset3.next()) {
                                int role_id_option = resultset3.getInt("id");
                                String rolename = resultset3.getString("rolename");
                                if (Integer.parseInt(role_id) == role_id_option) {
                        %>
                        <option value="<%=role_id_option%>" selected><%=rolename%></option>
                        <%
                        } else {
                        %>
                        <option value="<%=role_id_option%>"><%=rolename%></option>
                        <%}
                            }%>
                    </select>
                </div>

                <button type="submit" class="btn btn-warning mt-3" >Save</button>
            </form>
        </section>
        <br><br><br>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>