package models;

import java.sql.Date;
import java.sql.Time;

public class Lesson {
    private int lessonId;
    private int studentId;
    private int instructorId;
    private String instructorName;
    private int vehicleId;
    private Date lessonDate;
    private Time lessonTime;
    private String status;

    public Lesson() {}

    public Lesson(int lessonId, int studentId, int instructorId, int vehicleId, Date lessonDate, Time lessonTime, String status) {
        this.lessonId = lessonId;
        this.studentId = studentId;
        this.instructorId = instructorId;
        this.vehicleId = vehicleId;
        this.lessonDate = lessonDate;
        this.lessonTime = lessonTime;
        this.status = status;
    }

    public Lesson(int lessonId, int studentId, int instructorId, String instructorName, int vehicleId, Date lessonDate, Time lessonTime, String status) {
        this.lessonId = lessonId;
        this.studentId = studentId;
        this.instructorId = instructorId;
        this.instructorName = instructorName;
        this.vehicleId = vehicleId;
        this.lessonDate = lessonDate;
        this.lessonTime = lessonTime;
        this.status = status;
    }

    // Getters and Setters
    public int getLessonId() { return lessonId; }
    public void setLessonId(int lessonId) { this.lessonId = lessonId; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public int getInstructorId() { return instructorId; }
    public void setInstructorId(int instructorId) { this.instructorId = instructorId; }

    public String getInstructorName() { return instructorName; }
    public void setInstructorName(String instructorName) { this.instructorName = instructorName; }

    public int getVehicleId() { return vehicleId; }
    public void setVehicleId(int vehicleId) { this.vehicleId = vehicleId; }

    public Date getLessonDate() { return lessonDate; }
    public void setLessonDate(Date lessonDate) { this.lessonDate = lessonDate; }

    public Time getLessonTime() { return lessonTime; }
    public void setLessonTime(Time lessonTime) { this.lessonTime = lessonTime; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
