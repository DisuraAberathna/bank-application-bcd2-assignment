package com.disuraaberathna.core.util;

import java.security.SecureRandom;

public class AccountNumberGenerator {
    private static final SecureRandom secureRandom = new SecureRandom();

    public static String generate() {
        long number = 1_000_000_000_000L + (Math.abs(secureRandom.nextLong()) % 9_000_000_000_000L);
        return String.valueOf(number);
    }
}
