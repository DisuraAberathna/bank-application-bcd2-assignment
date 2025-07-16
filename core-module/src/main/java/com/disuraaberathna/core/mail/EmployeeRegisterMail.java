package com.disuraaberathna.core.mail;

import com.disuraaberathna.core.util.Env;
import jakarta.mail.Message;
import jakarta.mail.internet.InternetAddress;

public class EmployeeRegisterMail extends Mailable {
    private final String TO;
    private final String NAME;
    private final String USERNAME;
    private final String PASSWORD;

    public EmployeeRegisterMail(String to, String name, String username, String password) {
        this.TO = to;
        this.NAME = name;
        this.USERNAME = username;
        this.PASSWORD = password;
    }

    @Override
    public void build(Message message) throws Exception {
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(TO));
        message.setSubject("Employee Login - National Bank");

        String link = Env.get("app.path") + "/auth/login.jsp";

        String mailBody = "<div style='font-family: Arial, sans-serif; background-color: #f6f9fc; padding: 20px; margin: 0;'>\n" +
                "  <div style='background-color: #ffffff; padding: 60px 30px; margin: auto; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); display: flex; justify-content: center; max-width: 700px;'>\n" +
                "    <table cellpadding='0' cellspacing='0' style='padding:20px 0;'>\n" +
                "      <tr>\n" +
                "        <td align='center'>\n" +
                "          <table width='600' cellpadding='0' cellspacing='0' style='background-color:#ffffff; border-radius:8px; overflow:hidden; box-shadow:0 0 8px rgba(0,0,0,0.1);'>\n" +
                "            <tr>\n" +
                "              <td style='background-color:#4CAF50; color:#ffffff; padding:20px; text-align:center;'>\n" +
                "                <h2 style='margin:0; font-size:24px;'>Welcome to National Bank</h2>\n" +
                "                <p style='margin:5px 0 0; font-size:14px;'>Employee Portal Access</p>\n" +
                "              </td>\n" +
                "            </tr>\n" +
                "            <tr>\n" +
                "              <td style='padding:30px;'>\n" +
                "                <p style='font-size:16px; margin-bottom:20px;'>Dear " + NAME + ",</p>\n" +
                "                <p style='font-size:14px; line-height:1.5; margin-bottom:20px;'>Your employee account has been successfully created. Please find your login credentials below. Use them to access the secure banking employee portal.</p>\n" +
                "                <table cellpadding='0' cellspacing='0' width='100%' style='font-size:14px; margin-bottom:20px;'>\n" +
                "                  <tr>\n" +
                "                    <td style='padding:8px 0; font-weight:bold;'>Portal URL:</td>\n" +
                "                    <td style='padding:8px 0;'><a href=" + link + " style='color:#004080; text-decoration:none;'>" + link + "</a></td>\n" +
                "                  </tr>\n" +
                "                  <tr>\n" +
                "                    <td style='padding:8px 0; font-weight:bold;'>Username:</td>\n" +
                "                    <td style='padding:8px 0;'>" + USERNAME + "</td>\n" +
                "                  </tr>\n" +
                "                  <tr>\n" +
                "                    <td style='padding:8px 0; font-weight:bold;'>Password:</td>\n" +
                "                    <td style='padding:8px 0;'>" + PASSWORD + "</td>\n" +
                "                  </tr>\n" +
                "                </table>\n" +
                "                <p style='font-size:14px; margin-bottom:10px;'>Please log in and change your password immediately.</p>\n" +
                "                <p style='font-size:14px; color:#888888;'>Thank you,<br />The National Bank.</p>\n" +
                "              </td>\n" +
                "            </tr>\n" +
                "            <tr>\n" +
                "              <td style='background-color:#f0f0f0; padding:15px; text-align:center; font-size:12px; color:#777777;'>&copy; 2025 National Bank. All rights reserved.</td>\n" +
                "            </tr>\n" +
                "          </table>\n" +
                "        </td>\n" +
                "      </tr>\n" +
                "    </table>\n" +
                "  </div>\n" +
                "</div>";

        message.setContent(mailBody, "text/html; charset=utf-8");
    }
}
