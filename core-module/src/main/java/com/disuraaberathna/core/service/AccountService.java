package com.disuraaberathna.core.service;

import com.disuraaberathna.core.enums.AccountType;
import com.disuraaberathna.core.model.Account;
import com.disuraaberathna.core.model.Customer;
import jakarta.ejb.Remote;

import java.util.List;

@Remote
public interface AccountService {
    List<Account> getCustomerAccounts(Customer customer);

    Account getAccountByNo(String accountNo);

    void addAccount(Double deposit, String email, AccountType type);

    void updateAccount(Account account);

    void deleteAccount(Account account);
}
