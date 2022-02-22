package com.salesianostriana.dam.MiarmaApp.publicacion.repos;

import com.salesianostriana.dam.MiarmaApp.publicacion.model.Publicacion;
import com.salesianostriana.dam.MiarmaApp.usuario.model.Usuario;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.UUID;

public interface PublicacionRepository extends JpaRepository<Publicacion, UUID>, PagingAndSortingRepository<Publicacion, UUID> {

    @Query("select p from Publicacion p where p.isPublic = true")
    Page<Publicacion> findAllByPublicIsTrue(Pageable pageable);

    @Query("select p from Publicacion p where p.propietario.nick = :nickname")
    List<Publicacion> findAllByNickname(@Param("nickname") String nickname);

    @Query("select p from Publicacion p where p.propietario.nick = :nickname" +
            " and p.isPublic = true")
    List<Publicacion> findAllByNicknameAndPublic(@Param("nickname") String nickname);

    @EntityGraph("grafoUsuarioPublicacion")
    List<Publicacion> findAllByPropietarioEquals(Usuario usuario);
}
