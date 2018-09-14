package by.bsuir.piris.demo.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.validator.constraints.Range;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.time.Instant;

@Getter
@Setter
@Builder
public class Passport {

    private Integer passportId;

    @NotBlank
    @Range(min = 2, max = 2)
    private String series;

    @NotBlank
    @Pattern(regexp = "\\d{7}")
    private String number;

    @NotBlank
    @Pattern(regexp = "\\w{4}\\d{9}")
    private String numberId;

    @NotBlank
    private String issuedBy;

    @NotNull
    private Instant issueDate;

    @NotNull
    private String regAddr;
}
