<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.FeePayment" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Update Payment - CollegeFee</title>
  <%@ include file="header.jsp" %>
</head>
<body>
<% request.setAttribute("currentPage","update"); %>
<%@ include file="nav.jsp" %>

<div class="page-wrap">

  <div class="page-header">
    <div class="badge-gold">Fee Management</div>
    <h1> Update Payment</h1>
    <p>Search by Payment ID, then modify the details as needed.</p>
  </div>

  <%-- Messages --%>
  <%
    String msgType = (String) request.getAttribute("msgType");
    String message = (String) request.getAttribute("message");
    String error   = (String) request.getAttribute("error");
    FeePayment fp  = (FeePayment) request.getAttribute("fp");
  %>
  <% if (message != null) { %>
    <div class="alert alert-<%= msgType %>"><%= "success".equals(msgType)?"":"" %> <%= message %></div>
  <% } %>
  <% if (error != null) { %>
    <div class="alert alert-error"> <span><%= error %></span></div>
  <% } %>

  <%-- Step 1: Search form --%>
  <div class="card" style="margin-bottom:1.5rem;">
    <div class="card-body">
      <p style="font-weight:600;margin-bottom:1rem;color:var(--navy3);"> Step 1 - Find Payment Record</p>
      <form action="UpdateFeePaymentServlet" method="get" style="display:flex;gap:1rem;align-items:flex-end;flex-wrap:wrap;">
        <div class="form-group" style="flex:1;min-width:200px;">
          <label>Payment ID <span class="req">*</span></label>
          <input type="number" name="paymentID" class="form-control" min="1" placeholder="Enter Payment ID" required/>
        </div>
        <button type="submit" class="btn btn-primary"> Search</button>
      </form>
    </div>
  </div>

  <%-- Step 2: Edit form (shown when record found) --%>
  <% if (fp != null) { %>
  <div class="card">
    <div class="card-body">
      <p style="font-weight:600;margin-bottom:1.5rem;color:var(--navy3);"> Step 2 - Edit Details</p>
      <form action="UpdateFeePaymentServlet" method="post" novalidate>
        <input type="hidden" name="paymentID" value="<%= fp.getPaymentID() %>"/>
        <div class="form-grid">

          <div class="form-group">
            <label>Payment ID</label>
            <input type="text" class="form-control" value="<%= fp.getPaymentID() %>" disabled style="background:#f0f2f8;color:var(--muted);"/>
          </div>

          <div class="form-group">
            <label>Student ID <span class="req">*</span></label>
            <input type="number" name="studentID" class="form-control" min="1"
                   value="<%= fp.getStudentID() %>" required/>
          </div>

          <div class="form-group">
            <label>Student Name <span class="req">*</span></label>
            <input type="text" name="studentName" class="form-control" maxlength="100"
                   value="<%= fp.getStudentName() %>" required/>
          </div>

          <div class="form-group">
            <label>Payment Date <span class="req">*</span></label>
            <input type="date" name="paymentDate" class="form-control"
                   value="<%= fp.getPaymentDate() %>" required/>
          </div>

          <div class="form-group">
            <label>Amount (Rs.) <span class="req">*</span></label>
            <input type="number" name="amount" class="form-control" step="0.01" min="0.01"
                   value="<%= fp.getAmount() %>" required/>
          </div>

          <div class="form-group">
            <label>Status <span class="req">*</span></label>
            <select name="status" class="form-control" required>
              <option value="Paid"    <%= "Paid".equals(fp.getStatus())    ? "selected" : "" %>> Paid</option>
              <option value="Overdue" <%= "Overdue".equals(fp.getStatus()) ? "selected" : "" %>> Overdue</option>
              <option value="Pending" <%= "Pending".equals(fp.getStatus()) ? "selected" : "" %>> Pending</option>
            </select>
          </div>

        </div>
        <div class="divider"></div>
        <div class="btn-row">
          <button type="submit" class="btn btn-gold"> Update Payment</button>
          <a href="UpdateFeePaymentServlet" class="btn btn-outline">Reset Search Again</a>
          <a href="index.jsp" class="btn btn-outline">&lt;- Back</a>
        </div>
      </form>
    </div>
  </div>
  <% } %>

</div>
<footer class="site-footer"> 2025 College Fee Payment System</footer>
</body>
</html>
