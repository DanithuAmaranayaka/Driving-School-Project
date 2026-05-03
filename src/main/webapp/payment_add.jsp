<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%  if(session.getAttribute("adminUser")==null){response.sendRedirect("admin_login.jsp");return;} %>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
<title><c:if test="${payment != null}">Edit Payment</c:if><c:if test="${payment == null}">Record Payment</c:if> — DriveEase</title>
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
  .page-wrap{width:100%;max-width:620px;padding:48px 20px 80px;margin:0 auto}
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
  .amount-wrap{display:flex;align-items:center;background:var(--surface2);border:1px solid var(--border);border-radius:9px;overflow:hidden;transition:border-color 0.2s}
  .amount-wrap:focus-within{border-color:rgba(212,160,23,0.5);box-shadow:0 0 0 3px rgba(212,160,23,0.08)}
  .amount-prefix{padding:11px 14px;color:var(--gold-light);font-weight:600;background:rgba(212,160,23,0.08);border-right:1px solid var(--border)}
  .amount-wrap input{flex:1;padding:11px 14px;background:transparent;border:none;color:var(--text);font-family:'DM Sans',sans-serif;font-size:0.9rem;outline:none}
  .form-footer{display:flex;justify-content:flex-end;gap:10px;margin-top:28px;padding-top:24px;border-top:1px solid var(--border)}
  .btn{display:inline-flex;align-items:center;gap:7px;padding:10px 22px;border-radius:9px;font-family:'DM Sans',sans-serif;font-size:0.84rem;font-weight:500;cursor:pointer;transition:all 0.2s;text-decoration:none;border:none}
  .btn-cancel{background:transparent;border:1px solid var(--border);color:var(--muted2)}.btn-cancel:hover{border-color:var(--red);color:var(--red)}
  .btn-save{background:var(--gold);color:#0d0d0d;font-weight:600}.btn-save:hover{background:var(--gold-light)}
</style>
</head><body>
<div class="topbar">
  <a href="AdminServlet?action=dashboard" class="topbar-brand">Drive<span>Ease</span> <span style="color:var(--muted);font-family:'DM Sans',sans-serif;font-size:0.75rem;font-style:normal;margin-left:8px">Admin</span></a>
  <a href="PaymentServlet?action=list" class="btn-back">← Manage Payments</a>
</div>
<div class="page-wrap">
  <div class="form-card">
    <div class="form-card-header">
      <div class="form-title">
        <c:if test="${payment != null}">Edit Payment <em>Record</em></c:if>
        <c:if test="${payment == null}">Record New <em>Payment</em></c:if>
      </div>
    </div>
    <div class="form-body">
      <c:if test="${payment != null}"><form action="PaymentServlet?action=update" method="post"></c:if>
      <c:if test="${payment == null}"><form action="PaymentServlet?action=insert" method="post"></c:if>
        <c:if test="${payment != null}"><input type="hidden" name="id" value="<c:out value='${payment.paymentId}'/>" /></c:if>
        <div class="form-group">
          <label class="form-label">Student</label>
          <select class="form-select" name="studentId" required>
            <option value="">— Choose Student —</option>
            <c:forEach var="stu" items="${students}">
              <option value="${stu.studentId}" <c:if test="${payment.studentId==stu.studentId}">selected</c:if>>${stu.name} (NIC: ${stu.nic})</option>
            </c:forEach>
          </select>
        </div>
        <div class="form-row">
          <div>
            <label class="form-label">Course Type</label>
            <select class="form-select" name="courseType" required>
              <option value="Initial Registration" <c:if test="${payment.courseType=='Initial Registration'}">selected</c:if>>Initial Registration</option>
              <option value="Full Course" <c:if test="${payment.courseType=='Full Course'}">selected</c:if>>Full Course Package</option>
              <option value="Extra Lessons" <c:if test="${payment.courseType=='Extra Lessons'}">selected</c:if>>Extra Lessons Bundle</option>
              <option value="Test Fee" <c:if test="${payment.courseType=='Test Fee'}">selected</c:if>>Driving Test Fee</option>
            </select>
          </div>
          <div>
            <label class="form-label">Amount ($)</label>
            <div class="amount-wrap">
              <span class="amount-prefix">$</span>
              <input type="number" step="0.01" min="0" name="amount" value="<c:out value='${payment.amount}'/>" placeholder="0.00" required>
            </div>
          </div>
        </div>
        <div class="form-row">
          <div>
            <label class="form-label">Payment Date</label>
            <input type="date" class="form-control" name="paymentDate" value="<c:out value='${payment.paymentDate}'/>" required>
          </div>
          <div>
            <label class="form-label">Payment Method</label>
            <select class="form-select" name="paymentMethod" required>
              <option value="Cash" <c:if test="${payment.paymentMethod=='Cash'}">selected</c:if>>💵 Cash</option>
              <option value="Credit Card" <c:if test="${payment.paymentMethod=='Credit Card'}">selected</c:if>>💳 Credit Card</option>
              <option value="Bank Transfer" <c:if test="${payment.paymentMethod=='Bank Transfer'}">selected</c:if>>🏦 Bank Transfer</option>
            </select>
          </div>
        </div>
        <div class="form-footer">
          <a href="PaymentServlet?action=list" class="btn btn-cancel">Cancel</a>
          <button type="submit" class="btn btn-save">Save Payment</button>
        </div>
      </form>
    </div>
  </div>
</div>
</body></html>
