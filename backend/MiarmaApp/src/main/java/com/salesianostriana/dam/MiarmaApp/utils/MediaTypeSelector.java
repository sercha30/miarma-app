package com.salesianostriana.dam.MiarmaApp.utils;

import com.salesianostriana.dam.MiarmaApp.errors.exception.storage.MediaTypeNotValidException;
import com.salesianostriana.dam.MiarmaApp.media.ImageScaler;
import com.salesianostriana.dam.MiarmaApp.media.VideoCompressor;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.util.Objects;

@RequiredArgsConstructor
@Component
public class MediaTypeSelector {

    private final ImageScaler imageScaler;
    private final VideoCompressor videoCompressor;

    public MultipartFile selectMediaType(MultipartFile media) throws Exception {
        if (Objects.requireNonNull(media.getContentType()).contains("video")) {
            return videoCompressor.compressVideo(media);
        } else if(media.getContentType().contains("image")) {
            return imageScaler.resizePostImage(media);
        } else {
            throw new MediaTypeNotValidException(media.getContentType());
        }
    }
}
