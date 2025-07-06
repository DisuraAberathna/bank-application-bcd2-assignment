package com.disuraaberathna.core.provider;

import com.disuraaberathna.core.mail.Mailable;
import com.disuraaberathna.core.util.Env;
import jakarta.mail.Authenticator;
import jakarta.mail.PasswordAuthentication;

import java.util.Properties;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

public class MailServiceProvider {
    private final Properties PROPS = new Properties();
    private Authenticator authenticator;
    private static MailServiceProvider instance;
    private ThreadPoolExecutor executor;
    private final BlockingQueue<Runnable> queue = new LinkedBlockingQueue<>();

    public MailServiceProvider() {
        PROPS.setProperty("mail.smtp.host", Env.get("mailtrap.host"));
        PROPS.setProperty("mail.smtp.port", Env.get("mailtrap.port"));
        PROPS.setProperty("mail.smtp.auth", "true");
        PROPS.setProperty("mail.smtp.starttls.enable", "false");
    }

    public static MailServiceProvider getInstance() {
        if (instance == null) {
            instance = new MailServiceProvider();
        }
        return instance;
    }

    public void start() {
        authenticator = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(PROPS.getProperty("mailtrap.username"), PROPS.getProperty("mailtrap.password"));
            }
        };

        executor = new ThreadPoolExecutor(5, 20, 5, TimeUnit.SECONDS, queue, new ThreadPoolExecutor.AbortPolicy());
        executor.prestartAllCoreThreads();
    }

    public void sendMail(Mailable mail) {
        queue.offer(mail);
    }

    public void shutdown() {
        if (executor != null) {
            executor.shutdown();
        }
    }

    public Properties getProps() {
        return PROPS;
    }

    public Authenticator getAuth() {
        return authenticator;
    }
}
