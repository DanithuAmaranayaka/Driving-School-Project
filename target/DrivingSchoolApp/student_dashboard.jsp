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
<title>DriveEase — Student Portal</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,700;1,700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
  /* ── RESET & TOKENS ── */
  *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

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
  }

  html, body {
    background: var(--bg);
    color: var(--text);
    font-family: 'DM Sans', sans-serif;
    font-weight: 300;
    min-height: 100vh;
    overflow-x: hidden;
  }

  a { text-decoration: none; }

  /* ── LAYOUT ── */
  .page { display: flex; min-height: 100vh; }

  /* ── SIDEBAR ── */
  .sidebar {
    width: 280px;
    flex-shrink: 0;
    border-right: 1px solid var(--border);
    padding: 40px 24px;
    display: flex;
    flex-direction: column;
    gap: 32px;
    position: sticky;
    top: 0;
    height: 100vh;
    overflow-y: auto;
    background: var(--bg);
  }

  .profile-card {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 16px;
    text-align: center;
  }

  .avatar-wrap { position: relative; width: 88px; height: 88px; }

  .avatar {
    width: 88px; height: 88px;
    border-radius: 50%;
    background: var(--surface2);
    border: 2px solid var(--border);
    display: flex; align-items: center; justify-content: center;
    overflow: hidden;
    color: var(--muted2);
    font-size: 2.5rem;
  }

  .avatar-ring {
    position: absolute; inset: -4px;
    border-radius: 50%;
    border: 1.5px solid transparent;
    background: linear-gradient(135deg, var(--gold), transparent 60%) border-box;
    -webkit-mask: linear-gradient(#fff 0 0) padding-box, linear-gradient(#fff 0 0);
    -webkit-mask-composite: destination-out;
    mask-composite: exclude;
    animation: spin 8s linear infinite;
  }

  @keyframes spin { to { transform: rotate(360deg); } }

  .profile-name {
    font-family: 'Playfair Display', serif;
    font-size: 1.35rem;
    font-weight: 700;
    color: var(--text);
  }

  .profile-meta { display: flex; flex-direction: column; gap: 6px; }

  .meta-row {
    display: flex; align-items: center; justify-content: center; gap: 7px;
    font-size: 0.78rem; color: var(--muted2);
  }

  .meta-row i { opacity: 0.5; font-size: 0.8rem; }

  .license-badge {
    display: inline-flex; align-items: center; gap: 8px;
    margin-top: 4px; padding: 6px 16px;
    border: 1px solid rgba(212,160,23,0.35);
    border-radius: 999px;
    background: rgba(212,160,23,0.08);
    font-size: 0.75rem;
    color: var(--gold-light);
    letter-spacing: 0.1em;
    text-transform: uppercase;
  }

  .license-dot {
    width: 6px; height: 6px; border-radius: 50%;
    background: var(--gold);
    box-shadow: 0 0 8px var(--gold);
    animation: pulse 2s ease-in-out infinite;
  }

  @keyframes pulse { 0%,100%{opacity:1} 50%{opacity:0.4} }

  .stat-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }

  .stat-card {
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: 10px;
    padding: 14px 12px;
    text-align: center;
    transition: border-color 0.2s;
  }

  .stat-card:hover { border-color: rgba(212,160,23,0.3); }

  .stat-num {
    font-family: 'Playfair Display', serif;
    font-size: 1.6rem;
    font-weight: 700;
    color: var(--gold-light);
  }

  .stat-label {
    font-size: 0.68rem;
    color: var(--muted);
    text-transform: uppercase;
    letter-spacing: 0.08em;
    margin-top: 2px;
  }

  /* ── LOGOUT ── */
  .btn-logout {
    display: flex; align-items: center; justify-content: center; gap: 8px;
    padding: 10px 16px;
    border: 1px solid rgba(224,82,82,0.3);
    border-radius: 8px;
    background: rgba(224,82,82,0.06);
    color: var(--red);
    font-family: 'DM Sans', sans-serif;
    font-size: 0.82rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s;
    width: 100%;
    margin-top: auto;
  }

  .btn-logout:hover { background: rgba(224,82,82,0.15); border-color: var(--red); color: var(--red); }

  /* ── MAIN ── */
  .main { flex: 1; padding: 40px 48px; overflow-y: auto; }

  .section-title {
    font-family: 'Playfair Display', serif;
    font-size: 1.9rem;
    font-weight: 700;
    letter-spacing: -0.03em;
    margin-bottom: 28px;
  }

  .section-title em { font-style: italic; color: var(--gold); }

  /* ── UPCOMING BANNER ── */
  .upcoming-banner {
    background: linear-gradient(135deg, rgba(212,160,23,0.12), rgba(212,160,23,0.03));
    border: 1px solid rgba(212,160,23,0.2);
    border-radius: 14px;
    padding: 24px 28px;
    display: flex; align-items: center; justify-content: space-between;
    margin-bottom: 32px;
  }

  .upcoming-left { display: flex; flex-direction: column; gap: 6px; }

  .upcoming-eyebrow {
    font-size: 0.7rem;
    text-transform: uppercase;
    letter-spacing: 0.12em;
    color: var(--gold);
  }

  .upcoming-lesson { font-size: 1.05rem; font-weight: 500; color: var(--text); }
  .upcoming-sub { font-size: 0.8rem; color: var(--muted2); }

  .btn-gold {
    padding: 10px 22px;
    background: var(--gold);
    color: #0d0d0d;
    font-family: 'DM Sans', sans-serif;
    font-size: 0.82rem;
    font-weight: 600;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background 0.2s, transform 0.15s;
    white-space: nowrap;
  }

  .btn-gold:hover { background: var(--gold-light); transform: translateY(-1px); }

  /* ── TABS ── */
  .tabs {
    display: flex;
    border: 1px solid var(--border);
    border-radius: 10px;
    overflow: hidden;
    margin-bottom: 32px;
    width: fit-content;
    background: var(--surface);
  }

  .tab {
    padding: 10px 24px;
    font-family: 'DM Sans', sans-serif;
    font-size: 0.82rem;
    font-weight: 500;
    letter-spacing: 0.05em;
    text-transform: uppercase;
    cursor: pointer;
    border: none;
    background: transparent;
    color: var(--muted2);
    transition: all 0.2s;
    display: flex; align-items: center; gap: 8px;
    border-right: 1px solid var(--border);
  }

  .tab:last-child { border-right: none; }

  .tab.active {
    background: rgba(212,160,23,0.12);
    color: var(--gold-light);
  }

  .tab:hover:not(.active) { color: var(--text); background: rgba(255,255,255,0.03); }

  /* ── TAB PANELS ── */
  .tab-panel { display: none; }
  .tab-panel.active { display: block; animation: fadeUp 0.3s ease; }

  @keyframes fadeUp {
    from { opacity: 0; transform: translateY(10px); }
    to   { opacity: 1; transform: translateY(0); }
  }

  /* ── TABLE ── */
  .table-wrap {
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: 14px;
    overflow: hidden;
  }

  table { width: 100%; border-collapse: collapse; }
  thead tr { border-bottom: 1px solid var(--border); }

  th {
    padding: 16px 20px;
    font-size: 0.72rem;
    font-weight: 600;
    letter-spacing: 0.12em;
    text-transform: uppercase;
    color: var(--muted);
    text-align: left;
    background: transparent;
  }

  td {
    padding: 18px 20px;
    font-size: 0.88rem;
    color: var(--muted2);
    border-bottom: 1px solid var(--border);
    transition: background 0.15s;
    background: transparent;
  }

  tr:last-child td { border-bottom: none; }
  tbody tr:hover td { background: rgba(255,255,255,0.02); color: var(--text); }

  /* ── BADGES ── */
  .badge {
    display: inline-flex; align-items: center; gap: 6px;
    padding: 4px 12px;
    border-radius: 999px;
    font-size: 0.72rem;
    font-weight: 600;
    letter-spacing: 0.06em;
    text-transform: uppercase;
  }

  .badge-dot { width: 5px; height: 5px; border-radius: 50%; display: inline-block; }

  .badge-scheduled { background: rgba(74,158,255,0.12); color: var(--blue); }
  .badge-scheduled .badge-dot { background: var(--blue); }
  .badge-completed { background: rgba(62,207,142,0.12); color: var(--green); }
  .badge-completed .badge-dot { background: var(--green); box-shadow: 0 0 6px var(--green); }
  .badge-cancelled { background: rgba(224,82,82,0.12); color: var(--red); }
  .badge-cancelled .badge-dot { background: var(--red); }

  .empty-state { padding: 64px 0; text-align: center; }
  .empty-icon { font-size: 2.5rem; opacity: 0.2; margin-bottom: 12px; }
  .empty-text { font-size: 0.88rem; color: var(--muted); }

  /* ── PAYMENTS ── */
  .payment-list { display: flex; flex-direction: column; gap: 12px; }

  .payment-item {
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: 12px;
    padding: 18px 22px;
    display: flex; align-items: center; justify-content: space-between;
    transition: border-color 0.2s;
  }

  .payment-item:hover { border-color: rgba(212,160,23,0.25); }
  .payment-left { display: flex; flex-direction: column; gap: 4px; }
  .payment-desc { font-size: 0.9rem; font-weight: 500; color: var(--text); }
  .payment-date { font-size: 0.75rem; color: var(--muted); }

  .payment-amount {
    font-family: 'Playfair Display', serif;
    font-size: 1.2rem;
    color: var(--gold-light);
  }

  /* ── TEST CARDS ── */
  .test-cards { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }

  .test-card {
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: 14px;
    padding: 24px;
    display: flex; flex-direction: column; gap: 12px;
    transition: border-color 0.2s, transform 0.2s;
  }

  .test-card:hover { border-color: rgba(212,160,23,0.3); transform: translateY(-2px); }
  .test-card-header { display: flex; align-items: center; justify-content: space-between; }
  .test-type { font-size: 0.7rem; letter-spacing: 0.1em; text-transform: uppercase; color: var(--muted); }
  .test-card-title { font-family: 'Playfair Display', serif; font-size: 1.1rem; font-weight: 700; color: var(--text); }
  .test-date { font-size: 0.82rem; color: var(--muted2); }

  .progress-bar-wrap { height: 3px; background: rgba(255,255,255,0.07); border-radius: 999px; }
  .progress-bar { height: 100%; border-radius: 999px; background: linear-gradient(90deg, var(--gold), var(--gold-light)); }
