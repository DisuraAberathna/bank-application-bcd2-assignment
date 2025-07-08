package com.disuraaberathna.web.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;

import java.io.IOException;

@WebFilter({"/verify-email.jsp"})
public class IsVerified implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        if (request.getAttribute("verified") != null && (Boolean) request.getAttribute("verified")) {
            request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
        }

        chain.doFilter(request, response);
    }
}
