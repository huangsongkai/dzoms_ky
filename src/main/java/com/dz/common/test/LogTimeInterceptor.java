package com.dz.common.test;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class LogTimeInterceptor {

    @Pointcut("@annotation(com.dz.common.test.LogExecuteTime)")
    public void logTimeMethodPointcut() {

    }

    @Around("logTimeMethodPointcut()")
    public Object interceptor(ProceedingJoinPoint pjp) {
        long startTime = System.currentTimeMillis();

        Object result = null;
        try {
            result = pjp.proceed();
        } catch (Throwable e) {
            e.printStackTrace(System.out);
            throw new RuntimeException(e);
        }
        System.out.println(pjp.getSignature().getDeclaringTypeName() + "." + pjp.getSignature().getName() + " spend " + (System.currentTimeMillis() - startTime) + "ms");
        return result;
    }
}
