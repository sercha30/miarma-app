package com.salesianostriana.dam.MiarmaApp.usuario.repos;

import com.salesianostriana.dam.MiarmaApp.usuario.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface UsuarioRepository extends JpaRepository<Usuario, UUID> {
}
