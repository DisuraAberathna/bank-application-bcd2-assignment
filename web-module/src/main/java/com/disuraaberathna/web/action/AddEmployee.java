package com.disuraaberathna.web.action;

import com.disuraaberathna.core.enums.UserRoles;
import com.disuraaberathna.core.mail.EmployeeRegisterMail;
import com.disuraaberathna.core.model.User;
import com.disuraaberathna.core.provider.MailServiceProvider;
import com.disuraaberathna.core.service.UserService;
import com.disuraaberathna.core.util.Encryptor;
import com.disuraaberathna.core.util.PasswordGenerator;
import com.disuraaberathna.core.util.Validator;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.annotation.security.DeclareRoles;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@DeclareRoles({"ADMIN"})
@ServletSecurity(@HttpConstraint(rolesAllowed = {"ADMIN"}))
@WebServlet("/add-employee")
public class AddEmployee extends HttpServlet {
    @EJB
    private UserService userService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Gson gson = new Gson();
        JsonObject json = gson.fromJson(req.getReader(), JsonObject.class);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String firstName = json.get("firstName").getAsString();
        String lastName = json.get("lastName").getAsString();
        String email = json.get("email").getAsString();
        String mobile = json.get("mobile").getAsString();
        String username = json.get("username").getAsString();

        Map<String, String> errors = new HashMap<>();
        Map<String, Object> responseData = new HashMap<>();

        if (firstName == null || firstName.trim().isEmpty()) {
            errors.put("firstName", "Please enter customer's first name.");
        }

        if (firstName != null && Validator.containsDigit(firstName)) {
            errors.put("firstName", "First Name should not contain any digits.");
        }

        if (lastName == null || lastName.trim().isEmpty()) {
            errors.put("lastName", "Please enter customer's last name.");
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

        if (email != null && !email.isEmpty() && userService.getUserByEmail(email.trim()) != null) {
            errors.put("email", "This email address is already taken.");
        }

        if (mobile != null && !mobile.isEmpty() && userService.getUserByMobile(mobile.trim()) != null) {
            errors.put("mobile", "This mobile number is already taken.");
        }

        if (username != null && !username.isEmpty() && userService.getUserByUsername(username.trim()) != null) {
            errors.put("username", "This username is already taken.");
        }

        if (!errors.isEmpty()) {
            responseData.put("success", false);
            responseData.put("errors", errors);
            resp.getWriter().write(gson.toJson(responseData));
            return;
        }

        String password = PasswordGenerator.generatePassword(10, true, true, true, true);
        String hashedPassword = Encryptor.hashPassword(password);

        EmployeeRegisterMail mail = new EmployeeRegisterMail(email, firstName + " " + lastName, username, password);
        MailServiceProvider.getInstance().sendMail(mail);

        User user = new User(firstName, lastName, email, mobile, username, hashedPassword, UserRoles.USER);
        userService.addUser(user);

        responseData.put("success", true);
        responseData.put("message", "Employee account successfully created.");

        resp.getWriter().write(gson.toJson(responseData));
    }
}
