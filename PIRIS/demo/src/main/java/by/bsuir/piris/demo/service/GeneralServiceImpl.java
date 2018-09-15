package by.bsuir.piris.demo.service;

import by.bsuir.piris.demo.dao.model.CityModel;
import by.bsuir.piris.demo.dao.model.client.CitizenShipModel;
import by.bsuir.piris.demo.dao.model.client.DisabilityModel;
import by.bsuir.piris.demo.dao.model.client.MaritalStatusModel;
import by.bsuir.piris.demo.dao.repository.CitizenShipRepository;
import by.bsuir.piris.demo.dao.repository.CityRepository;
import by.bsuir.piris.demo.dao.repository.DisabilityRepository;
import by.bsuir.piris.demo.dao.repository.MaritalStatusRepository;
import by.bsuir.piris.demo.dto.CitizenShip;
import by.bsuir.piris.demo.dto.City;
import by.bsuir.piris.demo.dto.Disability;
import by.bsuir.piris.demo.dto.MaritalStatus;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class GeneralServiceImpl implements GeneralService {

    private final DisabilityRepository disabilityRepository;
    private final CityRepository cityRepository;
    private final MaritalStatusRepository maritalStatusRepository;
    private final CitizenShipRepository citizenShipRepository;

    @Override
    public List<CitizenShip> retrieveAllCitizenShips() {
        return citizenShipRepository.findAll().stream()
                .map(x -> toCitizenShip(x))
                .collect(Collectors.toList());
    }

    @Override
    public List<City> retrieveAllCities() {
        return cityRepository.findAll().stream()
                .map(x -> toCity(x))
                .collect(Collectors.toList());
    }

    @Override
    public List<Disability> retrieveAllDisabilities() {
        return disabilityRepository.findAll().stream()
                .map(x -> toDisability(x))
                .collect(Collectors.toList());
    }

    @Override
    public List<MaritalStatus> retrieveAllMaritalStatuses() {
        return maritalStatusRepository.findAll().stream()
                .map(x -> toFamilyStatus(x))
                .collect(Collectors.toList());
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

    private City toCity(CityModel cityModel) {
        return City.builder()
                .cityId(cityModel.getCityId())
                .name(cityModel.getName())
                .build();
    }
}
