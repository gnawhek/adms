package com.dma.domain.common.service.admin;


import com.dma.domain.common.mapper.admin.PWIElementMapper;
import com.dma.domain.common.service.BaseDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PWIElementService extends BaseDataService {
    @Autowired
    protected PWIElementMapper mapper;
}
