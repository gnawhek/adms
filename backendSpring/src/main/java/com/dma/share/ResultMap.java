package com.dma.share;

import java.util.HashMap;

@SuppressWarnings("serial")
public class ResultMap extends HashMap<String, Object> {
    
    // @Override
    // public Object put(String key, Object value) {

    //     if (GlobalConstants.CONVERT_CAMELCASE_KEY) {
    //         // ex) createTime
    //         return super.put(JdbcUtils.convertUnderscoreNameToPropertyName(key), value);
    //     } else {
    //         // ex) CREATE_TIME. 쿼리에서 AS "소문자" 를 사용하지 않으면 모두 대문자키 가 됨
    //         return super.put(key, value);
    //     }
    // }

}