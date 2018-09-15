package by.bsuir.piris.demo.controller;

import by.bsuir.piris.demo.dto.CitizenShip;
import by.bsuir.piris.demo.dto.City;
import by.bsuir.piris.demo.dto.Disability;
import by.bsuir.piris.demo.dto.MaritalStatus;
import by.bsuir.piris.demo.service.GeneralService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/static")
public class GeneralController {

    @Autowired
    private GeneralService generalService;

    @GetMapping("/cses")
    public List<CitizenShip> retrieveAllCitizenShip() {
        return generalService.retrieveAllCitizenShips();
    }

    @GetMapping("/cities")
    public List<City> retrieveAllCities() {
        return generalService.retrieveAllCities();
    }

    @GetMapping("/mses")
    public List<MaritalStatus> retrieveAllMaritalStatuses() {
        return generalService.retrieveAllMaritalStatuses();
    }

    @GetMapping("/disabilities")
    public List<Disability> retrieveAllDisabilities() {
        return generalService.retrieveAllDisabilities();
    }

}
