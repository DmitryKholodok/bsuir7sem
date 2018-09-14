package by.bsuir.piris.demo.controller;

import by.bsuir.piris.demo.dto.Client;
import by.bsuir.piris.demo.service.ClientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.util.Collection;

@RestController
@RequestMapping("/api/clients")
public class ClientController {

    @Autowired
    private ClientService clientService;

    @PostMapping
    public void addClient(@RequestBody @Valid Client client) {
        clientService.addClient(client);
    }

    @PutMapping("/{id}")
    public void updateClient(@RequestBody @Valid Client client, @PathVariable Integer id) {
        client.setClientId(id);
        clientService.updateClient(client);
    }

    @DeleteMapping("/{id}")
    public void deleteClient(@PathVariable Integer id) {
        clientService.deleteClientById(id);
    }

    @GetMapping
    public Collection<Client> retrieveAllClients() {
        return clientService.retrieveAllClients();
    }

}
