package com.salesianostriana.dam.MiarmaApp.publicacion.dto;

import com.salesianostriana.dam.MiarmaApp.publicacion.model.Publicacion;
import org.springframework.stereotype.Component;

@Component
public class PublicacionDtoConverter {

    public GetPublicacionDto convertPublicacionToGetPublicacionDto(Publicacion publicacion) {
        return GetPublicacionDto.builder()
                .id(publicacion.getId())
                .titulo(publicacion.getTitulo())
                .contenido(publicacion.getContenido())
                .media(publicacion.getMedia())
                .nickUsuario(publicacion.getPropietario().getNick())
                .fechaPublicacion(publicacion.getFechaPublicacion())
                .isPublic(publicacion.isPublic())
                .build();
    }
}
