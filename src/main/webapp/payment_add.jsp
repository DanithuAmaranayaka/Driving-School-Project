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
        <c:if test="${payment != null}">Edit Payment</c:if>
        <c:if test="${payment == null}">Record Payment</c:if>
    </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <nav class="navbar navbar-dark bg-danger shadow-sm mb-4">
        <div class="container">
            <a class="navbar-brand" href="AdminServlet?action=dashboard">Admin Dashboard</a>
            <a href="PaymentServlet?action=list" class="btn btn-outline-light btn-sm">Manage Payments</a>
        </div>
    </nav>

    <div class="container mb-5">
        <div class="row justify-content-center">
            <div class="col-md-7">
                <div class="card shadow-sm border-0 border-top border-danger border-5">
                    <div class="card-header bg-white py-3">
                        <h4 class="mb-0 text-danger">
                            <c:if test="${payment != null}">Edit Payment Record</c:if>
                            <c:if test="${payment == null}">Record New Payment</c:if>
                        </h4>
                    </div>
                    <div class="card-body p-4">
                        <c:if test="${payment != null}">
                            <form action="PaymentServlet?action=update" method="post">
                        </c:if>
                        <c:if test="${payment == null}">
                            <form action="PaymentServlet?action=insert" method="post">
                        </c:if>
                        
                            <c:if test="${payment != null}">
                                <input type="hidden" name="id" value="<c:out value='${payment.paymentId}' />" />
                            </c:if>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Student</label>
                                <select class="form-select" name="studentId" required>
                                    <option value="">-- Choose Student --</option>
                                    <c:forEach var="stu" items="${students}">
                                        <option value="${stu.studentId}" <c:if test="${payment.studentId == stu.studentId}">selected</c:if>>
                                            ${stu.name} (NIC: ${stu.nic})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Course Type</label>
                                    <select class="form-select" name="courseType" required>
                                        <option value="Initial Registration" <c:if test="${payment.courseType == 'Initial Registration'}">selected</c:if>>Initial Registration</option>
                                        <option value="Full Course" <c:if test="${payment.courseType == 'Full Course'}">selected</c:if>>Full Course Package</option>
                                        <option value="Extra Lessons" <c:if test="${payment.courseType == 'Extra Lessons'}">selected</c:if>>Extra Lessons Bundle</option>
                                        <option value="Test Fee" <c:if test="${payment.courseType == 'Test Fee'}">selected</c:if>>Driving Test Fee</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-bold text-success">Amount ($)</label>
                                    <div class="input-group">
                                        <span class="input-group-text">$</span>
                                        <input type="number" step="0.01" min="0" class="form-control" name="amount" value="<c:out value='${payment.amount}' />" required>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label class="form-label">Payment Date</label>
                                    <input type="date" class="form-control" name="paymentDate" value="<c:out value='${payment.paymentDate}' />" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Payment Method</label>
                                    <select class="form-select" name="paymentMethod" required>
                                        <option value="Cash" <c:if test="${payment.paymentMethod == 'Cash'}">selected</c:if>>Cash</option>
                                        <option value="Credit Card" <c:if test="${payment.paymentMethod == 'Credit Card'}">selected</c:if>>Credit Card</option>
                                        <option value="Bank Transfer" <c:if test="${payment.paymentMethod == 'Bank Transfer'}">selected</c:if>>Bank Transfer</option>
                                    </select>
                                </div>
                            </div>

                            <div class="text-end mt-4">
                                <a href="PaymentServlet?action=list" class="btn btn-secondary me-2">Cancel</a>
                                <button type="submit" class="btn btn-danger px-4">Save Payment</button>
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
