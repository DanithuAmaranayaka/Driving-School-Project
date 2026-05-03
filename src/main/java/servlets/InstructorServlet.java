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

import dao.InstructorDAO;
import models.Instructor;
import util.LogUtil;

@WebServlet("/InstructorServlet")
public class InstructorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private InstructorDAO instructorDAO;

    public void init() {
        instructorDAO = new InstructorDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        // Protect endpoints
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
                    insertInstructor(request, response);
                    break;
                case "delete":
                    deleteInstructor(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "update":
                    updateInstructor(request, response);
                    break;
                default:
                    listInstructor(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listInstructor(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Instructor> listInstructor = instructorDAO.selectAllInstructors();
        request.setAttribute("listInstructor", listInstructor);
        RequestDispatcher dispatcher = request.getRequestDispatcher("instructor_list.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("instructor_add.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Instructor existingInstructor = instructorDAO.selectInstructor(id);
        RequestDispatcher dispatcher = request.getRequestDispatcher("instructor_add.jsp");
        request.setAttribute("instructor", existingInstructor);
        dispatcher.forward(request, response);
    }

    private void insertInstructor(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String name = request.getParameter("name");
        String phoneNumber = request.getParameter("phoneNumber");
        String vehicleType = request.getParameter("vehicleType");
        
        Instructor newInstructor = new Instructor(0, name, phoneNumber, vehicleType);
        instructorDAO.insertInstructor(newInstructor);
        LogUtil.logAction("Instructor Added: " + name);
        response.sendRedirect("InstructorServlet?action=list");
    }

    private void updateInstructor(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String phoneNumber = request.getParameter("phoneNumber");
        String vehicleType = request.getParameter("vehicleType");

        Instructor instructor = new Instructor(id, name, phoneNumber, vehicleType);
        instructorDAO.updateInstructor(instructor);
        LogUtil.logAction("Instructor Updated: " + name + " (ID: " + id + ")");
        response.sendRedirect("InstructorServlet?action=list");
    }

    private void deleteInstructor(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        instructorDAO.deleteInstructor(id);
        LogUtil.logAction("Instructor Deleted (ID: " + id + ")");
        response.sendRedirect("InstructorServlet?action=list");
    }
}
