package vault.terraform.vaultterraformspringboot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;
import vault.terraform.vaultterraformspringboot.service.TerraformService;

@RestController
@RequestMapping("/terraform")
public class TerraformController {

    @Autowired
    TerraformService service;

    @PostMapping
    public Mono<Void> getEmployeeById() {
        service.initTerraform();
        service.applyTerraform();
        return Mono.empty();
    }

}
