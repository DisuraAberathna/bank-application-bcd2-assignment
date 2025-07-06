package com.disuraaberathna.core.mail;

import com.disuraaberathna.core.util.Env;
import jakarta.mail.Message;
import jakarta.mail.internet.InternetAddress;

import java.util.Base64;

public class VerificationMail extends Mailable {
    private final String TO;
    private final String VERIFICATION_CODE;

    public VerificationMail(String to, String verificationCode) {
        this.TO = to;
        this.VERIFICATION_CODE = verificationCode;
    }

    @Override
    public void build(Message message) throws Exception {
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(TO));
        message.setSubject("Verify Your Email Address - Bank App");

        String encodedEmail = Base64.getEncoder().encodeToString(TO.getBytes());
        String encodedVerificationCode = Base64.getEncoder().encodeToString(VERIFICATION_CODE.getBytes());
        String link = Env.get("app.path") + "/verify?id=" + encodedEmail + "&vc=" + encodedVerificationCode;

        String mailBody = "<body style='font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px;'>\n" +
                "  <div style='max-width: 600px; margin: auto; background-color: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1);'>\n" +
                "    <h2 style='color: #333;'>Verify Your Email Address</h2>\n" +
                "    <p>Hi there,</p>\n" +
                "    <p>Thank you for registering! Please click the button below to verify your email address:</p>\n" +
                "    \n" +
                "    <p style='text-align: center; margin: 30px 0;'>\n" +
                "      <a href=" + link + " style=\" background-color: #4CAF50; color: white; padding: 14px 25px; text-align: center; text-decoration: none; display: inline-block; border-radius: 5px;\">Verify Email</a>\n" +
                "    </p>\n" +
                "\n" +
                "    <p>If the button doesn't work, you can also copy and paste the following link into your browser:</p>\n" +
                "    <p><a href=" + link + ">" + link + "</a></p>\n" +
                "\n" +
                "    <p style='margin-top: 40px;'>Thanks,<br>Bank App</p>\n" +
                "  </div>";

        message.setContent(mailBody, "text/html; charset=utf-8");
    }
}
