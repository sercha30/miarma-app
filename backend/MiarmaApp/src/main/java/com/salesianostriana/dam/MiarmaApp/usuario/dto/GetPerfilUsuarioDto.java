package com.salesianostriana.dam.MiarmaApp.usuario.dto;

import com.salesianostriana.dam.MiarmaApp.publicacion.dto.GetPublicacionDto;
import lombok.*;

import java.util.List;
import java.util.UUID;

@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class GetPerfilUsuarioDto {

    private UUID id;
    private String nick;
    private String nombre;
    private String apellidos;
    private String email;
    private String avatar;
    private String rol;
    private List<GetPublicacionDto> publicaciones;
}
