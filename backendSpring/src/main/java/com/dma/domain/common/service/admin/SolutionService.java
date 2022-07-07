package com.dma.domain.common.service.admin;


import com.dma.domain.common.mapper.admin.SolutionMapper;
import com.dma.domain.common.service.BaseDataService;
import com.dma.share.ResultMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class SolutionService extends BaseDataService {
    @Autowired
    protected SolutionMapper mapper;

    public List<ResultMap> SELECT_SOLUTION_CATEGORY_LIST(HashMap<String, Object> map) {
        return mapper.SELECT_SOLUTION_CATEGORY_LIST(map);
    }
}
