<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%  if(session.getAttribute("adminUser")==null){response.sendRedirect("admin_login.jsp");return;} %>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
<title><c:if test="${instructor != null}">Edit Instructor</c:if><c:if test="${instructor == null}">Add Instructor</c:if> — DriveEase</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,700;1,700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
<style>
  *,*::before,*::after{margin:0;padding:0;box-sizing:border-box}
  :root{--bg:#0d0d0d;--surface:#161616;--surface2:#1f1f1f;--border:rgba(255,255,255,0.07);--gold:#d4a017;--gold-light:#f0be3d;--text:#f0ede8;--muted:#6b6760;--muted2:#9a9590;--green:#3ecf8e;--red:#e05252;--blue:#4a9eff}
  body{background:var(--bg);color:var(--text);font-family:'DM Sans',sans-serif;font-weight:300;min-height:100vh;display:flex;flex-direction:column;align-items:center;justify-content:flex-start;padding:0}
  .topbar{width:100%;height:56px;background:rgba(22,22,22,0.95);border-bottom:1px solid var(--border);display:flex;align-items:center;justify-content:space-between;padding:0 40px;position:sticky;top:0;z-index:50}
  .topbar-brand{font-family:'Playfair Display',serif;font-size:1rem;font-weight:700;color:var(--text);text-decoration:none}
  .topbar-brand span{color:var(--gold);font-style:italic}
  .topbar-links{display:flex;gap:12px;align-items:center}
  .btn-back{display:inline-flex;align-items:center;gap:7px;padding:7px 16px;border-radius:8px;border:1px solid var(--border);background:transparent;color:var(--muted2);font-family:'DM Sans',sans-serif;font-size:0.8rem;text-decoration:none;transition:all 0.2s}
  .btn-back:hover{border-color:var(--gold);color:var(--gold)}
  .page-wrap{width:100%;max-width:560px;padding:48px 20px 80px}
  .form-card{background:var(--surface);border:1px solid var(--border);border-radius:18px;overflow:hidden}
  .form-card-header{padding:28px 32px 22px;border-bottom:1px solid var(--border)}
  .form-title{font-family:'Playfair Display',serif;font-size:1.5rem;font-weight:700}
  .form-title em{color:var(--gold);font-style:italic}
  .form-body{padding:32px}
  .form-group{margin-bottom:22px}
  .form-label{display:block;font-size:0.75rem;text-transform:uppercase;letter-spacing:0.1em;color:var(--muted);margin-bottom:8px;font-weight:500}
  .form-control,.form-select{width:100%;padding:11px 14px;background:var(--surface2);border:1px solid var(--border);border-radius:9px;color:var(--text);font-family:'DM Sans',sans-serif;font-size:0.9rem;transition:border-color 0.2s;outline:none;appearance:none;-webkit-appearance:none}
  .form-control:focus,.form-select:focus{border-color:rgba(212,160,23,0.5);box-shadow:0 0 0 3px rgba(212,160,23,0.08)}
  .form-control::placeholder{color:var(--muted)}
  .form-select option{background:var(--surface2);color:var(--text)}
  .form-hint{font-size:0.72rem;color:var(--muted);margin-top:5px}
  .form-footer{display:flex;justify-content:flex-end;gap:10px;margin-top:28px;padding-top:24px;border-top:1px solid var(--border)}
  .btn{display:inline-flex;align-items:center;gap:7px;padding:10px 22px;border-radius:9px;font-family:'DM Sans',sans-serif;font-size:0.84rem;font-weight:500;cursor:pointer;transition:all 0.2s;text-decoration:none;border:none}
  .btn-cancel{background:transparent;border:1px solid var(--border);color:var(--muted2)}.btn-cancel:hover{border-color:var(--red);color:var(--red)}
  .btn-save{background:var(--gold);color:#0d0d0d;font-weight:600;border:none}.btn-save:hover{background:var(--gold-light)}
</style>
</head><body>
<div class="topbar">
  <a href="AdminServlet?action=dashboard" class="topbar-brand">Drive<span>Ease</span> <span style="color:var(--muted);font-family:'DM Sans',sans-serif;font-size:0.75rem;font-style:normal;margin-left:8px">Admin</span></a>
  <div class="topbar-links">
    <a href="InstructorServlet?action=list" class="btn-back">← Manage Instructors</a>
  </div>
</div>
<div class="page-wrap">
  <div class="form-card">
    <div class="form-card-header">
      <div class="form-title">
        <c:if test="${instructor != null}">Edit Instructor <em>Details</em></c:if>
        <c:if test="${instructor == null}">Register New <em>Instructor</em></c:if>
      </div>
    </div>
    <div class="form-body">
      <c:if test="${instructor != null}"><form action="InstructorServlet?action=update" method="post"></c:if>
      <c:if test="${instructor == null}"><form action="InstructorServlet?action=insert" method="post"></c:if>
        <c:if test="${instructor != null}"><input type="hidden" name="id" value="<c:out value='${instructor.instructorId}'/>" /></c:if>
        <div class="form-group">
          <label class="form-label">Full Name</label>
          <input type="text" class="form-control" name="name" value="<c:out value='${instructor.name}'/>" placeholder="e.g. John Perera" required>
        </div>
        <div class="form-group">
          <label class="form-label">Phone Number</label>
          <input type="text" class="form-control" name="phoneNumber" value="<c:out value='${instructor.phoneNumber}'/>" placeholder="e.g. 0771234567" required>
        </div>
        <div class="form-group">
          <label class="form-label">Vehicle Type</label>
          <select class="form-select" name="vehicleType" required>
            <option value="Car" <c:if test="${instructor.vehicleType=='Car'}">selected</c:if>>🚗 Car</option>
            <option value="Bike" <c:if test="${instructor.vehicleType=='Bike'}">selected</c:if>>🏍 Bike</option>
            <option value="Both" <c:if test="${instructor.vehicleType=='Both'}">selected</c:if>>🚗🏍 Both (Car &amp; Bike)</option>
          </select>
        </div>
        <div class="form-footer">
          <a href="InstructorServlet?action=list" class="btn btn-cancel">Cancel</a>
          <button type="submit" class="btn btn-save">Save Instructor</button>
        </div>
      </form>
    </div>
  </div>
</div>
</body></html>
