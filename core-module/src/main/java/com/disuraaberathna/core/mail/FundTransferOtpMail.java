package com.disuraaberathna.core.mail;

import jakarta.mail.Message;
import jakarta.mail.internet.InternetAddress;

public class FundTransferOtpMail extends Mailable {
    private final String TO;
    private final String VERIFICATION_CODE;

    public FundTransferOtpMail(String to, String verificationCode) {
        this.TO = to;
        this.VERIFICATION_CODE = verificationCode;
    }

    @Override
    public void build(Message message) throws Exception {
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(TO));
        message.setSubject("Verify Payment - National Bank");

        String mailBody =
                "<div style='font-family: Arial, sans-serif; background-color: #f6f9fc; padding: 20px; margin: 0;'>"
                        + "  <div style='max-width: 600px; background-color: #ffffff; padding: 30px; margin: auto; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);'>"
                        + "    <div style='text-align: center; background-color: #4CAF50; color: #ffffff; padding: 30px 0; border-radius: 8px 8px 0 0;'>"
                        + "      <h1 style='margin: 0; font-weight: 600; font-size: 24px;'>Payment Confirmation</h1>"
                        + "    </div>"
                        + "    <div style='padding: 20px; color: #333333;'>"
                        + "      <p>Dear Customer,</p>"
                        + "      <p>Your payment has been successfully processed. Please use the OTP below to verify this transaction:</p>"
                        + "      <div style='background-color: #e1fce2; padding: 20px; border-radius: 6px; font-size: 22px; text-align: center; font-weight: bold; letter-spacing: 2px; margin: 20px 0;'>" + VERIFICATION_CODE + "</div>"
                        + "      <p>This OTP is valid for a limited time only. Do not share it with anyone.</p>"
                        + "      <p>If you did not make this payment, please contact our support team immediately.</p>"
                        + "    </div>"
                        + "    <div style='text-align: center; font-size: 13px; color: #888888; margin-top: 30px;'>&copy; 2025 National Bank. All rights reserved.</div>"
                        + "  </div>"
                        + "</div>";


        message.setContent(mailBody, "text/html; charset=utf-8");
    }
}
