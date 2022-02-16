package com.salesianostriana.dam.MiarmaApp.publicacion.repos;

import com.salesianostriana.dam.MiarmaApp.publicacion.model.Publicacion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.UUID;

public interface PublicacionRepository extends JpaRepository<Publicacion, UUID> {

    @Query("select p from Publicacion p where p.isPublic = true")
    List<Publicacion> findAllByPublicIsTrue();
}
