<%@page import="java.sql.Date"%>
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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
        <title>Support | Service Now</title>
    </head>
    <body style="background-color: gray;">
        <%
            if (session.getAttribute("username") == null || !(session.getAttribute("role").equals("support"))) {
                response.sendRedirect("Login");
            }
        %>
        <jsp:include page="Navbar.jsp"/>

        <section class="container" style="margin-top: 40px; padding: 25px; background: rgb(220,220,220); height: 520px; border-radius: 10px;">

            <h4 style="">Assigned Tickets</h4><hr>

            <ul class="list-group" style="height: 400px; overflow-y: scroll; border-radius: 10px;">
                <%
                    Connection con = DatabaseConnection.initializeDatabase();
                    String query = String.format("select * from assigned_ticket where assigned_to='%s'", (String) session.getAttribute("username"));
                    PreparedStatement st = con.prepareStatement(query);
                    ResultSet resultset = st.executeQuery();
                    while (resultset.next()) {
                        int assignment_id = resultset.getInt("id");
                        int assigned_ticket_id = resultset.getInt("ticket_id");
                        String assigned_to = resultset.getString("assigned_to");
                        String assigned_by = resultset.getString("assigned_by");

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

                <li class="list-group-item" style="background: white; border-radius: 10px; margin: 10px 10px 0px 0px; border-left: 2px solid orange;">
                    <%= ticket_description%>
                    <span style="color:gray; font-size:12px;">(<%= ticket_category%>/<%= ticket_subcategory%>)</span>
                    <hr>
                    <div style="font-size:14px; color: rgb(60,60,60);">
                        <b>Assigned by: </b><%= assigned_by%> <br>
                        <b>Created by: </b><%= created_by%> <br>
                        <b>Date: </b><%= created_date%> <br>
                        <b>Feedback: </b><%= feedback%> <br>


                    </div>

                    <div style="float:right;">
                        <a href="Support-resolve-ticket?ticket_id=<%=assigned_ticket_id%>&assignment_id=<%=assignment_id%>" class="btn btn-sm btn-success" title="Resolve"><i class="bi bi-check2-square"></i> Resolve</a>
                        <a href="Support-reject-ticket?assignment_id=<%=assignment_id%>&ticket_id=<%=assigned_ticket_id%>" class='btn btn-sm btn-danger' title="Reject"><i class="bi bi-x-square"></i> Reject</a>
                    </div>
                </li>
                <%                    }
                    }
                %>
            </ul>


        </section>


        <section class="container" style="margin-top: 40px; padding: 25px; background: rgb(220,220,220); height: 400px; border-radius: 10px;">

            <h4 style="">Response History</h4><hr>

            <ul class="list-group" style="height: 280px; overflow-y: scroll; border-radius: 10px;">
                <%
                    String sql = String.format("select * from support_log where support_user = '%s'", ((String) session.getAttribute("username")));
                    PreparedStatement statement = con.prepareStatement(sql);
                    ResultSet result = statement.executeQuery();
                    while (result.next()) {
                        int response_id = result.getInt("id");
                        int responed_ticket_id = result.getInt("ticket_id");
                        String response_response = result.getString("response");

                        String get_details = String.format("select * from ticket where ticket_id = %d ", responed_ticket_id);
                        PreparedStatement detail_statement = con.prepareStatement(get_details);
                        ResultSet detail_result = detail_statement.executeQuery();
                        if (detail_result.next()) {
                            String ticket_description = detail_result.getString("ticket_description");
                            String feedback = detail_result.getString("feedback");
                            if (response_response.equals("Resolved")) {

                %>
                <li class="list-group-item" style="background: white; border-radius: 10px; margin: 10px 10px 0px 0px; border-left: 2px solid orange;">
                    <%= ticket_description%> (<span style="color: green;"><%= response_response%></span>)<br>
                    <b>Feedback:</b> <%= feedback%>
                </li>
                <%
                    } else {
                %>
                <li class="list-group-item" style="background: white; border-radius: 10px; margin: 10px 10px 0px 0px; border-left: 2px solid orange;">
                    <%= ticket_description%> (<span style="color: red;"><%= response_response%></span>)<br>
                    <b>Feedback:</b> <%= feedback%>
                </li>
                <%              }
                        }
                    }
                %>

            </ul>


        </section>




        <br><br>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>