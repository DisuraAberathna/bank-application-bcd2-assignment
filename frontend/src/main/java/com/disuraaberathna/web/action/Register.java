package com.disuraaberathna.web.action;

import com.disuraaberathna.core.exception.CommonException;
import com.disuraaberathna.core.model.Customer;
import com.disuraaberathna.core.service.CustomerService;
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
    private CustomerService customerService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nic = req.getParameter("nic");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String otp = req.getParameter("otp");

        Map<String, String> errors = new HashMap<>();

        if (!Validator.validateNic(nic)) {
            errors.put("nic", "Please enter a valid nic number.");
        }

        if (username == null || username.trim().isEmpty()) {
            errors.put("username", "Please enter your username.");
        }

        if (!Validator.validatePassword(password)) {
            errors.put("password", "Password must be at least 8 characters long and include at least one letter and one number or special character.");
        }

        if (otp == null || otp.trim().isEmpty()) {
            errors.put("otp", "Please enter your OTP.");
        }

        if (username != null && !username.isEmpty() && customerService.getCustomerByUsername(username.trim()) != null) {
            errors.put("username", "This username is already taken.");
        }

        if (customerService.findCustomerByNicAndOtp(nic, otp) == null) {
            errors.put("otp", "Invalid NIC Number or OTP, Please try again.");
        }

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("inputData", req.getParameterMap());
            req.getRequestDispatcher("/auth/register.jsp").forward(req, resp);
            return;
        }

        String hashedPassword = Encryptor.hashPassword(password.trim());
        boolean status = customerService.verifyCustomer(username, hashedPassword, nic, otp);

        if (!status) {
            throw new CommonException("Can not verify your registration, Please contact the bank.");
        }

        resp.sendRedirect(req.getContextPath() + "/auth/login.jsp");
    }
}
