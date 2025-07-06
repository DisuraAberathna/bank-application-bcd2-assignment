package com.disuraaberathna.web.action;

import com.disuraaberathna.core.exception.LoginFailedException;
import jakarta.inject.Inject;
import jakarta.security.enterprise.AuthenticationStatus;
import jakarta.security.enterprise.SecurityContext;
import jakarta.security.enterprise.authentication.mechanism.http.AuthenticationParameters;
import jakarta.security.enterprise.credential.UsernamePasswordCredential;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/auth/login")
public class Login extends HttpServlet {
    @Inject
    private SecurityContext securityContext;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        Map<String, String> errors = new HashMap<>();

        if (username == null || username.trim().isEmpty()) {
            errors.put("username", "Please enter your username.");
        }

        if (password == null || password.trim().isEmpty()) {
            errors.put("password", "Please enter your password.");
        }

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.getRequestDispatcher(req.getContextPath() + "/auth/login.jsp").forward(req, resp);
            return;
        }

        AuthenticationParameters params = AuthenticationParameters.withParams().credential(new UsernamePasswordCredential(username, password));

        AuthenticationStatus status = securityContext.authenticate(req, resp, params);
        if (status == AuthenticationStatus.SUCCESS) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
        } else {
            errors.put("username", "Invalid username or password.");
            req.setAttribute("errors", errors);
            req.getRequestDispatcher(req.getContextPath() + "/auth/login.jsp").forward(req, resp);
        }
    }
}
