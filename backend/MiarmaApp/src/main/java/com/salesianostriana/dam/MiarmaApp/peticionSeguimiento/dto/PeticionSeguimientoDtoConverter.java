package com.salesianostriana.dam.MiarmaApp.peticionSeguimiento.dto;

import com.salesianostriana.dam.MiarmaApp.peticionSeguimiento.model.PeticionSeguimiento;
import org.springframework.stereotype.Component;

@Component
public class PeticionSeguimientoDtoConverter {

    public GetPeticionSeguimientoDto convertPSToGetPSDto(PeticionSeguimiento ps) {
        return GetPeticionSeguimientoDto.builder()
                .id(ps.getId())
                .nickSolicitante(ps.getSolicitante().getNick())
                .idSolicitante(ps.getSolicitante().getId())
                .nickSolicitado(ps.getSolicitado().getNick())
                .idSolicitado(ps.getSolicitado().getId())
                .build();
    }
}
