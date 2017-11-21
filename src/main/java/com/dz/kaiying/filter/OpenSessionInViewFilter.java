package com.dz.kaiying.filter;

//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

import org.hibernate.FlushMode;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.orm.hibernate4.SessionFactoryUtils;
import org.springframework.orm.hibernate4.SessionHolder;
import org.springframework.transaction.support.TransactionSynchronizationManager;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.async.WebAsyncManager;
import org.springframework.web.context.request.async.WebAsyncUtils;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class OpenSessionInViewFilter extends OncePerRequestFilter {
    public static final String DEFAULT_SESSION_FACTORY_BEAN_NAME = "sessionFactory";
    private String sessionFactoryBeanName = "sessionFactory";

    public OpenSessionInViewFilter() {
    }

    public void setSessionFactoryBeanName(String sessionFactoryBeanName) {
        this.sessionFactoryBeanName = sessionFactoryBeanName;
    }

    protected String getSessionFactoryBeanName() {
        return this.sessionFactoryBeanName;
    }

    protected boolean shouldNotFilterAsyncDispatch() {
        return false;
    }

    protected boolean shouldNotFilterErrorDispatch() {
        return false;
    }

    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        SessionFactory sessionFactory = this.lookupSessionFactory(request);
        boolean participate = false;
        WebAsyncManager asyncManager = WebAsyncUtils.getAsyncManager(request);
        String key = this.getAlreadyFilteredAttributeName();
        if(TransactionSynchronizationManager.hasResource(sessionFactory)) {
            participate = true;
        } else {
            boolean sessionHolder = !this.isAsyncDispatch(request);
            if(sessionHolder || !this.applySessionBindingInterceptor(asyncManager, key)) {
                this.logger.debug("Opening Hibernate Session in OpenSessionInViewFilter");
                Session session = this.openSession(sessionFactory);
                SessionHolder sessionHolder1 = new SessionHolder(session);
                TransactionSynchronizationManager.bindResource(sessionFactory, sessionHolder1);

                AsyncRequestInterceptor interceptor = new AsyncRequestInterceptor(sessionFactory, sessionHolder1);
                asyncManager.registerCallableInterceptor(key, interceptor);
                asyncManager.registerDeferredResultInterceptor(key, interceptor);
            }
        }

        boolean var15 = false;

        try {
            var15 = true;
            filterChain.doFilter(request, response);
            var15 = false;
        } finally {
            if(var15) {
                if(!participate) {
                    SessionHolder sessionHolder2 = (SessionHolder)TransactionSynchronizationManager.unbindResource(sessionFactory);
                    if(!this.isAsyncStarted(request)) {
                        this.logger.debug("Closing Hibernate Session in OpenSessionInViewFilter");
                        SessionFactoryUtils.closeSession(sessionHolder2.getSession());
                    }
                }

            }
        }

        if(!participate) {
            SessionHolder sessionHolder3 = (SessionHolder)TransactionSynchronizationManager.unbindResource(sessionFactory);
            if(!this.isAsyncStarted(request)) {
                this.logger.debug("Closing Hibernate Session in OpenSessionInViewFilter");
                SessionFactoryUtils.closeSession(sessionHolder3.getSession());
            }
        }

    }

    protected SessionFactory lookupSessionFactory(HttpServletRequest request) {
        return this.lookupSessionFactory();
    }

    protected SessionFactory lookupSessionFactory() {
        if(this.logger.isDebugEnabled()) {
            this.logger.debug("Using SessionFactory \'" + this.getSessionFactoryBeanName() + "\' for OpenSessionInViewFilter");
        }

        WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(this.getServletContext());
        return (SessionFactory)wac.getBean(this.getSessionFactoryBeanName(), SessionFactory.class);
    }

    protected Session openSession(SessionFactory sessionFactory) throws DataAccessResourceFailureException {
        try {
            Session ex = sessionFactory.openSession();
            ex.setFlushMode(FlushMode.AUTO);
            return ex;
        } catch (HibernateException var3) {
            throw new DataAccessResourceFailureException("Could not open Hibernate Session", var3);
        }
    }

    private boolean applySessionBindingInterceptor(WebAsyncManager asyncManager, String key) {
        if(asyncManager.getCallableInterceptor(key) == null) {
            return false;
        } else {
            ((AsyncRequestInterceptor)asyncManager.getCallableInterceptor(key)).bindSession();
            return true;
        }
    }
}
