package com.salesianostriana.dam.MiarmaApp.exception.storage;

public class FileNotFoundException extends RuntimeException{

    public FileNotFoundException(String message, Exception ex) {
        super(message, ex);
    }

    public FileNotFoundException(String message) {
        super(message);
    }
}
