package com.dma.advice.exception;

public class CSigninFailedException extends RuntimeException {
    public CSigninFailedException(String message, Throwable t) {
        super(message, t);
    }

    public CSigninFailedException(String message) {
        super(message);
    }

    public CSigninFailedException() {
        super();
    }
}
