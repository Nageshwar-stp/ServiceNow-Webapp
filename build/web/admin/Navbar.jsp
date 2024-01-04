<%@page contentType="text/html" pageEncoding="UTF-8"%>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark" style="box-shadow: 0px 0px 6px gray;">
    <div class="container-fluid">
        <a class="navbar-brand" href="Admin">Service Now (Admin)</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link " aria-current="page" href="Admin">Tickets</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="Admin-employees">Employees</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="Admin-users">Users</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="dropdown01" data-bs-toggle="dropdown" aria-expanded="false"></a>
                    <ul class="dropdown-menu" aria-labelledby="dropdown01">
<!--                        <li><a class="dropdown-item" href="#">Roles</a></li>-->
                        <li><a class="dropdown-item" href="Admin-reports">Reports</a></li>
                        <li><a class="dropdown-item" href="Admin-ticket-categories">Ticket Categories</a></li>
                        <br>
                        <li>
                            <%
                                String logged_user = (String) session.getAttribute("username");
                            %>
                            <b class="dropdown-item" style="font-weight: bold;"><%=logged_user%></b>
                        </li>
                        <li><a class="dropdown-item" href="Logout">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>