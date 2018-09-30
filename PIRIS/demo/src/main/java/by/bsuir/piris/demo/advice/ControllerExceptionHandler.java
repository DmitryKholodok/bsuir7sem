package by.bsuir.piris.demo.advice;

import by.bsuir.piris.demo.exception.InvalidEntityException;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.exception.ConstraintViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice("by.bsuir.piris.demo.controller")
@Slf4j
public class ControllerExceptionHandler {

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(InvalidEntityException.class)
    public void handleInvalidEntityException(InvalidEntityException ex) {
        log.debug("Caught InvalidEntityException: {}. Returned bad request status", ex.getMessage());
    }

    @ResponseStatus(HttpStatus.UNPROCESSABLE_ENTITY)
    @ExceptionHandler({ConstraintViolationException.class}) // DB CONSTRAINTS
    public void handleConstraintViolationExceptionException(ConstraintViolationException ex) {
        log.debug("Caught Exception: {}. Returned bad request status", ex.getMessage());
    }

}
