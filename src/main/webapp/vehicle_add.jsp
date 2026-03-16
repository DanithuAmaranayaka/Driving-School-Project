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
        <c:if test="${vehicle != null}">Edit Vehicle</c:if>
        <c:if test="${vehicle == null}">Add Vehicle</c:if>
    </title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <!-- Navbar -->
    <nav class="navbar navbar-dark bg-primary shadow-sm mb-4">
        <div class="container">
            <a class="navbar-brand" href="AdminServlet?action=dashboard">Admin Dashboard</a>
            <a href="VehicleServlet?action=list" class="btn btn-outline-light btn-sm">Manage Vehicles</a>
        </div>
    </nav>

    <div class="container mb-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white py-3">
                        <h4 class="mb-0 text-warning text-dark">
                            <c:if test="${vehicle != null}">Edit Vehicle Details</c:if>
                            <c:if test="${vehicle == null}">Register New Vehicle</c:if>
                        </h4>
                    </div>
                    <div class="card-body p-4">
                        <c:if test="${vehicle != null}">
                            <form action="VehicleServlet?action=update" method="post">
                        </c:if>
                        <c:if test="${vehicle == null}">
                            <form action="VehicleServlet?action=insert" method="post">
                        </c:if>
                        
                            <c:if test="${vehicle != null}">
                                <input type="hidden" name="id" value="<c:out value='${vehicle.vehicleId}' />" />
                            </c:if>

                            <div class="mb-3">
                                <label class="form-label">Model Name</label>
                                <input type="text" class="form-control" name="model" value="<c:out value='${vehicle.model}' />" required>
                                <div class="form-text">Example: Toyota Corolla, Yamaha FZ</div>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Plate Number</label>
                                <input type="text" class="form-control font-monospace text-uppercase" name="plateNumber" value="<c:out value='${vehicle.plateNumber}' />" required>
                            </div>
                            
                            <div class="row g-3 mb-4">
                                <div class="col-md-6">
                                    <label class="form-label">Vehicle Type</label>
                                    <select class="form-select" name="vehicleType" required>
                                        <option value="Car" <c:if test="${vehicle.vehicleType == 'Car'}">selected</c:if>>Car</option>
                                        <option value="Bike" <c:if test="${vehicle.vehicleType == 'Bike'}">selected</c:if>>Bike</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Status</label>
                                    <select class="form-select" name="status" required>
                                        <option value="Available" <c:if test="${vehicle.status == 'Available'}">selected</c:if>>Available</option>
                                        <option value="In Lesson" <c:if test="${vehicle.status == 'In Lesson'}">selected</c:if>>In Lesson</option>
                                        <option value="Maintenance" <c:if test="${vehicle.status == 'Maintenance'}">selected</c:if>>Maintenance</option>
                                    </select>
                                </div>
                            </div>

                            <div class="text-end">
                                <a href="VehicleServlet?action=list" class="btn btn-secondary me-2">Cancel</a>
                                <button type="submit" class="btn btn-warning px-4 text-dark fw-bold">Save</button>
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
