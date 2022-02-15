package com.salesianostriana.dam.MiarmaApp.publicacion.controller;

import com.salesianostriana.dam.MiarmaApp.publicacion.dto.CreatePublicacionDto;
import com.salesianostriana.dam.MiarmaApp.publicacion.dto.GetPublicacionDto;
import com.salesianostriana.dam.MiarmaApp.publicacion.dto.PublicacionDtoConverter;
import com.salesianostriana.dam.MiarmaApp.publicacion.model.Publicacion;
import com.salesianostriana.dam.MiarmaApp.publicacion.service.PublicacionService;
import com.salesianostriana.dam.MiarmaApp.usuario.model.Usuario;
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
@RequestMapping("/post")
public class PublicacionController {

    private final PublicacionService publicacionService;
    private final PublicacionDtoConverter publicacionDtoConverter;

    @PostMapping("/")
    public ResponseEntity<GetPublicacionDto> nuevaPublicacion(@RequestPart("post")CreatePublicacionDto nuevaPublicacion,
                                                              @RequestPart("media") MultipartFile file,
                                                              @AuthenticationPrincipal Usuario usuario) throws Exception {
        Publicacion nueva = publicacionService.savePublicacion(nuevaPublicacion, usuario, file);

        if(nueva == null) {
            return ResponseEntity.badRequest().build();
        } else {
            return ResponseEntity.status(HttpStatus.CREATED)
                    .body(publicacionDtoConverter.convertPublicacionToGetPublicacionDto(nueva));
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<GetPublicacionDto> editPublicacion(@PathVariable UUID id,
                                                             @RequestPart("post")CreatePublicacionDto nuevaPublicacion,
                                                             @RequestPart("media")MultipartFile file,
                                                             @AuthenticationPrincipal Usuario usuario) throws Exception {
        Optional<Publicacion> publicacionOptional = publicacionService.findById(id);

        if(publicacionOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        } else {
            Publicacion publicacionAnt = publicacionOptional.get();

            if(usuario.getId().equals(publicacionAnt.getPropietario().getId())) {
                return ResponseEntity.status(HttpStatus.CREATED)
                        .body(publicacionService.editPublicacion(nuevaPublicacion, file, publicacionAnt));
            } else {
                return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
            }
        }
    }
}
