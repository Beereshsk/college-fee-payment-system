package com.servlet;

import com.dao.FeePaymentDAO;

import com.model.FeePayment;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeleteFeePaymentServlet")
public class DeleteFeePaymentServlet extends HttpServlet {

    private final FeePaymentDAO dao = new FeePaymentDAO();

    /* GET – load record to confirm deletion */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String pidStr = req.getParameter("paymentID");
        if (pidStr != null && !pidStr.trim().isEmpty()) {
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
        }
        req.getRequestDispatcher("feepaymentdelete.jsp").forward(req, resp);
    }

    /* POST – perform deletion */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String pidStr = req.getParameter("paymentID");
        if (pidStr == null || pidStr.trim().isEmpty()) {
            req.setAttribute("error", "Payment ID is required.");
            req.getRequestDispatcher("feepaymentdelete.jsp").forward(req, resp);
            return;
        }

        int pid;
        try {
            pid = Integer.parseInt(pidStr.trim());
            if (pid <= 0) throw new NumberFormatException();
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Payment ID must be a positive integer.");
            req.getRequestDispatcher("feepaymentdelete.jsp").forward(req, resp);
            return;
        }

        try {
            boolean ok = dao.deleteFeePayment(pid);
            req.setAttribute("message", ok ? "Payment record deleted successfully!" : "No record found with ID: " + pid);
            req.setAttribute("msgType", ok ? "success" : "error");
        } catch (Exception e) {
            req.setAttribute("message", "Database error: " + e.getMessage());
            req.setAttribute("msgType", "error");
        }
        req.getRequestDispatcher("feepaymentdelete.jsp").forward(req, resp);
    }
}