package com.dma;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@SpringBootApplication
@EnableCaching
@EnableWebSecurity
@EnableAsync
@EnableScheduling
public class dmaApplication implements WebMvcConfigurer {

	public static void main(String[] args) {
		SpringApplication.run(dmaApplication.class, args);
	}

}
