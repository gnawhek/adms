package com.dma.domain.common.controller;

import com.dma.domain.common.mapper.BaseDataMapper;
import com.dma.domain.common.mapper.DataMapper;
import com.dma.domain.common.service.BaseDataService;
import com.dma.domain.common.service.DataService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.annotation.PostConstruct;
import java.util.HashMap;
import java.util.List;

@Slf4j
@RestController
public class DataController extends BaseDataController {
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

    @PostConstruct
    public void Init() {
//        log.debug("DataController mappers: " + mappers.size());
//        log.debug("DataController services: " + services.size());
    }

    @Override
    protected List<Object> getServices() {
        return (List)services;
    }

    @Override
    protected List<Object> getMappers() {
        return (List)mappers;
    }

    @GetMapping(value = "/data")
    public Object getData(@RequestParam(value = "action", required = false) String action) throws Exception {
        return postData(action, new HashMap<String, Object>());
    }

    // @RequestMapping(value = "/data")
    @PostMapping(value = "/data")
    public Object postData(
            @RequestParam(value = "action", required = false) String action,
            @RequestBody HashMap<String, Object> param) throws Exception {
        return doRequest(action, param, true);
    }

    @PostMapping(value = "/selectList")
    public Object postSelectList(
            @RequestHeader(value = "command", required = false) String command,
            @RequestHeader("sqlId") String sqlId,
            @RequestBody HashMap<String, Object> param) throws Exception {
        return selectList(command, sqlId, param, true);
    }

    @PostMapping(value = "/selectList/{sqlId}")
    public Object postSelectList2(
            @RequestHeader(value = "command", required = false) String command,
            @PathVariable("sqlId") String sqlId,
            @RequestBody HashMap<String, Object> param) throws Exception {
        return selectList(command, sqlId, param, true);
    }

    @PostMapping(value = "/selectOne")
    public Object postSelectOne(
            @RequestHeader(value = "command", required = false) String command,
            @RequestHeader("sqlId") String sqlId,
            @RequestBody HashMap<String, Object> param) throws Exception {
        return selectOne(command, sqlId, param, true);
    }

    @PostMapping(value = "/selectOne/{sqlId}")
    public Object postSelectOne2(
            @RequestHeader(value = "command", required = false) String command,
            @PathVariable("sqlId") String sqlId,
            @RequestBody HashMap<String, Object> param) throws Exception {
        return selectOne(command, sqlId, param, true);
    }

    @PostMapping(value = "/modify")
    public Object postModify(
            @RequestHeader(value = "command", required = false) String command,
            @RequestHeader("sqlId") String sqlId,
            @RequestBody HashMap<String, Object> param) throws Exception {
        return modify(command, sqlId, param);
    }

    @PostMapping(value = "/modify/{sqlId}")
    public Object postModify2(
            @RequestHeader(value = "command", required = false) String command,
            @PathVariable("sqlId") String sqlId,
            @RequestBody HashMap<String, Object> param) throws Exception {
        return modify(command, sqlId, param);
    }
}
