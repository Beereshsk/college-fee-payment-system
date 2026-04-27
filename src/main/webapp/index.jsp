<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>College Fee Payment System</title>
  <%@ include file="header.jsp" %>
  <style>
    .hero {
      background: linear-gradient(135deg, var(--navy) 0%, #1e3a6e 60%, #2a4a8a 100%);
      border-radius: var(--radius);
      padding: 3rem 3rem 2.5rem;
      margin-bottom: 2.5rem;
      position: relative;
      overflow: hidden;
      color: var(--white);
    }
    .hero::before {
      content: 'Rs.';
      position: absolute;
      right: 2rem; top: 50%;
      transform: translateY(-50%);
      font-size: 12rem;
      color: rgba(201,168,76,.07);
      font-family: 'Playfair Display', serif;
      line-height: 1;
    }
    .hero-badge {
      display: inline-block;
      background: rgba(201,168,76,.2);
      color: var(--gold-lt);
      border: 1px solid rgba(201,168,76,.4);
      padding: .3rem 1rem;
      border-radius: 20px;
      font-size: .75rem;
      font-weight: 600;
      letter-spacing: .08em;
      text-transform: uppercase;
      margin-bottom: 1rem;
    }
    .hero h1 {
      font-family: 'Playfair Display', serif;
      font-size: 2.6rem;
      font-weight: 700;
      line-height: 1.15;
      margin-bottom: .75rem;
    }
    .hero h1 span { color: var(--gold-lt); }
    .hero p { color: rgba(255,255,255,.65); font-size: 1rem; max-width: 550px; line-height: 1.7; }

    .module-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
      gap: 1.25rem;
      margin-top: 2rem;
    }
    .module-card {
      background: var(--white);
      border: 1px solid var(--border);
      border-radius: var(--radius);
      padding: 1.75rem 1.5rem;
      text-decoration: none;
      color: var(--text);
      transition: transform .2s, box-shadow .2s, border-color .2s;
      display: flex;
      flex-direction: column;
      gap: .5rem;
    }
    .module-card:hover {
      transform: translateY(-4px);
      box-shadow: 0 12px 32px rgba(10,22,40,.12);
      border-color: var(--gold);
    }
    .module-card .mc-icon {
      width: 48px; height: 48px;
      border-radius: 12px;
      display: flex; align-items: center; justify-content: center;
      font-size: 1.5rem;
      margin-bottom: .5rem;
    }
    .mc-add    { background: #e8f5ee; }
    .mc-update { background: #eef3ff; }
    .mc-delete { background: #fff0f0; }
    .mc-view   { background: #fffbe8; }
    .mc-report { background: #f3eeff; }

    .module-card h3 { font-size: 1rem; font-weight: 600; color: var(--navy); }
    .module-card p  { font-size: .82rem; color: var(--muted); line-height: 1.5; }
    .module-card .mc-arrow { margin-top: auto; color: var(--gold); font-size: 1.2rem; }

    .section-title {
      font-family: 'Playfair Display', serif;
      font-size: 1.3rem;
      color: var(--navy);
      margin-bottom: 1rem;
      display: flex;
      align-items: center;
      gap: .6rem;
    }
    .section-title::after {
      content: '';
      flex: 1;
      height: 1px;
      background: var(--border);
    }
  </style>
</head>
<body>
<% request.setAttribute("currentPage","home"); %>
<%@ include file="nav.jsp" %>

<div class="page-wrap">

  <div class="hero">
    <div class="hero-badge">Academic Finance Management</div>
    <h1>College <span>Fee Payment</span><br/>System</h1>
    <p>Manage student fee records, track overdue payments, and generate detailed financial reports - all from one unified dashboard.</p>
    <div style="margin-top:1.5rem;display:flex;gap:1rem;flex-wrap:wrap;">
      <a href="AddFeePaymentServlet"      class="btn btn-gold"> Record Payment</a>
      <a href="DisplayFeePaymentsServlet" class="btn btn-outline" style="color:var(--white);border-color:rgba(255,255,255,.35);"> View All Records</a>
    </div>
  </div>

  <p class="section-title"> Modules</p>
  <div class="module-grid">
    <a href="AddFeePaymentServlet" class="module-card">
      <div class="mc-icon mc-add"></div>
      <h3>Add Payment</h3>
      <p>Record new student fee payment entries with all required details.</p>
      <span class="mc-arrow">-&gt;</span>
    </a>
    <a href="UpdateFeePaymentServlet" class="module-card">
      <div class="mc-icon mc-update"></div>
      <h3>Update Payment</h3>
      <p>Modify existing payment details such as amount, date, or status.</p>
      <span class="mc-arrow">-&gt;</span>
    </a>
    <a href="DeleteFeePaymentServlet" class="module-card">
      <div class="mc-icon mc-delete"></div>
      <h3>Delete Payment</h3>
      <p>Remove payment records from the system with confirmation.</p>
      <span class="mc-arrow">-&gt;</span>
    </a>
    <a href="DisplayFeePaymentsServlet" class="module-card">
      <div class="mc-icon mc-view"></div>
      <h3>View All Records</h3>
      <p>Browse the complete list of all fee payment transactions.</p>
      <span class="mc-arrow">-&gt;</span>
    </a>
    <a href="ReportCriteriaServlet" class="module-card">
      <div class="mc-icon mc-report"></div>
      <h3>Reports</h3>
      <p>Generate overdue, unpaid, and total collection reports by date.</p>
      <span class="mc-arrow">-&gt;</span>
    </a>
  </div>

</div>

<footer class="site-footer">
   2025 College Fee Payment System &nbsp;|&nbsp; Built with Java EE + JSP + MySQL
</footer>
</body>
</html>
