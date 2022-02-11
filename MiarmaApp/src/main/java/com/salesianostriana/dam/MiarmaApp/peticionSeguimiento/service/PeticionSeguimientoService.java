package com.salesianostriana.dam.MiarmaApp.peticionSeguimiento.service;

import com.salesianostriana.dam.MiarmaApp.peticionSeguimiento.model.PeticionSeguimiento;
import com.salesianostriana.dam.MiarmaApp.peticionSeguimiento.repos.PeticionSeguimientoRepository;
import com.salesianostriana.dam.MiarmaApp.publicacion.service.base.BaseService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class PeticionSeguimientoService extends BaseService<PeticionSeguimiento, UUID, PeticionSeguimientoRepository> {
}
