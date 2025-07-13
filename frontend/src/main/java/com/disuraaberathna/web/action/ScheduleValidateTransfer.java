package com.disuraaberathna.web.action;

import com.disuraaberathna.core.model.Account;
import com.disuraaberathna.core.service.AccountService;
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
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@DeclareRoles({"CUSTOMER"})
@ServletSecurity(@HttpConstraint(rolesAllowed = "CUSTOMER"))
@WebServlet("/validate-schedule-transfer")
public class ScheduleValidateTransfer extends HttpServlet {
    @EJB
    private AccountService accountService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        Gson gson = new Gson();
        JsonObject json = gson.fromJson(req.getReader(), JsonObject.class);

        Map<String, String> errors = new HashMap<>();
        Map<String, Object> responseData = new HashMap<>();

        String fromAccountNo = json.get("fromAccount").getAsString();
        String toAccountNo = json.get("toAccount").getAsString();
        double amount = json.get("amount").getAsDouble();

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

        Account toAccount = null;

        if (toAccountNo != null) {
            toAccount = accountService.getAccountByNo(toAccountNo);
        }

        if (fromAccountNo != null) {
            Account fromAccount = accountService.getAccountByNo(fromAccountNo);
            if (fromAccount.getBalance() - amount < 1000) {
                errors.put("amount", "Can not continue with your selected account, cause to low balance");
            }
        }

        if (toAccount == null) {
            errors.put("toAccountNo", "Please enter a valid account number.");
        }

        if (!errors.isEmpty()) {
            responseData.put("success", false);
            responseData.put("errors", errors);
            resp.getWriter().write(gson.toJson(responseData));
            return;
        }

        String toName = toAccount.getCustomer().getFirstName() + " " + toAccount.getCustomer().getLastName();
        JsonObject object = new JsonObject();
        object.addProperty("fromAccountNo", fromAccountNo);
        object.addProperty("toAccountNo", toAccountNo);
        object.addProperty("amount", amount);
        object.addProperty("toName", toName);
        object.addProperty("scheduledDate", dateTime.toString());

        responseData.put("success", true);
        responseData.put("transferData", object);
        resp.getWriter().write(gson.toJson(responseData));
    }
}
