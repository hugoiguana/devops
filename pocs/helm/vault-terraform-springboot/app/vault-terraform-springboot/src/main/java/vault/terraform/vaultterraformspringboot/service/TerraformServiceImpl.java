package vault.terraform.vaultterraformspringboot.service;

import lombok.SneakyThrows;
import lombok.extern.log4j.Log4j;
import lombok.extern.log4j.Log4j2;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

@Service
@Slf4j
public class TerraformServiceImpl implements TerraformService {

    @Value("${terraform.file}")
    String terraformFile;

    @Override
    @SneakyThrows
    public void execTerraform() {

        log.info("Init exec {}", terraformFile);

        ProcessBuilder processBuilder = new ProcessBuilder();
        processBuilder.command(terraformFile);

        Process process = processBuilder.start();
        BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));

        String line;
        while ((line = reader.readLine()) != null) {
            log.info(line);
        }

        int exitVal = process.waitFor();
        if (exitVal == 0) {
            log.info("Terraform executed");
        } else {
            log.info("Terraform executed with error");
        }

        log.info("End exec {} .", terraformFile);
    }
}
