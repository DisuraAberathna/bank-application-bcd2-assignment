package com.disuraaberathna.core.util;

import java.io.InputStream;
import java.util.Properties;

public class Env {
    private static final Properties PROPS = new Properties();

    static {
        try {
            InputStream in = Env.class.getClassLoader().getResourceAsStream("application.properties");
            PROPS.load(in);
        } catch (Exception e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    public static String get(String key) {
        return PROPS.getProperty(key);
    }
}
