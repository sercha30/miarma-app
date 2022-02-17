package com.salesianostriana.dam.MiarmaApp.usuario.controller;

import com.salesianostriana.dam.MiarmaApp.usuario.dto.CreateUsuarioDto;
import com.salesianostriana.dam.MiarmaApp.usuario.dto.GetPerfilUsuarioDto;
import com.salesianostriana.dam.MiarmaApp.usuario.dto.GetUsuarioDto;
import com.salesianostriana.dam.MiarmaApp.usuario.dto.UsuarioDtoConverter;
import com.salesianostriana.dam.MiarmaApp.usuario.model.Usuario;
import com.salesianostriana.dam.MiarmaApp.usuario.service.UsuarioService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Optional;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/")
public class UsuarioController {

    private final UsuarioService usuarioService;
    private final UsuarioDtoConverter usuarioDtoConverter;

    @PostMapping("auth/register/user")
    public ResponseEntity<GetUsuarioDto> nuevoUsuario(@RequestPart("usuario") CreateUsuarioDto createUsuarioDto,
                                                      @RequestPart("avatar")MultipartFile file) throws Exception {
        Usuario guardado = usuarioService.saveUsuario(createUsuarioDto, file);

        if(guardado == null){
            return ResponseEntity.badRequest().build();
        }else{
            return ResponseEntity.status(HttpStatus.CREATED)
                    .body(usuarioDtoConverter.convertUsuarioToUsuarioDto(guardado));
        }
    }

    @PostMapping("auth/register/admin")
    public ResponseEntity<GetUsuarioDto> nuevoAdmin(@RequestPart("admin") CreateUsuarioDto createUsuarioDto,
                                                      @RequestPart("avatar")MultipartFile file) throws Exception {
        Usuario guardado = usuarioService.saveAdmin(createUsuarioDto, file);

        if(guardado == null){
            return ResponseEntity.badRequest().build();
        }else{
            return ResponseEntity.status(HttpStatus.CREATED)
                    .body(usuarioDtoConverter.convertUsuarioToUsuarioDto(guardado));
        }
    }

    @GetMapping("profile/{id}")
    public ResponseEntity<GetPerfilUsuarioDto> getPerfilUsuario(@PathVariable UUID id,
                                                                @AuthenticationPrincipal Usuario usuario) {
        Optional<Usuario> usuarioOptional = usuarioService.findById(id);

        if(usuarioOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        } else {
            Usuario usuarioBuscado = usuarioOptional.get();

            if(usuarioBuscado.isPublic() || usuario.getSeguidos().contains(usuarioBuscado)) {
                return ResponseEntity.ok()
                        .body(usuarioDtoConverter.convertUsuarioToGetPerfilUsuarioDto(usuarioBuscado));
            } else {
                return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
            }
        }
    }
}
