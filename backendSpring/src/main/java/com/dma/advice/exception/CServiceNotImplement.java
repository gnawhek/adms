package com.dma.advice.exception;

public class CServiceNotImplement extends RuntimeException {
    public CServiceNotImplement(String message, Throwable t) {
        super(message, t);
    }

    public CServiceNotImplement(String message) {
        super(message);
    }

    public CServiceNotImplement() {
        super();
    }
}
