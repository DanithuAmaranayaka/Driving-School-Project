<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    if(session.getAttribute("adminUser") == null && session.getAttribute("loggedStudent") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:if test="${testObj != null}">Edit Driving Test</c:if>
        <c:if test="${testObj == null}">Book Driving Test</c:if>
    </title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <!-- Navbar -->
    <nav class="navbar navbar-dark bg-secondary shadow-sm mb-4">
        <div class="container">
            <c:if test="${sessionScope.adminUser != null}">
                <a class="navbar-brand text-white" href="AdminServlet?action=dashboard">Admin Dashboard</a>
                <a href="TestServlet?action=list" class="btn btn-outline-light btn-sm">Manage Tests</a>
            </c:if>
            <c:if test="${sessionScope.loggedStudent != null}">
                <a class="navbar-brand text-white" href="StudentServlet?action=dashboard">Student Portal</a>
            </c:if>
        </div>
    </nav>

    <div class="container mb-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-sm border-0 border-top border-secondary border-5">
                    <div class="card-header bg-white py-3">
                        <h4 class="mb-0 text-secondary text-dark">
                            <c:if test="${testObj != null}">Edit Driving Test Result</c:if>
                            <c:if test="${testObj == null}">Book Driving Test</c:if>
                        </h4>
                    </div>
                    <div class="card-body p-4">
                        <c:if test="${testObj != null}">
                            <form action="TestServlet?action=update" method="post">
                        </c:if>
                        <c:if test="${testObj == null}">
                            <form action="TestServlet?action=insert" method="post">
                        </c:if>
                        
                            <c:if test="${testObj != null}">
                                <input type="hidden" name="id" value="<c:out value='${testObj.testId}' />" />
                            </c:if>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Student</label>
                                <c:if test="${sessionScope.loggedStudent != null && sessionScope.adminUser == null}">
                                    <input type="hidden" name="studentId" value="${sessionScope.loggedStudent.studentId}">
                                    <input type="text" class="form-control" value="${sessionScope.loggedStudent.name}" disabled>
                                </c:if>
                                <c:if test="${sessionScope.adminUser != null}">
                                    <select class="form-select" name="studentId" required>
                                        <option value="">-- Choose Student --</option>
                                        <c:forEach var="stu" items="${students}">
                                            <option value="${stu.studentId}" <c:if test="${testObj.studentId == stu.studentId}">selected</c:if>>
                                                ${stu.name} (NIC: ${stu.nic})
                                            </option>
                                        </c:forEach>
                                    </select>
                                </c:if>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Test Date</label>
                                <input type="date" class="form-control" name="testDate" value="<c:out value='${testObj.testDate}' />" required>
                            </div>

                            <c:if test="${sessionScope.adminUser != null && testObj != null}">
                                <div class="mb-3">
                                    <label class="form-label">Result</label>
                                    <select class="form-select w-50" name="result" required>
                                        <option value="Pending" <c:if test="${testObj.result == 'Pending'}">selected</c:if>>Pending</option>
                                        <option value="Pass" <c:if test="${testObj.result == 'Pass'}">selected</c:if>>Pass</option>
                                        <option value="Fail" <c:if test="${testObj.result == 'Fail'}">selected</c:if>>Fail</option>
                                    </select>
                                </div>
                            </c:if>
                            <c:if test="${testObj == null}">
                                <div class="alert alert-info py-2 small">Result tracking will be updated by an Administrator later.</div>
                            </c:if>

                            <div class="text-end mt-4">
                                <c:if test="${sessionScope.adminUser != null}">
                                    <a href="TestServlet?action=list" class="btn btn-secondary me-2">Cancel</a>
                                </c:if>
                                <c:if test="${sessionScope.adminUser == null}">
                                    <a href="StudentServlet?action=dashboard" class="btn btn-secondary me-2">Cancel</a>
                                </c:if>
                                <button type="submit" class="btn btn-secondary px-4">Confirm Booking</button>
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
