package com.dao;

import com.model.FeePayment;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FeePaymentDAO {

    private static final String DB_URL  = "jdbc:mysql://localhost:3306/collegefeedb";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "password";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found", e);
        }
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
    }

    // ── CREATE ────────────────────────────────────────────────────────────────
    public boolean addFeePayment(FeePayment fp) throws SQLException {
        String sql = "INSERT INTO FeePayments (StudentID, StudentName, PaymentDate, Amount, Status) VALUES (?,?,?,?,?)";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, fp.getStudentID());
            ps.setString(2, fp.getStudentName());
            ps.setDate(3, fp.getPaymentDate());
            ps.setBigDecimal(4, fp.getAmount());
            ps.setString(5, fp.getStatus());
            return ps.executeUpdate() > 0;
        }
    }

    // ── READ ALL ──────────────────────────────────────────────────────────────
    public List<FeePayment> getAllPayments() throws SQLException {
        List<FeePayment> list = new ArrayList<>();
        String sql = "SELECT * FROM FeePayments ORDER BY PaymentDate DESC";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    // ── READ BY ID ────────────────────────────────────────────────────────────
    public FeePayment getPaymentByID(int paymentID) throws SQLException {
        String sql = "SELECT * FROM FeePayments WHERE PaymentID = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, paymentID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    // ── UPDATE ────────────────────────────────────────────────────────────────
    public boolean updateFeePayment(FeePayment fp) throws SQLException {
        String sql = "UPDATE FeePayments SET StudentID=?, StudentName=?, PaymentDate=?, Amount=?, Status=? WHERE PaymentID=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, fp.getStudentID());
            ps.setString(2, fp.getStudentName());
            ps.setDate(3, fp.getPaymentDate());
            ps.setBigDecimal(4, fp.getAmount());
            ps.setString(5, fp.getStatus());
            ps.setInt(6, fp.getPaymentID());
            return ps.executeUpdate() > 0;
        }
    }

    // ── DELETE ────────────────────────────────────────────────────────────────
    public boolean deleteFeePayment(int paymentID) throws SQLException {
        String sql = "DELETE FROM FeePayments WHERE PaymentID = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, paymentID);
            return ps.executeUpdate() > 0;
        }
    }

    // ── REPORT 1: Overdue payments ────────────────────────────────────────────
    public List<FeePayment> getOverduePayments() throws SQLException {
        List<FeePayment> list = new ArrayList<>();
        String sql = "SELECT * FROM FeePayments WHERE Status = 'Overdue' ORDER BY PaymentDate ASC";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    // ── REPORT 2: Students who haven't paid in a period ──────────────────────
    public List<FeePayment> getUnpaidInPeriod(Date startDate, Date endDate) throws SQLException {
        List<FeePayment> list = new ArrayList<>();
        String sql = "SELECT * FROM FeePayments WHERE Status != 'Paid' AND PaymentDate BETWEEN ? AND ? ORDER BY PaymentDate ASC";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    // ── REPORT 3: Total collection in date range ──────────────────────────────
    public BigDecimal getTotalCollection(Date startDate, Date endDate) throws SQLException {
        String sql = "SELECT COALESCE(SUM(Amount),0) AS Total FROM FeePayments WHERE Status = 'Paid' AND PaymentDate BETWEEN ? AND ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getBigDecimal("Total");
            }
        }
        return BigDecimal.ZERO;
    }

    // ── REPORT 3b: Paid records in date range ────────────────────────────────
    public List<FeePayment> getPaidInPeriod(Date startDate, Date endDate) throws SQLException {
        List<FeePayment> list = new ArrayList<>();
        String sql = "SELECT * FROM FeePayments WHERE Status = 'Paid' AND PaymentDate BETWEEN ? AND ? ORDER BY PaymentDate ASC";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    // ── helper ────────────────────────────────────────────────────────────────
    private FeePayment mapRow(ResultSet rs) throws SQLException {
        return new FeePayment(
            rs.getInt("PaymentID"),
            rs.getInt("StudentID"),
            rs.getString("StudentName"),
            rs.getDate("PaymentDate"),
            rs.getBigDecimal("Amount"),
            rs.getString("Status")
        );
    }
}