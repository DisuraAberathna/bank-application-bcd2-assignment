package com.disuraaberathna.core.service;

import com.disuraaberathna.core.enums.AccountType;
import com.disuraaberathna.core.model.Account;
import com.disuraaberathna.core.model.Customer;
import jakarta.ejb.Remote;

import java.util.List;

@Remote
public interface AccountService {
    List<Account> getCustomerAccounts(Customer customer);

    List<Account> getAccounts();

    Account getAccountByNo(String accountNo);

    void addAccount(Double deposit, String email, AccountType type);

    double credit(String accountNo, double amount);

    double debit(String accountNo, double amount);

    void updateAccount(Account account);

    void deleteAccount(Account account);
}
