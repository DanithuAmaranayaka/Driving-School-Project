<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driving School System</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body class="bg-light">

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">Driving School Registration & Scheduling System</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="admin_login.jsp">Admin Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="student_login.jsp">Student Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link btn btn-warning text-dark ms-2" href="StudentServlet?action=new">Register Now</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container mt-5">
        <div class="row align-items-center">
            <div class="col-md-6">
                <h1 class="display-4 fw-bold">Learn to Drive with Confidence</h1>
                <p class="lead mt-3">Join our driving school and get the best training from experienced instructors. Schedule your lessons, track your progress, and get your license easily!</p>
                <div class="mt-4">
                    <a href="StudentServlet?action=new" class="btn btn-primary btn-lg me-2">Become a Student</a>
                    <a href="student_login.jsp" class="btn btn-outline-primary btn-lg">Student Portal</a>
                </div>
            </div>
            <div class="col-md-6 text-center">
                <!-- Placeholder for Hero Image -->
                <img src="https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?auto=format&fit=crop&q=80&w=800" class="img-fluid rounded shadow" alt="Driving Car">
            </div>
        </div>
        
        <div class="row mt-5">
            <div class="col-md-4 mb-4">
                <div class="card h-100 border-primary border-top-0 border-end-0 border-bottom-0 border-5">
                    <div class="card-body">
                        <h5 class="card-title text-primary"><i class="bi bi-calendar-check ms-2"></i> Easy Scheduling</h5>
                        <p class="card-text">Book your driving lessons at times that suit you. Choose your instructor and vehicle easily online.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card h-100 border-success border-top-0 border-end-0 border-bottom-0 border-5">
                    <div class="card-body">
                        <h5 class="card-title text-success"><i class="bi bi-person-check ms-2"></i> Expert Instructors</h5>
                        <p class="card-text">Learn from fully qualified, experienced driving instructors dedicated to your success.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card h-100 border-warning border-top-0 border-end-0 border-bottom-0 border-5">
                    <div class="card-body">
                        <h5 class="card-title text-warning"><i class="bi bi-cash-coin ms-2"></i> Transparent Payments</h5>
                        <p class="card-text">View your payment history securely online and get notifications for upcoming dues.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</body>
</html>
