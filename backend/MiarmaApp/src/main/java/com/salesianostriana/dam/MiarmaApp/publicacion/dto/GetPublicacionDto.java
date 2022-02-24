package com.salesianostriana.dam.MiarmaApp.publicacion.dto;

import lombok.*;

import javax.persistence.Lob;
import java.time.LocalDateTime;
import java.util.UUID;

@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class GetPublicacionDto {

    private UUID id;

    private String titulo;

    @Lob
    private String contenido;

    private String originalMedia;

    private String transformedMedia;

    private String nickUsuario;

    private String avatar;

    private boolean isPublic;

    private LocalDateTime fechaPublicacion;
}
