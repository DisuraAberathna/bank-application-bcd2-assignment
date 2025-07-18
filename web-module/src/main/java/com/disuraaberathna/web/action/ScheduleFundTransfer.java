package com.disuraaberathna.web.action;

import com.disuraaberathna.core.mail.FundTransferOtpMail;
import com.disuraaberathna.core.model.Customer;
import com.disuraaberathna.core.provider.MailServiceProvider;
import com.disuraaberathna.core.service.CustomerService;
import com.disuraaberathna.core.service.ScheduleTransferService;
import com.disuraaberathna.core.util.Validator;
import com.disuraaberathna.core.util.VerificationCodeGenerator;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.annotation.security.DeclareRoles;
import jakarta.ejb.EJB;
import jakarta.inject.Inject;
import jakarta.security.enterprise.SecurityContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.security.Principal;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@DeclareRoles({"CUSTOMER"})
@ServletSecurity(@HttpConstraint(rolesAllowed = "CUSTOMER"))
@WebServlet("/schedule-fund-transfer")
public class ScheduleFundTransfer extends HttpServlet {
    @EJB
    private CustomerService customerService;

    @EJB
    private ScheduleTransferService scheduleTransferService;

    @Inject
    private SecurityContext securityContext;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Gson gson = new Gson();
        JsonObject json = gson.fromJson(req.getReader(), JsonObject.class);

        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");

        Map<String, String> errors = new HashMap<>();
        Map<String, Object> responseData = new HashMap<>();

        String fromAccountNo = json.get("fromAccount").getAsString();
        String toAccountNo = json.get("toAccount").getAsString();
        String amountString = json.get("amount").getAsString();

        double amount = Double.parseDouble(amountString);

        LocalDateTime dateTime = null;
        if (json.has("date")) {
            try {
                dateTime = LocalDateTime.parse(json.get("date").getAsString());
            } catch (Exception e) {
                errors.put("date", "Invalid date format.");
            }
        }

        if (fromAccountNo == null || fromAccountNo.trim().isEmpty()) {
            errors.put("fromAccountNo", "Please select your account.");
        }

        if (toAccountNo == null || toAccountNo.trim().isEmpty()) {
            errors.put("toAccountNo", "Please enter recipient account number.");
        }

        if (toAccountNo != null && toAccountNo.length() < 13 && !Validator.containsDigit(toAccountNo)) {
            errors.put("toAccountNo", "Please enter a valid account number.");
        }

        if (fromAccountNo != null && fromAccountNo.equals(toAccountNo)) {
            errors.put("toAccountNo", "Can not transfer to the same account.");
        }

        if (amount < 100) {
            errors.put("amount", "Amount must be greater than LKR 100.00");
        }

        if (dateTime == null) {
            errors.put("date", "Please select a schedule date and time.");
        }

        if (!errors.isEmpty()) {
            responseData.put("success", false);
            responseData.put("errors", errors);
            resp.getWriter().write(gson.toJson(responseData));
            return;
        }

        String otp = VerificationCodeGenerator.generate();
        Principal userPrincipal = securityContext.getCallerPrincipal();

        if (userPrincipal != null) {
            Customer customer = customerService.getCustomerByUsername(userPrincipal.getName());
            FundTransferOtpMail mail = new FundTransferOtpMail(customer.getEmail(), otp);
            MailServiceProvider.getInstance().sendMail(mail);
        }

        Date scheduleDate = Date.from(dateTime.atZone(ZoneId.systemDefault()).toInstant());
        Long transferId = scheduleTransferService.scheduleTransfer(fromAccountNo, toAccountNo, amount, scheduleDate, otp);

        responseData.put("success", true);
        responseData.put("transferId", transferId);
        resp.getWriter().write(gson.toJson(responseData));
    }
}
