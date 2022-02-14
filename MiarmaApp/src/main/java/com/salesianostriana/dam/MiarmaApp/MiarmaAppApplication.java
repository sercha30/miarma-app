package com.salesianostriana.dam.MiarmaApp;

import com.salesianostriana.dam.MiarmaApp.storage.config.StorageProperties;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

@EnableConfigurationProperties(StorageProperties.class)
@SpringBootApplication
public class MiarmaAppApplication {

	public static void main(String[] args) {
		SpringApplication.run(MiarmaAppApplication.class, args);
	}

}
