package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import models.Payment;
import util.DBConnection;

public class PaymentDAO {

    public boolean insertPayment(Payment payment) {
        boolean rowInserted = false;
        String query = "INSERT INTO payments (student_id, course_type, amount, payment_date, payment_method) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setInt(1, payment.getStudentId());
            preparedStatement.setString(2, payment.getCourseType());
            preparedStatement.setDouble(3, payment.getAmount());
            preparedStatement.setDate(4, payment.getPaymentDate());
            preparedStatement.setString(5, payment.getPaymentMethod());
            
            rowInserted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowInserted;
    }

    public Payment selectPayment(int paymentId) {
        Payment payment = null;
        String query = "SELECT * FROM payments WHERE payment_id = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setInt(1, paymentId);
            ResultSet rs = preparedStatement.executeQuery();
            
            if (rs.next()) {
                payment = new Payment(
                    rs.getInt("payment_id"),
                    rs.getInt("student_id"),
                    rs.getString("course_type"),
                    rs.getDouble("amount"),
                    rs.getDate("payment_date"),
                    rs.getString("payment_method")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payment;
    }

    public List<Payment> selectAllPayments() {
        List<Payment> payments = new ArrayList<>();
        String query = "SELECT * FROM payments";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet rs = preparedStatement.executeQuery()) {
            
            while (rs.next()) {
                payments.add(new Payment(
                    rs.getInt("payment_id"),
                    rs.getInt("student_id"),
                    rs.getString("course_type"),
                    rs.getDouble("amount"),
                    rs.getDate("payment_date"),
                    rs.getString("payment_method")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }

    public boolean updatePayment(Payment payment) {
        boolean rowUpdated = false;
        String query = "UPDATE payments SET student_id=?, course_type=?, amount=?, payment_date=?, payment_method=? WHERE payment_id=?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setInt(1, payment.getStudentId());
            preparedStatement.setString(2, payment.getCourseType());
            preparedStatement.setDouble(3, payment.getAmount());
            preparedStatement.setDate(4, payment.getPaymentDate());
            preparedStatement.setString(5, payment.getPaymentMethod());
            preparedStatement.setInt(6, payment.getPaymentId());
            
            rowUpdated = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }

    public boolean deletePayment(int paymentId) {
        boolean rowDeleted = false;
        String query = "DELETE FROM payments WHERE payment_id = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setInt(1, paymentId);
            rowDeleted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowDeleted;
    }
    
    public List<Payment> selectPaymentsByStudent(int studentId) {
        List<Payment> payments = new ArrayList<>();
        String query = "SELECT * FROM payments WHERE student_id = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setInt(1, studentId);
            ResultSet rs = preparedStatement.executeQuery();
            
            while (rs.next()) {
                payments.add(new Payment(
                    rs.getInt("payment_id"),
                    rs.getInt("student_id"),
                    rs.getString("course_type"),
                    rs.getDouble("amount"),
                    rs.getDate("payment_date"),
                    rs.getString("payment_method")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }
}
