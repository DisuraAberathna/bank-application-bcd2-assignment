package com.disuraaberathna.web.action;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.annotation.security.DeclareRoles;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@DeclareRoles({"ADMIN"})
@ServletSecurity(@HttpConstraint(rolesAllowed = {"ADMIN"}))
@WebServlet("/add-employee")
public class AddEmployee extends HttpServlet {
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
        String password = json.get("password").getAsString();
    }
}
