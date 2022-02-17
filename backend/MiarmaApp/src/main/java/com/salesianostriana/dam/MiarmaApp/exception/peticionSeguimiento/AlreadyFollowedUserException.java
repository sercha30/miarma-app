package com.salesianostriana.dam.MiarmaApp.exception.peticionSeguimiento;

public class AlreadyFollowedUserException extends RuntimeException{

    public AlreadyFollowedUserException() {
        super("Ya sigues a este usuario");
    }
}
