<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Protection
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
<title>DriveEase — Admin Panel</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,700;1,700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
<style>
  :root {
    --bg: #0d0d0d;
    --surface: #161616;
    --surface2: #1f1f1f;
    --border: rgba(255,255,255,0.07);
    --gold: #d4a017;
    --gold-light: #f0be3d;
    --text: #f0ede8;
    --muted: #6b6760;
    --muted2: #9a9590;
    --green: #3ecf8e;
    --red: #e05252;
    --blue: #4a9eff;
    --sidebar-w: 240px;
  }
  *, *::before, *::after { margin:0; padding:0; box-sizing:border-box; }
  body { background:var(--bg); color:var(--text); font-family:'DM Sans',sans-serif; font-weight:300; min-height:100vh; display:flex; }

  /* ── SIDEBAR ── */
  .sidebar {
    width: var(--sidebar-w); flex-shrink:0;
    background: var(--surface);
    border-right: 1px solid var(--border);
    display:flex; flex-direction:column;
    position:fixed; top:0; left:0; bottom:0;
    z-index:50;
  }
  .sidebar-logo {
    padding: 28px 24px 24px;
    border-bottom: 1px solid var(--border);
    display:flex; flex-direction:column; align-items:center; gap:10px;
  }
  .logo-icon {
    width:44px; height:44px;
    background: rgba(212,160,23,0.12);
    border: 1px solid rgba(212,160,23,0.3);
    border-radius:12px;
    display:flex; align-items:center; justify-content:center;
    color: var(--gold); font-size:1.2rem;
  }
  .logo-text {
    font-family:'Playfair Display',serif;
    font-size:1.15rem; font-weight:700;
    letter-spacing:-0.02em; color:var(--text);
  }
  .logo-text span { color:var(--gold); font-style:italic; }
  .logo-sub {
    font-size:0.65rem; text-transform:uppercase; letter-spacing:0.12em;
    color:var(--muted); margin-top:-4px;
  }

  .nav-section {
    padding:20px 12px 8px;
    font-size:0.6rem; text-transform:uppercase; letter-spacing:0.14em;
    color:var(--muted);
  }
  .nav-item {
    display:flex; align-items:center; gap:12px;
    padding:10px 16px;
    margin:2px 8px;
    border-radius:8px;
    font-size:0.84rem; font-weight:400;
    color:var(--muted2);
    text-decoration:none;
    transition:all 0.18s;
    border:none; background:transparent; cursor:pointer;
    width:calc(100% - 16px); text-align:left;
  }
  .nav-item:hover { background:rgba(255,255,255,0.04); color:var(--text); }
  .nav-item.active { background:rgba(212,160,23,0.1); color:var(--gold-light); }
  .nav-item .nav-icon { width:16px; height:16px; flex-shrink:0; opacity:0.7; }
  .nav-item.active .nav-icon { opacity:1; }
  .sidebar-footer {
    margin-top:auto;
    padding:16px 12px;
    border-top: 1px solid var(--border);
  }
  .nav-item.logout { color:var(--red); }
  .nav-item.logout:hover { background:rgba(224,82,82,0.08); }

  /* ── MAIN ── */
  .main {
    margin-left: var(--sidebar-w);
    flex:1; display:flex; flex-direction:column;
    min-height:100vh;
  }

  /* ── TOPBAR ── */
  .topbar {
    position:sticky; top:0; z-index:40;
    height:60px;
    background:rgba(13,13,13,0.9);
    backdrop-filter:blur(20px);
    border-bottom:1px solid var(--border);
    display:flex; align-items:center; justify-content:space-between;
    padding:0 36px;
  }
  .topbar-title {
    font-family:'Playfair Display',serif;
    font-size:1.1rem; font-weight:700;
    letter-spacing:-0.02em;
  }
  .topbar-right { display:flex; align-items:center; gap:16px; }
  .admin-chip {
    display:flex; align-items:center; gap:8px;
    padding:6px 14px;
    background:var(--surface2);
    border:1px solid var(--border);
    border-radius:999px;
    font-size:0.75rem; color:var(--muted2);
  }
  .admin-dot { width:7px; height:7px; border-radius:50%; background:var(--gold); box-shadow:0 0 8px var(--gold); }

  /* ── CONTENT ── */
  .content { padding:36px; flex:1; }
  @keyframes fadeUp { from{opacity:0;transform:translateY(10px)} to{opacity:1;transform:translateY(0)} }

  /* ── STAT CARDS ── */
  .stat-grid { display:grid; grid-template-columns:repeat(5,1fr); gap:14px; margin-bottom:32px; }
  .stat-card {
    background:var(--surface);
    border:1px solid var(--border);
    border-radius:14px;
    padding:22px 20px;
    position:relative; overflow:hidden;
    transition:border-color 0.2s, transform 0.2s;
  }
  .stat-card:hover { transform:translateY(-3px); border-color:rgba(212,160,23,0.25); }
  .stat-card::before {
    content:'';
    position:absolute; top:0; right:0;
    width:80px; height:80px;
    border-radius:50%;
    background:radial-gradient(circle, var(--accent-color,rgba(212,160,23,0.15)), transparent 70%);
    transform:translate(20px,-20px);
  }
  .stat-card[data-color="gold"]   { --accent-color: rgba(212,160,23,0.2); }
  .stat-card[data-color="green"]  { --accent-color: rgba(62,207,142,0.2); }
  .stat-card[data-color="blue"]   { --accent-color: rgba(74,158,255,0.2); }
  .stat-card[data-color="red"]    { --accent-color: rgba(224,82,82,0.2); }
  .stat-card[data-color="purple"] { --accent-color: rgba(160,100,255,0.2); }
  .stat-icon {
    width:34px; height:34px; border-radius:9px;
    display:flex; align-items:center; justify-content:center;
    margin-bottom:14px; font-size:1rem;
  }
  .stat-icon.gold   { background:rgba(212,160,23,0.15); }
  .stat-icon.green  { background:rgba(62,207,142,0.15); }
  .stat-icon.blue   { background:rgba(74,158,255,0.15); }
  .stat-icon.red    { background:rgba(224,82,82,0.15); }
  .stat-icon.purple { background:rgba(160,100,255,0.15); }
  .stat-num {
    font-family:'Playfair Display',serif;
    font-size:2.2rem; font-weight:700; line-height:1;
    margin-bottom:4px;
  }
  .stat-num.gold   { color:var(--gold-light); }
  .stat-num.green  { color:var(--green); }
  .stat-num.blue   { color:var(--blue); }
  .stat-num.red    { color:var(--red); }
  .stat-num.purple { color:#c084fc; }
  .stat-label { font-size:0.72rem; text-transform:uppercase; letter-spacing:0.1em; color:var(--muted); }

  /* ── QUICK ACTIONS ── */
  .quick-section { margin-bottom:32px; }
  .quick-title {
    font-size:0.7rem; text-transform:uppercase; letter-spacing:0.12em;
    color:var(--muted); margin-bottom:14px;
  }
  .quick-actions { display:flex; gap:10px; flex-wrap:wrap; }
  .btn-action {
    display:inline-flex; align-items:center; gap:8px;
    padding:10px 20px;
    border-radius:9px; border:1px solid var(--border);
    background:var(--surface);
    color:var(--muted2); font-family:'DM Sans',sans-serif;
    font-size:0.8rem; font-weight:500; letter-spacing:0.04em;
    cursor:pointer; transition:all 0.2s;
    text-decoration:none;
  }
  .btn-action:hover { border-color:var(--gold); color:var(--gold); background:rgba(212,160,23,0.06); }
  .btn-action.primary {
    background:var(--gold); color:#0d0d0d; border-color:var(--gold); font-weight:600;
  }
  .btn-action.primary:hover { background:var(--gold-light); border-color:var(--gold-light); color:#0d0d0d; }

  /* ── SECTION HEADER ── */
  .section-heading {
    font-family:'Playfair Display',serif;
    font-size:1.4rem; font-weight:700; letter-spacing:-0.02em;
  }
  .section-heading em { color:var(--gold); font-style:italic; }
</style>
</head>
<body>

<!-- SIDEBAR -->
<aside class="sidebar">
  <div class="sidebar-logo">
    <div class="logo-icon">&#128737;</div>
    <div>
      <div class="logo-text">Drive<span>Ease</span></div>
      <div class="logo-sub">Admin Panel</div>
    </div>
  </div>

  <div class="nav-section">Main</div>
  <a href="AdminServlet?action=dashboard" class="nav-item active">
    <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/><rect x="3" y="14" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/></svg>
    Dashboard
  </a>

  <div class="nav-section">Management</div>
  <a href="StudentServlet?action=list" class="nav-item">
    <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"/></svg>
    Students
  </a>
  <a href="InstructorServlet?action=list" class="nav-item">
    <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
    Instructors
  </a>
  <a href="VehicleServlet?action=list" class="nav-item">
    <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 17H3a2 2 0 01-2-2V5a2 2 0 012-2h11l5 5v9a2 2 0 01-2 2h-3"/><circle cx="7.5" cy="17.5" r="2.5"/><circle cx="17.5" cy="17.5" r="2.5"/></svg>
    Vehicles
  </a>
  <a href="LessonServlet?action=list" class="nav-item">
    <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"/><path d="M16 2v4M8 2v4M3 10h18"/></svg>
    Lessons
  </a>
  <a href="PaymentServlet?action=list" class="nav-item">
    <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="1" y="4" width="22" height="16" rx="2"/><path d="M1 10h22"/></svg>
    Payments
  </a>
  <a href="TestServlet?action=list" class="nav-item">
    <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 11l3 3L22 4"/><path d="M21 12v7a2 2 0 01-2 2H5a2 2 0 01-2-2V5a2 2 0 012-2h11"/></svg>
    Driving Tests
  </a>

  <div class="sidebar-footer">
    <a href="AdminServlet?action=logout" class="nav-item logout">
      <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4M16 17l5-5-5-5M21 12H9"/></svg>
      Logout
    </a>
  </div>
</aside>

<!-- MAIN -->
<div class="main">

  <!-- TOPBAR -->
  <div class="topbar">
    <span class="topbar-title">Dashboard <span style="color:var(--gold);font-style:italic">Summary</span></span>
    <div class="topbar-right">
      <div class="admin-chip">
        <span class="admin-dot"></span>
        Welcome, <strong style="color:var(--text);margin-left:4px;"><%= session.getAttribute("adminUser") %></strong>
      </div>
    </div>
  </div>

  <div class="content" style="animation:fadeUp 0.4s ease;">

    <!-- STAT CARDS -->
    <div class="stat-grid">
      <div class="stat-card" data-color="blue">
        <div class="stat-icon blue">👥</div>
        <div class="stat-num blue"><%= request.getAttribute("totalStudents") != null ? request.getAttribute("totalStudents") : 0 %></div>
        <div class="stat-label">Total Students</div>
      </div>
      <div class="stat-card" data-color="green">
        <div class="stat-icon green">🎓</div>
        <div class="stat-num green"><%= request.getAttribute("totalInstructors") != null ? request.getAttribute("totalInstructors") : 0 %></div>
        <div class="stat-label">Instructors</div>
      </div>
      <div class="stat-card" data-color="gold">
        <div class="stat-icon gold">🚗</div>
        <div class="stat-num gold"><%= request.getAttribute("totalVehicles") != null ? request.getAttribute("totalVehicles") : 0 %></div>
        <div class="stat-label">Vehicles</div>
      </div>
      <div class="stat-card" data-color="purple">
        <div class="stat-icon purple">📋</div>
        <div class="stat-num purple"><%= request.getAttribute("totalLessons") != null ? request.getAttribute("totalLessons") : 0 %></div>
        <div class="stat-label">Lessons</div>
      </div>
      <div class="stat-card" data-color="red">
        <div class="stat-icon red">💳</div>
        <div class="stat-num red"><%= request.getAttribute("totalPayments") != null ? request.getAttribute("totalPayments") : 0 %></div>
        <div class="stat-label">Payments</div>
      </div>
    </div>

    <!-- QUICK ACTIONS -->
    <div class="quick-section">
      <div class="quick-title">⚡ Quick Management</div>
      <div class="quick-actions">
        <a href="StudentServlet?action=new" class="btn-action primary">
          <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path d="M12 5v14M5 12h14"/></svg>
          Register Student
        </a>
        <a href="InstructorServlet?action=new" class="btn-action">
          <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path d="M12 5v14M5 12h14"/></svg>
          Add Instructor
        </a>
        <a href="VehicleServlet?action=new" class="btn-action">
          <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path d="M12 5v14M5 12h14"/></svg>
          Add Vehicle
        </a>
        <a href="LessonServlet?action=new" class="btn-action">
          <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path d="M12 5v14M5 12h14"/></svg>
          Schedule Lesson
        </a>
        <a href="TestServlet?action=new" class="btn-action">
          <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path d="M12 5v14M5 12h14"/></svg>
          Book Test
        </a>
      </div>
    </div>

  </div><!-- /content -->
</div><!-- /main -->

</body>
</html>
