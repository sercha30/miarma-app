package com.salesianostriana.dam.MiarmaApp.errors.exception.general;

public class ActionNotAvailableException extends RuntimeException{

    public ActionNotAvailableException() {
        super("No es posible realizar esta acción");
    }
}
