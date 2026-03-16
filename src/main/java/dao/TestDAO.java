package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import models.Test;
import util.DBConnection;

public class TestDAO {

    public boolean insertTest(Test test) {
        boolean rowInserted = false;
        String query = "INSERT INTO tests (student_id, test_date, result) VALUES (?, ?, ?)";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setInt(1, test.getStudentId());
            preparedStatement.setDate(2, test.getTestDate());
            preparedStatement.setString(3, test.getResult());
            
            rowInserted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowInserted;
    }

    public Test selectTest(int testId) {
        Test test = null;
        String query = "SELECT * FROM tests WHERE test_id = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setInt(1, testId);
            ResultSet rs = preparedStatement.executeQuery();
            
            if (rs.next()) {
                test = new Test(
                    rs.getInt("test_id"),
                    rs.getInt("student_id"),
                    rs.getDate("test_date"),
                    rs.getString("result")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return test;
    }

    public List<Test> selectAllTests() {
        List<Test> tests = new ArrayList<>();
        String query = "SELECT * FROM tests";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet rs = preparedStatement.executeQuery()) {
            
            while (rs.next()) {
                tests.add(new Test(
                    rs.getInt("test_id"),
                    rs.getInt("student_id"),
                    rs.getDate("test_date"),
                    rs.getString("result")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tests;
    }

    public boolean updateTest(Test test) {
        boolean rowUpdated = false;
        String query = "UPDATE tests SET student_id=?, test_date=?, result=? WHERE test_id=?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setInt(1, test.getStudentId());
            preparedStatement.setDate(2, test.getTestDate());
            preparedStatement.setString(3, test.getResult());
            preparedStatement.setInt(4, test.getTestId());
            
            rowUpdated = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }

    public boolean deleteTest(int testId) {
        boolean rowDeleted = false;
        String query = "DELETE FROM tests WHERE test_id = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setInt(1, testId);
            rowDeleted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowDeleted;
    }
    
    public List<Test> selectTestsByStudent(int studentId) {
        List<Test> tests = new ArrayList<>();
        String query = "SELECT * FROM tests WHERE student_id = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setInt(1, studentId);
            ResultSet rs = preparedStatement.executeQuery();
            
            while (rs.next()) {
                tests.add(new Test(
                    rs.getInt("test_id"),
                    rs.getInt("student_id"),
                    rs.getDate("test_date"),
                    rs.getString("result")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tests;
    }
}
