package com.salesianostriana.dam.MiarmaApp.peticionSeguimiento.repos;

import com.salesianostriana.dam.MiarmaApp.peticionSeguimiento.model.PeticionSeguimiento;
import com.salesianostriana.dam.MiarmaApp.usuario.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.UUID;

public interface PeticionSeguimientoRepository extends JpaRepository<PeticionSeguimiento, UUID> {

    @Query("select p from PeticionSeguimiento p where p.solicitado = :usuario")
    List<PeticionSeguimiento> findAllBySolicitadoEquals(@Param("usuario") Usuario usuario);

    @Query("select p from PeticionSeguimiento p where p.solicitante = :usuario")
    List<PeticionSeguimiento> findAllBySolicitanteEquals(@Param("usuario") Usuario usuario);
}
