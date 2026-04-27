package com.servlet;

import com.dao.FeePaymentDAO;
import com.model.FeePayment;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;

@WebServlet("/AddFeePaymentServlet")
public class AddFeePaymentServle extends HttpServlet {

    private final FeePaymentDAO dao = new FeePaymentDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String studentIDStr  = req.getParameter("studentID") == null ? "" : req.getParameter("studentID").trim();
        String studentName   = req.getParameter("studentName") == null ? "" : req.getParameter("studentName").trim();
        String paymentDateStr= req.getParameter("paymentDate") == null ? "" : req.getParameter("paymentDate").trim();
        String amountStr     = req.getParameter("amount") == null ? "" : req.getParameter("amount").trim();
        String status        = req.getParameter("status") == null ? "" : req.getParameter("status").trim();

        StringBuilder err = new StringBuilder();

        int studentID = 0;
        try { studentID = Integer.parseInt(studentIDStr); if(studentID<=0) throw new NumberFormatException(); }
        catch(NumberFormatException e){ err.append("• Student ID must be a positive integer.<br>"); }

        if(studentName.isEmpty()) err.append("• Student Name is required.<br>");

        Date paymentDate = null;
        try { paymentDate = Date.valueOf(paymentDateStr); }
        catch(Exception e){ err.append("• Payment Date is required and must be YYYY-MM-DD.<br>"); }

        BigDecimal amount = null;
        try { amount = new BigDecimal(amountStr); if(amount.compareTo(BigDecimal.ZERO)<=0) throw new Exception(); }
        catch(Exception e){ err.append("• Amount must be a positive number.<br>"); }

        if(!status.equals("Paid") && !status.equals("Overdue") && !status.equals("Pending"))
            err.append("• Status must be Paid, Overdue, or Pending.<br>");

        if(err.length() > 0){
            req.setAttribute("error", err.toString());
            req.getRequestDispatcher("feepaymentadd.jsp").forward(req, resp);
            return;
        }

        try {
            FeePayment fp = new FeePayment(0, studentID, studentName, paymentDate, amount, status);
            boolean ok = dao.addFeePayment(fp);
            req.setAttribute("message", ok ? "Payment recorded successfully!" : "Insert failed.");
        } catch(Exception e){
            req.setAttribute("message", "Database error: " + e.getMessage());
        }

        req.getRequestDispatcher("feepaymentadd.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("feepaymentadd.jsp").forward(req, resp);
    }
}