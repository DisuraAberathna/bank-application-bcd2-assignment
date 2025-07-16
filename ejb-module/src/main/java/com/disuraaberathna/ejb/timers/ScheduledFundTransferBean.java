package com.disuraaberathna.ejb.timers;

import com.disuraaberathna.core.enums.TransferStatus;
import com.disuraaberathna.core.mail.ScheduledTransferErrorMail;
import com.disuraaberathna.core.provider.MailServiceProvider;
import com.disuraaberathna.core.service.ScheduleTransferService;
import com.disuraaberathna.core.service.TransferService;
import jakarta.annotation.security.RunAs;
import jakarta.ejb.*;

import java.util.Date;

@Startup
@Singleton
@RunAs("SYSTEM")
public class ScheduledFundTransferBean {
    @EJB
    private TransferService transferService;

    @EJB
    private ScheduleTransferService scheduleTransferService;

    @Schedule(hour = "*", minute = "*", second = "*/30")
    @Lock(LockType.WRITE)
    public void doTask() {
        Date now = new Date();

        scheduleTransferService.getScheduledTransfers().forEach(scheduledTransfer -> {
            Date scheduledDate = scheduledTransfer.getScheduledDate();
            long diff = Math.abs(now.getTime() - scheduledDate.getTime());

            if (diff <= 15000 && scheduledTransfer.getStatus() == TransferStatus.VERIFIED &&
                    scheduledTransfer.getFromAccount().getBalance() - scheduledTransfer.getAmount() > 1000) {
                transferService.saveScheduledTransfer(scheduledTransfer);
                scheduleTransferService.delete(scheduledTransfer);
            } else {
                String reason = "";

                if (scheduledTransfer.getStatus() != TransferStatus.VERIFIED) {
                    reason = "Transfer is not verified.";
                } else if (scheduledTransfer.getFromAccount().getBalance() - scheduledTransfer.getAmount() <= 1000) {
                    reason = "Insufficient balance. Minimum balance must be maintained.";
                }

                if (!reason.isEmpty()) {
                    ScheduledTransferErrorMail mail = new ScheduledTransferErrorMail(
                            scheduledTransfer.getToAccount().getCustomer().getEmail(),
                            scheduledTransfer.getToAccount().getAccountNumber(),
                            scheduledTransfer.getFromAccount().getCustomer().getFirstName() + " " + scheduledTransfer.getFromAccount().getCustomer().getLastName(),
                            scheduledTransfer.getScheduledDate().toString(),
                            reason
                    );
                    MailServiceProvider.getInstance().sendMail(mail);
                }
            }
        });
    }
}
