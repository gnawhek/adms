package com.dma.domain.common.mapper.admin;

import com.dma.domain.common.mapper.BaseDataMapper;
import com.dma.share.ResultMap;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
//@formatter:off
public interface QNAMapper extends BaseDataMapper
//@formatter:on
{
    List<ResultMap> SELECT_QNA_MANAGEMENT_CODE_LIST(HashMap<String, Object> map);
    List<ResultMap> SELECT_QNA_MANAGEMENT_CODE_QNA_LIST(HashMap<String, Object> map);
    int UPDATE_QNA_MANAGEMENT_CODE_QNA_SORT(HashMap<String, Object> map);
    int INSERT_QNA_MANAGEMENT_CODE_QNA(HashMap<String, Object> map);
    int DELETE_QNA_MANAGEMENT_CODE_QNA(HashMap<String, Object> map);
    List<ResultMap> SELECT_QNA_MANAGEMENT_TEMPLATE_LIST(HashMap<String, Object> map);
    int SELECT_QNA_MANAGEMENT_TEMPLATE_EXISTS(HashMap<String, Object> map);
    ResultMap SELECT_QNA_MANAGEMENT_TEMPLATE(HashMap<String, Object> map);
    int INSERT_QNA_MANAGEMENT_TEMPLATE(HashMap<String, Object> map);
    int UPDATE_QNA_MANAGEMENT_TEMPLATE(HashMap<String, Object> map);
    int DELETE_QNA_MANAGEMENT_TEMPLATE(HashMap<String, Object> map);
    int INSERT_QNA_ITEM(HashMap<String, Object> map);
    int UPDATE_QNA_USER_INFO(HashMap<String, Object> map);
}
