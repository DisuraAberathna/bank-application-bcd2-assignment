package com.disuraaberathna.ejb.timers;

import com.disuraaberathna.core.enums.TransferStatus;
import com.disuraaberathna.core.service.ScheduleTransferService;
import com.disuraaberathna.core.service.TransferService;
import jakarta.annotation.security.PermitAll;
import jakarta.ejb.*;

import java.util.Date;

@Startup
@Singleton
@PermitAll
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
            }
        });
    }
}
