package com.disuraaberathna.ejb.interceptors;

import com.disuraaberathna.core.annotation.Performance;
import jakarta.annotation.Priority;
import jakarta.interceptor.AroundInvoke;
import jakarta.interceptor.Interceptor;
import jakarta.interceptor.InvocationContext;

@Interceptor
@Performance
@Priority(1)
public class PerformanceInterceptor {
    @AroundInvoke
    public Object measureTime(final InvocationContext ctx) throws Exception {
        long start = System.currentTimeMillis();
        Object result = ctx.proceed();
        long end = System.currentTimeMillis();

        System.out.println("[PerformanceInterceptor] " + ctx.getMethod().getName() + " took " + (end - start) + "ms");
        return result;
    }
}
