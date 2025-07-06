package com.disuraaberathna.web.action;

import com.disuraaberathna.core.enums.UserRoles;
import com.disuraaberathna.core.model.User;
import com.disuraaberathna.core.service.UserService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/auth/register")
public class Register extends HttpServlet {
    @EJB
    private UserService userService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");

        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String email = req.getParameter("email");
        String mobile = req.getParameter("mobile");
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        Map<String, String> errors = new HashMap<>();

        if (firstName == null || firstName.trim().isEmpty())
            errors.put("firstName", "Please enter your first name.");

        if (lastName == null || lastName.trim().isEmpty())
            errors.put("lastName", "Please enter your last name.");

        if (email == null || email.trim().isEmpty() || !email.matches("^[\\w-.]+@([\\w-]+\\.)+[\\w-]{2,4}$"))
            errors.put("email", "Valid Email is required.");

        if (mobile == null || !mobile.matches("^\\d{10}$"))
            errors.put("mobile", "Valid 10-digit Mobile Number is required.");

        if (username == null || username.trim().isEmpty())
            errors.put("username", "Username is required.");

        if (password == null || password.length() < 6)
            errors.put("password", "Password must be at least 6 characters.");

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("inputData", req.getParameterMap());
            req.getRequestDispatcher(req.getContextPath() +"/auth/register.jsp").forward(req, resp);
            return;
        }

        User user = new User(firstName, lastName, email, mobile, username, password, UserRoles.CUSTOMER);
        userService.addUser(user);
    }
}
