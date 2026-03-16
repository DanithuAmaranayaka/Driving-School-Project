package models;

import java.sql.Date;

public class Test {
    private int testId;
    private int studentId;
    private Date testDate;
    private String result;

    public Test() {}

    public Test(int testId, int studentId, Date testDate, String result) {
        this.testId = testId;
        this.studentId = studentId;
        this.testDate = testDate;
        this.result = result;
    }

    public int getTestId() { return testId; }
    public void setTestId(int testId) { this.testId = testId; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public Date getTestDate() { return testDate; }
    public void setTestDate(Date testDate) { this.testDate = testDate; }

    public String getResult() { return result; }
    public void setResult(String result) { this.result = result; }
}
