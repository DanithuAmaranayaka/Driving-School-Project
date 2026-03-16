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
        <c:if test="${lesson != null}">Edit Lesson</c:if>
        <c:if test="${lesson == null}">Book a Lesson</c:if>
    </title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <!-- Navbar -->
    <nav class="navbar navbar-dark bg-info shadow-sm mb-4">
        <div class="container">
            <c:if test="${sessionScope.adminUser != null}">
                <a class="navbar-brand text-white" href="AdminServlet?action=dashboard">Admin Dashboard</a>
                <a href="LessonServlet?action=list" class="btn btn-outline-light btn-sm">Manage Lessons</a>
            </c:if>
            <c:if test="${sessionScope.loggedStudent != null}">
                <a class="navbar-brand text-white" href="StudentServlet?action=dashboard">Student Portal</a>
            </c:if>
        </div>
    </nav>

    <div class="container mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-sm border-0 border-top border-info border-5">
                    <div class="card-header bg-white py-3">
                        <h4 class="mb-0 text-info text-dark">
                            <c:if test="${lesson != null}">Edit Scheduled Lesson</c:if>
                            <c:if test="${lesson == null}">Schedule a Driving Lesson</c:if>
                        </h4>
                    </div>
                    <div class="card-body p-4">
                        <c:if test="${lesson != null}">
                            <form action="LessonServlet?action=update" method="post">
                        </c:if>
                        <c:if test="${lesson == null}">
                            <form action="LessonServlet?action=insert" method="post">
                        </c:if>
                        
                            <c:if test="${lesson != null}">
                                <input type="hidden" name="id" value="<c:out value='${lesson.lessonId}' />" />
                            </c:if>

                            <div class="row g-3">
                                <!-- Student Selection -->
                                <div class="col-md-12">
                                    <label class="form-label fw-bold">Student</label>
                                    <c:if test="${sessionScope.loggedStudent != null && sessionScope.adminUser == null}">
                                        <input type="hidden" name="studentId" value="${sessionScope.loggedStudent.studentId}">
                                        <input type="text" class="form-control" value="${sessionScope.loggedStudent.name} (NIC: ${sessionScope.loggedStudent.nic})" disabled>
                                    </c:if>
                                    <c:if test="${sessionScope.adminUser != null}">
                                        <select class="form-select" name="studentId" required>
                                            <option value="">-- Select Student --</option>
                                            <c:forEach var="stu" items="${students}">
                                                <option value="${stu.studentId}" <c:if test="${lesson.studentId == stu.studentId}">selected</c:if>>
                                                    ${stu.name} (ID: ${stu.studentId})
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </c:if>
                                </div>

                                <!-- Instructor & Vehicle -->
                                <div class="col-md-6">
                                    <label class="form-label">Instructor</label>
                                    <select class="form-select" name="instructorId" required>
                                        <option value="">-- Select Instructor --</option>
                                        <c:forEach var="inst" items="${instructors}">
                                            <option value="${inst.instructorId}" <c:if test="${lesson.instructorId == inst.instructorId}">selected</c:if>>
                                                ${inst.name} (${inst.vehicleType})
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Vehicle</label>
                                    <select class="form-select" name="vehicleId" required>
                                        <option value="">-- Select Vehicle --</option>
                                        <c:forEach var="veh" items="${vehicles}">
                                            <option value="${veh.vehicleId}" <c:if test="${lesson.vehicleId == veh.vehicleId}">selected</c:if>>
                                                ${veh.model} - ${veh.plateNumber} (${veh.vehicleType})
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Date & Time -->
                                <div class="col-md-6">
                                    <label class="form-label">Date</label>
                                    <input type="date" class="form-control" name="lessonDate" value="<c:out value='${lesson.lessonDate}' />" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Time</label>
                                    <input type="time" class="form-control" name="lessonTime" value="<c:out value='${lesson.lessonTime}' />" required>
                                </div>

                                <!-- Status (Admin Only) -->
                                <c:if test="${sessionScope.adminUser != null && lesson != null}">
                                    <div class="col-12 mt-3 pt-3 border-top">
                                        <label class="form-label fw-bold">Status</label>
                                        <select class="form-select w-50" name="status" required>
                                            <option value="Scheduled" <c:if test="${lesson.status == 'Scheduled'}">selected</c:if>>Scheduled</option>
                                            <option value="Completed" <c:if test="${lesson.status == 'Completed'}">selected</c:if>>Completed</option>
                                            <option value="Cancelled" <c:if test="${lesson.status == 'Cancelled'}">selected</c:if>>Cancelled</option>
                                        </select>
                                    </div>
                                </c:if>
                            </div>

                            <div class="text-end mt-4">
                                <c:if test="${sessionScope.adminUser != null}">
                                    <a href="LessonServlet?action=list" class="btn btn-secondary me-2">Cancel</a>
                                </c:if>
                                <c:if test="${sessionScope.adminUser == null}">
                                    <a href="StudentServlet?action=dashboard" class="btn btn-secondary me-2">Cancel</a>
                                </c:if>
                                <button type="submit" class="btn btn-info px-4 text-white fw-bold">Confirm Booking</button>
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
