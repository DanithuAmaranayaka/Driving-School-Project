package servlets;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.LessonDAO;
import dao.StudentDAO;
import dao.InstructorDAO;
import dao.VehicleDAO;

import models.Lesson;
import util.LogUtil;


@WebServlet("/LessonServlet")
public class LessonServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private LessonDAO lessonDAO;
    private StudentDAO studentDAO;
    private InstructorDAO instructorDAO;
    private VehicleDAO vehicleDAO;

    public void init() {
        lessonDAO = new LessonDAO();
        studentDAO = new StudentDAO();
        instructorDAO = new InstructorDAO();
        vehicleDAO = new VehicleDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        HttpSession session = request.getSession(false);
        // Allow logged in students to also view their own, but restrict editing to admin.
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
                    insertLesson(request, response);
                    break;
                case "delete":
                    deleteLesson(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "update":
                    updateLesson(request, response);
                    break;
                default:
                    listLesson(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listLesson(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Lesson> listLesson = lessonDAO.selectAllLessons();
        request.setAttribute("listLesson", listLesson);
        RequestDispatcher dispatcher = request.getRequestDispatcher("lesson_list.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("students", studentDAO.selectAllStudents());
        request.setAttribute("instructors", instructorDAO.selectAllInstructors());
        request.setAttribute("vehicles", vehicleDAO.selectAllVehicles());
        RequestDispatcher dispatcher = request.getRequestDispatcher("lesson_booking.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Lesson existingLesson = lessonDAO.selectLesson(id);
        request.setAttribute("lesson", existingLesson);
        request.setAttribute("students", studentDAO.selectAllStudents());
        request.setAttribute("instructors", instructorDAO.selectAllInstructors());
        request.setAttribute("vehicles", vehicleDAO.selectAllVehicles());
        RequestDispatcher dispatcher = request.getRequestDispatcher("lesson_booking.jsp");
        dispatcher.forward(request, response);
    }

    private void insertLesson(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int studentId = Integer.parseInt(request.getParameter("studentId"));
        int instructorId = Integer.parseInt(request.getParameter("instructorId"));
        int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
        Date lessonDate = Date.valueOf(request.getParameter("lessonDate"));
        Time lessonTime = Time.valueOf(request.getParameter("lessonTime") + ":00"); // Add seconds
        String status = "Scheduled";
        
        Lesson newLesson = new Lesson(0, studentId, instructorId, vehicleId, lessonDate, lessonTime, status);
        lessonDAO.insertLesson(newLesson);
        LogUtil.logAction("Lesson Booked for Student ID: " + studentId);

        
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loggedStudent") != null) {
             response.sendRedirect("StudentServlet?action=dashboard");
        } else {
             response.sendRedirect("LessonServlet?action=list");
        }
    }

    private void updateLesson(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int studentId = Integer.parseInt(request.getParameter("studentId"));
        int instructorId = Integer.parseInt(request.getParameter("instructorId"));
        int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
        Date lessonDate = Date.valueOf(request.getParameter("lessonDate"));
        
        String timeStr = request.getParameter("lessonTime");
        if (timeStr.length() == 5) {
             timeStr += ":00";
        }
        Time lessonTime = Time.valueOf(timeStr);
        String status = request.getParameter("status");

        Lesson lesson = new Lesson(id, studentId, instructorId, vehicleId, lessonDate, lessonTime, status);
        lessonDAO.updateLesson(lesson);
        LogUtil.logAction("Lesson Updated (ID: " + id + ")");
        response.sendRedirect("LessonServlet?action=list");
    }

    private void deleteLesson(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        lessonDAO.deleteLesson(id);
        LogUtil.logAction("Lesson Cancelled (ID: " + id + ")");
        response.sendRedirect("LessonServlet?action=list");
    }
}
