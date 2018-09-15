package by.bsuir.piris.demo.dao.repository;

import by.bsuir.piris.demo.dao.model.client.CitizenShipModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CitizenShipRepository extends JpaRepository<CitizenShipModel, Integer> {
}
