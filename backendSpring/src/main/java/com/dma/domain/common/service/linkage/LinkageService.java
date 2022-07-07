package com.dma.domain.common.service.linkage;


import com.dma.domain.common.mapper.linkage.LinkageMapper;
import com.dma.share.ResultMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service
public class LinkageService {
    @Autowired
    protected LinkageMapper mapper;

    public List<ResultMap> LINKAGE_SAMPLE(HashMap<String, Object> map) {
        map.put("S_LOCALE", "ko");
        return mapper.LINKAGE_SAMPLE(map);
    }

    public Object DATA_SAMPLE(HashMap<String, Object> map) {
        HashMap<String, Object> mapUser = new HashMap<String, Object>() {{
            put("I_ID", "LINKAGE_ID");
            put("action", map.get("action"));
            put("ParamData", map.get("ParamData"));
        }};
        ResultMap data = new ResultMap();
        data.put("data", mapUser);
        data.put("count", 7);

        ArrayList<ResultMap> list = new ArrayList<>();
        list.add(data);

        return list;
    }
}
