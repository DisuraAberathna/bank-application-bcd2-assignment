package com.disuraaberathna.core.service;

import jakarta.ejb.Remote;

@Remote
public interface TransferService {
    void transfer(String fromAccountNo, String toAccountNo, double amount, String otp);

    void transferConfirm(String fromAccountNo, String toAccountNo, double amount, String otp);
}
