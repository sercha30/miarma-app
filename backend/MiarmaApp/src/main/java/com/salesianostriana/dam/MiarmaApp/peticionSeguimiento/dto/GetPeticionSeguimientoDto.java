package com.salesianostriana.dam.MiarmaApp.peticionSeguimiento.dto;

import lombok.*;

import java.util.UUID;

@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class GetPeticionSeguimientoDto {

    private UUID id;
    private String nickSolicitante;
    private UUID idSolicitante;
    private String nickSolicitado;
    private UUID idSolicitado;
}
