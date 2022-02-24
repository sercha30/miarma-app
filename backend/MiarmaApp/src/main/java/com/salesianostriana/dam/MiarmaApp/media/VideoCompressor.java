package com.salesianostriana.dam.MiarmaApp.media;

import com.salesianostriana.dam.MiarmaApp.utils.MultipartImage;
import io.github.techgnious.IVCompressor;
import io.github.techgnious.dto.ResizeResolution;
import io.github.techgnious.dto.VideoFormats;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class VideoCompressor {

    public MultipartFile compressVideo(MultipartFile originalVideo) throws Exception {
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
