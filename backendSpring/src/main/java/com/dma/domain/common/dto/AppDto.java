package com.dma.domain.common.dto;

import java.util.Arrays;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class AppDto {

    @Value("${myconf.project:}")
    private String project;
    
    @Value("${spring.application.name}")
    private String applicationName;

    @Value("${server.port}")
    private String port;

    @Value("${spring.datasource.url}")
    private String db;

    @JsonIgnore
    @Value("${spring.datasource.username}")
    private String dbUser;

    @Value("${spring.profiles.active:default}")
    private String profile;

    @Value("${myconf.websocket.url:/ws-stomp}")
    private String wsUrl;
    
    @Value("${myconf.websocket.enabled:true}")
    private String wsEnable;

    @Value("${myconf.websocket.auth-same-network:true}") // true: redis를 이용해 사용자 정보를 공유 할 수 있는 환경이다.
    private Boolean wsCanAccessUser;

    @Value("${spring.redis.host:127.0.0.1}")
    private String redisHost;

    @Value("${spring.redis.port:6379}")
    private Integer redisPort;
    
    @Value("${spring.redis.database:}")
    private Integer redisDb;

    @Value("${spring.redis.embedded-server-start}")
    private Boolean redisEmbededServerStart; // true: 자체 redis 서버를 실행한다

    @JsonIgnore
    @Value("${spring.redis.password:}")  // 패스워드 설정 시 에러가 떨어지는 케이스가 있다.  원인분석이 필요하다
    private String redisPassword;

    @JsonIgnore 
    @Value("${spring.redis.timeout:3000}")
    private Integer redisTimeout;

    @Value("${myconf.auth.use:true}") // false: 인증을 사용하지 않는다
    private Boolean authUse;

    private Boolean isDevProfile = isDevProfile();

    public Boolean isDevProfile() {
        List<String> array = Arrays.asList("default", "local", "dev", "cyg");
		return array.contains(this.getProfile());
    }
}
