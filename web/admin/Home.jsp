<%@page import="java.sql.Date"%>
<%@page import="database.DatabaseConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">

        <title>Admin | Service Now</title>
    </head>
    <body style="background-color: gray;">
        <%
            if (session.getAttribute("username") == null || !(session.getAttribute("role").equals("admin"))) {
                response.sendRedirect("Login");
            }
        %>
        <jsp:include page="Navbar.jsp"/>

        <section class="container" style="margin-top: 40px; box-shadow: 0px 0px 10px gray; padding: 25px; border-radius: 10px; background: white;">

            <h4>All Open Tickets</h4><hr>

            <ul class="list-group" style="">

                <%
                    String assign_by = (String) session.getAttribute("username");
                    Connection con = DatabaseConnection.initializeDatabase();

                    String sql = "select * from ticket where status = 'OPEN' order by ticket_id desc";
                    PreparedStatement st = con.prepareStatement(sql);
                    ResultSet resultset = st.executeQuery();
                    while (resultset.next()) {
                        int ticket_id = resultset.getInt("ticket_id");
                        int user_id = resultset.getInt("user_id");
                        String created_by = resultset.getString("created_by");
                        Date created_date = resultset.getDate("created_date");
                        String ticket_category = resultset.getString("ticket_category");
                        String ticket_subcategory = resultset.getString("ticket_subcategory");
                        String ticket_description = resultset.getString("ticket_description");
                        String status = resultset.getString("status");
                        String feedback = resultset.getString("feedback");

                        String query = String.format("select * from assigned_ticket where ticket_id=%d", ticket_id);
                        PreparedStatement statement = con.prepareStatement(query);
                        ResultSet result = statement.executeQuery();
                        if (result.next() == false) {

                %>

                <li class="list-group-item" style="background: rgb(245,245,245); border-top: 2px solid orange;"><%= ticket_description%>  <br> <span style="color:rgb(0,100,255); font-size: 13px;"> <%=created_by%></span> <span style="color: gray; font-size: 12px;"> ( <%=ticket_category%> / <%=ticket_subcategory%> ) </span><span style="color:gray; font-size: 12px;"><%=created_date%> </span>
                    <button class="btn btn-light btn-sm" title="View Ticket Details" style="float:right;" type="button" data-bs-toggle="collapse" data-bs-target="#box<%=ticket_id%>" aria-expanded="false" aria-controls="collapseExample">
                        <i style="color: green; font-size: 18px;" class="bi bi-activity"></i>
                    </button>

                    <div class="collapse" id="box<%=ticket_id%>"><br>
                        <div class="card card-body" style="font-size:14px;">
                            <ul>
                                <li><b>Id:</b>  <%=ticket_id%></li>
                                <li><b>Created Date:</b>  <%=created_date%></li>
                                <li><b>Category:</b>  <%=ticket_category%></li>
                                <li><b>Sub category:</b>  <%=ticket_subcategory%></li>
                                <li><b>Description:</b>  <%=ticket_description%></li>
                            </ul><br><br>
                            <form action="Admin" method="post">
                                <label>Assign to: </label>
                                <select name="assign_to" style="width: 40%; padding: 5px 12px; borde: none; border: 1px solid gray; border-radius: 5px; margin: 0px 16px; background: white;">
                                    <%
                                        String sql2 = "select id from role where rolename='support'";
                                        PreparedStatement st2 = con.prepareStatement(sql2);
                                        ResultSet resultset2 = st2.executeQuery();
                                        resultset2.next();
                                        int support_role_id = resultset2.getInt("id");
                                        sql2 = String.format("select * from user where role_id = %d", support_role_id);
                                        st2 = con.prepareStatement(sql2);
                                        resultset2 = st2.executeQuery();
                                        while (resultset2.next()) {
                                            String support_user_name = resultset2.getString("username");
                                    %>
                                    <option value="<%=support_user_name%>"><%= support_user_name%> </option>
                                    <%
                                        }
                                    %>
                                </select>
                                <input type="text" name="ticket_id" value="<%=ticket_id%>" class="visually-hidden">
                                <input type="text" name="assign_by" value="<%= assign_by%>" class="visually-hidden">
                                <button type="submit" class="btn btn-sm btn-warning">Assign</button>

                                </select>
                            </form>
                        </div>
                        <br>
                    </div>
                </li>

                <%                          }
                    }
                %>
            </ul>
        </section>

        <!--Assigned ticket list-->
        <section class="container" style="margin-top: 40px; box-shadow: 0px 0px 10px gray; padding: 25px; border-radius: 10px; background: white;">
            <h5>Assigned Tickets</h5><hr>
            <ul class="list-group" style="">

                <%
                    String query2 = String.format("select * from assigned_ticket where assigned_by='%s'", assign_by);
                    st = con.prepareStatement(query2);
                    resultset = st.executeQuery();
                    while (resultset.next()) {
                        int assignment_id = resultset.getInt("id");
                        int assigned_ticket_id = resultset.getInt("ticket_id");
                        String assigned_to = resultset.getString("assigned_to");

                        String get_details = String.format("select * from ticket where ticket_id = %d and status='OPEN'", assigned_ticket_id);
                        PreparedStatement detail_statement = con.prepareStatement(get_details);
                        ResultSet detail_result = detail_statement.executeQuery();
                        if (detail_result.next()) {
                            int user_id = detail_result.getInt("user_id");
                            String created_by = detail_result.getString("created_by");
                            Date created_date = detail_result.getDate("created_date");
                            String ticket_category = detail_result.getString("ticket_category");
                            String ticket_subcategory = detail_result.getString("ticket_subcategory");
                            String ticket_description = detail_result.getString("ticket_description");
                            String status = detail_result.getString("status");
                            String feedback = detail_result.getString("feedback");


                %>
                <li class="list-group-item" style="background: rgb(245,245,245);border-top: 2px solid gray;">
                    <%= ticket_description%><br> 
                    <span style="font-size: 13px;"> 
                        by <span style="color:gray;"> <%=created_by%> </span>, assigned to <span style="color:gray;"> <%=assigned_to%> </span>
                    </span>
                   
                    <a href="Admin-unassign-ticket?assignment_id=<%=assignment_id%>" style="color:red; font-size: 18px; float: right;"><i class="bi bi-person-x"></i></a>
                    
                    </i>

                    <%   }
                        }
                    %>

            </ul>

        </section><br><br>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>