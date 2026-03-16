package models;

public class Vehicle {
    private int vehicleId;
    private String model;
    private String plateNumber;
    private String vehicleType;
    private String status;

    public Vehicle() {}

    public Vehicle(int vehicleId, String model, String plateNumber, String vehicleType, String status) {
        this.vehicleId = vehicleId;
        this.model = model;
        this.plateNumber = plateNumber;
        this.vehicleType = vehicleType;
        this.status = status;
    }

    public int getVehicleId() { return vehicleId; }
    public void setVehicleId(int vehicleId) { this.vehicleId = vehicleId; }

    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }

    public String getPlateNumber() { return plateNumber; }
    public void setPlateNumber(String plateNumber) { this.plateNumber = plateNumber; }

    public String getVehicleType() { return vehicleType; }
    public void setVehicleType(String vehicleType) { this.vehicleType = vehicleType; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
