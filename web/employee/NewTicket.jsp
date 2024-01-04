<%@page import="database.DatabaseConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

        <title>New Ticket | Employee | Service Now</title>
    </head>
    <body>
        <%
            if (session.getAttribute("username") == null || !(session.getAttribute("role").equals("employee"))) {
                response.sendRedirect("Login");
            }
        %>
        <jsp:include page="Navbar.jsp"/>

        <section class="container" style="margin-top: 40px">
            <h4>New Ticket</h4><hr>
            <form action="Employee-new-ticket" method="post">
                <label for="category" class="form-label">Category</label>
                <select type="text" class="form-control" id="category" name="category">
                    <%
                        Connection con = DatabaseConnection.initializeDatabase();
                        String sql = "select * from ticket_category";
                        PreparedStatement st = con.prepareStatement(sql);
                        ResultSet resultset = st.executeQuery();
                        while (resultset.next()) {
                            String ticketcategory = resultset.getString("category_name");

                    %>
                    <option value="<%=ticketcategory%>"><%=ticketcategory%></option>
                    <%
                           
                        }
                    %>
                </select><br>
                <label for="subcategory" class="form-label">Sub-Category</label>
                <select type="text" class="form-control" id="subcategory" name="subcategory">
                    <%
                        String sql2 = "select * from ticket_subcategory";
                        PreparedStatement st2 = con.prepareStatement(sql2);
                        ResultSet resultset2 = st2.executeQuery();
                        while (resultset2.next()) {
                            String ticket_subcategory = resultset2.getString("subcategory_name");

                    %>
                    <option value="<%=ticket_subcategory%>"><%=ticket_subcategory%></option>
                    <%
                           
                        }
                    %>
                </select><br>
                <label for="description" class="form-label">Description</label>
                <input type="text" class="form-control" id="description" name="description" placeholder="Write about your issue...." maxlength="255" required>
                <br>
                <input type="submit" class="btn btn-warning" value="Create">
                
            </form>


        </section>

        <br><br><br>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>