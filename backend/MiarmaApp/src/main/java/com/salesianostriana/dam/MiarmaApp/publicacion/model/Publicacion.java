package com.salesianostriana.dam.MiarmaApp.publicacion.model;

import com.salesianostriana.dam.MiarmaApp.usuario.model.Usuario;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class Publicacion implements Serializable {

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

    private String titulo;

    @Lob
    private String contenido;

    private String originalMedia;

    private String transformedMedia;

    private boolean isPublic;

    @Builder.Default
    private LocalDateTime fechaPublicacion = LocalDateTime.now();

    @ManyToOne
    private Usuario propietario;
}
