package com.dma.domain.common.service.admin;


import com.dma.domain.common.mapper.admin.ProductMapper;
import com.dma.domain.common.service.BaseDataService;
import com.dma.share.ResultMap;
import com.dma.utils.ImageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class ProductService extends BaseDataService {
    @Autowired
    protected ProductMapper mapper;

    public List<ResultMap> SELECT_PRODUCT_CATEGORY_LIST(HashMap<String, Object> map) {
        return mapper.SELECT_PRODUCT_CATEGORY_LIST(map);
    }

    public int INSERT_PRODUCT_TEMPLATE(HashMap<String, Object> map) {
        //이미지
        byte[] bytes = ImageUtil.imageBase64ToBytes(map.get("B_ICON"));
        if (bytes != null) {
            map.put("S_ICON", "https://t1.daumcdn.net/cfile/tistory/173DA4364D290CBE1E");
        }
        return mapper.INSERT_PRODUCT_TEMPLATE(map);
    }

    public int UPDATE_PRODUCT_TEMPLATE(HashMap<String, Object> map) {
        //이미지
        byte[] bytes = ImageUtil.imageBase64ToBytes(map.get("B_ICON"));
        if (bytes != null) {
            map.put("S_ICON", "https://jtoppick.com/wp-content/uploads/2020/06/%E1%84%89%E1%85%B3%E1%84%91%E1%85%B5%E1%84%83%E1%85%B5-%E1%84%86%E1%85%AE%E1%84%89%E1%85%A5%E1%86%AB-%E1%84%8E%E1%85%AE%E1%86%BC%E1%84%8C%E1%85%A5%E1%86%AB%E1%84%80%E1%85%B5-1.png");
        }
        return mapper.UPDATE_PRODUCT_TEMPLATE(map);
    }
}
