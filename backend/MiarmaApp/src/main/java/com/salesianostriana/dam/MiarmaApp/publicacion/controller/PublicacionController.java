package com.salesianostriana.dam.MiarmaApp.publicacion.controller;

import com.salesianostriana.dam.MiarmaApp.pagination.PaginationUtilsLinks;
import com.salesianostriana.dam.MiarmaApp.publicacion.dto.CreatePublicacionDto;
import com.salesianostriana.dam.MiarmaApp.publicacion.dto.GetPublicacionDto;
import com.salesianostriana.dam.MiarmaApp.publicacion.dto.PublicacionDtoConverter;
import com.salesianostriana.dam.MiarmaApp.publicacion.model.Publicacion;
import com.salesianostriana.dam.MiarmaApp.publicacion.service.PublicacionService;
import com.salesianostriana.dam.MiarmaApp.usuario.model.Usuario;
import com.salesianostriana.dam.MiarmaApp.usuario.service.UsuarioService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@RestController
@RequiredArgsConstructor
@CrossOrigin(origins = {"http://localhost:4200"})
@RequestMapping("/post")
public class PublicacionController {

    private final PublicacionService publicacionService;
    private final UsuarioService usuarioService;
    private final PublicacionDtoConverter publicacionDtoConverter;
    private final PaginationUtilsLinks paginationUtilsLinks;

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
        return ResponseEntity.status(HttpStatus.CREATED)
                    .body(publicacionService.editPublicacion(nuevaPublicacion, file, id, usuario));

    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deletePublicacion(@PathVariable UUID id,
                                               @AuthenticationPrincipal Usuario usuario) {
        publicacionService.deletePublicacion(id, usuario);
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("/admin/{id}")
    public ResponseEntity<?> forceDeletePublicacion(@PathVariable UUID id) {
        publicacionService.forceDeletePublicacion(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/admin/all")
    public ResponseEntity<List<GetPublicacionDto>> getAllPublicaciones() {
        return ResponseEntity.ok(publicacionService.findAllPublicaciones()
                .stream()
                .map(publicacionDtoConverter::convertPublicacionToGetPublicacionDto)
                .collect(Collectors.toList()));
    }

    @GetMapping("/public")
    public ResponseEntity<?> getAllPublicacionesPublicas(@PageableDefault() Pageable pageable,
                                                         HttpServletRequest request) {
        Page<Publicacion> publicaciones = publicacionService.findAllPublicacionesPublicas(pageable);

        UriComponentsBuilder uriBuilder = UriComponentsBuilder
                .fromHttpUrl(request.getRequestURL().toString());

        if(publicaciones.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
        }

        return ResponseEntity.ok()
                .header("link", paginationUtilsLinks.createLinkHeader(publicaciones, uriBuilder))
                .body(publicaciones.stream()
                        .map(publicacionDtoConverter::convertPublicacionToGetPublicacionDto)
                        .collect(Collectors.toList())
        );
    }

    @GetMapping("/{id}")
    public ResponseEntity<GetPublicacionDto> getPublicacionById(@PathVariable UUID id,
                                                                 @AuthenticationPrincipal Usuario usuario) {
        Optional<Publicacion> publicacionOptional = publicacionService.findById(id);

        if(publicacionOptional.isEmpty()) {
            return ResponseEntity.notFound().build();
        } else {
            Publicacion publicacion = publicacionOptional.get();
            UUID propietarioId = publicacion.getPropietario().getId();

            if(propietarioId.equals(usuario.getId()) || publicacion.isPublic()
                || usuario.getSeguidos().contains(publicacion.getPropietario())) {
                return ResponseEntity.ok()
                        .body(publicacionDtoConverter.convertPublicacionToGetPublicacionDto(publicacion));
            } else {
                return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
            }
        }
    }

    @GetMapping("/{nick}/")
    public ResponseEntity<List<GetPublicacionDto>> getAllPublicacionesPorNick(@PathVariable String nick,
                                                                               @AuthenticationPrincipal Usuario usuario) {
        Usuario usuarioBuscado = usuarioService.findUsuarioByNick(nick);

        List<Publicacion> publicaciones;

        if(usuario.getSeguidos().contains(usuarioBuscado)) {
            publicaciones = publicacionService.findAllPublicacionesPorUsuario(nick);
        } else {
            publicaciones = publicacionService.findAllPublicacionesPublicasPorUsuario(nick);
        }

        if(publicaciones.isEmpty()){
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.ok().body(
                publicaciones.stream()
                        .map(publicacionDtoConverter::convertPublicacionToGetPublicacionDto)
                        .collect(Collectors.toList())
            );
        }
    }

    @GetMapping("/me")
    public ResponseEntity<List<GetPublicacionDto>> getPublicacionesUsuarioLogueado(@AuthenticationPrincipal Usuario usuario) {
        List<Publicacion> publicaciones = publicacionService.findAllPublicacionesUsuarioLogueado(usuario);

        if(publicaciones.isEmpty()) {
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.ok().body(
                    publicaciones.stream()
                            .map(publicacionDtoConverter::convertPublicacionToGetPublicacionDto)
                            .collect(Collectors.toList())
            );
        }
    }
}
