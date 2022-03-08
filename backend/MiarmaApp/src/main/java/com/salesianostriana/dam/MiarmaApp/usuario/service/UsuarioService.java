package com.salesianostriana.dam.MiarmaApp.usuario.service;

import com.salesianostriana.dam.MiarmaApp.errors.exception.entity.ListEntityNotFoundException;
import com.salesianostriana.dam.MiarmaApp.errors.exception.entity.SingleEntityNotFoundException;
import com.salesianostriana.dam.MiarmaApp.general.BaseService;
import com.salesianostriana.dam.MiarmaApp.media.ImageScaler;
import com.salesianostriana.dam.MiarmaApp.storage.service.StorageService;
import com.salesianostriana.dam.MiarmaApp.usuario.dto.CreateUsuarioDto;
import com.salesianostriana.dam.MiarmaApp.usuario.model.UserRole;
import com.salesianostriana.dam.MiarmaApp.usuario.model.Usuario;
import com.salesianostriana.dam.MiarmaApp.usuario.repos.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service("userDetailsService")
@RequiredArgsConstructor
public class UsuarioService extends BaseService<Usuario, UUID, UsuarioRepository> implements UserDetailsService {

    private final PasswordEncoder passwordEncoder;
    private final StorageService storageService;
    private final ImageScaler imageScaler;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        return this.repositorio.findFirstByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException(email + " no encontrado."));
    }

    public Usuario findUsuarioByNick(String nick) {
        return repositorio.findFirstByNick(nick)
                .orElseThrow(() -> new UsernameNotFoundException(nick + " no encontrado"));
    }

    public Usuario saveUsuario(CreateUsuarioDto nuevoUsuario, MultipartFile avatar) throws Exception {
        if(nuevoUsuario.getPassword().contentEquals(nuevoUsuario.getPassword2())){
            MultipartFile thumbnail = imageScaler.resizeAvatarImage(avatar);
            String filename = storageService.store(thumbnail);

            String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                    .path("/download/")
                    .path(filename)
                    .toUriString();

            Usuario usuario = Usuario.builder()
                    .password(passwordEncoder.encode(nuevoUsuario.getPassword()))
                    .apellidos(nuevoUsuario.getApellidos())
                    .avatar(uri)
                    .nick(nuevoUsuario.getNick())
                    .email(nuevoUsuario.getEmail())
                    .nombre(nuevoUsuario.getNombre())
                    .rol(UserRole.USUARIO)
                    .isPublic(nuevoUsuario.isPublic())
                    .build();
            return save(usuario);
        } else {
            return null;
        }
    }

    public Usuario saveAdmin(CreateUsuarioDto nuevoAdmin, MultipartFile avatar) throws Exception{
        if(nuevoAdmin.getPassword().contentEquals(nuevoAdmin.getPassword2())){
            MultipartFile thumbnail = imageScaler.resizeAvatarImage(avatar);
            String filename = storageService.store(thumbnail);

            String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                    .path("/download/")
                    .path(filename)
                    .toUriString();

            Usuario usuario = Usuario.builder()
                    .password(passwordEncoder.encode(nuevoAdmin.getPassword()))
                    .apellidos(nuevoAdmin.getApellidos())
                    .avatar(uri)
                    .nick(nuevoAdmin.getNick())
                    .email(nuevoAdmin.getEmail())
                    .nombre(nuevoAdmin.getNombre())
                    .rol(UserRole.ADMIN)
                    .isPublic(nuevoAdmin.isPublic())
                    .build();
            return save(usuario);
        } else {
            return null;
        }
    }

    public Usuario editUsuario(CreateUsuarioDto nuevoUsuario, MultipartFile file, Usuario usuarioAnt) throws Exception {
        MultipartFile thumbnail = imageScaler.resizeAvatarImage(file);
        String filename = storageService.store(thumbnail);

        String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/download/")
                .path(filename)
                .toUriString();

        Usuario usuario = Usuario.builder()
                .id(usuarioAnt.getId())
                .apellidos(nuevoUsuario.getApellidos())
                .avatar(uri)
                .nick(nuevoUsuario.getNick())
                .email(nuevoUsuario.getEmail())
                .nombre(nuevoUsuario.getNombre())
                .rol(UserRole.USUARIO)
                .isPublic(nuevoUsuario.isPublic())
                .build();

        return edit(usuario);
    }

    @PreAuthorize("hasRole('ADMIN')")
    public List<Usuario> getAllUsuarios() {
        List<Usuario> usuarios = findAll();

        if (usuarios.isEmpty()) {
            throw new ListEntityNotFoundException(Usuario.class);
        } else {
            return usuarios;
        }
    }

    @PreAuthorize("hasRole('ADMIN')")
    public Usuario giveAdmin(UUID usuarioId) {
        Optional<Usuario> usuarioOptional = findById(usuarioId);

        if (usuarioOptional.isEmpty()) {
            throw new SingleEntityNotFoundException(usuarioId.toString(), Usuario.class);
        } else {
            Usuario usuario = usuarioOptional.get();

            if (!usuario.getRol().equals(UserRole.ADMIN)) {
                usuario.setRol(UserRole.ADMIN);
                edit(usuario);
            }
            return usuario;
        }
    }

    @PreAuthorize("hasRole('ADMIN')")
    public Usuario removeAdmin(UUID usuarioId) {
        Optional<Usuario> usuarioOptional = findById(usuarioId);

        if (usuarioOptional.isEmpty()) {
            throw new SingleEntityNotFoundException(usuarioId.toString(), Usuario.class);
        } else {
            Usuario usuario = usuarioOptional.get();

            if (!usuario.getRol().equals(UserRole.USUARIO)) {
                usuario.setRol(UserRole.USUARIO);
                edit(usuario);
            }
            return usuario;
        }
    }
}
