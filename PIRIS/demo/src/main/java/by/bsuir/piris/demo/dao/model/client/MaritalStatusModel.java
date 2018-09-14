package by.bsuir.piris.demo.dao.model.client;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "MaritalStatus")
public class MaritalStatusModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer msId;

    private String value;

}
