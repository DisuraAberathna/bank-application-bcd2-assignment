package com.disuraaberathna.core.service;

import com.disuraaberathna.core.model.ScheduledTransfer;
import jakarta.ejb.Remote;

@Remote
public interface TransferService {
    Long transfer(String fromAccountNo, String toAccountNo, double amount, String otp);

    boolean transferConfirm(Long id, String otp);

    void saveScheduledTransfer(ScheduledTransfer scheduledTransfer);
}
