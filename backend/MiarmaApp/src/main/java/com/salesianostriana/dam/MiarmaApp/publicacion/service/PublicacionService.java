package com.salesianostriana.dam.MiarmaApp.publicacion.service;

import com.salesianostriana.dam.MiarmaApp.errors.exception.entity.ListEntityNotFoundException;
import com.salesianostriana.dam.MiarmaApp.errors.exception.entity.SingleEntityNotFoundException;
import com.salesianostriana.dam.MiarmaApp.errors.exception.general.ActionNotAvailableException;
import com.salesianostriana.dam.MiarmaApp.general.BaseService;
import com.salesianostriana.dam.MiarmaApp.media.ImageScaler;
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
    private final ImageScaler imageScaler;
    private final MediaTypeSelector mediaTypeSelector;
    private MultipartFile file;

    public Publicacion savePublicacion(CreatePublicacionDto nuevaPublicacion, Usuario usuario,
                                       MultipartFile media) throws Exception {
        file = mediaTypeSelector.selectMediaType(media);

        storageService.store(media);
        String filename = storageService.store(file);

        String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/download/")
                .path(filename)
                .toUriString();

        Publicacion publicacion = Publicacion.builder()
                .contenido(nuevaPublicacion.getContenido())
                .titulo(nuevaPublicacion.getTitulo())
                .media(uri)
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

                storageService.store(media);
                String filename = storageService.store(file);

                String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                        .path("/download/")
                        .path(filename)
                        .toUriString();

                Publicacion publicacionEditada = dtoConverter
                        .convertCreatePublicacionDtoToPublicacion(publicacion, publicacionAnt, uri);

                edit(publicacionEditada);

                return GetPublicacionDto.builder()
                        .id(publicacionAnt.getId())
                        .contenido(publicacion.getContenido())
                        .titulo(publicacion.getTitulo())
                        .nickUsuario(publicacionAnt.getPropietario().getNick())
                        .fechaPublicacion(publicacionAnt.getFechaPublicacion())
                        .media(uri)
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
                storageService.deleteFile(publicacion.getMedia());
                delete(publicacion);
            } else {
                throw new ActionNotAvailableException();
            }
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
