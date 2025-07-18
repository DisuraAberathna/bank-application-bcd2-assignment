package com.disuraaberathna.ejb.timers;

import com.disuraaberathna.core.annotation.Performance;
import com.disuraaberathna.core.enums.AccountType;
import com.disuraaberathna.core.enums.TransferStatus;
import com.disuraaberathna.core.model.TransferHistory;
import com.disuraaberathna.core.service.AccountService;
import com.disuraaberathna.core.service.TransferService;
import jakarta.annotation.security.RunAs;
import jakarta.ejb.*;

import java.util.Calendar;
import java.util.Date;

@Startup
@Singleton
@Performance
@RunAs("SYSTEM")
public class InterestCalculatorBean {
    @EJB
    private AccountService accountService;

    @EJB
    private TransferService transferService;

    @Schedule(dayOfMonth = "Last", hour = "23", minute = "59", second = "59")
    @Lock(LockType.WRITE)
    public void doTask() {
        accountService.getAccounts().forEach(account -> {
            Date createdAt = account.getCreatedAt();
            Calendar cal = Calendar.getInstance();
            cal.setTime(createdAt);
            int dayOfMonth = cal.get(Calendar.DAY_OF_MONTH);

            if (dayOfMonth <= 28 && account.getAccountType() == AccountType.SAVINGS) {
                double balance = account.getBalance();
                double interest = calculateInterest(balance);

                double toAccountBalance = accountService.credit(account.getAccountNumber(), interest);

                TransferHistory transferHistory = new TransferHistory(null, account, interest, null);
                transferHistory.setToAccountBalance(toAccountBalance);
                transferHistory.setStatus(TransferStatus.COMPLETED);

                transferService.addInterest(transferHistory);
            }
        });
    }

    private double calculateInterest(double balance) {
        double interestRate = 0.06;
        return Math.round(balance * interestRate * 100.0) / 100.0;
    }
}
