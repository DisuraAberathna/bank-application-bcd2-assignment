package com.disuraaberathna.core.service;

import jakarta.ejb.Remote;

@Remote
public interface TransferService {
    void transfer(String fromAccount, String toAccount, double amount);
}
