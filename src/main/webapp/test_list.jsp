<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%  if(session.getAttribute("adminUser")==null){response.sendRedirect("admin_login.jsp");return;} %>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Driving Tests — DriveEase Admin</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,700;1,700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
<style>
  *,*::before,*::after{margin:0;padding:0;box-sizing:border-box}
  :root{--bg:#0d0d0d;--surface:#161616;--surface2:#1f1f1f;--border:rgba(255,255,255,0.07);--gold:#d4a017;--gold-light:#f0be3d;--text:#f0ede8;--muted:#6b6760;--muted2:#9a9590;--green:#3ecf8e;--red:#e05252;--blue:#4a9eff;--sidebar-w:240px}
  body{background:var(--bg);color:var(--text);font-family:'DM Sans',sans-serif;font-weight:300;min-height:100vh;display:flex}
  .sidebar{width:var(--sidebar-w);flex-shrink:0;background:var(--surface);border-right:1px solid var(--border);display:flex;flex-direction:column;position:fixed;top:0;left:0;bottom:0;z-index:50}
  .sidebar-logo{padding:28px 24px 24px;border-bottom:1px solid var(--border);display:flex;flex-direction:column;align-items:center;gap:10px}
  .logo-icon{width:44px;height:44px;background:rgba(212,160,23,0.12);border:1px solid rgba(212,160,23,0.3);border-radius:12px;display:flex;align-items:center;justify-content:center;color:var(--gold);font-size:1.2rem}
  .logo-text{font-family:'Playfair Display',serif;font-size:1.15rem;font-weight:700;color:var(--text)}.logo-text span{color:var(--gold);font-style:italic}
  .logo-sub{font-size:0.65rem;text-transform:uppercase;letter-spacing:0.12em;color:var(--muted);margin-top:-4px}
  .nav-section{padding:20px 12px 8px;font-size:0.6rem;text-transform:uppercase;letter-spacing:0.14em;color:var(--muted)}
  .nav-item{display:flex;align-items:center;gap:12px;padding:10px 16px;margin:2px 8px;border-radius:8px;font-size:0.84rem;color:var(--muted2);text-decoration:none;transition:all 0.18s;width:calc(100% - 16px)}
  .nav-item:hover{background:rgba(255,255,255,0.04);color:var(--text)}.nav-item.active{background:rgba(212,160,23,0.1);color:var(--gold-light)}
  .nav-icon{width:16px;height:16px;flex-shrink:0;opacity:0.7}.nav-item.active .nav-icon{opacity:1}
  .sidebar-footer{margin-top:auto;padding:16px 12px;border-top:1px solid var(--border)}
  .nav-item.logout{color:var(--red)}.nav-item.logout:hover{background:rgba(224,82,82,0.08)}
  .main{margin-left:var(--sidebar-w);flex:1;display:flex;flex-direction:column;min-height:100vh}
  .topbar{position:sticky;top:0;z-index:40;height:60px;background:rgba(13,13,13,0.9);backdrop-filter:blur(20px);border-bottom:1px solid var(--border);display:flex;align-items:center;justify-content:space-between;padding:0 36px}
  .topbar-title{font-family:'Playfair Display',serif;font-size:1.1rem;font-weight:700}
  .admin-chip{display:flex;align-items:center;gap:8px;padding:6px 14px;background:var(--surface2);border:1px solid var(--border);border-radius:999px;font-size:0.75rem;color:var(--muted2)}
  .admin-dot{width:7px;height:7px;border-radius:50%;background:var(--gold);box-shadow:0 0 8px var(--gold)}
  .content{padding:36px;flex:1}
  .section-header{display:flex;align-items:center;justify-content:space-between;margin-bottom:24px}
  .section-heading{font-family:'Playfair Display',serif;font-size:1.4rem;font-weight:700}.section-heading em{color:var(--gold);font-style:italic}
  .btn-action{display:inline-flex;align-items:center;gap:8px;padding:10px 20px;border-radius:9px;border:1px solid var(--border);background:var(--surface);color:var(--muted2);font-family:'DM Sans',sans-serif;font-size:0.8rem;font-weight:500;cursor:pointer;transition:all 0.2s;text-decoration:none}
  .btn-action.primary{background:var(--gold);color:#0d0d0d;border-color:var(--gold);font-weight:600}.btn-action.primary:hover{background:var(--gold-light)}
  .table-wrap{background:var(--surface);border:1px solid var(--border);border-radius:14px;overflow:hidden}
  table{width:100%;border-collapse:collapse}thead tr{border-bottom:1px solid var(--border)}
  th{padding:14px 20px;font-size:0.68rem;font-weight:600;letter-spacing:0.12em;text-transform:uppercase;color:var(--muted);text-align:left;background:transparent}
  td{padding:15px 20px;font-size:0.86rem;color:var(--muted2);border-bottom:1px solid var(--border);transition:background 0.15s;background:transparent}
  tr:last-child td{border-bottom:none}tbody tr:hover td{background:rgba(255,255,255,0.02);color:var(--text)}td.bold{font-weight:500;color:var(--text)}
  .badge{display:inline-flex;align-items:center;gap:5px;padding:4px 11px;border-radius:999px;font-size:0.68rem;font-weight:600;text-transform:uppercase}
  .badge-pass{background:rgba(62,207,142,0.12);color:var(--green)}.badge-fail{background:rgba(224,82,82,0.12);color:var(--red)}.badge-pend{background:rgba(212,160,23,0.12);color:var(--gold-light)}
  .id-pill{display:inline-flex;align-items:center;justify-content:center;width:26px;height:26px;background:var(--surface2);border:1px solid var(--border);border-radius:6px;font-size:0.75rem;font-weight:600;color:var(--muted2)}
  .action-btns{display:flex;gap:6px}
  .btn-icon{width:30px;height:30px;border-radius:7px;display:flex;align-items:center;justify-content:center;cursor:pointer;border:1px solid var(--border);background:transparent;transition:all 0.18s;text-decoration:none;color:var(--muted2)}
  .btn-icon.edit:hover{border-color:var(--blue);color:var(--blue);background:rgba(74,158,255,0.08)}.btn-icon.del:hover{border-color:var(--red);color:var(--red);background:rgba(224,82,82,0.08)}
  .btn-icon svg{width:13px;height:13px;stroke:currentColor;fill:none;stroke-width:2}
  .back-link{display:inline-flex;align-items:center;gap:6px;font-size:0.78rem;color:var(--muted);text-decoration:none;margin-top:20px;transition:color 0.2s}.back-link:hover{color:var(--gold)}
  .empty-row{padding:48px;text-align:center;color:var(--muted);font-size:0.88rem}
</style>
</head><body>
<aside class="sidebar">
  <div class="sidebar-logo"><div class="logo-icon">&#128737;</div><div><div class="logo-text">Drive<span>Ease</span></div><div class="logo-sub">Admin Panel</div></div></div>
  <div class="nav-section">Main</div>
  <a href="AdminServlet?action=dashboard" class="nav-item"><svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/><rect x="3" y="14" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/></svg>Dashboard</a>
  <div class="nav-section">Management</div>
  <a href="StudentServlet?action=list" class="nav-item"><svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/></svg>Students</a>
  <a href="InstructorServlet?action=list" class="nav-item"><svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>Instructors</a>
  <a href="VehicleServlet?action=list" class="nav-item"><svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 17H3a2 2 0 01-2-2V5a2 2 0 012-2h11l5 5v9a2 2 0 01-2 2h-3"/><circle cx="7.5" cy="17.5" r="2.5"/><circle cx="17.5" cy="17.5" r="2.5"/></svg>Vehicles</a>
  <a href="LessonServlet?action=list" class="nav-item"><svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"/><path d="M16 2v4M8 2v4M3 10h18"/></svg>Lessons</a>
  <a href="PaymentServlet?action=list" class="nav-item"><svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="1" y="4" width="22" height="16" rx="2"/><path d="M1 10h22"/></svg>Payments</a>
  <a href="TestServlet?action=list" class="nav-item active"><svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 11l3 3L22 4"/><path d="M21 12v7a2 2 0 01-2 2H5a2 2 0 01-2-2V5a2 2 0 012-2h11"/></svg>Driving Tests</a>
  <div class="sidebar-footer"><a href="AdminServlet?action=logout" class="nav-item logout"><svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4M16 17l5-5-5-5M21 12H9"/></svg>Logout</a></div>
</aside>
<div class="main">
  <div class="topbar">
    <span class="topbar-title">Driving Tests <span style="color:var(--gold);font-style:italic">Scheduled</span></span>
    <div class="admin-chip"><span class="admin-dot"></span>Admin: <%= session.getAttribute("adminUser") %></div>
  </div>
  <div class="content">
    <div class="section-header">
      <h2 class="section-heading">Driving Tests <em>Scheduled</em></h2>
      <a href="TestServlet?action=new" class="btn-action primary"><svg width="13" height="13" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path d="M12 5v14M5 12h14"/></svg>Book New Test</a>
    </div>
    <div class="table-wrap">
      <table>
        <thead><tr><th>ID</th><th>Student</th><th>Test Date</th><th>Result</th><th>Actions</th></tr></thead>
        <tbody>
          <c:forEach var="testObj" items="${listTest}">
            <tr>
              <td><span class="id-pill"><c:out value="${testObj.testId}"/></span></td>
              <td><span class="id-pill"><c:out value="${testObj.studentId}"/></span></td>
              <td class="bold"><c:out value="${testObj.testDate}"/></td>
              <td><span class="badge ${testObj.result=='Pass'?'badge-pass':(testObj.result=='Fail'?'badge-fail':'badge-pend')}"><c:out value="${testObj.result}"/></span></td>
              <td><div class="action-btns">
                <a href="TestServlet?action=edit&id=<c:out value='${testObj.testId}'/>" class="btn-icon edit"><svg viewBox="0 0 24 24"><path d="M11 4H4a2 2 0 00-2 2v14a2 2 0 002 2h14a2 2 0 002-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 013 3L12 15l-4 1 1-4 9.5-9.5z"/></svg></a>
                <a href="TestServlet?action=delete&id=<c:out value='${testObj.testId}'/>" class="btn-icon del" onclick="return confirm('Delete this test record?');"><svg viewBox="0 0 24 24"><polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14H6L5 6"/><path d="M10 11v6M14 11v6"/><path d="M9 6V4h6v2"/></svg></a>
              </div></td>
            </tr>
          </c:forEach>
          <c:if test="${empty listTest}"><tr><td colspan="5"><div class="empty-row">No driving tests scheduled.</div></td></tr></c:if>
        </tbody>
      </table>
    </div>
    <a href="AdminServlet?action=dashboard" class="back-link"><svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg>Back to Dashboard</a>
  </div>
</div>
</body></html>
