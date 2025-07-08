package com.disuraaberathna.web.action;

import com.disuraaberathna.core.exception.CommonException;
import com.disuraaberathna.core.model.Customer;
import com.disuraaberathna.core.service.CustomerService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.*;

@WebServlet("/verify")
public class VerifyEmail extends HttpServlet {
    @EJB
    private CustomerService customerService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String vc = req.getParameter("vc");

        byte[] decodedEmailBytes = Base64.getDecoder().decode(id);
        String email = new String(decodedEmailBytes);

        byte[] decodedCodeBytes = Base64.getDecoder().decode(vc);
        String verificationCode = new String(decodedCodeBytes);

        Customer customer = customerService.getCustomerByEmail(email);
        if (customer == null) {
            throw new CommonException("Invalid email address.");
        }

        if (customer.isVerified()) {
            throw new CommonException("Email address is already verified.");
        }

        if (customer.getVerificationExpireAt() != null && customer.getVerificationExpireAt().before(new Date())) {
            throw new CommonException("Verification code expired.");
        }

        if (customer.getVerificationCode() != null && !customer.getVerificationCode().equals(verificationCode)) {
            throw new CommonException("Verification code does not match.");
        }

        boolean status = customerService.verifyCustomer(customer.getId());

        if (!status) {
            throw new CommonException("Email address is not verified.");
        }

        req.getSession().setAttribute("verified", true);
        req.removeAttribute("allow-verified");
        resp.sendRedirect(req.getContextPath() + "/auth/login.jsp");
    }
}
