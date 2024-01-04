<%@page import="java.sql.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="database.DatabaseConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

        <title>Reports | Admin | Service Now</title>
    </head>
    <body>
        <%
            if (session.getAttribute("username") == null || !(session.getAttribute("role").equals("admin"))) {
                response.sendRedirect("Login");
            }
        %>
        <jsp:include page="Navbar.jsp"/>

        <section class="container" style="margin-top: 40px;">
            <h5>Reports</h5><hr>
            <ul class="list-group">
                <%
                    String username = (String) session.getAttribute("username");

                    Connection con = DatabaseConnection.initializeDatabase();

                    String sql = "select * from report";
                    PreparedStatement st = con.prepareStatement(sql);
                    ResultSet resultset = st.executeQuery();
                    while (resultset.next()) {
                        int report_id = resultset.getInt("report_id");
                        String report_name = resultset.getString("report_name");
                        int user_id = resultset.getInt("user_id");
                        Date generated_on = resultset.getDate("generated_on");

                %>
                <li class="list-group-item"><%=report_name%> [<%=generated_on%>]</li>
                    <%
                        }
                    %>
            </ul>

            <hr>
            <form class="row g-3" style="margin-top: 20px;" action="" method="post">
                <div class="col-auto">
                    <input type="text" value="<%=username%>" name="username" class="visually-hidden">
                    <input type="text" class="form-control" id="category" name="report_name" placeholder="Report Name" required>
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-warning mb-3">Generate</button>
                </div>
            </form>
        </section>
        <br><br><br>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>