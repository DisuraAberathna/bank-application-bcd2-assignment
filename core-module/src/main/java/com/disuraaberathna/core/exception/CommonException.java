package com.disuraaberathna.core.exception;

import jakarta.ejb.ApplicationException;

@ApplicationException(rollback = true)
public class CommonException extends RuntimeException {
    public CommonException(String message) {
        super(message);
    }
}
