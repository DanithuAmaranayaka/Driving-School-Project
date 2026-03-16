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
    <title>Manage Lessons - Driving School</title>
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
        <!-- Lesson List -->
        <div class="card shadow-sm border-0">
            <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                <h4 class="mb-0 text-info text-dark"><i class="bi bi-calendar-check me-2"></i>Lesson Schedule</h4>
                <a href="LessonServlet?action=new" class="btn btn-info text-white fw-bold btn-sm"><i class="bi bi-plus-circle me-1"></i> Schedule New Lesson</a>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Lesson ID</th>
                                <th>Student ID</th>
                                <th>Instructor ID</th>
                                <th>Vehicle ID</th>
                                <th>Date</th>
                                <th>Time</th>
                                <th>Status</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="lesson" items="${listLesson}">
                                <tr>
                                    <td><c:out value="${lesson.lessonId}" /></td>
                                    <td><span class="badge bg-secondary"><c:out value="${lesson.studentId}" /></span></td>
                                    <td><span class="badge bg-secondary"><c:out value="${lesson.instructorId}" /></span></td>
                                    <td><span class="badge bg-secondary"><c:out value="${lesson.vehicleId}" /></span></td>
                                    <td><c:out value="${lesson.lessonDate}" /></td>
                                    <td><c:out value="${lesson.lessonTime}" /></td>
                                    <td>
                                        <span class="badge ${lesson.status == 'Scheduled' ? 'bg-warning text-dark' : (lesson.status == 'Completed' ? 'bg-success' : 'bg-danger')}">
                                            <c:out value="${lesson.status}" />
                                        </span>
                                    </td>
                                    <td class="text-center">
                                        <a href="LessonServlet?action=edit&id=<c:out value='${lesson.lessonId}' />" class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></a>
                                        <a href="LessonServlet?action=delete&id=<c:out value='${lesson.lessonId}' />" class="btn btn-sm btn-outline-danger" onclick="return confirm('Delete this lesson?');"><i class="bi bi-trash"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty listLesson}">
                                <tr>
                                    <td colspan="8" class="text-center py-4 text-muted">No lessons scheduled.</td>
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
