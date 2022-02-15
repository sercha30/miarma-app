package com.salesianostriana.dam.MiarmaApp.security;

import lombok.*;

@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class LoginDto {

    private String email;
    private String password;
}
