package com.dz.common.test;

import com.dz.module.vehicle.MailReceiver;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 * 用于提供Spring的 ApplicationContext 对象
 */
public class SpringContextListener implements ServletContextListener{

    private static ApplicationContext springContext = null;
    private static SpringContextListener instance = null;
    private ScheduledExecutorService executor;

    // Public constructor is required by servlet spec
    public SpringContextListener() {
        executor = Executors.newScheduledThreadPool(1);
        instance = this;
    }

    // -------------------------------------------------------
    // ServletContextListener implementation
    // -------------------------------------------------------
    public void contextInitialized(ServletContextEvent sce) {
        springContext = WebApplicationContextUtils.getWebApplicationContext(sce.getServletContext());
        // 获取当前时间
        long currentTime = System.currentTimeMillis();

        // 计算第一次执行任务的延迟时间
        long initialDelay = getNextExecutionDelay(currentTime);

        // 设置每天 1 点和 13 点自动执行任务
        executor.scheduleAtFixedRate(this::task, initialDelay, 12 * 60 * 60 * 1000, TimeUnit.MILLISECONDS);
    }

    public void contextDestroyed(ServletContextEvent sce) {
      /* This method is invoked when the Servlet Context 
         (the Web application) is undeployed or 
         Application Server shuts down.
      */
        stopScheduledTask();
    }

    public static ApplicationContext getApplicationContext() {
        return springContext;
    }

    /**
     * 该方法只用于测试
     * @param springContext
     */
    public static void setSpringContext(ApplicationContext springContext) {
        SpringContextListener.springContext = springContext;
    }

    private long getNextExecutionDelay(long currentTime) {
        long oneAmMillis = getTimeMillis(1, 0, 0);
        long onePmMillis = getTimeMillis(13, 0, 0);

        // 如果当前时间在 1 点和 13 点之间，则等待到下一个执行时间
        if (currentTime >= oneAmMillis && currentTime < onePmMillis) {
            return onePmMillis - currentTime;
        }

        // 如果当前时间在 13 点之后，则等待到第二天的 1 点
        if (currentTime >= onePmMillis) {
            return oneAmMillis + 24 * 60 * 60 * 1000 - currentTime;
        }

        // 如果当前时间在 1 点之前，则等待到今天的 1 点
        return oneAmMillis - currentTime;
    }

    private long getTimeMillis(int hours, int minutes, int seconds) {
        return TimeUnit.HOURS.toMillis(hours) +
                TimeUnit.MINUTES.toMillis(minutes) +
                TimeUnit.SECONDS.toMillis(seconds);
    }

    private void task() {
        // 在这里执行特定的任务逻辑
        System.out.println("开始执行定时任务");
        MailReceiver receiver = springContext.getBean(MailReceiver.class);
        receiver.doReceive(false);
    }

    public static void startTaskManual(){
        instance.executor.execute(new Runnable() {
            @Override
            public void run() {
                MailReceiver receiver = springContext.getBean(MailReceiver.class);
                receiver.doReceive(true);
            }
        });
    }

    private void stopScheduledTask() {
        executor.shutdown();
    }
}
