package models;

public class Instructor extends Person {
    private int instructorId;
    private String vehicleType;

    public Instructor() {
        super();
    }

    public Instructor(int instructorId, String name, String phoneNumber, String vehicleType) {
        super(name, phoneNumber);
        this.instructorId = instructorId;
        this.vehicleType = vehicleType;
    }

    public int getInstructorId() {
        return instructorId;
    }

    public void setInstructorId(int instructorId) {
        this.instructorId = instructorId;
    }


    public String getVehicleType() {
        return vehicleType;
    }

    public void setVehicleType(String vehicleType) {
        this.vehicleType = vehicleType;
    }

    @Override
    public String getRole() {
        return "Instructor";
    }
}
