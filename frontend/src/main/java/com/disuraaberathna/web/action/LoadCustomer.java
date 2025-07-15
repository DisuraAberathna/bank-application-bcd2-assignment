package com.disuraaberathna.web.action;

import com.disuraaberathna.core.dto.AccountDTO;
import com.disuraaberathna.core.dto.CustomerDTO;
import com.disuraaberathna.core.model.Customer;
import com.disuraaberathna.core.model.TransferHistory;
import com.disuraaberathna.core.service.CustomerService;
import com.disuraaberathna.core.service.TransferService;
import com.disuraaberathna.core.util.Validator;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
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
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

@DeclareRoles({"USER", "ADMIN"})
@ServletSecurity(@HttpConstraint(rolesAllowed = {"USER", "ADMIN"}))
@WebServlet("/load-customer")
public class LoadCustomer extends HttpServlet {
    @EJB
    private CustomerService customerService;

    @EJB
    private TransferService transferService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Gson gson = new Gson();
        JsonObject json = gson.fromJson(req.getReader(), JsonObject.class);

        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");

        String nic = json.get("nic").getAsString();

        Map<String, String> errors = new HashMap<>();
        Map<String, Object> responseData = new HashMap<>();

        if (!Validator.validateNic(nic)) {
            errors.put("nic", "Please enter a valid nic number.");
        }

        if (!errors.isEmpty()) {
            responseData.put("success", false);
            responseData.put("errors", errors);
            resp.getWriter().write(gson.toJson(responseData));
            return;
        }

        Customer customer = customerService.findCustomerByNic(nic);

        if (customer != null) {
            CustomerDTO customerDTO = new CustomerDTO();
            customerDTO.setName(customer.getFirstName() + " " + customer.getLastName());
            customerDTO.setEmail(customer.getEmail());
            customerDTO.setMobile(customer.getContact());
            customerDTO.setNic(customer.getNic());
            customerDTO.setVerified(customer.isVerified());

            JsonArray jsonArray = new JsonArray();

            customer.getAccounts().forEach(account -> {
                TransferHistory transferHistory = transferService.getLastTransferHistory(account.getAccountNumber());

                AccountDTO accountDTO = new AccountDTO(account.getAccountNumber(), account.getAccountType().toString().toLowerCase(), account.getBalance());
                if (transferHistory != null) {
                    accountDTO.setLastTransactionDate(new SimpleDateFormat("yyyy/MM/dd hh.mm a").format(transferHistory.getCreatedAt()));
                }

                jsonArray.add(gson.toJsonTree(accountDTO));
            });

            responseData.put("success", true);
            responseData.put("customer", customerDTO);
            responseData.put("accounts", jsonArray);
        }

        resp.getWriter().write(gson.toJson(responseData));
    }
}
