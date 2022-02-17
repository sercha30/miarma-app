package com.salesianostriana.dam.MiarmaApp.peticionSeguimiento.controller;

import com.salesianostriana.dam.MiarmaApp.peticionSeguimiento.dto.GetPeticionSeguimientoDto;
import com.salesianostriana.dam.MiarmaApp.peticionSeguimiento.dto.PeticionSeguimientoDtoConverter;
import com.salesianostriana.dam.MiarmaApp.peticionSeguimiento.model.PeticionSeguimiento;
import com.salesianostriana.dam.MiarmaApp.peticionSeguimiento.service.PeticionSeguimientoService;
import com.salesianostriana.dam.MiarmaApp.usuario.model.Usuario;
import com.salesianostriana.dam.MiarmaApp.usuario.service.UsuarioService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@RestController
@RequiredArgsConstructor
@RequestMapping("/follow")
public class PeticionSeguimientoController {

    private final PeticionSeguimientoService psService;
    private final UsuarioService usuarioService;
    private final PeticionSeguimientoDtoConverter psDtoConverter;

    @PostMapping("/{nick}")
    public ResponseEntity<GetPeticionSeguimientoDto> createPeticion(@PathVariable String nick,
                                                                    @AuthenticationPrincipal Usuario usuario) {
        PeticionSeguimiento ps = psService.createPeticion(nick, usuario);

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(psDtoConverter.convertPSToGetPSDto(ps));
    }

    @PostMapping("/accept/{id}")
    public ResponseEntity<?> aceptarPeticion(@PathVariable UUID id,
                                             @AuthenticationPrincipal Usuario usuario) {
        Optional<PeticionSeguimiento> psOptional = psService.findById(id);

        if(psOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        } else {
            PeticionSeguimiento ps = psOptional.get();
            usuario.addSeguidor(ps.getSolicitante());
            usuarioService.edit(usuario);
            usuarioService.edit(ps.getSolicitante());
            psService.delete(ps);

            return ResponseEntity.status(HttpStatus.CREATED).build();
        }
    }

    @PostMapping("/decline/{id}")
    public ResponseEntity<?> rechazarPeticion(@PathVariable UUID id,
                                             @AuthenticationPrincipal Usuario usuario) {
        Optional<PeticionSeguimiento> psOptional = psService.findById(id);

        if(psOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        } else {
            PeticionSeguimiento ps = psOptional.get();
            usuario.removeSeguidor(ps.getSolicitante());
            usuarioService.edit(usuario);
            usuarioService.edit(ps.getSolicitante());
            psService.delete(ps);

            return ResponseEntity.status(HttpStatus.CREATED).build();
        }
    }

    @GetMapping("/list")
    public ResponseEntity<List<GetPeticionSeguimientoDto>> getPeticionesUsuario(@AuthenticationPrincipal Usuario usuario) {
        List<PeticionSeguimiento> psList = psService.findAllPSUsuario(usuario);

        if(psList.isEmpty()) {
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.ok()
                    .body(
                            psList.stream()
                                    .map(psDtoConverter::convertPSToGetPSDto)
                                    .collect(Collectors.toList())
                    );
        }
    }
}
