package by.bsuir.piris.demo.dao.repository;

import by.bsuir.piris.demo.dao.model.client.MaritalStatusModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MaritalStatusRepository extends JpaRepository<MaritalStatusModel, Integer>{
}
