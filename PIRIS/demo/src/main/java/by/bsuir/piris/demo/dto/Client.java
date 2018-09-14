package by.bsuir.piris.demo.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.time.Instant;

@Getter
@Setter // todo накатать по новой базу - добавил юник индекс
@Builder
public class Client {

    private Integer clientId;

    @NotBlank
    @Pattern(regexp = "\\s+")
    private String surname;

    @NotBlank
    @Pattern(regexp = "\\s+")
    private String name;

    @NotBlank
    @Pattern(regexp = "\\s+")
    private String patronymic;

    @NotBlank
    private Instant dateOfBirth;

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
