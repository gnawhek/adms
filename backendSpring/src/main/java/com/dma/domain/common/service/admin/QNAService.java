package com.dma.domain.common.service.admin;


import com.dma.domain.common.mapper.admin.QNAMapper;
import com.dma.domain.common.service.BaseDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
public class QNAService extends BaseDataService {
    @Autowired
    protected QNAMapper mapper;

    public int INSERT_QNA_ITEM(HashMap<String, Object> map) {
        int result = mapper.INSERT_QNA_ITEM(map);
        if(result != -1) {
            result = mapper.UPDATE_QNA_USER_INFO(map);
        }
        return result;
    }
}
