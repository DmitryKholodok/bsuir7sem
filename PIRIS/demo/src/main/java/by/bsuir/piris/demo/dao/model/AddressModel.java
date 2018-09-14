package by.bsuir.piris.demo.dao.model;

import lombok.Builder;
import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "address")
public class AddressModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer addressId;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "city_id")
    private CityModel city;

    private String address;
    private String tel;

}
