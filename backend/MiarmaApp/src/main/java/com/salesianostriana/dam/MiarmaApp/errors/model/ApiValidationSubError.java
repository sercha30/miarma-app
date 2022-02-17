package com.salesianostriana.dam.MiarmaApp.errors.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@SuperBuilder
public class ApiValidationSubError extends ApiSubError{

    private String objeto, campo, mensaje;
    private Object valorRechazado;
}
