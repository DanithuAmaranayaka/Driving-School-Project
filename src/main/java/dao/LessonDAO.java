package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import models.Lesson;
import util.DBConnection;

public class LessonDAO {

    public boolean insertLesson(Lesson lesson) {
        boolean rowInserted = false;
        String query = "INSERT INTO lessons (student_id, instructor_id, vehicle_id, lesson_date, lesson_time, status) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setInt(1, lesson.getStudentId());
            preparedStatement.setInt(2, lesson.getInstructorId());
            preparedStatement.setInt(3, lesson.getVehicleId());
            preparedStatement.setDate(4, lesson.getLessonDate());
            preparedStatement.setTime(5, lesson.getLessonTime());
            preparedStatement.setString(6, lesson.getStatus());
            
            rowInserted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowInserted;
    }

    public Lesson selectLesson(int lessonId) {
        Lesson lesson = null;
        String query = "SELECT l.*, i.name as instructor_name FROM lessons l LEFT JOIN instructors i ON l.instructor_id = i.instructor_id WHERE l.lesson_id = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setInt(1, lessonId);
            ResultSet rs = preparedStatement.executeQuery();
            
            if (rs.next()) {
                lesson = new Lesson(
                    rs.getInt("lesson_id"),
                    rs.getInt("student_id"),
                    rs.getInt("instructor_id"),
                    rs.getString("instructor_name"),
                    rs.getInt("vehicle_id"),
                    rs.getDate("lesson_date"),
                    rs.getTime("lesson_time"),
                    rs.getString("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lesson;
    }

    public List<Lesson> selectAllLessons() {
        List<Lesson> lessons = new ArrayList<>();
        String query = "SELECT l.*, i.name as instructor_name FROM lessons l LEFT JOIN instructors i ON l.instructor_id = i.instructor_id";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet rs = preparedStatement.executeQuery()) {
            
            while (rs.next()) {
                lessons.add(new Lesson(
                    rs.getInt("lesson_id"),
                    rs.getInt("student_id"),
                    rs.getInt("instructor_id"),
                    rs.getString("instructor_name"),
                    rs.getInt("vehicle_id"),
                    rs.getDate("lesson_date"),
                    rs.getTime("lesson_time"),
                    rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lessons;
    }

    public boolean updateLesson(Lesson lesson) {
        boolean rowUpdated = false;
        String query = "UPDATE lessons SET student_id=?, instructor_id=?, vehicle_id=?, lesson_date=?, lesson_time=?, status=? WHERE lesson_id=?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setInt(1, lesson.getStudentId());
            preparedStatement.setInt(2, lesson.getInstructorId());
            preparedStatement.setInt(3, lesson.getVehicleId());
            preparedStatement.setDate(4, lesson.getLessonDate());
            preparedStatement.setTime(5, lesson.getLessonTime());
            preparedStatement.setString(6, lesson.getStatus());
            preparedStatement.setInt(7, lesson.getLessonId());
            
            rowUpdated = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }

    public boolean deleteLesson(int lessonId) {
        boolean rowDeleted = false;
        String query = "DELETE FROM lessons WHERE lesson_id = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setInt(1, lessonId);
            rowDeleted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowDeleted;
    }

    public List<Lesson> selectLessonsByStudent(int studentId) {
        List<Lesson> lessons = new ArrayList<>();
        String query = "SELECT l.*, i.name as instructor_name FROM lessons l LEFT JOIN instructors i ON l.instructor_id = i.instructor_id WHERE l.student_id = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setInt(1, studentId);
            ResultSet rs = preparedStatement.executeQuery();
            
            while (rs.next()) {
                lessons.add(new Lesson(
                    rs.getInt("lesson_id"),
                    rs.getInt("student_id"),
                    rs.getInt("instructor_id"),
                    rs.getString("instructor_name"),
                    rs.getInt("vehicle_id"),
                    rs.getDate("lesson_date"),
                    rs.getTime("lesson_time"),
                    rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lessons;
    }
}
