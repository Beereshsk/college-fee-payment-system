<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.FeePayment" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Delete Payment - CollegeFee</title>
  <%@ include file="header.jsp" %>
</head>
<body>
<% request.setAttribute("currentPage","delete"); %>
<%@ include file="nav.jsp" %>

<div class="page-wrap">

  <div class="page-header">
    <div class="badge-gold">Fee Management</div>
    <h1> Delete Payment</h1>
    <p>Search for a record by Payment ID, review it, then confirm deletion.</p>
  </div>

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

  <%-- Search --%>
  <div class="card" style="margin-bottom:1.5rem;">
    <div class="card-body">
      <p style="font-weight:600;margin-bottom:1rem;color:var(--navy3);"> Search Payment Record</p>
      <form action="DeleteFeePaymentServlet" method="get" style="display:flex;gap:1rem;align-items:flex-end;flex-wrap:wrap;">
        <div class="form-group" style="flex:1;min-width:200px;">
          <label>Payment ID <span class="req">*</span></label>
          <input type="number" name="paymentID" class="form-control" min="1" placeholder="Enter Payment ID" required/>
        </div>
        <button type="submit" class="btn btn-primary"> Search</button>
      </form>
    </div>
  </div>

  <%-- Confirmation --%>
  <% if (fp != null) { %>
  <div class="card">
    <div class="card-body">
      <div class="confirm-box">
        <h3> Confirm Deletion</h3>
        <p style="font-size:.88rem;color:var(--muted);margin-bottom:1rem;">
          This action is <strong>permanent</strong> and cannot be undone. Please review the record below before proceeding.
        </p>
        <table>
          <tr><td>Payment ID</td><td><strong>#<%= fp.getPaymentID() %></strong></td></tr>
          <tr><td>Student ID</td><td><%= fp.getStudentID() %></td></tr>
          <tr><td>Student Name</td><td><%= fp.getStudentName() %></td></tr>
          <tr><td>Payment Date</td><td><%= fp.getPaymentDate() %></td></tr>
          <tr><td>Amount</td><td>Rs.<%= fp.getAmount() %></td></tr>
          <tr><td>Status</td><td>
            <span class="badge badge-<%= fp.getStatus().toLowerCase() %>"><%= fp.getStatus() %></span>
          </td></tr>
        </table>
      </div>
      <form action="DeleteFeePaymentServlet" method="post">
        <input type="hidden" name="paymentID" value="<%= fp.getPaymentID() %>"/>
        <div class="btn-row">
          <button type="submit" class="btn btn-danger"> Yes, Delete This Record</button>
          <a href="DeleteFeePaymentServlet" class="btn btn-outline">Cancel</a>
          <a href="index.jsp"              class="btn btn-outline">&lt;- Home</a>
        </div>
      </form>
    </div>
  </div>
  <% } %>

</div>
<footer class="site-footer"> 2025 College Fee Payment System</footer>
</body>
</html>
