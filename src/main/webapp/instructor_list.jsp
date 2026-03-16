<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
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
    <title>Manage Instructors - Driving School</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">

    <!-- Admin Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm mb-4">
        <div class="container">
            <a class="navbar-brand" href="AdminServlet?action=dashboard"><i class="bi bi-shield-lock me-2"></i>Admin Dashboard</a>
            <div class="d-flex">
                <a href="AdminServlet?action=logout" class="btn btn-outline-light btn-sm"><i class="bi bi-box-arrow-right"></i> Logout</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <!-- Instructor List -->
        <div class="card shadow-sm border-0">
            <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                <h4 class="mb-0 text-primary"><i class="bi bi-person-badge me-2"></i>Instructor Management</h4>
                <a href="InstructorServlet?action=new" class="btn btn-success btn-sm"><i class="bi bi-plus-circle me-1"></i> Add New Instructor</a>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Phone Number</th>
                                <th>Vehicle Type</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="instructor" items="${listInstructor}">
                                <tr>
                                    <td><c:out value="${instructor.instructorId}" /></td>
                                    <td class="fw-bold"><c:out value="${instructor.name}" /></td>
                                    <td><c:out value="${instructor.phoneNumber}" /></td>
                                    <td>
                                        <span class="badge ${instructor.vehicleType == 'Car' ? 'bg-primary' : (instructor.vehicleType == 'Bike' ? 'bg-warning text-dark' : 'bg-success')}">
                                            <c:out value="${instructor.vehicleType}" />
                                        </span>
                                    </td>
                                    <td class="text-center">
                                        <a href="InstructorServlet?action=edit&id=<c:out value='${instructor.instructorId}' />" class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></a>
                                        <a href="InstructorServlet?action=delete&id=<c:out value='${instructor.instructorId}' />" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure you want to delete this instructor?');"><i class="bi bi-trash"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty listInstructor}">
                                <tr>
                                    <td colspan="5" class="text-center py-4 text-muted">No instructors added yet.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <div class="mt-3">
            <a href="AdminServlet?action=dashboard" class="text-decoration-none"><i class="bi bi-arrow-left"></i> Back to Dashboard</a>
        </div>
    </div>

    <!-- Bootstrap Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
