<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

        <title>Add Employee | Admin | Service Now</title>
    </head>
    <body>
        <%
            if (session.getAttribute("username") == null || !(session.getAttribute("role").equals("admin"))) {
                response.sendRedirect("Login");
            }
        %>
        <jsp:include page="Navbar.jsp"/>

        <section class="container" style="margin-top: 40px;">
            <h1>Add New Employee</h1>
           
            <form class="mt-4" method="post" action="Admin-add-employee">
                <div class="mb-3">
                    <label for="emailEntry" class="form-label" >First-name</label>
                    <input type="text" name="firstname" placeholder="eg: John" class="form-control" id="emailEntry" aria-describedby="emailHelp" maxlength="50" required>
                </div>
               <div class="mb-3">
                    <label for="emailEntry" class="form-label" >Middle-name</label>
                    <input type="text" name="middlename" placeholder="Optional" class="form-control" id="emailEntry" aria-describedby="emailHelp" maxlength="50">
                </div>
                <div class="mb-3">
                    <label for="emailEntry" class="form-label" >Last-name</label>
                    <input type="text" name="lastname" placeholder="eg: Doe" class="form-control" id="emailEntry" aria-describedby="emailHelp" maxlength="50" required>
                </div>
                <div class="mb-3">
                    <label for="emailEntry" class="form-label" >Email</label>
                    <input type="email" name="email" placeholder="eg: youremail@something.com" class="form-control" id="emailEntry" aria-describedby="emailHelp" maxlength="255" required>
                </div>
                <div class="mb-3">
                    <label for="emailEntry" class="form-label" >Mobile</label>
                    <input type="text" name="mobile" placeholder="eg: 999999XXXX" class="form-control" id="emailEntry" aria-describedby="emailHelp" maxlength="13" required>
                </div>
                <div class="mb-3">
                    <label for="emailEntry" class="form-label" >Department</label>
                    <input type="text" name="department" placeholder="eg: Sales" class="form-control" id="emailEntry" aria-describedby="emailHelp" maxlength="20" required>
                </div>
                <div class="mb-3">
                    <label for="emailEntry" class="form-label" >Employee Type</label>
                    <input type="text" name="employee_type" placeholder="eg: Part Time" class="form-control" id="emailEntry" aria-describedby="emailHelp" maxlength="10" required>
                </div>

                <button type="submit" class="btn btn-warning mt-3" >Add</button>
            </form>
        </section>
        <br><br><br>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </body>
</html>