package by.bsuir.piris.demo.dao.model.client;

import lombok.Builder;
import lombok.Data;

import javax.persistence.*;
import java.time.Instant;

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
    private Instant issueDate;

    private String regAddr;

}
