package com.dma.domain.common.mapper.admin;

import com.dma.domain.common.mapper.BaseDataMapper;
import com.dma.share.ResultMap;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
//@formatter:off
public interface PWIElementMapper extends BaseDataMapper
//@formatter:on
{
    List<ResultMap> SELECT_PWI_ELEMENT_PWI_LIST(HashMap<String, Object> map);
    List<ResultMap> SELECT_PWI_ELEMENT_TUPLE_LIST(HashMap<String, Object> map);
    int INSERT_PWI_ELEMENT_TUPLE_ELEMENT(HashMap<String, Object> map);
    int DELETE_PWI_ELEMENT_TUPLE_ELEMENT(HashMap<String, Object> map);
    List<ResultMap> SELECT_PWI_ELEMENT_LIST(HashMap<String, Object> map);
    ResultMap SELECT_PWI_ELEMENT(HashMap<String, Object> map);
    int SELECT_PWI_ELEMENT_EXISTS(HashMap<String, Object> map);
    int INSERT_PWI_ELEMENT(HashMap<String, Object> map);
    int UPDATE_PWI_ELEMENT(HashMap<String, Object> map);
    int DELETE_PWI_ELEMENT(HashMap<String, Object> map);
}
