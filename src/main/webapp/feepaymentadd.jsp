<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Add Fee Payment - CollegeFee</title>
  <%@ include file="header.jsp" %>
</head>
<body>
<% request.setAttribute("currentPage","add"); %>
<%@ include file="nav.jsp" %>

<div class="page-wrap">

  <div class="page-header">
    <div class="badge-gold">Fee Management</div>
    <h1> Add New Payment</h1>
    <p>Record a new student fee payment entry into the system.</p>
  </div>

  <%-- Success / Error messages --%>
  <%
    String msgType = (String) request.getAttribute("msgType");
    String message = (String) request.getAttribute("message");
    String error   = (String) request.getAttribute("error");
  %>
  <% if (message != null) { %>
    <div class="alert alert-<%= msgType %>">
      <%= "success".equals(msgType) ? "" : "" %> <%= message %>
    </div>
  <% } %>
  <% if (error != null) { %>
    <div class="alert alert-error"> <span><%= error %></span></div>
  <% } %>

  <div class="card">
    <div class="card-body">
      <form action="AddFeePaymentServlet" method="post" novalidate>
        <div class="form-grid">

          <div class="form-group">
            <label>Student ID <span class="req">*</span></label>
            <input type="number" name="studentID" class="form-control" min="1"
                   placeholder="e.g. 1001"
                   value="<%= request.getAttribute("studentID") != null ? request.getAttribute("studentID") : "" %>"
                   required/>
          </div>

          <div class="form-group">
            <label>Student Name <span class="req">*</span></label>
            <input type="text" name="studentName" class="form-control" maxlength="100"
                   placeholder="Full name"
                   value="<%= request.getAttribute("studentName") != null ? request.getAttribute("studentName") : "" %>"
                   required/>
          </div>

          <div class="form-group">
            <label>Payment Date <span class="req">*</span></label>
            <input type="date" name="paymentDate" class="form-control"
                   value="<%= request.getAttribute("paymentDate") != null ? request.getAttribute("paymentDate") : "" %>"
                   required/>
          </div>

          <div class="form-group">
            <label>Amount (Rs.) <span class="req">*</span></label>
            <input type="number" name="amount" class="form-control" step="0.01" min="0.01"
                   placeholder="e.g. 15000.00"
                   value="<%= request.getAttribute("amount") != null ? request.getAttribute("amount") : "" %>"
                   required/>
          </div>

          <div class="form-group">
            <label>Payment Status <span class="req">*</span></label>
            <select name="status" class="form-control" required>
              <option value="">-- Select Status --</option>
              <% String selStatus = (String) request.getAttribute("status"); %>
              <option value="Paid"    <%= "Paid".equals(selStatus)    ? "selected" : "" %>> Paid</option>
              <option value="Overdue" <%= "Overdue".equals(selStatus) ? "selected" : "" %>> Overdue</option>
              <option value="Pending" <%= "Pending".equals(selStatus) ? "selected" : "" %>> Pending</option>
            </select>
          </div>

        </div>

        <div class="divider"></div>
        <div class="btn-row">
          <button type="submit" class="btn btn-gold"> Save Payment</button>
          <button type="reset"  class="btn btn-outline">Reset Reset</button>
          <a href="index.jsp"   class="btn btn-outline">&lt;- Back</a>
        </div>
      </form>
    </div>
  </div>

</div>
<footer class="site-footer"> 2025 College Fee Payment System</footer>
</body>
</html>
