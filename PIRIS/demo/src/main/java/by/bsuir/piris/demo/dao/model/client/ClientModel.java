package by.bsuir.piris.demo.dao.model.client;

import by.bsuir.piris.demo.dao.model.AddressModel;
import lombok.Data;

import javax.persistence.*;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "client")
public class ClientModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer clientId;

    private String surname;
    private String name;
    private String patronymic;
    private LocalDateTime dateOfBirth;
    private String sex;
    private Boolean isPensioner;
    private Integer monthlyIncome;
    private String placeOfBirth;

    private String email;
    private String mobTel;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "ms_id")
    private MaritalStatusModel maritalStatus;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "cs_id")
    private CitizenShipModel citizenShip;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "disability_id")
    private DisabilityModel disability;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "address_id")
    private AddressModel address;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "passport_id")
    private PassportModel passport;

}
