package by.bsuir.piris.demo.service;


import by.bsuir.piris.demo.dao.model.AddressModel;
import by.bsuir.piris.demo.dao.model.CityModel;
import by.bsuir.piris.demo.dao.model.client.*;
import by.bsuir.piris.demo.dao.repository.ClientRepository;
import by.bsuir.piris.demo.dto.*;
import by.bsuir.piris.demo.exception.InvalidEntityException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Service
public class ClientServiceImpl implements ClientService {

    @Autowired
    private ClientRepository clientRepository;

    @Override
    public void addClient(Client client) {
        clientRepository.save(toClientModel(client));
    }

    @Override
    public void updateClient(Client client) {
        validateClientThrows(client);
        clientRepository.save(toClientModel(client));
    }

    @Override
    public void deleteClientById(Integer clientId) {
        clientRepository.deleteById(clientId); // todo exception???
    }

    @Override
    public Collection<Client> retrieveAllClients() {
        List<ClientModel> clients = clientRepository.findAll();
        Collection<Client> clientsDto = new ArrayList<>(clients.size());
        clients.forEach(clientModel -> clientsDto.add(toClient(clientModel)));
        return clientsDto;
    }

    private void validateClientThrows(Client client) {
        if (client.getAddress().getAddressId() == null) {
            throwInvalidEntityException("addressId");
        } else if (client.getPassport().getPassportId() == null) {
            throwInvalidEntityException("passportId");
        }
    }

    private void throwInvalidEntityException(String field) {
        throw new InvalidEntityException("Client has nullable field" + field);
    }

    private Client toClient(ClientModel clientModel) {
        return Client.builder()
                .clientId(clientModel.getClientId())
                .name(clientModel.getName())
                .surname(clientModel.getSurname())
                .patronymic(clientModel.getPatronymic())
                .sex(clientModel.getSex())
                .dateOfBirth(clientModel.getDateOfBirth())
                .isPensioner(clientModel.getIsPensioner())
                .mobTel(clientModel.getMobTel())
                .monthlyIncome(clientModel.getMonthlyIncome())
                .placeOfBirth(clientModel.getPlaceOfBirth())
                .email(clientModel.getEmail())
                .address(toAddress(clientModel.getAddress()))
                .citizenShip(toCitizenShip(clientModel.getCitizenShip()))
                .disability(toDisability(clientModel.getDisability()))
                .maritalStatus(toFamilyStatus(clientModel.getMaritalStatus()))
                .passport(toPassport(clientModel.getPassport()))
                .build();
    }

    private Passport toPassport(PassportModel passport) {
        return Passport.builder()
                .issueDate(passport.getIssueDate())
                .issuedBy(passport.getIssuedBy())
                .number(passport.getNumber())
                .numberId(passport.getNumberId())
                .passportId(passport.getPassportId())
                .regAddr(passport.getRegAddr())
                .series(passport.getSeries())
                .build();
    }

    private MaritalStatus toFamilyStatus(MaritalStatusModel ms) {
        return MaritalStatus.builder()
                .msId(ms.getMsId())
                .value(ms.getValue())
                .build();
    }

    private Disability toDisability(DisabilityModel disability) {
        return Disability.builder()
                .disabilityId(disability.getDisabilityId())
                .value(disability.getValue())
                .build();
    }

    private CitizenShip toCitizenShip(CitizenShipModel citizenShip) {
        return CitizenShip.builder()
                .csId(citizenShip.getCsId())
                .value(citizenShip.getValue())
                .build();
    }

    private Address toAddress(AddressModel address) {
        return Address.builder()
                .addressId(address.getAddressId())
                .currAddr(address.getAddress())
                .homeTel(address.getTel())
                .currCity(
                        City.builder()
                            .cityId(address.getCity().getCityId())
                            .name(address.getCity().getName())
                            .build()
                ).build();
    }

    private ClientModel toClientModel(Client client) {
        ClientModel clientModel = new ClientModel();
        clientModel.setClientId(client.getClientId());
        clientModel.setName(client.getName());
        clientModel.setSurname(client.getSurname());
        clientModel.setPatronymic(client.getPatronymic());
        clientModel.setSex(client.getSex());
        clientModel.setDateOfBirth(client.getDateOfBirth());
        clientModel.setIsPensioner(client.getIsPensioner());
        clientModel.setMobTel(client.getMobTel());
        clientModel.setMonthlyIncome(client.getMonthlyIncome());
        clientModel.setEmail(client.getEmail());
        clientModel.setPlaceOfBirth(client.getPlaceOfBirth());
        clientModel.setAddress(toAddressModel(client.getAddress()));
        clientModel.setCitizenShip(toCitizenShipModel(client.getCitizenShip()));
        clientModel.setDisability(toDisabilityModel(client.getDisability()));
        clientModel.setMaritalStatus(toMaritalStatusModel(client.getMaritalStatus()));
        clientModel.setPassport(toPassportModel(client.getPassport()));
        return clientModel;
    }

    private CitizenShipModel toCitizenShipModel(CitizenShip citizenShip) {
        CitizenShipModel csModel = new CitizenShipModel();
        csModel.setCsId(citizenShip.getCsId());
        return csModel;
    }

    private PassportModel toPassportModel(Passport passport) {
        PassportModel passportModel = new PassportModel();
        passportModel.setPassportId(passport.getPassportId());
        passportModel.setIssueDate(passport.getIssueDate());
        passportModel.setIssuedBy(passport.getIssuedBy());
        passportModel.setNumber(passport.getNumber());
        passportModel.setNumberId(passport.getNumberId());
        passportModel.setRegAddr(passport.getRegAddr());
        passportModel.setSeries(passport.getSeries());
        return passportModel;
    }

    private AddressModel toAddressModel(Address address) {
        AddressModel addressModel = new AddressModel();
        addressModel.setAddressId(address.getAddressId());
        addressModel.setAddress(address.getCurrAddr());
        addressModel.setTel(address.getHomeTel());
        addressModel.setCity(toCityModel(address));
        return addressModel;
    }

    private CityModel toCityModel(Address address) {
        CityModel cityModel = new CityModel();
        cityModel.setCityId(address.getCurrCity().getCityId());
        return cityModel;
    }

    private DisabilityModel toDisabilityModel(Disability disability) {
        DisabilityModel disabilityModel = new DisabilityModel();
        disabilityModel.setDisabilityId(disability.getDisabilityId());
        return disabilityModel;
    }

    private MaritalStatusModel toMaritalStatusModel(MaritalStatus maritalStatus) {
        MaritalStatusModel maritalStatusModel = new MaritalStatusModel();
        maritalStatusModel.setMsId(maritalStatus.getMsId());
        return maritalStatusModel;
    }
}
