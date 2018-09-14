package by.bsuir.piris.demo.dao.model.client;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "disability")
public class DisabilityModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer disabilityId;

    private String value;

}
