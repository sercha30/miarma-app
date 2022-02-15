package com.salesianostriana.dam.MiarmaApp.usuario.controller;

import com.salesianostriana.dam.MiarmaApp.usuario.dto.CreateUsuarioDto;
import com.salesianostriana.dam.MiarmaApp.usuario.dto.GetUsuarioDto;
import com.salesianostriana.dam.MiarmaApp.usuario.dto.UsuarioDtoConverter;
import com.salesianostriana.dam.MiarmaApp.usuario.model.Usuario;
import com.salesianostriana.dam.MiarmaApp.usuario.service.UsuarioService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequiredArgsConstructor
@RequestMapping("/auth")
public class UsuarioController {

    private final UsuarioService usuarioService;
    private final UsuarioDtoConverter usuarioDtoConverter;

    @PostMapping("/register/user")
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
}
