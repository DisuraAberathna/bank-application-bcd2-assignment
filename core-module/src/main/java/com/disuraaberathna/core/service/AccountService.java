package com.disuraaberathna.core.service;

import com.disuraaberathna.core.model.Account;
import jakarta.ejb.Remote;

@Remote
public interface AccountService {
    void addAccount(Double deposit, String email);

    void updateAccount(Account account);

    void deleteAccount(Account account);
}
