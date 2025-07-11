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
        message.setSubject("Verify Your Email Address - National Bank");

        String link = Env.get("app.path") + "/auth/register.jsp";

        String mailBody = "<div style='font-family: Arial, sans-serif; background-color: #f6f9fc; padding: 20px; margin: 0;'>\n" +
                "  <div style='max-width: 600px; background-color: #ffffff; padding: 30px; margin: auto; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);'>\n" +
                "    <div style='text-align: center; background-color: #4CAF50; color: #ffffff; padding: 30px 0; border-radius: 8px 8px 0 0;'>\n" +
                "      <h1 style='margin: 0; font-weight: 600; font-size: 24px;'>Welcome to National Bank</h1>\n" +
                "    </div>\n" +
                "    <div style='padding: 20px; color: #333333;'>\n" +
                "      <p>Dear Customer,</p>\n" +
                "      <p>Your account has been successfully registered by our staff. To activate your account, please use the following OTP:</p>\n" +
                "      <div style='background-color: #e1fce2; padding: 20px; border-radius: 6px; font-size: 18px; text-align: center; font-weight: bold; letter-spacing: 2px; margin: 20px 0;'>" + VERIFICATION_CODE + "</div>\n" +
                "      <h3 style='color: #4CAF50; font-size: 16px; font-weight: 600;'>\uD83D\uDD10 How to Register In & Verify</h3>\n" +
                "      <ul style='padding-left: 25px; padding-bottom: 15px; padding-top: 5px; list-style-type: circle; font-size: 15px;'>\n" +
                "        <li>Visit our register page: <a href=" + link + " style='color: #4CAF50;'>" + link + "</a></li>\n" +
                "        <li>Enter your own <strong>NIC</strong>, <strong>username</strong>, and <strong>password</strong> that were provided during registration.</li>\n" +
                "        <li>When prompted, enter the above OTP to verify and activate your account.</li>\n" +
                "        <li>Once verified, you can start using our online banking services.</li>\n" +
                "      </ul>\n" +
                "      <p>This OTP is valid for a limited time. If you did not request this email or have any issues, please contact our support team immediately.</p>\n" +
                "    </div>\n" +
                "    <div style='text-align: center; font-size: 13px; color: #888888; margin-top: 30px;'>&copy; 2025 National Bank. All rights reserved.</div>\n" +
                "  </div>\n" +
                "</div>";

        message.setContent(mailBody, "text/html; charset=utf-8");
    }
}
