package com.model;

import java.math.BigDecimal;
import java.sql.Date;

public class FeePayment {
    private int paymentID;
    private int studentID;
    private String studentName;
    private Date paymentDate;
    private BigDecimal amount;
    private String status;

    public FeePayment() {}

    public FeePayment(int paymentID, int studentID, String studentName, Date paymentDate, BigDecimal amount, String status) {
        this.paymentID = paymentID;
        this.studentID = studentID;
        this.studentName = studentName;
        this.paymentDate = paymentDate;
        this.amount = amount;
        this.status = status;
    }

    public int getPaymentID() { return paymentID; }
    public void setPaymentID(int paymentID) { this.paymentID = paymentID; }

    public int getStudentID() { return studentID; }
    public void setStudentID(int studentID) { this.studentID = studentID; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public Date getPaymentDate() { return paymentDate; }
    public void setPaymentDate(Date paymentDate) { this.paymentDate = paymentDate; }

    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    @Override
    public String toString() {
        return "FeePayment [paymentID=" + paymentID + ", studentID=" + studentID +
               ", studentName=" + studentName + ", paymentDate=" + paymentDate +
               ", amount=" + amount + ", status=" + status + "]";
    }
}
