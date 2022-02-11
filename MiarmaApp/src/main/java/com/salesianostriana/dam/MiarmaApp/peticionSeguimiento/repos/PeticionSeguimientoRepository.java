package com.salesianostriana.dam.MiarmaApp.peticionSeguimiento.repos;

import com.salesianostriana.dam.MiarmaApp.peticionSeguimiento.model.PeticionSeguimiento;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface PeticionSeguimientoRepository extends JpaRepository<PeticionSeguimiento, UUID> {
}
