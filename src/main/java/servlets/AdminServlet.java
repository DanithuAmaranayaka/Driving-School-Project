package servlets;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.AdminDAO;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminDAO adminDAO;

    public void init() {
        adminDAO = new AdminDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            loginAdmin(request, response);
        } else if ("logout".equals(action)) {
            logoutAdmin(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("dashboard".equals(action)) {
            showDashboard(request, response);
        } else if ("logout".equals(action)) {
            logoutAdmin(request, response);
        }
    }

    private void loginAdmin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (adminDAO.validateAdmin(username, password)) {
            HttpSession session = request.getSession();
            session.setAttribute("adminUser", username);
            response.sendRedirect("AdminServlet?action=dashboard");
        } else {
            request.setAttribute("error", "Invalid username or password");
            RequestDispatcher dispatcher = request.getRequestDispatcher("admin_login.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("adminUser") != null) {
            
            int totalStudents = adminDAO.getTotalCount("students");
            int totalInstructors = adminDAO.getTotalCount("instructors");
            int totalVehicles = adminDAO.getTotalCount("vehicles");
            int totalLessons = adminDAO.getTotalCount("lessons");
            int totalPayments = adminDAO.getTotalCount("payments");
            
            request.setAttribute("totalStudents", totalStudents);
            request.setAttribute("totalInstructors", totalInstructors);
            request.setAttribute("totalVehicles", totalVehicles);
            request.setAttribute("totalLessons", totalLessons);
            request.setAttribute("totalPayments", totalPayments);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("admin_dashboard.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("admin_login.jsp");
        }
    }

    private void logoutAdmin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("admin_login.jsp");
    }
}
