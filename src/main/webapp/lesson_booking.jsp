<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%  if(session.getAttribute("adminUser")==null && session.getAttribute("loggedStudent")==null){response.sendRedirect("index.jsp");return;} %>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
<title><c:if test="${lesson != null}">Edit Lesson</c:if><c:if test="${lesson == null}">Book a Lesson</c:if> — DriveEase</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,700;1,700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
<style>
  *,*::before,*::after{margin:0;padding:0;box-sizing:border-box}
  :root{--bg:#0d0d0d;--surface:#161616;--surface2:#1f1f1f;--border:rgba(255,255,255,0.07);--gold:#d4a017;--gold-light:#f0be3d;--text:#f0ede8;--muted:#6b6760;--muted2:#9a9590;--red:#e05252}
  body{background:var(--bg);color:var(--text);font-family:'DM Sans',sans-serif;font-weight:300;min-height:100vh}
  .topbar{width:100%;height:56px;background:rgba(22,22,22,0.95);border-bottom:1px solid var(--border);display:flex;align-items:center;justify-content:space-between;padding:0 40px;position:sticky;top:0;z-index:50}
  .topbar-brand{font-family:'Playfair Display',serif;font-size:1rem;font-weight:700;color:var(--text);text-decoration:none}
  .topbar-brand span{color:var(--gold);font-style:italic}
  .btn-back{display:inline-flex;align-items:center;gap:7px;padding:7px 16px;border-radius:8px;border:1px solid var(--border);background:transparent;color:var(--muted2);font-family:'DM Sans',sans-serif;font-size:0.8rem;text-decoration:none;transition:all 0.2s}
  .btn-back:hover{border-color:var(--gold);color:var(--gold)}
  .page-wrap{width:100%;max-width:640px;padding:48px 20px 80px;margin:0 auto}
  .form-card{background:var(--surface);border:1px solid var(--border);border-radius:18px;overflow:hidden}
  .form-card-header{padding:28px 32px 22px;border-bottom:1px solid var(--border)}
  .form-title{font-family:'Playfair Display',serif;font-size:1.5rem;font-weight:700}
  .form-title em{color:var(--gold);font-style:italic}
  .form-body{padding:32px}
  .form-group{margin-bottom:22px}
  .form-row{display:grid;grid-template-columns:1fr 1fr;gap:16px;margin-bottom:22px}
  .form-label{display:block;font-size:0.75rem;text-transform:uppercase;letter-spacing:0.1em;color:var(--muted);margin-bottom:8px;font-weight:500}
  .form-control,.form-select{width:100%;padding:11px 14px;background:var(--surface2);border:1px solid var(--border);border-radius:9px;color:var(--text);font-family:'DM Sans',sans-serif;font-size:0.9rem;transition:border-color 0.2s;outline:none;appearance:none;-webkit-appearance:none}
  .form-control:focus,.form-select:focus{border-color:rgba(212,160,23,0.5);box-shadow:0 0 0 3px rgba(212,160,23,0.08)}
  .form-control::placeholder{color:var(--muted)}
  .form-select option{background:var(--surface2);color:var(--text)}
  .form-divider{border-top:1px solid var(--border);margin:24px 0;padding-top:20px}
  .form-divider-label{font-size:0.68rem;text-transform:uppercase;letter-spacing:0.12em;color:var(--muted);margin-bottom:16px}
  .form-footer{display:flex;justify-content:flex-end;gap:10px;margin-top:28px;padding-top:24px;border-top:1px solid var(--border)}
  .btn{display:inline-flex;align-items:center;gap:7px;padding:10px 22px;border-radius:9px;font-family:'DM Sans',sans-serif;font-size:0.84rem;font-weight:500;cursor:pointer;transition:all 0.2s;text-decoration:none;border:none}
  .btn-cancel{background:transparent;border:1px solid var(--border);color:var(--muted2)}.btn-cancel:hover{border-color:var(--red);color:var(--red)}
  .btn-save{background:var(--gold);color:#0d0d0d;font-weight:600}.btn-save:hover{background:var(--gold-light)}
</style>
</head><body>
<div class="topbar">
  <a href="<c:if test="${sessionScope.adminUser!=null}">AdminServlet?action=dashboard</c:if><c:if test="${sessionScope.loggedStudent!=null}">StudentServlet?action=dashboard</c:if>" class="topbar-brand">Drive<span>Ease</span></a>
  <c:if test="${sessionScope.adminUser!=null}"><a href="LessonServlet?action=list" class="btn-back">← Manage Lessons</a></c:if>
  <c:if test="${sessionScope.loggedStudent!=null}"><a href="StudentServlet?action=dashboard" class="btn-back">← My Portal</a></c:if>
</div>
<div class="page-wrap">
  <div class="form-card">
    <div class="form-card-header">
      <div class="form-title">
        <c:if test="${lesson != null}">Edit Scheduled <em>Lesson</em></c:if>
        <c:if test="${lesson == null}">Schedule a Driving <em>Lesson</em></c:if>
      </div>
    </div>
    <div class="form-body">
      <c:if test="${lesson != null}"><form action="LessonServlet?action=update" method="post"></c:if>
      <c:if test="${lesson == null}"><form action="LessonServlet?action=insert" method="post"></c:if>
        <c:if test="${lesson != null}"><input type="hidden" name="id" value="<c:out value='${lesson.lessonId}'/>" /></c:if>

        <div class="form-group">
          <label class="form-label">Student</label>
          <c:if test="${sessionScope.loggedStudent!=null && sessionScope.adminUser==null}">
            <input type="hidden" name="studentId" value="${sessionScope.loggedStudent.studentId}">
            <input type="text" class="form-control" value="${sessionScope.loggedStudent.name} (NIC: ${sessionScope.loggedStudent.nic})" disabled>
          </c:if>
          <c:if test="${sessionScope.adminUser!=null}">
            <select class="form-select" name="studentId" required>
              <option value="">— Select Student —</option>
              <c:forEach var="stu" items="${students}">
                <option value="${stu.studentId}" <c:if test="${lesson.studentId==stu.studentId}">selected</c:if>>${stu.name} (ID: ${stu.studentId})</option>
              </c:forEach>
            </select>
          </c:if>
        </div>

        <div class="form-row">
          <div>
            <label class="form-label">Instructor</label>
            <select class="form-select" name="instructorId" required>
              <option value="">— Select Instructor —</option>
              <c:forEach var="inst" items="${instructors}">
                <option value="${inst.instructorId}" <c:if test="${lesson.instructorId==inst.instructorId}">selected</c:if>>${inst.name} (${inst.vehicleType})</option>
              </c:forEach>
            </select>
          </div>
          <div>
            <label class="form-label">Vehicle</label>
            <select class="form-select" name="vehicleId" required>
              <option value="">— Select Vehicle —</option>
              <c:forEach var="veh" items="${vehicles}">
                <option value="${veh.vehicleId}" <c:if test="${lesson.vehicleId==veh.vehicleId}">selected</c:if>>${veh.model} · ${veh.plateNumber}</option>
              </c:forEach>
            </select>
          </div>
        </div>

        <div class="form-row">
          <div>
            <label class="form-label">Date</label>
            <input type="date" class="form-control" name="lessonDate" value="<c:out value='${lesson.lessonDate}'/>" required>
          </div>
          <div>
            <label class="form-label">Time</label>
            <input type="time" class="form-control" name="lessonTime" value="<c:out value='${lesson.lessonTime}'/>" required>
          </div>
        </div>

        <c:if test="${sessionScope.adminUser!=null && lesson!=null}">
          <div class="form-divider">
            <div class="form-divider-label">Admin Controls</div>
            <div class="form-group">
              <label class="form-label">Status</label>
              <select class="form-select" name="status" required style="max-width:220px">
                <option value="Scheduled" <c:if test="${lesson.status=='Scheduled'}">selected</c:if>>Scheduled</option>
                <option value="Completed" <c:if test="${lesson.status=='Completed'}">selected</c:if>>Completed</option>
                <option value="Cancelled" <c:if test="${lesson.status=='Cancelled'}">selected</c:if>>Cancelled</option>
              </select>
            </div>
          </div>
        </c:if>

        <div class="form-footer">
          <c:if test="${sessionScope.adminUser!=null}"><a href="LessonServlet?action=list" class="btn btn-cancel">Cancel</a></c:if>
          <c:if test="${sessionScope.adminUser==null}"><a href="StudentServlet?action=dashboard" class="btn btn-cancel">Cancel</a></c:if>
          <button type="submit" class="btn btn-save">Confirm Booking</button>
        </div>
      </form>
    </div>
  </div>
</div>
</body></html>
