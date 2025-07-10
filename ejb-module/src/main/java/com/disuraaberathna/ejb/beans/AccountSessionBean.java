package com.disuraaberathna.ejb.beans;

import com.disuraaberathna.core.model.Account;
import com.disuraaberathna.core.model.Customer;
import com.disuraaberathna.core.service.AccountService;
import com.disuraaberathna.core.service.CustomerService;
import com.disuraaberathna.core.util.AccountNumberGenerator;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.UUID;

@Stateless
public class AccountSessionBean implements AccountService {
    @PersistenceContext
    private EntityManager em;

    @EJB
    private CustomerService customerService;

    @Override
    public void addAccount(Double deposit, String email) {
        String accountNumber = AccountNumberGenerator.generate();

        Customer customer = customerService.getCustomerByEmail(email);
        Account account = new Account(customer, deposit, accountNumber);

        em.persist(account);
    }
}
