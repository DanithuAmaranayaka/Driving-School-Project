<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:if test="${student != null}">Edit Student</c:if>
        <c:if test="${student == null}">Student Registration</c:if>
    </title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <!-- Simple Navbar -->
    <nav class="navbar navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">Driving School</a>
            <c:if test="${sessionScope.adminUser != null}">
                <a class="btn btn-outline-light btn-sm" href="AdminServlet?action=dashboard">Admin Dashboard</a>
            </c:if>
        </div>
    </nav>

    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white py-3">
                        <h4 class="mb-0 text-primary">
                            <c:if test="${student != null}">Edit Student Details</c:if>
                            <c:if test="${student == null}">Register as a New Student</c:if>
                        </h4>
                    </div>
                    <div class="card-body p-4">
                        <c:if test="${student != null}">
                            <form action="StudentServlet?action=update" method="post">
                        </c:if>
                        <c:if test="${student == null}">
                            <form action="StudentServlet?action=insert" method="post">
                        </c:if>
                        
                            <c:if test="${student != null}">
                                <input type="hidden" name="id" value="<c:out value='${student.studentId}' />" />
                            </c:if>

                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Full Name</label>
                                    <input type="text" class="form-control" name="name" value="<c:out value='${student.name}' />" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">NIC</label>
                                    <input type="text" class="form-control" name="nic" value="<c:out value='${student.nic}' />" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Phone Number</label>
                                    <input type="text" class="form-control" name="phoneNumber" value="<c:out value='${student.phoneNumber}' />" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">License Type</label>
                                    <select class="form-select" name="licenseType" required>
                                        <option value="Car" <c:if test="${student.licenseType == 'Car'}">selected</c:if>>Car</option>
                                        <option value="Bike" <c:if test="${student.licenseType == 'Bike'}">selected</c:if>>Bike</option>
                                        <option value="Both" <c:if test="${student.licenseType == 'Both'}">selected</c:if>>Both (Car & Bike)</option>
                                    </select>
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Address</label>
                                    <textarea class="form-control" name="address" rows="3" required><c:out value='${student.address}' /></textarea>
                                </div>
                                
                                <c:if test="${student == null}">
                                    <div class="col-md-6 mt-4 border-top pt-3">
                                        <label class="form-label text-success fw-bold">Login Username</label>
                                        <input type="text" class="form-control border-success" name="username" required>
                                    </div>
                                    <div class="col-md-6 mt-4 border-top pt-3">
                                        <label class="form-label text-success fw-bold">Login Password</label>
                                        <input type="password" class="form-control border-success" name="password" required>
                                    </div>
                                </c:if>
                            </div>

                            <div class="mt-4 text-end">
                                <c:if test="${sessionScope.adminUser != null}">
                                    <a href="StudentServlet?action=list" class="btn btn-secondary me-2">Cancel</a>
                                </c:if>
                                <c:if test="${sessionScope.adminUser == null}">
                                    <a href="index.jsp" class="btn btn-secondary me-2">Cancel</a>
                                </c:if>
                                <button type="submit" class="btn btn-primary px-4">Save</button>
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
