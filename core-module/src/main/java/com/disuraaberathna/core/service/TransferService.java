package com.disuraaberathna.core.service;

import com.disuraaberathna.core.model.ScheduledTransfer;
import com.disuraaberathna.core.model.TransferHistory;
import jakarta.ejb.Remote;

import java.util.List;

@Remote
public interface TransferService {
    Long transfer(String fromAccountNo, String toAccountNo, double amount, String otp);

    boolean transferConfirm(Long id, String otp);

    void saveScheduledTransfer(ScheduledTransfer scheduledTransfer);

    List<TransferHistory> getTransferHistory(String accNo);

    void addInterest(TransferHistory transferHistory);
}
