package com.salesianostriana.dam.MiarmaApp.security;

import com.salesianostriana.dam.MiarmaApp.security.jwt.JwtProvider;
import com.salesianostriana.dam.MiarmaApp.security.jwt.JwtUserResponse;
import com.salesianostriana.dam.MiarmaApp.usuario.dto.GetPerfilUsuarioDto;
import com.salesianostriana.dam.MiarmaApp.usuario.dto.UsuarioDtoConverter;
import com.salesianostriana.dam.MiarmaApp.usuario.model.Usuario;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/auth")
public class AuthenticationController {

    private final AuthenticationManager authenticationManager;
    private final JwtProvider jwtProvider;
    private final UsuarioDtoConverter usuarioDtoConverter;

    @PostMapping("/login")
    public ResponseEntity<?> doLogin(@RequestBody LoginDto loginDto) {
        Authentication authentication =
                authenticationManager.authenticate(
                        new UsernamePasswordAuthenticationToken(
                                loginDto.getEmail(),
                                loginDto.getPassword()
                        )
                );

        SecurityContextHolder.getContext().setAuthentication(authentication);

        String jwt = jwtProvider.generateToken(authentication);

        Usuario usuario = (Usuario) authentication.getPrincipal();

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(
                        convertUserToJwtUserResponse(usuario,jwt)
                );
    }

    @GetMapping("/me")
    public ResponseEntity<GetPerfilUsuarioDto> identifyUser(@AuthenticationPrincipal Usuario usuario){
        return ResponseEntity.ok((usuarioDtoConverter.convertUsuarioToGetPerfilUsuarioDto(usuario)));
    }

    private JwtUserResponse convertUserToJwtUserResponse(Usuario usuario, String jwt){
        return JwtUserResponse.builder()
                .nombre(usuario.getNombre())
                .apellidos(usuario.getApellidos())
                .email(usuario.getEmail())
                .avatar(usuario.getAvatar())
                .rol(usuario.getRol().name())
                .token(jwt)
                .build();
    }
}
