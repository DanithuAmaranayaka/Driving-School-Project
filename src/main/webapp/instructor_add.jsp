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
    <title>
        <c:if test="${instructor != null}">Edit Instructor</c:if>
        <c:if test="${instructor == null}">Add Instructor</c:if>
    </title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <!-- Navbar -->
    <nav class="navbar navbar-dark bg-primary shadow-sm mb-4">
        <div class="container">
            <a class="navbar-brand" href="AdminServlet?action=dashboard">Admin Dashboard</a>
            <a href="InstructorServlet?action=list" class="btn btn-outline-light btn-sm">Manage Instructors</a>
        </div>
    </nav>

    <div class="container mb-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white py-3">
                        <h4 class="mb-0 text-success">
                            <c:if test="${instructor != null}">Edit Instructor Details</c:if>
                            <c:if test="${instructor == null}">Register New Instructor</c:if>
                        </h4>
                    </div>
                    <div class="card-body p-4">
                        <c:if test="${instructor != null}">
                            <form action="InstructorServlet?action=update" method="post">
                        </c:if>
                        <c:if test="${instructor == null}">
                            <form action="InstructorServlet?action=insert" method="post">
                        </c:if>
                        
                            <c:if test="${instructor != null}">
                                <input type="hidden" name="id" value="<c:out value='${instructor.instructorId}' />" />
                            </c:if>

                            <div class="mb-3">
                                <label class="form-label">Full Name</label>
                                <input type="text" class="form-control" name="name" value="<c:out value='${instructor.name}' />" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Phone Number</label>
                                <input type="text" class="form-control" name="phoneNumber" value="<c:out value='${instructor.phoneNumber}' />" required>
                            </div>
                            
                            <div class="mb-4">
                                <label class="form-label">Vehicle Type</label>
                                <select class="form-select" name="vehicleType" required>
                                    <option value="Car" <c:if test="${instructor.vehicleType == 'Car'}">selected</c:if>>Car</option>
                                    <option value="Bike" <c:if test="${instructor.vehicleType == 'Bike'}">selected</c:if>>Bike</option>
                                    <option value="Both" <c:if test="${instructor.vehicleType == 'Both'}">selected</c:if>>Both (Car & Bike)</option>
                                </select>
                            </div>

                            <div class="text-end">
                                <a href="InstructorServlet?action=list" class="btn btn-secondary me-2">Cancel</a>
                                <button type="submit" class="btn btn-success px-4">Save</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
