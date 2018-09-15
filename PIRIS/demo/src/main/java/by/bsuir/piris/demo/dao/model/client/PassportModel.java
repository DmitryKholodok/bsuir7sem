package by.bsuir.piris.demo.dao.model.client;

import lombok.Data;

import javax.persistence.*;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "passport")
public class PassportModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer passportId;

    private String series;
    private String number;
    private String numberId;
    private String issuedBy;
    private LocalDateTime issueDate;

    private String regAddr;

}
