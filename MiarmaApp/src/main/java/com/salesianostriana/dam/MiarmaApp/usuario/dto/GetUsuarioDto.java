package com.salesianostriana.dam.MiarmaApp.usuario.dto;

import lombok.*;

import java.util.UUID;

@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class GetUsuarioDto {

    private UUID id;
    private String nick;
    private String avatar;
    private String email;
    private String rol;
}
