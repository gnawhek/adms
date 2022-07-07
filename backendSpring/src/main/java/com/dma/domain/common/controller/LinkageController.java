package com.dma.domain.common.controller;

import com.dma.domain.common.mapper.DataMapper;
import com.dma.domain.common.service.linkage.LinkageService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;

@Slf4j
@RestController
public class LinkageController extends BaseDataController {
    @Autowired
    protected DataMapper mapper;

    @Autowired
    protected LinkageService service;

    @Override
    protected Object getService() {
        return service;
    }

    @Override
    protected Object getMapper() {
        return mapper;
    }

    @GetMapping(value = "/linkage")
    public Object getLinkage(@RequestParam(value = "action", required = false) String action) throws Exception {
        return postLinkage(action, new HashMap<>());
    }

    @PostMapping(value = "/linkage")
    public Object postLinkage(
            @RequestParam(value = "action", required = false) String action,
            @RequestBody HashMap<String, Object> param) throws Exception {
        return doRequest(action, param, false);
    }
}
