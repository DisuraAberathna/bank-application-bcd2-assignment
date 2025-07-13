package com.disuraaberathna.ejb.beans;

import com.disuraaberathna.core.enums.TransferStatus;
import com.disuraaberathna.core.model.Account;
import com.disuraaberathna.core.model.ScheduledTransfer;
import com.disuraaberathna.core.service.AccountService;
import com.disuraaberathna.core.service.ScheduleTransferService;
import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionManagement;
import jakarta.ejb.TransactionManagementType;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Status;
import jakarta.transaction.SystemException;
import jakarta.transaction.UserTransaction;

import java.util.Date;

@Stateless
@TransactionManagement(TransactionManagementType.BEAN)
public class ScheduleTransferSessionBean implements ScheduleTransferService {
    @PersistenceContext
    private EntityManager em;

    @EJB
    private AccountService accountService;

    @Inject
    private UserTransaction transaction;

    @Override
    @RolesAllowed({"CUSTOMER"})
    public Long scheduleTransfer(String fromAccountNo, String toAccountNo, double amount, Date date, String otp) {
        try {
            transaction.begin();
            em.joinTransaction();

            Account fromAccount = accountService.getAccountByNo(fromAccountNo);
            Account toAccount = accountService.getAccountByNo(toAccountNo);
            ScheduledTransfer scheduledTransfer = new ScheduledTransfer(fromAccount, toAccount, amount, otp, date);

            em.persist(scheduledTransfer);
            transaction.commit();
            return scheduledTransfer.getId();
        } catch (Exception e) {
            rollback();
            throw new RuntimeException(e);
        }
    }

    @Override
    @RolesAllowed({"CUSTOMER"})
    public boolean scheduleTransferConfirm(Long id, String otp) {
        try {
            transaction.begin();
            em.joinTransaction();

            ScheduledTransfer scheduledTransfer;
            try {
                scheduledTransfer = em.createNamedQuery("ScheduledTransfer.verify", ScheduledTransfer.class)
                        .setParameter("id", id)
                        .setParameter("otp", otp)
                        .getSingleResult();
            } catch (NoResultException e) {
                rollback();
                return false;
            }

            scheduledTransfer.setStatus(TransferStatus.VERIFIED);
            scheduledTransfer.setOtp(null);
            em.merge(scheduledTransfer);

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
