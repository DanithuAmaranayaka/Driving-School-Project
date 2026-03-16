<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Login - Driving School</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body class="bg-light">

    <div class="container login-container">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card shadow-lg border-0 rounded-lg mt-5">
                    <div class="card-header bg-success text-white text-center py-4">
                        <h3 class="font-weight-light my-2">Student Portal Login</h3>
                    </div>
                    <div class="card-body p-5">
                        <% if(request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger" role="alert">
                                <%= request.getAttribute("error") %>
                            </div>
                        <% } %>
                        <% if(request.getParameter("registered") != null) { %>
                            <div class="alert alert-success" role="alert">
                                Registration successful! Please login.
                            </div>
                        <% } %>
                        <form action="StudentServlet" method="post">
                            <input type="hidden" name="action" value="login">
                            
                            <div class="form-floating mb-3">
                                <input class="form-control" id="inputUsername" type="text" name="username" placeholder="Username" required />
                                <label for="inputUsername">Username</label>
                            </div>
                            
                            <div class="form-floating mb-3">
                                <input class="form-control" id="inputPassword" type="password" name="password" placeholder="Password" required />
                                <label for="inputPassword">Password</label>
                            </div>
                            
                            <div class="d-flex align-items-center justify-content-between mt-4 mb-0">
                                <a class="small text-decoration-none" href="index.jsp">Back to Home</a>
                                <button type="submit" class="btn btn-success px-4">Login</button>
                            </div>
                        </form>
                    </div>
                    <div class="card-footer text-center py-3">
                        <div class="small"><a href="StudentServlet?action=new">Need an account? Sign up!</a></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
