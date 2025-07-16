package com.disuraaberathna.ejb.beans;

import com.disuraaberathna.core.annotation.Audit;
import com.disuraaberathna.core.annotation.Performance;
import com.disuraaberathna.core.enums.TransferStatus;
import com.disuraaberathna.core.model.Account;
import com.disuraaberathna.core.model.ScheduledTransfer;
import com.disuraaberathna.core.model.TransferHistory;
import com.disuraaberathna.core.service.AccountService;
import com.disuraaberathna.core.service.TransferService;
import jakarta.annotation.security.PermitAll;
import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.*;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.*;

import java.util.List;

@Stateless
@Audit
@Performance
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
                transferHistory = em.createNamedQuery("TransferHistory.verify", TransferHistory.class).setParameter("id", id).setParameter("otp", otp).getSingleResult();
            } catch (NoResultException e) {
                return false;
            }

            double fromAccountBalance = accountService.debit(transferHistory.getFromAccount().getAccountNumber(), transferHistory.getAmount());
            double toAccountBalance = accountService.credit(transferHistory.getToAccount().getAccountNumber(), transferHistory.getAmount());

            transferHistory.setFromAccountBalance(fromAccountBalance);
            transferHistory.setToAccountBalance(toAccountBalance);
            transferHistory.setStatus(TransferStatus.COMPLETED);
            transferHistory.setOtp(null);

            em.merge(transferHistory);
            transaction.commit();
            return true;
        } catch (Exception e) {
            rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    @RolesAllowed("SYSTEM")
    public void saveScheduledTransfer(ScheduledTransfer scheduledTransfer) {
        try {
            transaction.begin();
            em.joinTransaction();

            double amount = scheduledTransfer.getAmount();
            Account fromAccount = scheduledTransfer.getFromAccount();
            Account toAccount = scheduledTransfer.getToAccount();

            double fromAccountBalance = accountService.debit(fromAccount.getAccountNumber(), amount);
            double toAccountBalance = accountService.credit(toAccount.getAccountNumber(), amount);

            TransferHistory transferHistory = new TransferHistory(fromAccount, toAccount, amount, null);
            transferHistory.setStatus(TransferStatus.COMPLETED);
            transferHistory.setFromAccountBalance(fromAccountBalance);
            transferHistory.setToAccountBalance(toAccountBalance);

            em.persist(transferHistory);
            transaction.commit();
        } catch (Exception e) {
            rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    @PermitAll
    public List<TransferHistory> getTransferHistory(String accNo) {
        try {
            transaction.begin();
            em.joinTransaction();

            Account account = accountService.getAccountByNo(accNo);
            List<TransferHistory> transferHistory = em.createNamedQuery("TransferHistory.getHistoryByAccount", TransferHistory.class).setParameter("account", account).getResultList();

            transaction.commit();
            return transferHistory;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    @RolesAllowed({"USER", "ADMIN", "SUPER_ADMIN"})
    public TransferHistory getLastTransferHistory(String accNo) {
        try {
            transaction.begin();
            em.joinTransaction();

            Account account = accountService.getAccountByNo(accNo);
            TransferHistory transferHistory = null;
            try {
                transferHistory = em.createNamedQuery("TransferHistory.getHistoryByAccount", TransferHistory.class)
                        .setParameter("account", account).setMaxResults(1).getSingleResult();
            } catch (NoResultException e) {

            }

            transaction.commit();
            return transferHistory;
        } catch (Exception e) {
            rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    @PermitAll
    public void addInterest(TransferHistory transferHistory) {
        try {
            transaction.begin();
            em.joinTransaction();

            em.persist(transferHistory);

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
