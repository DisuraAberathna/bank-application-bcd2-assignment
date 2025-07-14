package com.disuraaberathna.ejb.timers;

import com.disuraaberathna.core.service.AccountService;
import com.disuraaberathna.core.service.TransferService;
import jakarta.annotation.security.PermitAll;
import jakarta.ejb.*;

@Startup
@Singleton
@PermitAll
public class InterestCalculatorBean {
    @EJB
    private AccountService accountService;

    @EJB
    private TransferService transferService;

    @Schedule(dayOfMonth = "L", hour = "12", minute = "00", second = "00")
    @Lock(LockType.WRITE)
    public void doTask() {

    }
}
