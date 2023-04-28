package vault.terraform.vaultterraformspringboot.service;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.function.Consumer;

@Builder
@Getter
@Setter
public class StreamGobbler implements Runnable {

    private InputStream inputStream;
    private Consumer<String> consumer;


    @Override
    public void run() {
        new BufferedReader(new InputStreamReader(inputStream)).lines()
                .forEach(consumer);
    }

}