</style>
</head>
<body>

<div class="page">
  <!-- SIDEBAR -->
  <aside class="sidebar">
    <div class="profile-card">
      <div class="avatar-wrap">
        <div class="avatar">
          <i class="fa-regular fa-user"></i>
        </div>
        <div class="avatar-ring"></div>
      </div>

      <div>
        <div class="profile-name">${sessionScope.loggedStudent.name}</div>
        <div class="profile-meta">
          <div class="meta-row">
            <i class="fa-regular fa-id-card"></i>
            ${sessionScope.loggedStudent.nic}
          </div>
          <div class="meta-row">
            <i class="fa-solid fa-phone"></i>
            ${sessionScope.loggedStudent.phoneNumber}
          </div>
        </div>
      </div>

      <div class="license-badge">
        <span class="license-dot"></span>
        ${sessionScope.loggedStudent.licenseType} License
      </div>
    </div>

    <!-- STATS -->
    <div class="stat-grid">
      <div class="stat-card">
        <div class="stat-num">12</div>
        <div class="stat-label">Lessons</div>
      </div>
      <div class="stat-card">
        <div class="stat-num">8</div>
        <div class="stat-label">Done</div>
      </div>
      <div class="stat-card">
        <div class="stat-num">2</div>
        <div class="stat-label">Tests</div>
      </div>
      <div class="stat-card">
        <div class="stat-num">94%</div>
        <div class="stat-label">Score</div>
      </div>
    </div>

    <a href="StudentServlet?action=logout" class="btn-logout">
      <i class="fa-solid fa-right-from-bracket"></i> Logout
    </a>
  </aside>

  <!-- MAIN -->
  <main class="main">
    <h1 class="section-title">My <em>Dashboard</em></h1>

    <!-- UPCOMING BANNER -->
    <div class="upcoming-banner">
      <div class="upcoming-left">
        <span class="upcoming-eyebrow">⚡ Next Session</span>
        <span class="upcoming-lesson">Practical Driving — City Route</span>
        <span class="upcoming-sub">License type: ${sessionScope.loggedStudent.licenseType}</span>
      </div>
      <button class="btn-gold">View Details →</button>
    </div>

    <!-- TABS -->
    <div class="tabs">
      <button class="tab active" onclick="switchTab('lessons', this)">
        <i class="fa-regular fa-calendar-check"></i> My Lessons
      </button>
      <button class="tab" onclick="switchTab('payments', this)">
        <i class="fa-regular fa-credit-card"></i> Payments
      </button>
      <button class="tab" onclick="switchTab('tests', this)">
        <i class="fa-solid fa-flag-checkered"></i> Driving Tests
      </button>
    </div>

    <!-- LESSONS PANEL -->
    <div id="panel-lessons" class="tab-panel active">
      <div class="table-wrap">
        <table>
          <thead>
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
                  <span class="badge badge-${lesson.status == 'Scheduled' ? 'scheduled' : (lesson.status == 'Completed' ? 'completed' : 'cancelled')}">
                    <span class="badge-dot"></span>
                    <c:out value="${lesson.status}" />
                  </span>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty listLessons}">
              <tr>
                <td colspan="3">
                  <div class="empty-state">
                    <div class="empty-icon">📋</div>
                    <div class="empty-text">No lessons scheduled yet.</div>
                  </div>
                </td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>

    <!-- PAYMENTS PANEL -->
    <div id="panel-payments" class="tab-panel">
      <div class="payment-list">
        <c:forEach var="payment" items="${listPayments}">
          <div class="payment-item">
            <div class="payment-left">
              <span class="payment-desc"><c:out value="${payment.courseType}" /></span>
              <span class="payment-date">via <c:out value="${payment.paymentMethod}" /> · <c:out value="${payment.paymentDate}" /></span>
            </div>
            <div style="display:flex;align-items:center;gap:14px;">
              <span class="badge badge-completed"><span class="badge-dot"></span>Paid</span>
              <span class="payment-amount">LKR <c:out value="${payment.amount}" /></span>
            </div>
          </div>
        </c:forEach>
        <c:if test="${empty listPayments}">
          <div class="empty-state">
            <div class="empty-icon">💳</div>
            <div class="empty-text">No payments found.</div>
          </div>
        </c:if>
      </div>
    </div>

    <!-- TESTS PANEL -->
    <div id="panel-tests" class="tab-panel">
      <div class="test-cards">
        <c:forEach var="testObj" items="${listTests}">
          <div class="test-card">
            <div class="test-card-header">
              <span class="test-type">Driving Exam</span>
              <span class="badge badge-${testObj.result == 'Pass' ? 'completed' : 'cancelled'}">
                <span class="badge-dot"></span>
                <c:out value="${testObj.result}" />
              </span>
            </div>
            <div class="test-card-title">Road Test Session</div>
            <div class="test-date"><c:out value="${testObj.testDate}" /></div>
            <div class="progress-bar-wrap">
              <div class="progress-bar" style="width:${testObj.result == 'Pass' ? '100%' : '20%'}"></div>
            </div>
          </div>
        </c:forEach>
        <c:if test="${empty listTests}">
          <div class="empty-state" style="grid-column: span 2;">
            <div class="empty-icon">🏁</div>
            <div class="empty-text">No driving tests scheduled yet.</div>
          </div>
        </c:if>
      </div>
    </div>
  </main>
</div>

<script>
  function switchTab(name, el) {
    document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
    document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'));
    el.classList.add('active');
    document.getElementById('panel-' + name).classList.add('active');
  }
</script>
</body>
</html>
