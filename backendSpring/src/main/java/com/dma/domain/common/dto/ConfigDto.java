package com.dma.domain.common.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
@Data
public class ConfigDto {
    @JsonIgnore
    private final AppDto appDto;

    @Value("${dma.encrypt:}")
    private Boolean encrypt;

    public Boolean isDevProfile() {
        return appDto.isDevProfile();
    }
}
