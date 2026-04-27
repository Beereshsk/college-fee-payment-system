package com.servlet;

import com.dao.FeePaymentDAO;
import com.model.FeePayment;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {

    private final FeePaymentDAO dao = new FeePaymentDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String reportType = req.getParameter("reportType");
        if (reportType == null) reportType = "";

        try {
            switch (reportType) {

                case "overdue": {
                    List<FeePayment> list = dao.getOverduePayments();
                    req.setAttribute("reportTitle", "Overdue Payments");
                    req.setAttribute("reportData", list);
                    req.setAttribute("reportType", "overdue");
                    break;
                }

                case "unpaid": {
                    String startStr = req.getParameter("startDate");
                    String endStr   = req.getParameter("endDate");
                    StringBuilder err = new StringBuilder();

                    Date start = null, end = null;
                    try { start = Date.valueOf(startStr); } catch(Exception e){ err.append("• Start Date is required (YYYY-MM-DD).<br>"); }
                    try { end   = Date.valueOf(endStr);   } catch(Exception e){ err.append("• End Date is required (YYYY-MM-DD).<br>"); }
                    if (start != null && end != null && start.after(end))
                        err.append("• Start Date must be before End Date.<br>");

                    if (err.length() > 0) {
                        req.setAttribute("error", err.toString());
                        req.getRequestDispatcher("report_form.jsp").forward(req, resp);
                        return;
                    }
                    List<FeePayment> list = dao.getUnpaidInPeriod(start, end);
                    req.setAttribute("reportTitle", "Unpaid / Pending Payments (" + startStr + " to " + endStr + ")");
                    req.setAttribute("reportData", list);
                    req.setAttribute("reportType", "unpaid");
                    req.setAttribute("startDate", startStr);
                    req.setAttribute("endDate", endStr);
                    break;
                }

                case "collection": {
                    String startStr = req.getParameter("startDate");
                    String endStr   = req.getParameter("endDate");
                    StringBuilder err = new StringBuilder();

                    Date start = null, end = null;
                    try { start = Date.valueOf(startStr); } catch(Exception e){ err.append("• Start Date is required (YYYY-MM-DD).<br>"); }
                    try { end   = Date.valueOf(endStr);   } catch(Exception e){ err.append("• End Date is required (YYYY-MM-DD).<br>"); }
                    if (start != null && end != null && start.after(end))
                        err.append("• Start Date must be before End Date.<br>");

                    if (err.length() > 0) {
                        req.setAttribute("error", err.toString());
                        req.getRequestDispatcher("report_form.jsp").forward(req, resp);
                        return;
                    }
                    BigDecimal total = dao.getTotalCollection(start, end);
                    List<FeePayment> list = dao.getPaidInPeriod(start, end);
                    req.setAttribute("reportTitle", "Total Fee Collection (" + startStr + " to " + endStr + ")");
                    req.setAttribute("reportData", list);
                    req.setAttribute("totalCollection", total);
                    req.setAttribute("reportType", "collection");
                    req.setAttribute("startDate", startStr);
                    req.setAttribute("endDate", endStr);
                    break;
                }

                default:
                    req.setAttribute("error", "Unknown report type.");
                    req.getRequestDispatcher("report_form.jsp").forward(req, resp);
                    return;
            }
        } catch (Exception e) {
            req.setAttribute("error", "Report error: " + e.getMessage());
            req.getRequestDispatcher("report_form.jsp").forward(req, resp);
            return;
        }

        req.getRequestDispatcher("report_result.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("report_form.jsp").forward(req, resp);
    }
}