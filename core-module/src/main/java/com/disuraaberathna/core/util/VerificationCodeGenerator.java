package com.disuraaberathna.core.util;

import java.security.SecureRandom;

public class VerificationCodeGenerator {
    private static final SecureRandom secureRandom = new SecureRandom();

    public static String generate() {
        return String.valueOf(100000 + secureRandom.nextInt(900000));
    }
}
