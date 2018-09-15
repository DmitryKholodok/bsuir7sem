package by.bsuir.piris.demo.dto;

import lombok.*;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.time.LocalDateTime;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Client {

    private Integer clientId;

    @NotBlank
    @Pattern(regexp = "[A-Za-z]+")
    private String surname;

    @NotBlank
    @Pattern(regexp = "[A-Za-z]+")
    private String name;

    @NotBlank
    @Pattern(regexp = "[A-Za-z]+")
    private String patronymic;

    @NotBlank
    private LocalDateTime dateOfBirth;

    @NotBlank
    private String sex;

    @NotBlank
    private String placeOfBirth;

    @NotNull
    @Valid
    private Passport passport;

    @NotNull
    @Valid
    private Address address;

    @Pattern(regexp = "(\\d+-)+\\d+")
    private String mobTel;

    private String email;

    @NotNull
    @Valid
    private MaritalStatus maritalStatus;

    @NotNull
    @Valid
    private CitizenShip citizenShip;

    @NotNull
    @Valid
    private Disability disability;

    @NotNull
    private Boolean isPensioner;

    private Integer monthlyIncome;

}
