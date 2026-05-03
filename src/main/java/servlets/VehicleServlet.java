package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.VehicleDAO;
import models.Vehicle;

@WebServlet("/VehicleServlet")
public class VehicleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private VehicleDAO vehicleDAO;

    public void init() {
        vehicleDAO = new VehicleDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect("admin_login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "insert":
                    insertVehicle(request, response);
                    break;
                case "delete":
                    deleteVehicle(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "update":
                    updateVehicle(request, response);
                    break;
                default:
                    listVehicle(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listVehicle(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Vehicle> listVehicle = vehicleDAO.selectAllVehicles();
        request.setAttribute("listVehicle", listVehicle);
        RequestDispatcher dispatcher = request.getRequestDispatcher("vehicle_list.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("vehicle_add.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Vehicle existingVehicle = vehicleDAO.selectVehicle(id);
        RequestDispatcher dispatcher = request.getRequestDispatcher("vehicle_add.jsp");
        request.setAttribute("vehicle", existingVehicle);
        dispatcher.forward(request, response);
    }

    private void insertVehicle(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String model = request.getParameter("model");
        String plateNumber = request.getParameter("plateNumber");
        String vehicleType = request.getParameter("vehicleType");
        String status = request.getParameter("status");
        
        Vehicle newVehicle = new Vehicle(0, model, plateNumber, vehicleType, status);
        vehicleDAO.insertVehicle(newVehicle);
        response.sendRedirect("VehicleServlet?action=list");
    }

    private void updateVehicle(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String model = request.getParameter("model");
        String plateNumber = request.getParameter("plateNumber");
        String vehicleType = request.getParameter("vehicleType");
        String status = request.getParameter("status");

        Vehicle vehicle = new Vehicle(id, model, plateNumber, vehicleType, status);
        vehicleDAO.updateVehicle(vehicle);
        response.sendRedirect("VehicleServlet?action=list");
    }

    private void deleteVehicle(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        vehicleDAO.deleteVehicle(id);
        response.sendRedirect("VehicleServlet?action=list");
    }
}
