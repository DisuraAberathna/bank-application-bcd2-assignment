package com.disuraaberathna.web.action;

import com.disuraaberathna.core.dto.TransferHistoryDTO;
import com.disuraaberathna.core.service.TransferService;
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
import java.util.HashMap;
import java.util.Map;

@DeclareRoles({"CUSTOMER"})
@ServletSecurity(@HttpConstraint(rolesAllowed = "CUSTOMER"))
@WebServlet("/load-my-transfer-history")
public class LoadCustomerTransferHistory extends HttpServlet {
    @EJB
    private TransferService transferService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Gson gson = new Gson();
        JsonObject json = gson.fromJson(req.getReader(), JsonObject.class);

        String accNo = json.get("accNo").getAsString();
        Map<String, Object> responseData = new HashMap<>();

        if (accNo != null && !accNo.isEmpty()) {
            JsonArray jsonArray = new JsonArray();

            transferService.getTransferHistory(accNo).forEach(transferHistory -> {
                TransferHistoryDTO transferHistoryDTO = new TransferHistoryDTO();
                transferHistoryDTO.setAmount(transferHistory.getAmount());
                transferHistoryDTO.setDate(transferHistory.getCreatedAt().toString());

                if (accNo.equals(transferHistory.getFromAccount().getAccountNumber())) {
                    transferHistoryDTO.setCreditor(false);
                    transferHistoryDTO.setBalance(transferHistory.getFromAccountBalance());
                    transferHistoryDTO.setDescription("Fund Transfer to" + transferHistory.getToAccount().getAccountNumber());
                }

                if (accNo.equals(transferHistory.getToAccount().getAccountNumber())) {
                    transferHistoryDTO.setCreditor(true);
                    transferHistoryDTO.setBalance(transferHistory.getToAccountBalance());

                    if (transferHistory.getFromAccount() == null) {
                        transferHistoryDTO.setDescription("Interest Credit");
                    } else {
                        transferHistoryDTO.setDescription("Fund Transfer from" + transferHistory.getFromAccount().getAccountNumber());
                    }
                }

                jsonArray.add(gson.toJsonTree(transferHistoryDTO));
            });

            responseData.put("transferHistory", jsonArray);
            responseData.put("success", true);
        }

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(gson.toJson(responseData));
    }
}
