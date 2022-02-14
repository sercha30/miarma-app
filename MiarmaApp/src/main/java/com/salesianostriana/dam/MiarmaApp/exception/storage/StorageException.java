package com.salesianostriana.dam.MiarmaApp.exception.storage;

public class StorageException extends RuntimeException{

    public StorageException(String message, Exception ex) {
        super(message, ex);
    }

    public StorageException(String message) {
        super(message);
    }
}
