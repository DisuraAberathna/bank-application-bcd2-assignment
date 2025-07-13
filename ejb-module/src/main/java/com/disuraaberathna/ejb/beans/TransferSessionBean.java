package com.disuraaberathna.ejb.beans;

import com.disuraaberathna.core.enums.TransferStatus;
import com.disuraaberathna.core.model.Account;
import com.disuraaberathna.core.model.TransferHistory;
import com.disuraaberathna.core.service.AccountService;
import com.disuraaberathna.core.service.TransferService;
import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.*;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
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
    @RolesAllowed({"CUSTOMER"})
    public Long transfer(String fromAccountNo, String toAccountNo, double amount, String otp) {
        try {
            transaction.begin();
            em.joinTransaction();

            Account fromAccount = accountService.getAccountByNo(fromAccountNo);
            Account toAccount = accountService.getAccountByNo(toAccountNo);
            TransferHistory transferHistory = new TransferHistory(fromAccount, toAccount, amount, otp);

            em.persist(transferHistory);
            transaction.commit();
            return transferHistory.getId();
        } catch (Exception e) {
            rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    @RolesAllowed({"CUSTOMER"})
    public boolean transferConfirm(Long id, String otp) {
        try {
            transaction.begin();
            em.joinTransaction();

            TransferHistory transferHistory;
            try {
                transferHistory = em.createNamedQuery("TransferHistory.verify", TransferHistory.class)
                        .setParameter("id", id)
                        .setParameter("otp", otp)
                        .getSingleResult();
            } catch (NoResultException e) {
                rollback();
                return false;
            }

            transferHistory.setStatus(TransferStatus.COMPLETED);
            transferHistory.setOtp(null);
            em.merge(transferHistory);

            accountService.credit(transferHistory.getToAccount().getAccountNumber(), transferHistory.getAmount());
            accountService.debit(transferHistory.getFromAccount().getAccountNumber(), transferHistory.getAmount());

            transaction.commit();
            return true;
        } catch (Exception e) {
            rollback();
            throw new RuntimeException(e);
        }
    }

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
