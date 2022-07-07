package com.dma.domain.common.mapper.admin;

import com.dma.domain.common.mapper.BaseDataMapper;
import com.dma.share.ResultMap;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
//@formatter:off
public interface QNAElementMapper extends BaseDataMapper
//@formatter:on
{
    List<ResultMap> SELECT_QNA_ELEMENT_CODE_LIST(HashMap<String, Object> map);
    List<ResultMap> SELECT_QNA_ELEMENT_QNA_LIST(HashMap<String, Object> map);
    List<ResultMap> SELECT_QNA_ELEMENT_TEMPLATE_LIST(HashMap<String, Object> map);
    ResultMap SELECT_QNA_ELEMENT_TEMPLATE(HashMap<String, Object> map);
    int INSERT_QNA_ELEMENT_QNA_ELEMENT(HashMap<String, Object> map);
    int UPDATE_QNA_ELEMENT_QNA_ELEMENT(HashMap<String, Object> map);
    int DELETE_QNA_ELEMENT_QNA_ELEMENT(HashMap<String, Object> map);
}
