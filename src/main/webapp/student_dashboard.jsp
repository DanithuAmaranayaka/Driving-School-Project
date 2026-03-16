<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    // Protection
    if(session.getAttribute("loggedStudent") == null) {
        response.sendRedirect("student_login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - Driving School</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-success shadow-sm">
        <div class="container">
            <a class="navbar-brand" href="StudentServlet?action=dashboard"><i class="bi bi-person-circle me-2"></i>Student Portal</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarStudent">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarStudent">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item">
                        <span class="nav-link text-white">Welcome, ${sessionScope.loggedStudent.name}</span>
                    </li>
                    <li class="nav-item ms-3">
                        <a class="btn btn-outline-light btn-sm" href="StudentServlet?action=logout"><i class="bi bi-box-arrow-right me-1"></i>Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <!-- Profile Summary -->
            <div class="col-md-4 mb-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body text-center">
                        <div class="mb-3">
                            <i class="bi bi-person-badge display-1 text-success opacity-50"></i>
                        </div>
                        <h4 class="card-title">${sessionScope.loggedStudent.name}</h4>
                        <p class="text-muted mb-1">NIC: ${sessionScope.loggedStudent.nic}</p>
                        <p class="text-muted"><i class="bi bi-telephone ms-1 me-1"></i> ${sessionScope.loggedStudent.phoneNumber}</p>
                        <hr>
                        <div class="d-flex justify-content-between text-start px-2">
                            <span><strong>License Type:</strong></span>
                            <span class="badge bg-primary">${sessionScope.loggedStudent.licenseType}</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Dashboard Content tabs -->
            <div class="col-md-8 mb-4">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white">
                        <ul class="nav nav-tabs card-header-tabs" id="myTab" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active fw-bold text-success" id="lessons-tab" data-bs-toggle="tab" data-bs-target="#lessons" type="button" role="tab" aria-controls="lessons" aria-selected="true"><i class="bi bi-calendar-check me-1"></i> My Lessons</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link fw-bold text-success" id="payments-tab" data-bs-toggle="tab" data-bs-target="#payments" type="button" role="tab" aria-controls="payments" aria-selected="false"><i class="bi bi-credit-card me-1"></i> Payments</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link fw-bold text-success" id="tests-tab" data-bs-toggle="tab" data-bs-target="#tests" type="button" role="tab" aria-controls="tests" aria-selected="false"><i class="bi bi-card-checklist me-1"></i> Driving Tests</button>
                            </li>
                        </ul>
                    </div>
                    <div class="card-body">
                        <div class="tab-content" id="myTabContent">
                            <!-- Lessons Tab -->
                            <div class="tab-pane fade show active" id="lessons" role="tabpanel" aria-labelledby="lessons-tab">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Date</th>
                                                <th>Time</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="lesson" items="${listLessons}">
                                                <tr>
                                                    <td><c:out value="${lesson.lessonDate}" /></td>
                                                    <td><c:out value="${lesson.lessonTime}" /></td>
                                                    <td>
                                                        <span class="badge ${lesson.status == 'Scheduled' ? 'bg-warning text-dark' : (lesson.status == 'Completed' ? 'bg-success' : 'bg-danger')}">
                                                            <c:out value="${lesson.status}" />
                                                        </span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty listLessons}">
                                                <tr>
                                                    <td colspan="3" class="text-center text-muted">No lessons found.</td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            
                            <!-- Payments Tab -->
                            <div class="tab-pane fade" id="payments" role="tabpanel" aria-labelledby="payments-tab">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Date</th>
                                                <th>Course</th>
                                                <th>Amount ($)</th>
                                                <th>Method</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="payment" items="${listPayments}">
                                                <tr>
                                                    <td><c:out value="${payment.paymentDate}" /></td>
                                                    <td><c:out value="${payment.courseType}" /></td>
                                                    <td class="text-success fw-bold"><c:out value="${payment.amount}" /></td>
                                                    <td><c:out value="${payment.paymentMethod}" /></td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty listPayments}">
                                                <tr>
                                                    <td colspan="4" class="text-center text-muted">No payments found.</td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            
                            <!-- Tests Tab -->
                            <div class="tab-pane fade" id="tests" role="tabpanel" aria-labelledby="tests-tab">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Test Date</th>
                                                <th>Result</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="testObj" items="${listTests}">
                                                <tr>
                                                    <td><c:out value="${testObj.testDate}" /></td>
                                                    <td>
                                                        <span class="badge ${testObj.result == 'Pass' ? 'bg-success' : (testObj.result == 'Fail' ? 'bg-danger' : 'bg-secondary')}">
                                                            <c:out value="${testObj.result}" />
                                                        </span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty listTests}">
                                                <tr>
                                                    <td colspan="2" class="text-center text-muted">No driving tests scheduled yet.</td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
