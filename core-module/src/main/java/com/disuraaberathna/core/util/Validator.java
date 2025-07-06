package com.disuraaberathna.core.util;

public class Validator {
    public static boolean validateEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }

        return email.matches("^\\S+@\\S+\\.\\S+$");
    }

    public static boolean validatePassword(String password) {
        if (password == null || password.trim().isEmpty()) {
            return false;
        }

        return password.matches("^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$");
    }

    public static boolean validateMobile(String mobile) {
        if ((mobile == null || mobile.trim().isEmpty())) {
            return false;
        }

        return mobile.matches("^07[01245678]{1}[0-9]{7}$");
    }

    public static boolean containsDigit(String input) {
        return input.matches("^[0-9]+");
    }
}
