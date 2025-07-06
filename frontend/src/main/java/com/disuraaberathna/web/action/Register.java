package com.disuraaberathna.web.action;

import com.disuraaberathna.core.enums.UserRoles;
import com.disuraaberathna.core.model.User;
import com.disuraaberathna.core.service.UserService;
import com.disuraaberathna.core.util.Encryptor;
import com.disuraaberathna.core.util.Validator;
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
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String email = req.getParameter("email");
        String mobile = req.getParameter("mobile");
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        Map<String, String> errors = new HashMap<>();

        if (firstName == null || firstName.trim().isEmpty()) {
            errors.put("firstName", "Please enter your first name.");
        }

        if (firstName != null && Validator.containsDigit(firstName)) {
            errors.put("firstName", "First Name should not contain any digits.");
        }

        if (lastName == null || lastName.trim().isEmpty()) {
            errors.put("lastName", "Please enter your last name.");
        }

        if (lastName != null && Validator.containsDigit(lastName)) {
            errors.put("lastName", "Last Name should not contain any digits.");
        }

        if (!Validator.validateEmail(email)) {
            errors.put("email", "Please enter a valid email address.");
        }

        if (!Validator.validateMobile(mobile)) {
            errors.put("mobile", "Valid 10-digit Mobile Number is required.");
        }

        if (username == null || username.trim().isEmpty()) {
            errors.put("username", "Please enter your username.");
        }

        if (!Validator.validatePassword(password)) {
            errors.put("password", "Password must be at least 8 characters long and include at least one letter and one number or special character.");
        }

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("inputData", req.getParameterMap());
            req.getRequestDispatcher("/auth/register.jsp").forward(req, resp);
            return;
        }

        String hashedPassword = Encryptor.hashPassword(password.trim());

        User user = new User(firstName.trim(), lastName.trim(), email.trim(), mobile.trim(), username.trim(), hashedPassword, UserRoles.CUSTOMER);
        userService.addUser(user);
    }
}
