package com.salesianostriana.dam.MiarmaApp.errors.exception.peticionSeguimiento;

public class SelfFollowException extends RuntimeException{

    public SelfFollowException() {
        super("No puedes seguirte a ti mismo");
    }
}
