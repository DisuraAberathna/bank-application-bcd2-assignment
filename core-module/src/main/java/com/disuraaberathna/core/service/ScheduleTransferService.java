package com.disuraaberathna.core.service;

import jakarta.ejb.Remote;

import java.util.Date;

@Remote
public interface ScheduleTransferService {
    Long scheduleTransfer(String fromAccountNo, String toAccountNo, double amount, Date date, String otp);

    boolean scheduleTransferConfirm(Long id, String otp);
}
