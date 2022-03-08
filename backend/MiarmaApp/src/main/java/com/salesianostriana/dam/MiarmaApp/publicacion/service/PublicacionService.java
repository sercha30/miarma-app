package com.salesianostriana.dam.MiarmaApp.publicacion.service;

import com.salesianostriana.dam.MiarmaApp.errors.exception.entity.ListEntityNotFoundException;
import com.salesianostriana.dam.MiarmaApp.errors.exception.entity.SingleEntityNotFoundException;
import com.salesianostriana.dam.MiarmaApp.errors.exception.general.ActionNotAvailableException;
import com.salesianostriana.dam.MiarmaApp.general.BaseService;
import com.salesianostriana.dam.MiarmaApp.publicacion.dto.CreatePublicacionDto;
import com.salesianostriana.dam.MiarmaApp.publicacion.dto.GetPublicacionDto;
import com.salesianostriana.dam.MiarmaApp.publicacion.dto.PublicacionDtoConverter;
import com.salesianostriana.dam.MiarmaApp.publicacion.model.Publicacion;
import com.salesianostriana.dam.MiarmaApp.publicacion.repos.PublicacionRepository;
import com.salesianostriana.dam.MiarmaApp.storage.service.StorageService;
import com.salesianostriana.dam.MiarmaApp.usuario.model.Usuario;
import com.salesianostriana.dam.MiarmaApp.utils.MediaTypeSelector;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class PublicacionService extends BaseService<Publicacion, UUID, PublicacionRepository> {

    private final StorageService storageService;
    private final PublicacionRepository publicacionRepository;
    private final PublicacionDtoConverter dtoConverter;
    private final MediaTypeSelector mediaTypeSelector;
    private MultipartFile file;

    public Publicacion savePublicacion(CreatePublicacionDto nuevaPublicacion, Usuario usuario,
                                       MultipartFile media) throws Exception {
        file = mediaTypeSelector.selectMediaType(media);

        String originalFilename = storageService.store(media);
        String scaledFilename = storageService.store(file);

        String originalUri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/download/")
                .path(originalFilename)
                .toUriString();

        String scaledUri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/download/")
                .path(scaledFilename)
                .toUriString();

        Publicacion publicacion = Publicacion.builder()
                .contenido(nuevaPublicacion.getContenido())
                .titulo(nuevaPublicacion.getTitulo())
                .originalMedia(originalUri)
                .transformedMedia(scaledUri)
                .isPublic(nuevaPublicacion.isPublic())
                .propietario(usuario)
                .build();

        return save(publicacion);
    }

    public GetPublicacionDto editPublicacion(CreatePublicacionDto publicacion, MultipartFile media,
                                             UUID id, Usuario usuario) throws Exception {
        Optional<Publicacion> publicacionOptional = findById(id);

        if(publicacionOptional.isEmpty()) {
            throw new SingleEntityNotFoundException(id.toString(), Publicacion.class);
        } else {
            Publicacion publicacionAnt = publicacionOptional.get();

            if(usuario.getId().equals(publicacionAnt.getPropietario().getId())) {
                file = mediaTypeSelector.selectMediaType(media);

                String originalFilename = storageService.store(media);
                String scaledFilename = storageService.store(file);

                String originalUri = ServletUriComponentsBuilder.fromCurrentContextPath()
                        .path("/download/")
                        .path(originalFilename)
                        .toUriString();

                String scaledUri = ServletUriComponentsBuilder.fromCurrentContextPath()
                        .path("/download/")
                        .path(scaledFilename)
                        .toUriString();

                Publicacion publicacionEditada = dtoConverter
                        .convertCreatePublicacionDtoToPublicacion(publicacion, publicacionAnt, scaledUri, originalUri);

                edit(publicacionEditada);

                return GetPublicacionDto.builder()
                        .id(publicacionAnt.getId())
                        .contenido(publicacion.getContenido())
                        .titulo(publicacion.getTitulo())
                        .nickUsuario(publicacionAnt.getPropietario().getNick())
                        .fechaPublicacion(publicacionAnt.getFechaPublicacion())
                        .originalMedia(originalUri)
                        .transformedMedia(scaledUri)
                        .isPublic(publicacion.isPublic())
                        .build();
            } else {
                throw new ActionNotAvailableException();
            }
        }
    }

    public void deletePublicacion(UUID id, Usuario usuario) {
        Optional<Publicacion> publicacionOptional = findById(id);

        if(publicacionOptional.isEmpty()) {
            throw new SingleEntityNotFoundException(id.toString(), Publicacion.class);
        } else {
            Publicacion publicacion = publicacionOptional.get();

            if (usuario.getId().equals(publicacion.getPropietario().getId())) {
                storageService.deleteFile(publicacion.getTransformedMedia());
                delete(publicacion);
            } else {
                throw new ActionNotAvailableException();
            }
        }
    }

    @PreAuthorize("hasRole('ADMIN')")
    public void forceDeletePublicacion(UUID id) {
        Optional<Publicacion> publicacionOptional = findById(id);

        if (publicacionOptional.isEmpty()) {
            throw new SingleEntityNotFoundException(id.toString(), Publicacion.class);
        } else {
            Publicacion publicacion = publicacionOptional.get();

            storageService.deleteFile(publicacion.getTransformedMedia());
            delete(publicacion);
        }
    }

    public Page<Publicacion> findAllPublicacionesPublicas(Pageable pageable) {
        Page<Publicacion> publicaciones = publicacionRepository.findAllByPublicIsTrue(pageable);

        if(publicaciones.isEmpty()) {
            throw new ListEntityNotFoundException(Publicacion.class);
        } else {
            return publicaciones;
        }
    }

    @PreAuthorize("hasRole('ADMIN')")
    public List<Publicacion> findAllPublicaciones() {
        List<Publicacion> publicaciones = findAll();

        if(publicaciones.isEmpty()) {
            throw new ListEntityNotFoundException(Publicacion.class);
        } else {
            return publicaciones;
        }
    }

    public List<Publicacion> findAllPublicacionesPorUsuario(String nickname) {
        return publicacionRepository.findAllByNickname(nickname);
    }

    public List<Publicacion> findAllPublicacionesPublicasPorUsuario(String nickname) {
        return publicacionRepository.findAllByNicknameAndPublic(nickname);
    }

    public List<Publicacion> findAllPublicacionesUsuarioLogueado(Usuario usuario) {
        return repositorio.findAllByPropietarioEquals(usuario);
    }
}
