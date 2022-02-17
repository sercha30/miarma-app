package com.salesianostriana.dam.MiarmaApp.errors.exception.peticionSeguimiento;

public class AlreadyFollowedUserException extends RuntimeException{

    public AlreadyFollowedUserException() {
        super("Ya sigues a este usuario");
    }
}
