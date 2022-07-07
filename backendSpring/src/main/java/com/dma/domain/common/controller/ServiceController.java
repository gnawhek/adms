package com.dma.domain.common.controller;

import com.dma.domain.common.mapper.BaseDataMapper;
import com.dma.domain.common.mapper.DataMapper;
import com.dma.domain.common.service.BaseDataService;
import com.dma.domain.common.service.DataService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import javax.annotation.PostConstruct;
import java.util.HashMap;
import java.util.List;

@Slf4j
@RestController
public class ServiceController extends BaseDataController {
    @Autowired
    protected DataMapper mapper;

    @Autowired
    protected DataService service;

    @Override
    protected Object getService() {
        return service;
    }

    @Override
    protected Object getMapper() {
        return mapper;
    }

    @Autowired
    protected List<BaseDataService> services;

    @Autowired
    protected List<BaseDataMapper> mappers;

    @Override
    protected List<Object> getServices() {
        return (List)services;
    }

    @Override
    protected List<Object> getMappers() {
        return (List)mappers;
    }

    @GetMapping(value = "/service")
    public Object getService(@RequestParam(value = "action", required = false) String action) throws Exception {
        return postService(action, new HashMap<>());
    }

    @PostMapping(value = "/service")
    public Object postService(
            @RequestParam(value = "action", required = false) String action,
            @RequestBody HashMap<String, Object> param) throws Exception {
        Authentication authentication = authUserService.getAuthentication();
        if (authentication == null) {
            throw new Exception("잘못된 접근 입니다.");
        }
        return doRequest(action, param, false);
    }
}
