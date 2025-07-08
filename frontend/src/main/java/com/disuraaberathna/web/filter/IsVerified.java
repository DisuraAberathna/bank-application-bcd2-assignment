package com.disuraaberathna.web.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter({"/verify-email.jsp", "/account/*"})
public class IsVerified implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        if (req.getSession().getAttribute("verified") != null && (Boolean) req.getSession().getAttribute("verified")) {
            resp.sendRedirect(req.getContextPath() + "/auth/login.jsp");
        }

        if (request.getAttribute("allow-verified") != null && (Boolean) request.getAttribute("allow-verified")) {
            request.getRequestDispatcher("/verify-email.jsp").forward(request, response);
        }

        chain.doFilter(request, response);
    }
}
