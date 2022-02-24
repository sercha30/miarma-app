package com.salesianostriana.dam.MiarmaApp.media;

import com.salesianostriana.dam.MiarmaApp.utils.MultipartImage;
import net.coobird.thumbnailator.Thumbnails;
import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;

@Component
public class ImageScaler {

    @Value("${image.avatar.width:128}")
    private int avatarWidth;

    @Value("${image.avatar.height:128}")
    private int avatarHeight;

    @Value("${image.post.size:1024}")
    private int postImageSize;

    public MultipartFile resizeAvatarImage(MultipartFile originalImage) throws Exception {
        BufferedImage avatarImage = ImageIO.read(originalImage.getInputStream());
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

        Thumbnails.of(avatarImage)
                .size(avatarWidth, avatarHeight)
                .outputFormat("png")
                .outputQuality(1)
                .toOutputStream(outputStream);

        byte[] data = outputStream.toByteArray();

        return MultipartImage.builder()
                .fieldName(originalImage.getName())
                .fileName(originalImage.getOriginalFilename())
                .contentType(originalImage.getContentType())
                .bytes(data)
                .build();
    }

    public MultipartFile resizePostImage(MultipartFile originalImage) throws Exception{
        BufferedImage postImage = Scalr
                .resize(ImageIO
                        .read(originalImage
                                .getInputStream()), postImageSize);

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
}
