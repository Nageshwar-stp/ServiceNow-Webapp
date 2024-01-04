<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        
        <title>Service Now</title>
    </head>
    <body>
        <%
            if (session.getAttribute("username") != null) {
                if (session.getAttribute("role").equals("admin")) {
                    response.sendRedirect("Admin");
                } else if (session.getAttribute("role").equals("support")) {
                    response.sendRedirect("Support");
                } else if (session.getAttribute("role").equals("employee")) {
                    response.sendRedirect("Employee");
                }
            }
        %>
        <nav class="navbar navbar-expand-lg navbar-light bg-light" style="box-shadow: 0px 0px 6px gray;">
            <div class="container-fluid">
                <a class="navbar-brand" href="">Service Now</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Login">Login</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <section class="container">

            <section class="py-5 text-center container">
                <div class="row py-lg-5">
                    <div class="col-lg-6 col-md-8 mx-auto">
                        <h1 class="fw-light">Service Now</h1>
                        <p class="lead text-muted">
                            "ServiceNow" is a web based project to manage the various type of support ticket created in 
                            an Information Technology organization for fast resolution of issues without manual intervention 
                            to increase the productivity of the organization.
                        </p>
                        <p>
                            <a href="Login" class="btn btn-warning my-2">Login</a>
                            <a href="#" class="btn btn-secondary my-2">Read more</a>
                        </p>
                    </div>
                </div>
            </section>


        </section>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>