package by.bsuir.piris.demo.dao.model.client;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "CitizenShip")
public class CitizenShipModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer csId;

    private String value;

}
