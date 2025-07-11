package com.disuraaberathna.ejb.beans;

import com.disuraaberathna.core.model.Account;
import com.disuraaberathna.core.model.TransferHistory;
import com.disuraaberathna.core.service.AccountService;
import com.disuraaberathna.core.service.TransferService;
import jakarta.ejb.*;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.*;

@Stateless
@TransactionManagement(TransactionManagementType.BEAN)
public class TransferSessionBean implements TransferService {
    @PersistenceContext
    private EntityManager em;

    @EJB
    private AccountService accountService;

    @Inject
    private UserTransaction transaction;

    @Override
    public void transfer(String fromAccountNo, String toAccountNo, double amount, String otp) {
        try {
            transaction.begin();
            em.joinTransaction();

            Account fromAccount = accountService.getAccountByNo(fromAccountNo);
            Account toAccount = accountService.getAccountByNo(toAccountNo);
            TransferHistory transferHistory = new TransferHistory(fromAccount, toAccount, amount, otp);

            em.persist(transferHistory);
            transaction.commit();
        } catch (NotSupportedException | SystemException | HeuristicRollbackException | HeuristicMixedException |
                 RollbackException e) {
            rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    public void transferConfirm(String fromAccountNo, String toAccountNo, double amount, String otp) {

    }

    private void rollback() {
        try {
            transaction.rollback();
        } catch (SystemException e) {
            throw new RuntimeException(e);
        }
    }
}
