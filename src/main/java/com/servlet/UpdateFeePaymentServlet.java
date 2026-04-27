package com.servlet;

import com.dao.FeePaymentDAO;
import com.model.FeePayment;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;

@WebServlet("/UpdateFeePaymentServlet")
public class UpdateFeePaymentServlet extends HttpServlet {

    private final FeePaymentDAO dao = new FeePaymentDAO();

    /* GET – load record for editing */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String pidStr = req.getParameter("paymentID");
        if (pidStr == null || pidStr.trim().isEmpty()) {
            req.getRequestDispatcher("feepaymentupdate.jsp").forward(req, resp);
            return;
        }
        try {
            int pid = Integer.parseInt(pidStr.trim());
            FeePayment fp = dao.getPaymentByID(pid);
            if (fp == null) {
                req.setAttribute("error", "No record found for Payment ID: " + pid);
            } else {
                req.setAttribute("fp", fp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Error: " + e.getMessage());
        }
        req.getRequestDispatcher("feepaymentupdate.jsp").forward(req, resp);
    }

    /* POST – save changes */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String pidStr        = req.getParameter("paymentID")   == null ? "" : req.getParameter("paymentID").trim();
        String studentIDStr  = req.getParameter("studentID")   == null ? "" : req.getParameter("studentID").trim();
        String studentName   = req.getParameter("studentName") == null ? "" : req.getParameter("studentName").trim();
        String paymentDateStr= req.getParameter("paymentDate") == null ? "" : req.getParameter("paymentDate").trim();
        String amountStr     = req.getParameter("amount")      == null ? "" : req.getParameter("amount").trim();
        String status        = req.getParameter("status")      == null ? "" : req.getParameter("status").trim();

        StringBuilder err = new StringBuilder();

        int pid = 0;
        try { pid = Integer.parseInt(pidStr); if(pid<=0) throw new NumberFormatException(); }
        catch(NumberFormatException e){ err.append("• Payment ID is invalid.<br>"); }

        int studentID = 0;
        try { studentID = Integer.parseInt(studentIDStr); if(studentID<=0) throw new NumberFormatException(); }
        catch(NumberFormatException e){ err.append("• Student ID must be a positive integer.<br>"); }

        if(studentName.isEmpty()) err.append("• Student Name is required.<br>");

        Date paymentDate = null;
        try { paymentDate = Date.valueOf(paymentDateStr); }
        catch(Exception e){ err.append("• Payment Date is required (YYYY-MM-DD).<br>"); }

        BigDecimal amount = null;
        try { amount = new BigDecimal(amountStr); if(amount.compareTo(BigDecimal.ZERO)<=0) throw new Exception(); }
        catch(Exception e){ err.append("• Amount must be a positive number.<br>"); }

        if(!status.equals("Paid") && !status.equals("Overdue") && !status.equals("Pending"))
            err.append("• Status must be Paid, Overdue, or Pending.<br>");

        FeePayment fp = new FeePayment(pid, studentID, studentName, paymentDate, amount, status);
        req.setAttribute("fp", fp);

        if(err.length() > 0){
            req.setAttribute("error", err.toString());
            req.getRequestDispatcher("feepaymentupdate.jsp").forward(req, resp);
            return;
        }

        try {
            boolean ok = dao.updateFeePayment(fp);
            req.setAttribute("message", ok ? "Payment updated successfully!" : "Update failed. Record not found.");
            req.setAttribute("msgType", ok ? "success" : "error");
        } catch(Exception e){
            req.setAttribute("message", "Database error: " + e.getMessage());
            req.setAttribute("msgType", "error");
        }
        req.getRequestDispatcher("feepaymentupdate.jsp").forward(req, resp);
    }
}