package com.salesianostriana.dam.MiarmaApp.errors.exception.storage;

public class MediaTypeNotValidException extends RuntimeException{

    public MediaTypeNotValidException(String mediaType) {
        super("Los archivos de tipo " + mediaType + " no son compatibles");
    }
}
