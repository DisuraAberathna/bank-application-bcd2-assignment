package com.disuraaberathna.core.util;

import java.security.SecureRandom;

public class PasswordGenerator {
    private static final String UPPER = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private static final String LOWER = "abcdefghijklmnopqrstuvwxyz";
    private static final String DIGITS = "0123456789";
    private static final String SPECIAL = "!@#$%^&*()-_=+[]{}|;:,.<>?";

    private static final SecureRandom random = new SecureRandom();

    public static String generatePassword(int length, boolean useUpper, boolean useLower, boolean useDigits, boolean useSpecial) {
        StringBuilder password = new StringBuilder(length);
        String charPool = "";

        if (useUpper) charPool += UPPER;
        if (useLower) charPool += LOWER;
        if (useDigits) charPool += DIGITS;
        if (useSpecial) charPool += SPECIAL;

        if (charPool.isEmpty()) {
            throw new IllegalArgumentException("At least one character type must be selected");
        }

        for (int i = 0; i < length; i++) {
            int randIndex = random.nextInt(charPool.length());
            password.append(charPool.charAt(randIndex));
        }

        return password.toString();
    }
}
