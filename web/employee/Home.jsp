<%@page import="java.sql.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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

        <title>Employee | Service Now</title>
    </head>
    <body style="background: rgb(230,230,230);">
        <%
            if (session.getAttribute("username") == null || !(session.getAttribute("role").equals("employee"))) {
                response.sendRedirect("Login");
            }
        %>
        <jsp:include page="Navbar.jsp"/>

        <section class="container" style="margin-top: 40px">
            <!--Open Tickets-->
            <h4>Tickets (Open)</h4><hr>

            <ul class="list-group">


                <%
                    Connection con = DatabaseConnection.initializeDatabase();

                    String sql = String.format("select * from ticket where created_by='%s' and status = 'OPEN'", (String) session.getAttribute("username"));
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

                <li class="list-group-item" style="margin-bottom: 12px;border-top: 2px solid orange;"><%= ticket_description%> <br><span style="color: rgba(0,0,0,0.7); font-size: 12px;"> ( <%=ticket_category%> / <%=ticket_subcategory%> ) </span><br>
                    <button class="btn btn-secondary btn-sm" title="View Ticket Details" style="float:right;" type="button" data-bs-toggle="collapse" data-bs-target="#box<%=ticket_id%>" aria-expanded="false" aria-controls="collapseExample">
                        <i class="bi bi-info-lg"></i>
                    </button>

                    <div class="collapse" id="box<%=ticket_id%>"><br>
                        <div class="card card-body" style="font-size:14px;">
                            <ul>
                                <li><b>Id:</b>  <%=ticket_id%></li>
                                <li><b>Created Date:</b>  <%=created_date%></li>
                                <li><b>Category:</b>  <%=ticket_category%></li>
                                <li><b>Sub category:</b>  <%=ticket_subcategory%></li>
                                <li><b>Description:</b>  <%=ticket_description%></li>
                                <li><b>Status:</b>  <%=status%></li>
                                <li><b>Feedback:</b>  <%=feedback%></li>
                            </ul>
                        </div>
                        <a href="Employee-delete-ticket?ticket_id=<%=ticket_id%>" class="btn btn-danger btn-sm mt-2"><i class="bi bi-trash-fill"></i> Delete</a>

                        <br>
                    </div>

                    <button class="btn btn-warning btn-sm" title="Edit Ticket Details" style="float:right; margin-right: 10px;" type="button" data-bs-toggle="collapse" data-bs-target="#box-edit<%=ticket_id%>" aria-expanded="false" aria-controls="collapseExample">
                        <i class="bi bi-pencil-square"></i>
                    </button>

                    <div class="collapse" id="box-edit<%=ticket_id%>" ><br>
                        <div class="card card-body" style="background: rgb(240,240,240); margin-top: 10px;">

                            <form method="post" action="Employee">
                                <input type="text" name="ticket_id" value="<%=ticket_id%>" class="visually-hidden">
                                <div class="mb-3">
                                    <label for="ticket_description" class="form-label">Description</label>
                                    <input type="text" name="ticket_description" maxlength="255" class="form-control" id="ticket_description" value="<%=ticket_description%>">
                                </div>
                                <div class="mb-3">
                                    <label for="category" class="form-label">Category</label>
                                    <select class="form-control" id="category" name="category">
                                        <%

                                            String sql2 = "select * from ticket_category";
                                            PreparedStatement st2 = con.prepareStatement(sql2);
                                            ResultSet resultset2 = st2.executeQuery();
                                            while (resultset2.next()) {
                                                String ticketcategory = resultset2.getString("category_name");
                                                if (ticketcategory.equals(ticket_category)) {


                                        %>
                                        <option value="<%=ticketcategory%>" selected><%=ticketcategory%></option>
                                        <%
                                        } else {
                                        %>
                                        <option value="<%=ticketcategory%>"><%=ticketcategory%></option>
                                        <%
                                                }
                                            }
                                        %>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="category" class="form-label">Sub-Category</label>
                                    <select class="form-control" id="category" name="subcategory">
                                        <%
                                            String sql3 = "select * from ticket_subcategory";
                                            PreparedStatement st3 = con.prepareStatement(sql3);
                                            ResultSet resultset3 = st3.executeQuery();
                                            while (resultset3.next()) {
                                                String ticketsubcategory = resultset3.getString("subcategory_name");
                                                if (ticketsubcategory.equals(ticket_subcategory)) {


                                        %>
                                        <option value="<%=ticketsubcategory%>" selected><%=ticketsubcategory%></option>
                                        <%
                                        } else {
                                        %>
                                        <option value="<%=ticketsubcategory%>"><%=ticketsubcategory%></option>
                                        <%
                                                }
                                            }
                                        %>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="status" class="form-label">Status</label>
                                    <div class="form-check form-switch" id="status">

                                        <input class="form-check-input" name="status" type="checkbox" role="switch" id="flexSwitchCheckChecked" checked>
                                        <label class="form-check-label" for="flexSwitchCheckChecked">Open</label>
                                    </div>
                                </div>
                                <div class="mb-3 visually-hidden">
                                    <label for="ticket_feedback" class="form-label">Feedback</label>
                                    <input type="text" name="ticket_feedback" maxlength="255" class="form-control" id="ticket_feedback" value="<%=feedback%>">
                                </div>

                                <button type="submit" class="btn btn-warning btn-sm">Update</button>
                            </form>
                        </div>
                    </div>
                </li>

                <%                            }
                    }
                %>
            </ul>

            <!--under-review tickets-->
            <br>
            <h5 style="color: rgba(0,0,0,0.8);">Under Review</h5><hr>
            <ul class="list-group">
                <%
                    sql = String.format("select * from ticket where created_by='%s' and status = 'OPEN'", (String) session.getAttribute("username"));
                    st = con.prepareStatement(sql);
                    resultset = st.executeQuery();
                    while (resultset.next()) {
                        int ticket_id = resultset.getInt("ticket_id");
                        int user_id = resultset.getInt("user_id");
                        Date created_date = resultset.getDate("created_date");
                        String ticket_category = resultset.getString("ticket_category");
                        String ticket_subcategory = resultset.getString("ticket_subcategory");
                        String ticket_description = resultset.getString("ticket_description");

                        String query = String.format("select * from assigned_ticket where ticket_id=%d", ticket_id);
                        PreparedStatement statement = con.prepareStatement(query);
                        ResultSet result = statement.executeQuery();
                        if (result.next() == true) {


                %>
                <li class="list-group-item" style="margin-bottom: 12px;border-top: 2px solid green; font-size: 15px;">
                    <%= ticket_description%><br>
                    <span style="font-size: 12px; color: gray;">(<%=ticket_category%>/<%=ticket_subcategory%>)</span>
                </li>
                <%                        }
                    }
                %>
            </ul>

            <!--closed tickets-->
            <br>
            <h5 style="color: rgba(0,0,0,0.8);">Tickets (Closed)</h5><hr>

            <ul class="list-group">


                <%
                    String sql4 = String.format("select * from ticket where created_by='%s' and status = 'CLOSE'", (String) session.getAttribute("username"));
                    PreparedStatement st4 = con.prepareStatement(sql4);
                    ResultSet resultset4 = st4.executeQuery();
                    while (resultset4.next()) {
                        int ticket_id = resultset4.getInt("ticket_id");
                        int user_id = resultset4.getInt("user_id");
                        String created_by = resultset4.getString("created_by");
                        Date created_date = resultset4.getDate("created_date");
                        String ticket_category = resultset4.getString("ticket_category");
                        String ticket_subcategory = resultset4.getString("ticket_subcategory");
                        String ticket_description = resultset4.getString("ticket_description");
                        String status = resultset4.getString("status");
                        String feedback = resultset4.getString("feedback");

                %>

                <li class="list-group-item" style="margin-bottom: 12px;border-top: 2px solid gray;"><%= ticket_description%> <span style="color: rgba(0,0,0,0.7);"> ( <%=ticket_category%> / <%=ticket_subcategory%> ) </span><br>
                    <button class="btn btn-secondary btn-sm" title="View Ticket Details" style="float:right;" type="button" data-bs-toggle="collapse" data-bs-target="#box<%=ticket_id%>" aria-expanded="false" aria-controls="collapseExample">
                        <i class="bi bi-info-lg"></i>
                    </button>

                    <div class="collapse" id="box<%=ticket_id%>"><br>
                        <div class="card card-body">
                            <ul>
                                <li><b>Id:</b>  <%=ticket_id%></li>
                                <li><b>Created Date:</b>  <%=created_date%></li>
                                <li><b>Category:</b>  <%=ticket_category%></li>
                                <li><b>Sub category:</b>  <%=ticket_subcategory%></li>
                                <li><b>Description:</b>  <%=ticket_description%></li>
                                <li><b>Status:</b>  <%=status%></li>
                                <li><b>Feedback:</b>  <%=feedback%></li>
                            </ul>

                        </div>
                        <a href="Employee-delete-ticket?ticket_id=<%=ticket_id%>" class="btn btn-danger btn-sm mt-2"><i class="bi bi-trash-fill"></i> Delete</a>
                        <br>
                    </div>

                    <button class="btn btn-danger btn-sm" title="Reopen Ticket" style="float:right; margin-right: 10px;" type="button" data-bs-toggle="collapse" data-bs-target="#box-edit<%=ticket_id%>" aria-expanded="false" aria-controls="collapseExample">
                        <i class="bi bi-arrow-repeat"></i>
                    </button>
                    <button class="btn btn-warning btn-sm" title="Give Feedback" style="float:right; margin-right: 10px;" type="button" data-bs-toggle="collapse" data-bs-target="#box-edit<%=ticket_id%>" aria-expanded="false" aria-controls="collapseExample">
                        <i class="bi bi-star-half"></i>
                    </button>

                    <div class="collapse" id="box-edit<%=ticket_id%>" ><br>
                        <div class="card card-body" style="background: rgb(240,240,240); margin-top: 10px;">

                            <form method="post" action="Employee">
                                <input type="text" name="ticket_id" value="<%=ticket_id%>" class="visually-hidden">
                                <div class="mb-3 visually-hidden">
                                    <label for="ticket_description" class="form-label">Description</label>
                                    <input type="text" name="ticket_description" maxlength="255" class="form-control" id="ticket_description" value="<%=ticket_description%>">
                                </div>
                                <div class="mb-3 visually-hidden">
                                    <label for="category" class="form-label">Category</label>
                                    <select class="form-control" id="category" name="category">
                                        <%

                                            String sql2 = "select * from ticket_category";
                                            PreparedStatement st2 = con.prepareStatement(sql2);
                                            ResultSet resultset2 = st2.executeQuery();
                                            while (resultset2.next()) {
                                                String ticketcategory = resultset2.getString("category_name");
                                                if (ticketcategory.equals(ticket_category)) {


                                        %>
                                        <option value="<%=ticketcategory%>" selected><%=ticketcategory%></option>
                                        <%
                                        } else {
                                        %>
                                        <option value="<%=ticketcategory%>"><%=ticketcategory%></option>
                                        <%
                                                }
                                            }
                                        %>
                                    </select>
                                </div>
                                <div class="mb-3 visually-hidden">
                                    <label for="category" class="form-label">Sub-Category</label>
                                    <select class="form-control" id="category" name="subcategory">
                                        <%
                                            String sql3 = "select * from ticket_subcategory";
                                            PreparedStatement st3 = con.prepareStatement(sql3);
                                            ResultSet resultset3 = st3.executeQuery();
                                            while (resultset3.next()) {
                                                String ticketsubcategory = resultset3.getString("subcategory_name");
                                                if (ticketsubcategory.equals(ticket_subcategory)) {


                                        %>
                                        <option value="<%=ticketsubcategory%>" selected><%=ticketsubcategory%></option>
                                        <%
                                        } else {
                                        %>
                                        <option value="<%=ticketsubcategory%>"><%=ticketsubcategory%></option>
                                        <%
                                                }
                                            }
                                        %>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="status" class="form-label">Reopen</label>
                                    <div class="form-check form-switch" id="status">

                                        <input class="form-check-input" name="status" type="checkbox" role="switch" id="flexSwitchCheckChecked" >
                                        <label class="form-check-label" for="flexSwitchCheckChecked">Yes</label>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="ticket_feedback" class="form-label">Feedback</label>
                                    <input type="text" name="ticket_feedback" maxlength="255" class="form-control" id="ticket_feedback" value="<%=feedback%>">
                                </div>

                                <button type="submit" class="btn btn-warning btn-sm">Send</button>
                            </form>
                        </div>
                    </div>
                </li>

                <%                            }
                %>
            </ul>
        </section>

        <div style="position: fixed; top: 10px; right: 20px;">
            <a href="Employee-new-ticket" class="btn btn-warning"><i class="bi bi-plus-lg"></i> New Ticket</a>
        </div>

        <br><br><br>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>