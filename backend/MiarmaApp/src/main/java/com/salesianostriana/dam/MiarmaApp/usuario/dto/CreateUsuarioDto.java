package com.salesianostriana.dam.MiarmaApp.usuario.dto;

import lombok.*;

@Getter @Setter
@AllArgsConstructor @NoArgsConstructor
@Builder
public class CreateUsuarioDto {

    private String nick;
    private String email;
    private String nombre;
    private String apellidos;
    private String fechaNacimiento;
    private boolean isPublic;
    private String password;
    private String password2;
}
