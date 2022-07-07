package com.dma.domain.common.controller;

import com.dma.domain.common.dto.ConfigDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dma.domain.common.dto.AppDto;
import com.dma.service.ResponseService;
import com.dma.share.response.BaseResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class AppController extends BaseController {

    @Autowired
    private ResponseService responseService; // 결과를 처리할 Service

    @Autowired
    private AppDto appDto;

    @Autowired
    private ConfigDto configDto;

    @PostMapping(value = "/setting")
    public BaseResponse postSetting() throws Exception {
        log.info("/setting PostMapping");
        return responseService.createSingleResponse(appDto);
    }

    @GetMapping(value = "/setting")
    public ResponseEntity<?> getSetting() throws Exception {
        log.info("/setting GetMapping");
        return new ResponseEntity<>(appDto, HttpStatus.OK);
    }

    @GetMapping(value = "/config")
    public ResponseEntity<?> getConfig() throws Exception {
        log.info("/config GetMapping");
        return new ResponseEntity<>(configDto, HttpStatus.OK);
    }
}
