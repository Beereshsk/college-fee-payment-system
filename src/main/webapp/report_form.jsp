<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Generate Reports - CollegeFee</title>
  <%@ include file="header.jsp" %>
  <style>
    .report-cards { display:grid; grid-template-columns:repeat(auto-fit,minmax(280px,1fr)); gap:1.5rem; margin-top:1.5rem; }
    .rcard {
      background:var(--white);
      border:2px solid var(--border);
      border-radius:var(--radius);
      padding:1.75rem;
      transition:border-color .2s, box-shadow .2s;
    }
    .rcard:hover { border-color:var(--gold); box-shadow:0 8px 24px rgba(201,168,76,.12); }
    .rcard .rcard-icon { font-size:2rem; margin-bottom:.75rem; }
    .rcard h3 { font-size:1rem; font-weight:700; color:var(--navy); margin-bottom:.4rem; }
    .rcard p  { font-size:.82rem; color:var(--muted); line-height:1.6; margin-bottom:1rem; }
    .date-row { display:grid; grid-template-columns:1fr 1fr; gap:1rem; margin-bottom:1rem; }
  </style>
</head>
<body>
<% request.setAttribute("currentPage","report"); %>
<%@ include file="nav.jsp" %>

<div class="page-wrap">

  <div class="page-header">
    <div class="badge-gold">Analytics</div>
    <h1> Fee Reports</h1>
    <p>Generate insights on overdue payments, unpaid students, and total fee collection.</p>
  </div>

  <%
    String error = (String) request.getAttribute("error");
  %>
  <% if (error != null) { %>
    <div class="alert alert-error"> <span><%= error %></span></div>
  <% } %>

  <div class="report-cards">

    <!-- Report 1: Overdue -->
    <div class="rcard">
      <div class="rcard-icon"></div>
      <h3>Overdue Payments</h3>
      <p>List all students whose payment status is marked as <em>Overdue</em>.</p>
      <form action="ReportServlet" method="post">
        <input type="hidden" name="reportType" value="overdue"/>
        <button type="submit" class="btn btn-danger" style="width:100%;">Generate Report -&gt;</button>
      </form>
    </div>

    <!-- Report 2: Unpaid in period -->
    <div class="rcard">
      <div class="rcard-icon"></div>
      <h3>Unpaid / Pending in Period</h3>
      <p>Find students who have <em>not paid</em> (Pending/Overdue) within a specified date range.</p>
      <form action="ReportServlet" method="post">
        <input type="hidden" name="reportType" value="unpaid"/>
        <div class="date-row">
          <div class="form-group">
            <label>From <span class="req">*</span></label>
            <input type="date" name="startDate" class="form-control" required/>
          </div>
          <div class="form-group">
            <label>To <span class="req">*</span></label>
            <input type="date" name="endDate" class="form-control" required/>
          </div>
        </div>
        <button type="submit" class="btn btn-gold" style="width:100%;">Generate Report -&gt;</button>
      </form>
    </div>

    <!-- Report 3: Total collection -->
    <div class="rcard">
      <div class="rcard-icon"></div>
      <h3>Total Fee Collection</h3>
      <p>Calculate the <em>total amount collected</em> (Paid status) over a date range.</p>
      <form action="ReportServlet" method="post">
        <input type="hidden" name="reportType" value="collection"/>
        <div class="date-row">
          <div class="form-group">
            <label>From <span class="req">*</span></label>
            <input type="date" name="startDate" class="form-control" required/>
          </div>
          <div class="form-group">
            <label>To <span class="req">*</span></label>
            <input type="date" name="endDate" class="form-control" required/>
          </div>
        </div>
        <button type="submit" class="btn btn-primary" style="width:100%;">Generate Report -&gt;</button>
      </form>
    </div>

  </div>
</div>
<footer class="site-footer"> 2025 College Fee Payment System</footer>
</body>
</html>
