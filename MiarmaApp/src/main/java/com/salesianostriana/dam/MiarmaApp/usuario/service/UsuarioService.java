package com.salesianostriana.dam.MiarmaApp.usuario.service;

import com.salesianostriana.dam.MiarmaApp.storage.service.StorageService;
import com.salesianostriana.dam.MiarmaApp.usuario.dto.CreateUsuarioDto;
import com.salesianostriana.dam.MiarmaApp.usuario.model.UserRole;
import com.salesianostriana.dam.MiarmaApp.usuario.model.Usuario;
import com.salesianostriana.dam.MiarmaApp.usuario.repos.UsuarioRepository;
import com.salesianostriana.dam.MiarmaApp.usuario.service.base.BaseService;
import com.salesianostriana.dam.MiarmaApp.utils.MultipartImage;
import lombok.RequiredArgsConstructor;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.util.UUID;

@Service("userDetailsService")
@RequiredArgsConstructor
public class UsuarioService extends BaseService<Usuario, UUID, UsuarioRepository> implements UserDetailsService {

    private final PasswordEncoder passwordEncoder;
    private final StorageService storageService;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        return this.repositorio.findFirstByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException(email + " no encontrado."));
    }

    public Usuario saveUsuario(CreateUsuarioDto nuevoUsuario, MultipartFile avatar) throws Exception {
        if(nuevoUsuario.getPassword().contentEquals(nuevoUsuario.getPassword2())){
            MultipartFile thumbnail = resizeImage(avatar);
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
                    .build();
            return save(usuario);
        } else {
            return null;
        }
    }

    public Usuario saveAdmin(CreateUsuarioDto nuevoAdmin, MultipartFile avatar) throws Exception{
        if(nuevoAdmin.getPassword().contentEquals(nuevoAdmin.getPassword2())){
            MultipartFile thumbnail = resizeImage(avatar);
            String filename = storageService.store(thumbnail);

            String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                    .path("/download/")
                    .path(filename)
                    .toUriString();

            Usuario usuario = Usuario.builder()
                    .password(passwordEncoder.encode(nuevoAdmin.getPassword()))
                    .apellidos(nuevoAdmin.getApellidos())
                    .avatar(uri)
                    .email(nuevoAdmin.getEmail())
                    .nombre(nuevoAdmin.getNombre())
                    .rol(UserRole.ADMIN)
                    .build();
            return save(usuario);
        } else {
            return null;
        }
    }

    private MultipartFile resizeImage(MultipartFile originalImage) throws Exception {
        BufferedImage avatarImage = ImageIO.read(originalImage.getInputStream());
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

        Thumbnails.of(avatarImage)
                .size(128, 128)
                .outputFormat("png")
                .outputQuality(1)
                .toOutputStream(outputStream);

        byte[] data = outputStream.toByteArray();

        return MultipartImage.builder()
                .fieldName(originalImage.getName())
                .fileName(originalImage.getOriginalFilename())
                .contentType(originalImage.getContentType())
                .bytes(data)
                .build();
    }
}
