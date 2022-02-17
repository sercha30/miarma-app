package com.salesianostriana.dam.MiarmaApp.usuario.dto;

import com.salesianostriana.dam.MiarmaApp.publicacion.dto.PublicacionDtoConverter;
import com.salesianostriana.dam.MiarmaApp.publicacion.service.PublicacionService;
import com.salesianostriana.dam.MiarmaApp.usuario.model.Usuario;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class UsuarioDtoConverter {

    private final PublicacionService publicacionService;
    private final PublicacionDtoConverter publicacionDtoConverter;

    public GetUsuarioDto convertUsuarioToUsuarioDto(Usuario usuario) {
        return GetUsuarioDto.builder()
                .id(usuario.getId())
                .nick(usuario.getNick())
                .email(usuario.getEmail())
                .avatar(usuario.getAvatar())
                .rol(usuario.getRol().name())
                .isPublic(usuario.isPublic())
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
                .publicaciones(publicacionService.findAllPublicacionesUsuarioLogueado(usuario)
                        .stream()
                        .map(publicacionDtoConverter::convertPublicacionToGetPublicacionDto)
                        .collect(Collectors.toList()))
                .build();
    }
}
