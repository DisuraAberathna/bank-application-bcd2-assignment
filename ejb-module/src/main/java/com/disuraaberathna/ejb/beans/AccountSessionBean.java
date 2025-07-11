package com.disuraaberathna.ejb.beans;

import com.disuraaberathna.core.enums.AccountType;
import com.disuraaberathna.core.model.Account;
import com.disuraaberathna.core.model.Customer;
import com.disuraaberathna.core.service.AccountService;
import com.disuraaberathna.core.service.CustomerService;
import com.disuraaberathna.core.util.AccountNumberGenerator;
import jakarta.annotation.security.DenyAll;
import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

import java.util.List;

@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
public class AccountSessionBean implements AccountService {
    @PersistenceContext
    private EntityManager em;

    @EJB
    private CustomerService customerService;

    @Override
    public List<Account> getCustomerAccounts(Customer customer) {
        return em.createNamedQuery("Account.findCustomerAccounts", Account.class).setParameter("customer", customer).getResultList();
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.MANDATORY)
    public Account getAccountByNo(String accountNo) {
        try {
            TypedQuery<Account> query = em.createNamedQuery("Account.findByAccountNo", Account.class).setParameter("accountNo", accountNo);
            return query.getSingleResult();
        } catch (NullPointerException e) {
            return null;
        }
    }

    @Override
    @RolesAllowed({"USER", "ADMIN", "SUPER_ADMIN"})
    public void addAccount(Double deposit, String email, AccountType type) {
        String accountNumber = AccountNumberGenerator.generate();

        Customer customer = customerService.getCustomerByEmail(email);
        Account account = new Account(customer, deposit, accountNumber, type);

        em.persist(account);
    }

    @Override
    @RolesAllowed({"USER", "ADMIN", "SUPER_ADMIN"})
    public void updateAccount(Account account) {
        em.merge(account);
    }

    @Override
    @DenyAll
    public void deleteAccount(Account account) {
        em.remove(account);
    }
}
