package com.disuraaberathna.web.action;

import com.disuraaberathna.core.enums.AccountType;
import com.disuraaberathna.core.mail.VerificationMail;
import com.disuraaberathna.core.model.Customer;
import com.disuraaberathna.core.provider.MailServiceProvider;
import com.disuraaberathna.core.service.AccountService;
import com.disuraaberathna.core.service.CustomerService;
import com.disuraaberathna.core.util.Validator;
import com.disuraaberathna.core.util.VerificationCodeGenerator;
import com.google.gson.JsonObject;
import jakarta.annotation.security.DeclareRoles;
import jakarta.ejb.EJB;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

@DeclareRoles({"USER", "ADMIN"})
@ServletSecurity(@HttpConstraint(rolesAllowed = {"USER", "ADMIN"}))
@WebServlet("/add-customer")
public class AddCustomer extends HttpServlet {
    @EJB
    private CustomerService customerService;

    @EJB
    private AccountService accountService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        Gson gson = new Gson();
        JsonObject json = gson.fromJson(req.getReader(), JsonObject.class);

        String firstName = json.get("firstName").getAsString();
        String lastName = json.get("lastName").getAsString();
        String email = json.get("email").getAsString();
        String mobile = json.get("mobile").getAsString();
        String nic = json.get("nic").getAsString();
        double deposit = json.get("deposit").getAsDouble();
        String type = json.get("type").getAsString();
        boolean exists = json.get("exists").getAsBoolean();

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

        if (!Validator.validateNic(nic)) {
            errors.put("nic", "Please enter a valid nic number.");
        }

        if (deposit < 0) {
            errors.put("deposit", "Please enter a valid initial deposit.");
        }

        if (type == null || type.trim().isEmpty()) {
            errors.put("type", "Please select a valid account type.");
        }

        Customer customer = customerService.isExist(email, mobile, nic);

        if (customer != null && !exists) {
            responseData.put("success", false);
            responseData.put("warning", "Customer already exists.");
            responseData.put("existsCustomer", true);
            resp.getWriter().write(gson.toJson(responseData));
            return;
        } else {
            if (customerService.getCustomerByEmail(email.trim()) != null && !exists) {
                errors.put("email", "This email address is already taken.");
            }

            if (customerService.getCustomerByMobile(mobile.trim()) != null && !exists) {
                errors.put("mobile", "This mobile number is already taken.");
            }

            if (customerService.findCustomerByNic(nic.trim()) != null && !exists) {
                errors.put("nic", "This nic number is already taken.");
            }
        }

        if (!errors.isEmpty()) {
            responseData.put("success", false);
            responseData.put("errors", errors);
            resp.getWriter().write(gson.toJson(responseData));
            return;
        }

        AccountType accountType = switch (type) {
            case "savings" -> AccountType.SAVINGS;
            case "current" -> AccountType.CURRENT;
            case "deposit" -> AccountType.DEPOSIT;
            default -> null;
        };

        if (customer == null) {
            String verificationCode = VerificationCodeGenerator.generate();

            VerificationMail mail = new VerificationMail(email, verificationCode);
            MailServiceProvider.getInstance().sendMail(mail);

            Customer newCustomer = new Customer(firstName.trim(), lastName.trim(), email.trim(), mobile.trim(), nic.trim());
            newCustomer.setVerificationCode(verificationCode);
            newCustomer.setVerificationExpireAt(Date.from(LocalDateTime.now().plusDays(1).atZone(ZoneId.systemDefault()).toInstant()));
            customerService.addCustomer(newCustomer);
        }

        accountService.addAccount(deposit, email.trim(), accountType);

        responseData.put("success", true);
        responseData.put("message", customer != null
                ? "New Account has been added successfully."
                : "Customer and account successfully created. Verification email sent.");

        resp.getWriter().write(gson.toJson(responseData));
    }
}
