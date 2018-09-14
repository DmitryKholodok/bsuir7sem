package by.bsuir.piris.demo.service;

import by.bsuir.piris.demo.dto.Client;

import java.util.Collection;

public interface ClientService {

    void addClient(Client client);
    void updateClient(Client client);
    void deleteClientById(Integer clientId);
    Collection<Client> retrieveAllClients();

}
