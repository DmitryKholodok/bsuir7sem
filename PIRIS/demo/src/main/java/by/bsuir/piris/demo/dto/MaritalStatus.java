package by.bsuir.piris.demo.dto;

import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MaritalStatus {

    @NotNull
    private Integer msId;

    @NotBlank
    private String value;

}
