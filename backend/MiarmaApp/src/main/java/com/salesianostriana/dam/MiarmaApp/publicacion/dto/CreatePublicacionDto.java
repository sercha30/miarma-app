package com.salesianostriana.dam.MiarmaApp.publicacion.dto;

import lombok.*;

import javax.persistence.Lob;

@Getter @Setter
@AllArgsConstructor @NoArgsConstructor
@Builder
public class CreatePublicacionDto {

    private String titulo;

    @Lob
    private String contenido;

    private boolean isPublic;
}
