package com.disuraaberathna.core.mail;

import com.disuraaberathna.core.provider.MailServiceProvider;
import com.disuraaberathna.core.util.Env;
import jakarta.mail.Message;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public abstract class Mailable implements Runnable {
    private final MailServiceProvider mailServiceProvider;

    public Mailable() {
        this.mailServiceProvider = MailServiceProvider.getInstance();
    }

    @Override
    public void run() {
        try {
            Session session = Session.getInstance(mailServiceProvider.getProps(), mailServiceProvider.getAuth());

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(Env.get("mailtrap.email")));
            build(message);
            Transport.send(message);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    abstract void build(Message message) throws Exception;
}
