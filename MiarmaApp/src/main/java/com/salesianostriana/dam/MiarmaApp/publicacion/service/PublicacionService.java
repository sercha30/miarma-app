package com.salesianostriana.dam.MiarmaApp.publicacion.service;

import com.salesianostriana.dam.MiarmaApp.publicacion.model.Publicacion;
import com.salesianostriana.dam.MiarmaApp.publicacion.repos.PublicacionRepository;
import com.salesianostriana.dam.MiarmaApp.publicacion.service.base.BaseService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class PublicacionService extends BaseService<Publicacion, UUID, PublicacionRepository> {
}
