package com.salesianostriana.dam.MiarmaApp.storage.controller;

import com.salesianostriana.dam.MiarmaApp.storage.service.StorageService;
import com.salesianostriana.dam.MiarmaApp.utils.MediaTypeUrlResource;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class FileController {

    private final StorageService storageService;

    @GetMapping("/download/{filename:.+}")
    public ResponseEntity<Resource> getFile(@PathVariable String filename) {
        MediaTypeUrlResource resource = (MediaTypeUrlResource) storageService.loadAsResource(filename);

        return ResponseEntity.status(HttpStatus.OK)
                .header("content-type", resource.getType())
                .body(resource);
    }
}