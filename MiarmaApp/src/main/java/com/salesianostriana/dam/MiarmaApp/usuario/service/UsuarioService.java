package com.salesianostriana.dam.MiarmaApp.usuario.service;

import com.salesianostriana.dam.MiarmaApp.usuario.model.Usuario;
import com.salesianostriana.dam.MiarmaApp.usuario.repos.UsuarioRepository;
import com.salesianostriana.dam.MiarmaApp.usuario.service.base.BaseService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service("userDetailsService")
@RequiredArgsConstructor
public class UsuarioService extends BaseService<Usuario, UUID, UsuarioRepository> implements UserDetailsService {

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return null;
    }
}
