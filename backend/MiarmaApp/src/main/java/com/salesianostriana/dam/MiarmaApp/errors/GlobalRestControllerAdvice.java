package com.salesianostriana.dam.MiarmaApp.errors;

import com.salesianostriana.dam.MiarmaApp.errors.exception.general.ActionNotAvailableException;
import com.salesianostriana.dam.MiarmaApp.errors.exception.peticionSeguimiento.AlreadyFollowedUserException;
import com.salesianostriana.dam.MiarmaApp.errors.exception.peticionSeguimiento.SelfFollowException;
import com.salesianostriana.dam.MiarmaApp.errors.exception.storage.FileNotFoundException;
import com.salesianostriana.dam.MiarmaApp.errors.exception.storage.MediaTypeNotValidException;
import com.salesianostriana.dam.MiarmaApp.errors.exception.storage.StorageException;
import com.salesianostriana.dam.MiarmaApp.errors.model.ApiError;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import javax.persistence.EntityNotFoundException;

@RestControllerAdvice
public class GlobalRestControllerAdvice extends ResponseEntityExceptionHandler {

    @ExceptionHandler({EntityNotFoundException.class})
    public ResponseEntity<?> handleNotFoundException(EntityNotFoundException ex, WebRequest request) {
        return buildApiError(ex, request, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler({ActionNotAvailableException.class})
    public ResponseEntity<?> handleActionNotAvailableException(ActionNotAvailableException ex, WebRequest request) {
        return buildApiError(ex, request, HttpStatus.FORBIDDEN);
    }

    @ExceptionHandler({AlreadyFollowedUserException.class})
    public ResponseEntity<?> handleAlreadyFollowedUserException(AlreadyFollowedUserException ex, WebRequest request) {
        return buildApiError(ex, request, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler({SelfFollowException.class})
    public ResponseEntity<?> handleSelfFollowException(SelfFollowException ex, WebRequest request) {
        return buildApiError(ex, request, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler({FileNotFoundException.class})
    public ResponseEntity<?> handleFileNotFoundException(FileNotFoundException ex, WebRequest request) {
        return buildApiError(ex, request, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler({MediaTypeNotValidException.class})
    public ResponseEntity<?> handleMediaTypeNotValidException(MediaTypeNotValidException ex, WebRequest request) {
        return buildApiError(ex, request, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler({StorageException.class})
    public ResponseEntity<?> handleStorageException(StorageException ex, WebRequest request) {
        return buildApiError(ex, request, HttpStatus.BAD_REQUEST);
    }

    @Override
    protected ResponseEntity<Object> handleExceptionInternal(Exception ex, Object body, HttpHeaders headers,
                                                             HttpStatus status, WebRequest request) {
        return buildApiError(ex, request, status);
    }

    private ResponseEntity<Object> buildApiError(Exception ex, WebRequest request, HttpStatus status) {
        return ResponseEntity
                .status(status)
                .body(new ApiError(status, ex.getMessage(),
                        ((ServletWebRequest) request).getRequest().getRequestURI()));

    }
}
