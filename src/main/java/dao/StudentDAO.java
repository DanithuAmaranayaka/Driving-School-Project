package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import models.Student;
import util.DBConnection;

public class StudentDAO {

    public boolean insertStudent(Student student) {
        boolean rowInserted = false;
        String query = "INSERT INTO students (name, nic, phone_number, address, license_type, username, password) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setString(1, student.getName());
            preparedStatement.setString(2, student.getNic());
            preparedStatement.setString(3, student.getPhoneNumber());
            preparedStatement.setString(4, student.getAddress());
            preparedStatement.setString(5, student.getLicenseType());
            preparedStatement.setString(6, student.getUsername());
            preparedStatement.setString(7, student.getPassword());
            
            rowInserted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowInserted;
    }

    public Student selectStudent(int studentId) {
        Student student = null;
        String query = "SELECT * FROM students WHERE student_id = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setInt(1, studentId);
            ResultSet rs = preparedStatement.executeQuery();
            
            if (rs.next()) {
                student = new Student(
                    rs.getInt("student_id"),
                    rs.getString("name"),
                    rs.getString("nic"),
                    rs.getString("phone_number"),
                    rs.getString("address"),
                    rs.getString("license_type"),
                    rs.getString("username"),
                    rs.getString("password")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return student;
    }

    public List<Student> selectAllStudents() {
        List<Student> students = new ArrayList<>();
        String query = "SELECT * FROM students";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet rs = preparedStatement.executeQuery()) {
            
            while (rs.next()) {
                students.add(new Student(
                    rs.getInt("student_id"),
                    rs.getString("name"),
                    rs.getString("nic"),
                    rs.getString("phone_number"),
                    rs.getString("address"),
                    rs.getString("license_type"),
                    rs.getString("username"),
                    rs.getString("password")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    public boolean updateStudent(Student student) {
        boolean rowUpdated = false;
        String query = "UPDATE students SET name=?, nic=?, phone_number=?, address=?, license_type=? WHERE student_id=?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setString(1, student.getName());
            preparedStatement.setString(2, student.getNic());
            preparedStatement.setString(3, student.getPhoneNumber());
            preparedStatement.setString(4, student.getAddress());
            preparedStatement.setString(5, student.getLicenseType());
            preparedStatement.setInt(6, student.getStudentId());
            
            rowUpdated = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }

    public boolean deleteStudent(int studentId) {
        boolean rowDeleted = false;
        String query = "DELETE FROM students WHERE student_id = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setInt(1, studentId);
            rowDeleted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowDeleted;
    }

    public Student validateStudent(String username, String password) {
        Student student = null;
        String query = "SELECT * FROM students WHERE username = ? AND password = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                student = new Student(
                    rs.getInt("student_id"),
                    rs.getString("name"),
                    rs.getString("nic"),
                    rs.getString("phone_number"),
                    rs.getString("address"),
                    rs.getString("license_type"),
                    rs.getString("username"),
                    rs.getString("password")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return student;
    }
}
