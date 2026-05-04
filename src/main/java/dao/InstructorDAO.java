package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import models.Instructor;
import util.DBConnection;

public class InstructorDAO {

    public boolean insertInstructor(Instructor instructor) {
        boolean rowInserted = false;
        String query = "INSERT INTO instructors (name, phone_number, vehicle_type) VALUES (?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, instructor.getName());
            preparedStatement.setString(2, instructor.getPhoneNumber());
            preparedStatement.setString(3, instructor.getVehicleType());

            rowInserted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowInserted;
    }

    public Instructor selectInstructor(int instructorId) {
        Instructor instructor = null;
        String query = "SELECT * FROM instructors WHERE instructor_id = ?";

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, instructorId);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                instructor = new Instructor(
                        rs.getInt("instructor_id"),
                        rs.getString("name"),
                        rs.getString("phone_number"),
                        rs.getString("vehicle_type"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return instructor;
    }

    public List<Instructor> selectAllInstructors() {
        List<Instructor> instructors = new ArrayList<>();
        String query = "SELECT * FROM instructors";

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(query);
                ResultSet rs = preparedStatement.executeQuery()) {

            while (rs.next()) {
                instructors.add(new Instructor(
                        rs.getInt("instructor_id"),
                        rs.getString("name"),
                        rs.getString("phone_number"),
                        rs.getString("vehicle_type")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return instructors;
    }

    public boolean updateInstructor(Instructor instructor) {
        boolean rowUpdated = false;
        String query = "UPDATE instructors SET name=?, phone_number=?, vehicle_type=? WHERE instructor_id=?";

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, instructor.getName());
            preparedStatement.setString(2, instructor.getPhoneNumber());
            preparedStatement.setString(3, instructor.getVehicleType());
            preparedStatement.setInt(4, instructor.getInstructorId());

            rowUpdated = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }

    public boolean deleteInstructor(int instructorId) {
        boolean rowDeleted = false;
        String query = "DELETE FROM instructors WHERE instructor_id = ?";

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, instructorId);
            rowDeleted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowDeleted;
    }
}
