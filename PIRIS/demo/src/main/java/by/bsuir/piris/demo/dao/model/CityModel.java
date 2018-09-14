package by.bsuir.piris.demo.dao.model;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "city")
public class CityModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer cityId;

    private String name;
}
