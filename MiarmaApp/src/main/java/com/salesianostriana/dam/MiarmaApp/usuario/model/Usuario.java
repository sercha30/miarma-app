package com.salesianostriana.dam.MiarmaApp.usuario.model;

import com.salesianostriana.dam.MiarmaApp.peticionSeguimiento.model.PeticionSeguimiento;
import com.salesianostriana.dam.MiarmaApp.publicacion.model.Publicacion;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.NaturalId;
import org.hibernate.annotations.Parameter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.UUID;

@Entity
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class Usuario implements Serializable, UserDetails {

    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(
            name = "UUID",
            strategy = "org.hibernate.id.UUIDGenerator",
            parameters = {
                    @Parameter(
                            name = "uuid_gen_strategy_class",
                            value = "org.hibernate.id.uuid.CustomVersionOneStrategy"
                    )
            }
    )
    private UUID id;

    private String nick;

    private String password;

    private String nombre;

    private String apellidos;

    @NaturalId
    @Column(nullable = false, updatable = false)
    private String email;

    private String fechaNacimiento;

    private String avatar;

    private boolean isPublic;

    private UserRole rol;

    @Builder.Default
    @ManyToMany
    private List<Usuario> seguidores = new ArrayList<>();

    @Builder.Default
    @ManyToMany
    private List<Usuario> seguidos = new ArrayList<>();

    @Builder.Default
    @OneToMany(mappedBy = "propietario")
    private List<Publicacion> publicaciones = new ArrayList<>();

    @Builder.Default
    @OneToMany(mappedBy = "solicitante")
    private List<PeticionSeguimiento> solicitudesActivas = new ArrayList<>();

    @Builder.Default
    @OneToMany(mappedBy = "solicitado")
    private List<PeticionSeguimiento> solicitudesPendientes = new ArrayList<>();

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority("ROLE_" + rol.name()));
    }

    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
