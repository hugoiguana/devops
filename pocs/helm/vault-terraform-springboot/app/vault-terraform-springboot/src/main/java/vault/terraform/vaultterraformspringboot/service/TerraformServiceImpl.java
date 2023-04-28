package vault.terraform.vaultterraformspringboot.service;

import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.concurrent.Executors;
import java.util.concurrent.Future;

@Service
public class TerraformServiceImpl implements TerraformService {

    @Override
    @SneakyThrows
    public void initTerraform() {

        String homeDirectory = System.getProperty("user.home");
        //Process process = Runtime.getRuntime().exec(String.format("/bin/sh -c ls %s", homeDirectory));
        Process process = Runtime.getRuntime().exec("/bin/sh -c ./terraform.sh");

        //StreamGobbler streamGobbler = new StreamGobbler(process.getInputStream(), System.out::println);
        StreamGobbler streamGobbler = StreamGobbler.builder()
                .inputStream(process.getInputStream())
                .consumer(System.out::println)
                .build();

        Future<?> future = Executors.newSingleThreadExecutor().submit(streamGobbler);

        int exitCode = process.waitFor();
        assert exitCode == 0;

        future.get(); // waits for streamGobbler to finish
    }

    @Override
    public void applyTerraform() {

    }
}
