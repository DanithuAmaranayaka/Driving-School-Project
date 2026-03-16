<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Protection
    if(session.getAttribute("adminUser") == null) {
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Driving School</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav class="col-md-2 d-none d-md-block sidebar px-0">
                <div class="position-sticky pt-3">
                    <div class="text-center text-white mb-4">
                        <i class="bi bi-shield-lock fs-1"></i>
                        <h5>Admin Panel</h5>
                    </div>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link active text-white bg-primary bg-opacity-25" aria-current="page" href="AdminServlet?action=dashboard">
                                <i class="bi bi-house-door me-2"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="StudentServlet?action=list">
                                <i class="bi bi-people me-2"></i> Students
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="InstructorServlet?action=list">
                                <i class="bi bi-person-badge me-2"></i> Instructors
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="VehicleServlet?action=list">
                                <i class="bi bi-car-front me-2"></i> Vehicles
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="LessonServlet?action=list">
                                <i class="bi bi-calendar-check me-2"></i> Lessons
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="PaymentServlet?action=list">
                                <i class="bi bi-credit-card me-2"></i> Payments
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="TestServlet?action=list">
                                <i class="bi bi-card-checklist me-2"></i> Driving Tests
                            </a>
                        </li>
                        <li class="nav-item mt-5 border-top border-white border-opacity-25 pt-2">
                            <a class="nav-link text-warning" href="AdminServlet?action=logout">
                                <i class="bi bi-box-arrow-right me-2"></i> Logout
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main Content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 bg-light min-vh-100">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 mb-4 border-bottom">
                    <h1 class="h2">Dashboard Summary</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <span class="text-muted">Welcome, Admin (<%= session.getAttribute("adminUser") %>)</span>
                    </div>
                </div>

                <!-- Statistics Cards -->
                <div class="row">
                    <div class="col-md-4 col-xl-3">
                        <div class="card-counter primary">
                            <i class="bi bi-people-fill"></i>
                            <span class="count-numbers"><%= request.getAttribute("totalStudents") != null ? request.getAttribute("totalStudents") : 0 %></span>
                            <span class="count-name">Total Students</span>
                        </div>
                    </div>
                    
                    <div class="col-md-4 col-xl-3">
                        <div class="card-counter success">
                            <i class="bi bi-person-badge-fill"></i>
                            <span class="count-numbers"><%= request.getAttribute("totalInstructors") != null ? request.getAttribute("totalInstructors") : 0 %></span>
                            <span class="count-name">Instructors</span>
                        </div>
                    </div>
                    
                    <div class="col-md-4 col-xl-3">
                        <div class="card-counter warning">
                            <i class="bi bi-car-front-fill"></i>
                            <span class="count-numbers"><%= request.getAttribute("totalVehicles") != null ? request.getAttribute("totalVehicles") : 0 %></span>
                            <span class="count-name">Vehicles</span>
                        </div>
                    </div>
                    
                    <div class="col-md-4 col-xl-3">
                        <div class="card-counter info">
                            <i class="bi bi-calendar2-check-fill"></i>
                            <span class="count-numbers"><%= request.getAttribute("totalLessons") != null ? request.getAttribute("totalLessons") : 0 %></span>
                            <span class="count-name">Lessons</span>
                        </div>
                    </div>
                    
                    <div class="col-md-4 col-xl-3 mt-3">
                        <div class="card-counter danger">
                            <i class="bi bi-credit-card-fill"></i>
                            <span class="count-numbers"><%= request.getAttribute("totalPayments") != null ? request.getAttribute("totalPayments") : 0 %></span>
                            <span class="count-name">Payments</span>
                        </div>
                    </div>
                </div>

                <div class="row mt-5">
                    <div class="col-12">
                        <div class="card shadow-sm">
                            <div class="card-header bg-white py-3">
                                <h5 class="mb-0">Quick Management Links</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-flex gap-2 flex-wrap">
                                    <a href="StudentServlet?action=new" class="btn btn-primary"><i class="bi bi-plus-circle me-1"></i> Register Student</a>
                                    <a href="InstructorServlet?action=new" class="btn btn-success"><i class="bi bi-plus-circle me-1"></i> Add Instructor</a>
                                    <a href="VehicleServlet?action=new" class="btn btn-warning text-dark"><i class="bi bi-plus-circle me-1"></i> Add Vehicle</a>
                                    <a href="LessonServlet?action=new" class="btn btn-info text-white"><i class="bi bi-plus-circle me-1"></i> Schedule Lesson</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Bootstrap Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
