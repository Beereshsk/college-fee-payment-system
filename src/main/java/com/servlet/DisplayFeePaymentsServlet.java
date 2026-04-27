package com.servlet;

import com.dao.FeePaymentDAO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/DisplayFeePaymentsServlet")
public class DisplayFeePaymentsServlet extends HttpServlet {

    private FeePaymentDAO dao = new FeePaymentDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            req.setAttribute("payments", dao.getAllPayments());
        } catch (Exception e) {
            req.setAttribute("error", "Failed to load records");
        }
        req.getRequestDispatcher("feepaymentdisplay.jsp").forward(req, resp);
    }
}