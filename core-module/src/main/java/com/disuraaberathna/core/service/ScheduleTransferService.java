package com.disuraaberathna.core.service;

import com.disuraaberathna.core.model.ScheduledTransfer;
import jakarta.ejb.Remote;

import java.util.Date;
import java.util.List;

@Remote
public interface ScheduleTransferService {
    Long scheduleTransfer(String fromAccountNo, String toAccountNo, double amount, Date date, String otp);

    boolean scheduleTransferConfirm(Long id, String otp);

    List<ScheduledTransfer> getScheduledTransfers();

    void delete(ScheduledTransfer scheduledTransfer);
}
