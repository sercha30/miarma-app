package com.salesianostriana.dam.MiarmaApp.publicacion.repos;

import com.salesianostriana.dam.MiarmaApp.publicacion.model.Publicacion;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface PublicacionRepository extends JpaRepository<Publicacion, UUID> {
}
