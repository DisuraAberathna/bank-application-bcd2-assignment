package com.disuraaberathna.core.mail;

import com.disuraaberathna.core.util.Env;
import jakarta.mail.Message;
import jakarta.mail.internet.InternetAddress;

public class ScheduledTransferErrorMail extends Mailable {
    private final String TO;
    private final String TO_ACC;
    private final String NAME;
    private final String DATE;
    private final String MESSAGE;

    public ScheduledTransferErrorMail(String TO, String TO_ACC, String NAME, String DATE, String MESSAGE) {
        this.TO = TO;
        this.TO_ACC = TO_ACC;
        this.NAME = NAME;
        this.DATE = DATE;
        this.MESSAGE = MESSAGE;
    }

    @Override
    void build(Message message) throws Exception {
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(TO));
        message.setSubject("Scheduled Transfer Error - National Bank");

        String link = Env.get("app.path") + "/account/index.jsp";

        String mailBody = "<div style='font-family: Arial, sans-serif; background-color: #f6f8fa; margin: 0; padding: 0;'>\n" +
                "  <div style='max-width: 600px; margin: 30px auto; background-color: #ffffff; border: 1px solid #e1e4e8; border-radius: 8px; padding: 30px;'>\n" +
                "    <div style='background-color: #4CAF50; color: #ffffff; padding: 20px; text-align: center; border-radius: 8px 8px 0 0;'>\n" +
                "      <h2 style='margin: 0; font-size: 24px;'>Scheduled Transfer Failed</h2>\n" +
                "    </div>\n" +
                "    <div style='padding: 20px; color: #333333;'>\n" +
                "      <p style='line-height: 1.6;'>Dear <strong>" + NAME + "</strong>,</p>\n" +
                "      <p style='line-height: 1.6;'>We attempted to process your scheduled fund transfer on <strong>" + DATE + "</strong> for the " + TO_ACC + ", but it failed due to the following reason:</p>\n" +
                "      <p style='line-height: 1.6;'><strong>" + MESSAGE + "</strong></p>\n" +
                "      <p style='line-height: 1.6;'>Please ensure that your account has sufficient balance or contact customer support for assistance.</p>\n" +
                "      <div style='text-align: center;'>\n" +
                "        <a href=" + link + " style='display: inline-block; margin: 20px 0px; background-color: #4CAF50; color: #ffffff; padding: 12px 20px; text-decoration: none; border-radius: 5px;'>View Account</a>\n" +
                "      </div>\n" +
                "      <p style='line-height: 1.6;'>If you believe this is an error, please get in touch with our support team immediately.</p>\n" +
                "    </div>\n" +
                "    <div style='margin-top: 30px; font-size: 12px; color: #888888; text-align: center;'>&copy; 2025 National Bank. All rights reserved.</div>\n" +
                "  </div>\n" +
                "</div>";

        message.setContent(mailBody, "text/html; charset=utf-8");
    }
}
