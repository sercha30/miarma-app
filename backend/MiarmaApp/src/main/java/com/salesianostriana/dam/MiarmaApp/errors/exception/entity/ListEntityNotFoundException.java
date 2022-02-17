package com.salesianostriana.dam.MiarmaApp.errors.exception.entity;

public class ListEntityNotFoundException extends EntityNotFoundException{

    public ListEntityNotFoundException(Class clazz) {
        super(String.format("No se pueden encontrar elementos del tipo %s ",
                clazz.getName()));
    }
}
