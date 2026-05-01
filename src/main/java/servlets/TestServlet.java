package servlets;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.TestDAO;
import dao.StudentDAO;

import models.Test;
import util.LogUtil;


@WebServlet("/TestServlet")
public class TestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TestDAO testDAO;
    private StudentDAO studentDAO;

    public void init() {
        testDAO = new TestDAO();
        studentDAO = new StudentDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        HttpSession session = request.getSession(false);
        if (session == null || (session.getAttribute("adminUser") == null && session.getAttribute("loggedStudent") == null)) {
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
                    insertTest(request, response);
                    break;
                case "delete":
                    deleteTest(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "update":
                    updateTest(request, response);
                    break;
                default:
                    listTest(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listTest(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Test> listTest = testDAO.selectAllTests();
        request.setAttribute("listTest", listTest);
        RequestDispatcher dispatcher = request.getRequestDispatcher("test_list.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("students", studentDAO.selectAllStudents());
        RequestDispatcher dispatcher = request.getRequestDispatcher("test_booking.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Test existingTest = testDAO.selectTest(id);
        request.setAttribute("testObj", existingTest);
        request.setAttribute("students", studentDAO.selectAllStudents());
        RequestDispatcher dispatcher = request.getRequestDispatcher("test_booking.jsp");
        dispatcher.forward(request, response);
    }

    private void insertTest(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int studentId = Integer.parseInt(request.getParameter("studentId"));
        Date testDate = Date.valueOf(request.getParameter("testDate"));
        String result = "Pending"; // Default for new test
        
        Test newTest = new Test(0, studentId, testDate, result);
        testDAO.insertTest(newTest);
        LogUtil.logAction("Test Booking: Date " + testDate + " for Student ID: " + studentId);

        
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loggedStudent") != null) {
            response.sendRedirect("StudentServlet?action=dashboard");
        } else {
            response.sendRedirect("TestServlet?action=list");
        }
    }

    private void updateTest(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int studentId = Integer.parseInt(request.getParameter("studentId"));
        Date testDate = Date.valueOf(request.getParameter("testDate"));
        String result = request.getParameter("result");

        Test test = new Test(id, studentId, testDate, result);
        testDAO.updateTest(test);
        response.sendRedirect("TestServlet?action=list");
    }

    private void deleteTest(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        testDAO.deleteTest(id);
        response.sendRedirect("TestServlet?action=list");
    }
}
