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

import dao.PaymentDAO;
import dao.StudentDAO;

import models.Payment;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PaymentDAO paymentDAO;
    private StudentDAO studentDAO;

    public void init() {
        paymentDAO = new PaymentDAO();
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
                    insertPayment(request, response);
                    break;
                case "delete":
                    deletePayment(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "update":
                    updatePayment(request, response);
                    break;
                default:
                    listPayment(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listPayment(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Payment> listPayment = paymentDAO.selectAllPayments();
        request.setAttribute("listPayment", listPayment);
        RequestDispatcher dispatcher = request.getRequestDispatcher("payment_list.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("students", studentDAO.selectAllStudents());
        RequestDispatcher dispatcher = request.getRequestDispatcher("payment_add.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Payment existingPayment = paymentDAO.selectPayment(id);
        request.setAttribute("payment", existingPayment);
        request.setAttribute("students", studentDAO.selectAllStudents());
        RequestDispatcher dispatcher = request.getRequestDispatcher("payment_add.jsp"); // reuse add form for edit
        dispatcher.forward(request, response);
    }

    private void insertPayment(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int studentId = Integer.parseInt(request.getParameter("studentId"));
        String courseType = request.getParameter("courseType");
        double amount = Double.parseDouble(request.getParameter("amount"));
        Date paymentDate = Date.valueOf(request.getParameter("paymentDate"));
        String paymentMethod = request.getParameter("paymentMethod");
        
        Payment newPayment = new Payment(0, studentId, courseType, amount, paymentDate, paymentMethod);
        paymentDAO.insertPayment(newPayment);
        response.sendRedirect("PaymentServlet?action=list");
    }

    private void updatePayment(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int studentId = Integer.parseInt(request.getParameter("studentId"));
        String courseType = request.getParameter("courseType");
        double amount = Double.parseDouble(request.getParameter("amount"));
        Date paymentDate = Date.valueOf(request.getParameter("paymentDate"));
        String paymentMethod = request.getParameter("paymentMethod");

        Payment payment = new Payment(id, studentId, courseType, amount, paymentDate, paymentMethod);
        paymentDAO.updatePayment(payment);
        response.sendRedirect("PaymentServlet?action=list");
    }

    private void deletePayment(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        paymentDAO.deletePayment(id);
        response.sendRedirect("PaymentServlet?action=list");
    }
}
