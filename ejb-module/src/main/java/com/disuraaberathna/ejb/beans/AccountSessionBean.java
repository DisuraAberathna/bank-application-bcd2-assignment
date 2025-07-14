package com.disuraaberathna.ejb.beans;

import com.disuraaberathna.core.enums.AccountType;
import com.disuraaberathna.core.model.Account;
import com.disuraaberathna.core.model.Customer;
import com.disuraaberathna.core.service.AccountService;
import com.disuraaberathna.core.service.CustomerService;
import com.disuraaberathna.core.util.AccountNumberGenerator;
import jakarta.annotation.security.DenyAll;
import jakarta.annotation.security.PermitAll;
import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.*;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import jakarta.transaction.Status;
import jakarta.transaction.SystemException;
import jakarta.transaction.UserTransaction;

import java.util.List;

@Stateless
@TransactionManagement(TransactionManagementType.BEAN)
public class AccountSessionBean implements AccountService {
    @PersistenceContext
    private EntityManager em;

    @EJB
    private CustomerService customerService;

    @Inject
    private UserTransaction transaction;

    @Override
    @RolesAllowed({"CUSTOMER", "USER", "ADMIN", "SUPER_ADMIN"})
    public List<Account> getCustomerAccounts(Customer customer) {
        try {
            transaction.begin();
            em.joinTransaction();

            List<Account> accounts = em.createNamedQuery("Account.findCustomerAccounts", Account.class).setParameter("customer", customer).getResultList();

            transaction.commit();
            return accounts;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    @RolesAllowed({"CUSTOMER", "USER", "ADMIN", "SUPER_ADMIN"})
    public Account getAccountByNo(String accountNo) {
        try {
            transaction.begin();
            em.joinTransaction();

            try {
                TypedQuery<Account> query = em.createNamedQuery("Account.findByAccountNo", Account.class).setParameter("accountNo", accountNo);
                Account account = query.getSingleResult();

                transaction.commit();
                return account;
            } catch (NullPointerException e) {
                return null;
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    private Account findAccountByNo(String accountNo) {
        TypedQuery<Account> query = em.createNamedQuery("Account.findByAccountNo", Account.class)
                .setParameter("accountNo", accountNo);
        return query.getSingleResult();
    }

    @Override
    @RolesAllowed({"USER", "ADMIN", "SUPER_ADMIN"})
    public void addAccount(Double deposit, String email, AccountType type) {
        try {
            transaction.begin();
            em.joinTransaction();

            String accountNumber = AccountNumberGenerator.generate();

            Customer customer = customerService.getCustomerByEmail(email);
            Account account = new Account(customer, deposit, accountNumber, type);

            em.persist(account);
            transaction.commit();
        } catch (Exception e) {
            rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    @RolesAllowed({"CUSTOMER"})
    public void credit(String accountNo, double amount) {
        try {
            transaction.begin();
            em.joinTransaction();

            Account account = findAccountByNo(accountNo);
            account.setBalance(account.getBalance() + amount);

            em.merge(account);
            transaction.commit();
        } catch (Exception e) {
            rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    @RolesAllowed({"CUSTOMER"})
    public void debit(String accountNo, double amount) {
        try {
            transaction.begin();
            em.joinTransaction();

            Account account = findAccountByNo(accountNo);
            account.setBalance(account.getBalance() - amount);

            em.merge(account);
            transaction.commit();
        } catch (Exception e) {
            rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    @RolesAllowed({"USER", "ADMIN", "SUPER_ADMIN"})
    public void updateAccount(Account account) {
        try {
            transaction.begin();
            em.joinTransaction();

            em.merge(account);
            transaction.commit();
        } catch (Exception e) {
            rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    @DenyAll
    public void deleteAccount(Account account) {
        try {
            transaction.begin();
            em.joinTransaction();

            Account managed = em.merge(account);

            em.remove(managed);
            transaction.commit();
        } catch (Exception e) {
            rollback();
            throw new RuntimeException(e);
        }
    }

    @PermitAll
    private void rollback() {
        try {
            if (transaction.getStatus() == Status.STATUS_ACTIVE) {
                transaction.rollback();
            }
        } catch (SystemException e) {
            throw new RuntimeException(e);
        }
    }
}
