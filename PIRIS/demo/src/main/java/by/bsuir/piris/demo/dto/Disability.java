package by.bsuir.piris.demo.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Getter
@Setter
@Builder
public class Disability {

    @NotNull
    private Integer disabilityId;

    @NotBlank
    private String value;

}
