package by.bsuir.piris.demo.dto;

import lombok.*;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Address {

    private Integer addressId;

    @NotNull
    @Valid
    private City currCity;

    @NotBlank
    private String currAddr;

    @Pattern(regexp = "(\\d+-)+\\d+")
    private String homeTel;
}
