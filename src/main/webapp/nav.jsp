<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%
  String currentPage = (String) request.getAttribute("currentPage");
  if (currentPage == null) currentPage = "";
%>
<nav class="topbar">
  <a href="index.jsp" class="topbar-brand"><span>College</span>Fee</a>
  <div class="nav-links">
    <a href="index.jsp"                 class="<%= currentPage.equals("home")    ? "active" : "" %>">Home</a>
    <a href="AddFeePaymentServlet"      class="<%= currentPage.equals("add")     ? "active" : "" %>">Add Payment</a>
    <a href="UpdateFeePaymentServlet"   class="<%= currentPage.equals("update")  ? "active" : "" %>">Update</a>
    <a href="DeleteFeePaymentServlet"   class="<%= currentPage.equals("delete")  ? "active" : "" %>">Delete</a>
    <a href="DisplayFeePaymentsServlet" class="<%= currentPage.equals("display") ? "active" : "" %>">All Records</a>
    <a href="ReportCriteriaServlet"     class="<%= currentPage.equals("report")  ? "active" : "" %>">Reports</a>
  </div>
</nav>
