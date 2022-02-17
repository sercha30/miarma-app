package com.salesianostriana.dam.MiarmaApp.peticionSeguimiento.service;

import com.salesianostriana.dam.MiarmaApp.exception.peticionSeguimiento.AlreadyFollowedUserException;
import com.salesianostriana.dam.MiarmaApp.peticionSeguimiento.model.PeticionSeguimiento;
import com.salesianostriana.dam.MiarmaApp.peticionSeguimiento.repos.PeticionSeguimientoRepository;
import com.salesianostriana.dam.MiarmaApp.publicacion.service.base.BaseService;
import com.salesianostriana.dam.MiarmaApp.usuario.model.Usuario;
import com.salesianostriana.dam.MiarmaApp.usuario.service.UsuarioService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class PeticionSeguimientoService extends BaseService<PeticionSeguimiento, UUID, PeticionSeguimientoRepository> {

    private final UsuarioService usuarioService;

    public PeticionSeguimiento createPeticion(String nick, Usuario usuario) {
        Usuario usuarioSolicitado = usuarioService.findUsuarioByNick(nick);

        if(usuarioSolicitado == null) {
            throw new UsernameNotFoundException("Usuario no encontrado");
        }

        if(usuario.getSeguidos().contains(usuarioSolicitado)) {
            throw new AlreadyFollowedUserException();
        } else {
            PeticionSeguimiento ps = PeticionSeguimiento.builder()
                    .solicitante(usuario)
                    .solicitado(usuarioSolicitado)
                    .build();

            usuario.addToActivas(ps);
            usuarioService.edit(usuario);

            usuarioSolicitado.addToPendientes(ps);
            usuarioService.edit(usuarioSolicitado);

            return save(ps);
        }
    }
}
