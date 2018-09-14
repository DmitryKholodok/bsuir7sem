package by.bsuir.piris.demo.dao.repository;

import by.bsuir.piris.demo.dao.model.client.ClientModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ClientRepository extends JpaRepository<ClientModel, Integer> {
}
