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
    <title>Manage Payments - Driving School</title>
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
        <!-- Payment List -->
        <div class="card shadow-sm border-0">
            <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                <h4 class="mb-0 text-danger"><i class="bi bi-credit-card mx-2"></i>Payment History</h4>
                <a href="PaymentServlet?action=new" class="btn btn-danger btn-sm"><i class="bi bi-plus-circle me-1"></i> Record New Payment</a>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Payment ID</th>
                                <th>Student ID</th>
                                <th>Course Type</th>
                                <th>Amount</th>
                                <th>Date</th>
                                <th>Method</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="payment" items="${listPayment}">
                                <tr>
                                    <td><c:out value="${payment.paymentId}" /></td>
                                    <td><span class="badge bg-secondary"><c:out value="${payment.studentId}" /></span></td>
                                    <td><c:out value="${payment.courseType}" /></td>
                                    <td class="text-success fw-bold">$<c:out value="${payment.amount}" /></td>
                                    <td><c:out value="${payment.paymentDate}" /></td>
                                    <td><c:out value="${payment.paymentMethod}" /></td>
                                    <td class="text-center">
                                        <a href="PaymentServlet?action=edit&id=<c:out value='${payment.paymentId}' />" class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></a>
                                        <a href="PaymentServlet?action=delete&id=<c:out value='${payment.paymentId}' />" class="btn btn-sm btn-outline-danger" onclick="return confirm('Delete this payment record? WARNING: This action cannot be undone.');"><i class="bi bi-trash"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty listPayment}">
                                <tr>
                                    <td colspan="7" class="text-center py-4 text-muted">No payments recorded.</td>
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
