package by.bsuir.piris.demo.dao.repository;

import by.bsuir.piris.demo.dao.model.CityModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CityRepository extends JpaRepository<CityModel, Integer> {
}
