package com.dz.common.test;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * 用于提供Spring的 ApplicationContext 对象
 */
public class SpringContextListener implements ServletContextListener{

    private static WebApplicationContext springContext;
    // Public constructor is required by servlet spec
    public SpringContextListener() {
    }

    // -------------------------------------------------------
    // ServletContextListener implementation
    // -------------------------------------------------------
    public void contextInitialized(ServletContextEvent sce) {
        springContext = WebApplicationContextUtils.getWebApplicationContext(sce.getServletContext());
    }

    public void contextDestroyed(ServletContextEvent sce) {
      /* This method is invoked when the Servlet Context 
         (the Web application) is undeployed or 
         Application Server shuts down.
      */
    }

    public static ApplicationContext getApplicationContext() {
        return springContext;
    }
}
