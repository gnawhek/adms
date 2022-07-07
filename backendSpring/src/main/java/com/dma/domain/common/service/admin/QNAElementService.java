package com.dma.domain.common.service.admin;


import com.dma.domain.common.mapper.admin.QNAElementMapper;
import com.dma.domain.common.service.BaseDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class QNAElementService extends BaseDataService {
    @Autowired
    protected QNAElementMapper mapper;
}
