package com.salesianostriana.dam.MiarmaApp.usuario.dto;

import com.salesianostriana.dam.MiarmaApp.usuario.model.Usuario;
import org.springframework.stereotype.Component;

@Component
public class UsuarioDtoConverter {

    public GetUsuarioDto convertUsuarioToUsuarioDto(Usuario usuario) {
        return GetUsuarioDto.builder()
                .id(usuario.getId())
                .nick(usuario.getNick())
                .email(usuario.getEmail())
                .avatar(usuario.getAvatar())
                .rol(usuario.getRol().name())
                .build();
    }

    public GetPerfilUsuarioDto convertUsuarioToGetPerfilUsuarioDto(Usuario usuario) {
        return GetPerfilUsuarioDto.builder()
                .id(usuario.getId())
                .nick(usuario.getNick())
                .email(usuario.getEmail())
                .avatar(usuario.getAvatar())
                .rol(usuario.getRol().name())
                .nombre(usuario.getNombre())
                .apellidos(usuario.getApellidos())
                .publicaciones(usuario.getPublicaciones())
                .build();
    }
}
