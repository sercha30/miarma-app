package com.salesianostriana.dam.MiarmaApp.publicacion.dto;

import com.salesianostriana.dam.MiarmaApp.usuario.model.Usuario;
import lombok.*;

import javax.persistence.Lob;
import java.time.LocalDateTime;

@Getter @Setter
@AllArgsConstructor @NoArgsConstructor
@Builder
public class CreatePublicacionDto {

    private String titulo;

    @Lob
    private String contenido;

    private String media;

    private boolean isPublic;

    private Usuario usuario;

    private LocalDateTime fecha_publicacion;
}
