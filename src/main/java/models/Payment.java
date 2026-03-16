package models;

import java.sql.Date;

public class Payment {
    private int paymentId;
    private int studentId;
    private String courseType;
    private double amount;
    private Date paymentDate;
    private String paymentMethod;

    public Payment() {}

    public Payment(int paymentId, int studentId, String courseType, double amount, Date paymentDate, String paymentMethod) {
        this.paymentId = paymentId;
        this.studentId = studentId;
        this.courseType = courseType;
        this.amount = amount;
        this.paymentDate = paymentDate;
        this.paymentMethod = paymentMethod;
    }

    public int getPaymentId() { return paymentId; }
    public void setPaymentId(int paymentId) { this.paymentId = paymentId; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public String getCourseType() { return courseType; }
    public void setCourseType(String courseType) { this.courseType = courseType; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public Date getPaymentDate() { return paymentDate; }
    public void setPaymentDate(Date paymentDate) { this.paymentDate = paymentDate; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
}
