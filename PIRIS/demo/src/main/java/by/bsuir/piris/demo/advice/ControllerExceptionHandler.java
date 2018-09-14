package by.bsuir.piris.demo.advice;

import by.bsuir.piris.demo.exception.InvalidEntityException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice
@Slf4j
public class ControllerExceptionHandler {

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(InvalidEntityException.class)
    public void handleInvalidEntityException(InvalidEntityException ex) {
        log.debug("Caught InvalidEntityException: {}. Returned bad request status", ex.getMessage());
    }

}
