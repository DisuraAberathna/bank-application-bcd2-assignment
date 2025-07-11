package com.disuraaberathna.web.action;

import com.disuraaberathna.core.dto.AccountDTO;
import com.disuraaberathna.core.model.Account;
import com.disuraaberathna.core.model.Customer;
import com.disuraaberathna.core.service.AccountService;
import com.disuraaberathna.core.service.CustomerService;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
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
import java.util.List;

@DeclareRoles({"CUSTOMER"})
@ServletSecurity(@HttpConstraint(rolesAllowed = "CUSTOMER"))
@WebServlet("/load-my-accounts")
public class LoadCustomerAccounts extends HttpServlet {
    @EJB
    private CustomerService customerService;

    @EJB
    private AccountService accountService;

    @Inject
    private SecurityContext securityContext;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Principal userPrincipal = securityContext.getCallerPrincipal();

        if (userPrincipal != null) {
            Customer customer = customerService.getCustomerByUsername(userPrincipal.getName());

            List<Account> accounts = accountService.getCustomerAccounts(customer);
            JsonArray jsonArray = new JsonArray();
            Gson gson = new Gson();
            JsonObject respObj = new JsonObject();

            for (Account account : accounts) {
                String type = account.getAccountType() != null ? account.getAccountType().toString().toLowerCase() : "";
                AccountDTO accountDTO = new AccountDTO(account.getAccountNumber(), type, account.getBalance());
                jsonArray.add(gson.toJsonTree(accountDTO));
            }

            respObj.add("accounts", jsonArray);
            respObj.addProperty("success", true);

            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(gson.toJson(respObj));
        }
    }
}
