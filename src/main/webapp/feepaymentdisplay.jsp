<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.FeePayment, java.util.List, java.math.BigDecimal" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>All Fee Payments - CollegeFee</title>
  <%@ include file="header.jsp" %>
  <style>
    .search-bar { display:flex; gap:1rem; margin-bottom:1.5rem; flex-wrap:wrap; }
    .search-bar input { flex:1; min-width:200px; }
    #noDataRow { display:none; }
  </style>
</head>
<body>
<% request.setAttribute("currentPage","display"); %>
<%@ include file="nav.jsp" %>

<div class="page-wrap">

  <div class="page-header">
    <div class="badge-gold">Records</div>
    <h1> All Fee Payment Records</h1>
    <p>Complete list of all student fee transactions.</p>
  </div>

  <%
    String error = (String) request.getAttribute("error");
    List<FeePayment> payments = (List<FeePayment>) request.getAttribute("payments");
    int total = payments != null ? payments.size() : 0;

    int paid=0, overdue=0, pending=0;
    BigDecimal totalAmt = BigDecimal.ZERO;
    if (payments != null) {
      for (FeePayment p : payments) {
        if ("Paid".equals(p.getStatus())) { paid++; totalAmt = totalAmt.add(p.getAmount()); }
        else if ("Overdue".equals(p.getStatus())) overdue++;
        else pending++;
      }
    }
  %>

  <% if (error != null) { %>
    <div class="alert alert-error"> <%= error %></div>
  <% } %>

  <%-- Stats row --%>
  <div class="stats-row">
    <div class="stat-card">
      <div class="stat-val"><%= total %></div>
      <div class="stat-lbl">Total Records</div>
    </div>
    <div class="stat-card">
      <div class="stat-val" style="color:var(--green)"><%= paid %></div>
      <div class="stat-lbl">Paid</div>
    </div>
    <div class="stat-card">
      <div class="stat-val" style="color:var(--red)"><%= overdue %></div>
      <div class="stat-lbl">Overdue</div>
    </div>
    <div class="stat-card">
      <div class="stat-val" style="color:var(--orange)"><%= pending %></div>
      <div class="stat-lbl">Pending</div>
    </div>
    <div class="stat-card">
      <div class="stat-val" style="font-size:1.4rem;color:var(--navy)">Rs.<%= totalAmt.toPlainString() %></div>
      <div class="stat-lbl">Total Collected</div>
    </div>
  </div>

  <%-- Search bar --%>
  <div class="search-bar">
    <input type="text" id="searchInput" class="form-control"
           placeholder=" Filter by name, ID, status..." oninput="filterTable()"/>
    <a href="AddFeePaymentServlet" class="btn btn-gold"> Add New</a>
  </div>

  <div class="card">
    <div class="table-wrap">
      <table id="paymentsTable">
        <thead>
          <tr>
            <th>Pay ID</th>
            <th>Stu ID</th>
            <th>Student Name</th>
            <th>Payment Date</th>
            <th>Amount (Rs.)</th>
            <th>Status</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <% if (payments != null && !payments.isEmpty()) {
               for (FeePayment p : payments) {
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
            <td>
              <a href="UpdateFeePaymentServlet?paymentID=<%= p.getPaymentID() %>" class="btn btn-outline btn-sm"> Edit</a>
              <a href="DeleteFeePaymentServlet?paymentID=<%= p.getPaymentID() %>" class="btn btn-danger btn-sm"
                 onclick="return confirm('Delete payment #<%= p.getPaymentID() %>?')"></a>
            </td>
          </tr>
          <% }} else { %>
          <tr id="noDataRow"><td colspan="7" style="text-align:center;padding:2rem;color:var(--muted);">No payment records found.</td></tr>
          <% } %>
          <tr id="filterEmpty" style="display:none;">
            <td colspan="7" style="text-align:center;padding:2rem;color:var(--muted);">No matching records.</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>

</div>
<footer class="site-footer"> 2025 College Fee Payment System</footer>

<script>
function filterTable() {
  const q = document.getElementById('searchInput').value.toLowerCase();
  const rows = document.querySelectorAll('#paymentsTable tbody tr:not(#filterEmpty)');
  let visible = 0;
  rows.forEach(r => {
    const match = r.innerText.toLowerCase().includes(q);
    r.style.display = match ? '' : 'none';
    if (match) visible++;
  });
  document.getElementById('filterEmpty').style.display = visible === 0 ? '' : 'none';
}
</script>
</body>
</html>
