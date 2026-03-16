package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import models.Vehicle;
import util.DBConnection;

public class VehicleDAO {

    public boolean insertVehicle(Vehicle vehicle) {
        boolean rowInserted = false;
        String query = "INSERT INTO vehicles (model, plate_number, vehicle_type, status) VALUES (?, ?, ?, ?)";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setString(1, vehicle.getModel());
            preparedStatement.setString(2, vehicle.getPlateNumber());
            preparedStatement.setString(3, vehicle.getVehicleType());
            preparedStatement.setString(4, vehicle.getStatus());
            
            rowInserted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowInserted;
    }

    public Vehicle selectVehicle(int vehicleId) {
        Vehicle vehicle = null;
        String query = "SELECT * FROM vehicles WHERE vehicle_id = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setInt(1, vehicleId);
            ResultSet rs = preparedStatement.executeQuery();
            
            if (rs.next()) {
                vehicle = new Vehicle(
                    rs.getInt("vehicle_id"),
                    rs.getString("model"),
                    rs.getString("plate_number"),
                    rs.getString("vehicle_type"),
                    rs.getString("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vehicle;
    }

    public List<Vehicle> selectAllVehicles() {
        List<Vehicle> vehicles = new ArrayList<>();
        String query = "SELECT * FROM vehicles";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet rs = preparedStatement.executeQuery()) {
            
            while (rs.next()) {
                vehicles.add(new Vehicle(
                    rs.getInt("vehicle_id"),
                    rs.getString("model"),
                    rs.getString("plate_number"),
                    rs.getString("vehicle_type"),
                    rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vehicles;
    }

    public boolean updateVehicle(Vehicle vehicle) {
        boolean rowUpdated = false;
        String query = "UPDATE vehicles SET model=?, plate_number=?, vehicle_type=?, status=? WHERE vehicle_id=?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setString(1, vehicle.getModel());
            preparedStatement.setString(2, vehicle.getPlateNumber());
            preparedStatement.setString(3, vehicle.getVehicleType());
            preparedStatement.setString(4, vehicle.getStatus());
            preparedStatement.setInt(5, vehicle.getVehicleId());
            
            rowUpdated = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }

    public boolean deleteVehicle(int vehicleId) {
        boolean rowDeleted = false;
        String query = "DELETE FROM vehicles WHERE vehicle_id = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setInt(1, vehicleId);
            rowDeleted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowDeleted;
    }
}
