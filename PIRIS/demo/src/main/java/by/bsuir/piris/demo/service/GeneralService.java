package by.bsuir.piris.demo.service;

import by.bsuir.piris.demo.dto.CitizenShip;
import by.bsuir.piris.demo.dto.City;
import by.bsuir.piris.demo.dto.Disability;
import by.bsuir.piris.demo.dto.MaritalStatus;

import java.util.List;

public interface GeneralService {

    List<CitizenShip> retrieveAllCitizenShips();
    List<City> retrieveAllCities();
    List<Disability> retrieveAllDisabilities();
    List<MaritalStatus> retrieveAllMaritalStatuses();

}
