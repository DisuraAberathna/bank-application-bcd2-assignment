package com.disuraaberathna.web.action;

import com.disuraaberathna.core.service.TransferService;
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

@DeclareRoles({"CUSTOMER"})
@ServletSecurity(@HttpConstraint(rolesAllowed = "CUSTOMER"))
@WebServlet("/verify-transfer")
public class VerifyTransfer extends HttpServlet {

    @EJB
    private TransferService transferService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Gson gson = new Gson();
        JsonObject json = gson.fromJson(req.getReader(), JsonObject.class);

        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");

        Map<String, String> errors = new HashMap<>();
        Map<String, Object> responseData = new HashMap<>();

        String id = json.get("transferId").getAsString();
        String otp = json.get("otp").getAsString();

        if (id == null || otp == null) {
            errors.put("transferId", "Something went wrong, please try again");
        }

        if (otp == null || otp.isEmpty()) {
            errors.put("otp", "Please enter the otp you received!");
        }

        if (!errors.isEmpty()) {
            responseData.put("success", false);
            responseData.put("errors", errors);
            resp.getWriter().write(gson.toJson(responseData));
            return;
        }

        boolean status = transferService.transferConfirm(Long.parseLong(id), otp);

        if (!status) {
            errors.put("transferId", "Invalid otp, please enter correct otp");
            responseData.put("success", false);
            responseData.put("errors", errors);
            resp.getWriter().write(gson.toJson(responseData));
            return;
        }

        responseData.put("success", true);
        resp.getWriter().write(gson.toJson(responseData));
    }
}
