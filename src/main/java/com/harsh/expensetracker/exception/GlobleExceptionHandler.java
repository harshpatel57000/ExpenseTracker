package com.harsh.expensetracker.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.http.ResponseEntity;

@RestControllerAdvice
public class GlobleExceptionHandler {
   
    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<String>handleResourceNotFound(ResourceNotFoundException ex){
        return new ResponseEntity<>(ex.getMessage(),HttpStatus.NOT_FOUND);

    }
}
