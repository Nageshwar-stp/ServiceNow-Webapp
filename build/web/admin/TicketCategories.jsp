<%@page import="database.DatabaseConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
        <title>Ticket Categories | Admin | Service Now</title>
    </head>
    <body>
        <%
            if (session.getAttribute("username") == null || !(session.getAttribute("role").equals("admin"))) {
                response.sendRedirect("Login");
            }
        %>
        <jsp:include page="Navbar.jsp"/>
        <section class="container" style="margin-top: 40px"> 
            <h4>Ticket Categories</h4><hr>

            <ul class="list-group">
                <%
                    Connection con = DatabaseConnection.initializeDatabase();

                    String sql = "select * from ticket_category";
                    PreparedStatement st = con.prepareStatement(sql);
                    ResultSet resultset = st.executeQuery();
                    while (resultset.next()) {
                        int id = resultset.getInt("id");
                        String category_name = resultset.getString("category_name");
                %>
                <li class="list-group-item"><%=category_name%><a href="Admin-delete-category?category=category&id=<%=id%>" style="float: right;"><i class="bi bi-x-lg" style="color: red;"></i></a></li>

                <%
                    }
                %>
                <form class="row g-3" style="margin-top: 20px;" action="Admin-ticket-categories" method="post">
                    <div class="col-auto">
                        <input type="text" class="visually-hidden" value="category" name="category">
                        <input type="text" class="form-control" id="category" name="category_name" placeholder="Create new Category" required>
                    </div>
                    <div class="col-auto">
                        <button type="submit" class="btn btn-warning mb-3">Create</button>
                    </div>
                </form>

            </ul>

            <br><h5>Sub Categories</h5><hr>

            <ul class="list-group">
                <%
                    String sql2 = "select * from ticket_subcategory";
                    PreparedStatement st2 = con.prepareStatement(sql2);
                    ResultSet resultset2 = st2.executeQuery();
                    while (resultset2.next()) {
                        int id = resultset2.getInt("id");
                        String subcategory_name = resultset2.getString("subcategory_name");
                %>
                <li class="list-group-item"><%=subcategory_name%><a href="Admin-delete-category?category=subcategory&id=<%=id%>" style="float: right;"><i class="bi bi-x-lg" style="color: red;"></i></a></li>

                <%
                    }
                %>
                <form class="row g-3" style="margin-top: 20px;" action="Admin-ticket-categories" method="post">
                    <div class="col-auto">
                       <input type="text" class="visually-hidden" value="subcategory" name="category">
                       <input type="text" class="form-control" id="category" name="category_name" placeholder="Create new Sub-Category" required>
                    </div>
                    <div class="col-auto">
                        <button type="submit" class="btn btn-warning mb-3">Create</button>
                    </div>
                </form>

            </ul>
        </section>
                <br><br><br>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>