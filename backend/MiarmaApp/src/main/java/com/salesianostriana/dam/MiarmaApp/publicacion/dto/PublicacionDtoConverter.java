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
                .originalMedia(publicacion.getOriginalMedia())
                .transformedMedia(publicacion.getTransformedMedia())
                .nickUsuario(publicacion.getPropietario().getNick())
                .avatar(publicacion.getPropietario().getAvatar())
                .fechaPublicacion(publicacion.getFechaPublicacion())
                .isPublic(publicacion.isPublic())
                .build();
    }

    public Publicacion convertCreatePublicacionDtoToPublicacion(CreatePublicacionDto publicacionDto,
                                                                Publicacion publicacion,
                                                                String originalMediaUri,
                                                                String transformedMediaUri) {
        return Publicacion.builder()
                .id(publicacion.getId())
                .titulo(publicacionDto.getTitulo())
                .contenido(publicacionDto.getContenido())
                .fechaPublicacion(publicacion.getFechaPublicacion())
                .isPublic(publicacionDto.isPublic())
                .originalMedia(originalMediaUri)
                .transformedMedia(transformedMediaUri)
                .propietario(publicacion.getPropietario())
                .build();
    }
}
