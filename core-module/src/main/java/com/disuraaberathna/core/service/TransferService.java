package com.disuraaberathna.core.service;

import jakarta.ejb.Remote;

@Remote
public interface TransferService {
    Long transfer(String fromAccountNo, String toAccountNo, double amount, String otp);

    boolean transferConfirm(Long id, String otp);
}
