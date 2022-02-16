package com.salesianostriana.dam.MiarmaApp.publicacion.service;

import com.salesianostriana.dam.MiarmaApp.publicacion.dto.CreatePublicacionDto;
import com.salesianostriana.dam.MiarmaApp.publicacion.dto.GetPublicacionDto;
import com.salesianostriana.dam.MiarmaApp.publicacion.dto.PublicacionDtoConverter;
import com.salesianostriana.dam.MiarmaApp.publicacion.model.Publicacion;
import com.salesianostriana.dam.MiarmaApp.publicacion.repos.PublicacionRepository;
import com.salesianostriana.dam.MiarmaApp.publicacion.service.base.BaseService;
import com.salesianostriana.dam.MiarmaApp.storage.service.StorageService;
import com.salesianostriana.dam.MiarmaApp.usuario.model.Usuario;
import com.salesianostriana.dam.MiarmaApp.utils.MultipartImage;
import io.github.techgnious.IVCompressor;
import io.github.techgnious.dto.ResizeResolution;
import io.github.techgnious.dto.VideoFormats;
import lombok.RequiredArgsConstructor;
import org.imgscalr.Scalr;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class PublicacionService extends BaseService<Publicacion, UUID, PublicacionRepository> {

    private final StorageService storageService;
    private final PublicacionDtoConverter dtoConverter;
    private MultipartFile file;

    public Publicacion savePublicacion(CreatePublicacionDto nuevaPublicacion, Usuario usuario,
                                       MultipartFile media) throws Exception {
        file = selectMediaType(media);

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
                                             Publicacion publicacionAnt) throws Exception {
        file = selectMediaType(media);

        storageService.store(media);
        String filename = storageService.store(file);

        String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/download/")
                .path(filename)
                .toUriString();

        edit(dtoConverter.convertCreatePublicacionDtoToPublicacion(publicacion, publicacionAnt, uri));

        return GetPublicacionDto.builder()
                .id(publicacionAnt.getId())
                .contenido(publicacion.getContenido())
                .titulo(publicacion.getTitulo())
                .nickUsuario(publicacionAnt.getPropietario().getNick())
                .fechaPublicacion(publicacionAnt.getFechaPublicacion())
                .media(uri)
                .isPublic(publicacion.isPublic())
                .build();
    }

    public void deletePublicacion(Publicacion publicacion) {
        storageService.deleteFile(publicacion.getMedia());
        delete(publicacion);
    }

    private MultipartFile selectMediaType(MultipartFile media) throws Exception {
        if (media.getContentType().contains("video")) {
            return compressVideo(media);
        } else if(media.getContentType().contains("image")) {
            return resizeImage(media);
        }
        return null;
    }

    private MultipartFile resizeImage(MultipartFile originalImage) throws Exception{
        BufferedImage postImage = Scalr
                .resize(ImageIO
                        .read(originalImage
                                .getInputStream()), 1024);

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

        ImageIO.write(postImage, "png", outputStream);

        byte[] data = outputStream.toByteArray();

        return MultipartImage.builder()
                .fieldName(originalImage.getName())
                .fileName(originalImage.getOriginalFilename())
                .contentType(originalImage.getContentType())
                .bytes(data)
                .build();
    }

    private MultipartFile compressVideo(MultipartFile originalVideo) throws Exception {
        IVCompressor compressor = new IVCompressor();

        byte[] data = compressor.reduceVideoSize(originalVideo.getBytes(),
                VideoFormats.MP4, ResizeResolution.R720P);

        return MultipartImage.builder()
                .fieldName(originalVideo.getName())
                .fileName(originalVideo.getOriginalFilename())
                .contentType(originalVideo.getContentType())
                .bytes(data)
                .build();
    }
}
