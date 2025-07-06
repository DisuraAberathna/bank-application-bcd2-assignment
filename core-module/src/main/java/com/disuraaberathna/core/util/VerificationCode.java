package com.disuraaberathna.core.util;

import java.util.UUID;

public class VerificationCode {
    public static String generate() {
        return UUID.randomUUID().toString();
    }
}
