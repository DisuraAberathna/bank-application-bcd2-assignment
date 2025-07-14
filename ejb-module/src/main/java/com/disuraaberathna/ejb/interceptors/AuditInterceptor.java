package com.disuraaberathna.ejb.interceptors;

import com.disuraaberathna.core.annotation.Audit;
import jakarta.annotation.Priority;
import jakarta.annotation.Resource;
import jakarta.ejb.SessionContext;
import jakarta.interceptor.AroundInvoke;
import jakarta.interceptor.Interceptor;
import jakarta.interceptor.InvocationContext;

import java.time.LocalDateTime;

@Interceptor
@Audit
@Priority(1)
public class AuditInterceptor {
    @Resource
    private SessionContext sessionContext;

    @AroundInvoke
    public Object logOperation(InvocationContext ctx) throws Exception {
        String methodName = ctx.getMethod().getName();
        String className = ctx.getTarget().getClass().getSimpleName();
        String user = sessionContext.getCallerPrincipal() != null ?
                sessionContext.getCallerPrincipal().getName() : "UNKNOWN";
        LocalDateTime time = LocalDateTime.now();

        System.out.println("[AuditInterceptor] " + user + " accessed " + className + "." + methodName + " at " + time);

        return ctx.proceed();
    }
}
