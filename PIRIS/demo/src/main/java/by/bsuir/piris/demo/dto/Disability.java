package by.bsuir.piris.demo.dto;

import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Disability {

    @NotNull
    private Integer disabilityId;

    @NotBlank
    private String value;

}
