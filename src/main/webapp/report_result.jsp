<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.FeePayment, java.util.List, java.math.BigDecimal" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Report Results - CollegeFee</title>
  <%@ include file="header.jsp" %>
  <style>
    .report-meta {
      background: var(--navy);
      color: var(--white);
      border-radius: var(--radius);
      padding: 1.25rem 2rem;
      display: flex;
      align-items: center;
      justify-content: space-between;
      flex-wrap: wrap;
      gap: 1rem;
      margin-bottom: 1.5rem;
    }
    .report-meta h2 { font-family:'Playfair Display',serif; font-size:1.2rem; font-weight:700; }
    .report-meta span { font-size:.85rem; color:rgba(255,255,255,.6); }
    .total-banner {
      background: linear-gradient(135deg,#1a5c37,#2da55e);
      color: var(--white);
      border-radius: var(--radius);
      padding: 1.5rem 2rem;
      margin-bottom: 1.5rem;
      display: flex;
      align-items: center;
      gap: 1.5rem;
    }
    .total-banner .tb-icon { font-size: 2.5rem; }
    .total-banner .tb-val {
      font-family: 'Playfair Display', serif;
      font-size: 2.2rem;
      font-weight: 700;
    }
    .total-banner .tb-lbl { font-size: .85rem; opacity: .8; margin-top: .2rem; }
    .no-data {
      text-align:center;
      padding:3rem;
      color:var(--muted);
    }
    .no-data .nd-icon { font-size:3rem; display:block; margin-bottom:1rem; }
  </style>
</head>
<body>
<% request.setAttribute("currentPage","report"); %>
<%@ include file="nav.jsp" %>

<div class="page-wrap">

  <%
    String reportTitle = (String) request.getAttribute("reportTitle");
    String reportType  = (String) request.getAttribute("reportType");
    String startDate   = (String) request.getAttribute("startDate");
    String endDate     = (String) request.getAttribute("endDate");
    BigDecimal totalCollection = (BigDecimal) request.getAttribute("totalCollection");
    List<FeePayment> reportData = (List<FeePayment>) request.getAttribute("reportData");
    int count = (reportData != null) ? reportData.size() : 0;
  %>

  <div class="page-header">
    <div class="badge-gold">Report Result</div>
    <h1> <%= reportTitle != null ? reportTitle : "Report" %></h1>
    <% if (startDate != null) { %>
      <p>Date range: <strong style="color:var(--gold-lt)"><%= startDate %></strong> to <strong style="color:var(--gold-lt)"><%= endDate %></strong></p>
    <% } %>
  </div>

  <%-- Total collection banner (only for collection report) --%>
  <% if ("collection".equals(reportType) && totalCollection != null) { %>
  <div class="total-banner">
    <span class="tb-icon"></span>
    <div>
      <div class="tb-val">Rs. <%= totalCollection.toPlainString() %></div>
      <div class="tb-lbl">Total Fee Collected   <%= count %> paid record<%= count!=1?"s":"" %></div>
    </div>
  </div>
  <% } %>

  <%-- Count summary --%>
  <div class="report-meta">
    <h2><%= reportTitle %></h2>
    <span><%= count %> record<%= count!=1?"s":"" %> found</span>
  </div>

  <% if (count > 0) { %>
  <div class="card">
    <div class="table-wrap">
      <table>
        <thead>
          <tr>
            <th>Pay ID</th>
            <th>Stu ID</th>
            <th>Student Name</th>
            <th>Payment Date</th>
            <th>Amount (Rs.)</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          <%
            for (FeePayment p : reportData) {
              String sBadge = "Paid".equals(p.getStatus()) ? "badge-paid"
                            : "Overdue".equals(p.getStatus()) ? "badge-overdue" : "badge-pending";
          %>
          <tr>
            <td><strong>#<%= p.getPaymentID() %></strong></td>
            <td><%= p.getStudentID() %></td>
            <td><%= p.getStudentName() %></td>
            <td><%= p.getPaymentDate() %></td>
            <td><strong>Rs.<%= p.getAmount() %></strong></td>
            <td><span class="badge <%= sBadge %>"><%= p.getStatus() %></span></td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </div>
  </div>
  <% } else { %>
  <div class="card">
    <div class="no-data">
      <span class="nd-icon"></span>
      <p>No records found for the selected criteria.</p>
    </div>
  </div>
  <% } %>

  <div class="btn-row" style="margin-top:1.5rem;">
    <a href="ReportCriteriaServlet" class="btn btn-gold">&lt;- Generate Another Report</a>
    <a href="index.jsp"             class="btn btn-outline"> Home</a>
  </div>

</div>
<footer class="site-footer"> 2025 College Fee Payment System</footer>
</body>
</html>
