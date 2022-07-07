package com.dma.domain.common.mapper.admin;

import com.dma.domain.common.mapper.BaseDataMapper;
import com.dma.share.ResultMap;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
//@formatter:off
public interface SolutionMapper extends BaseDataMapper
//@formatter:on
{
    List<ResultMap> SELECT_SOLUTION_CATEGORY_LIST(HashMap<String, Object> map);
    int SELECT_SOLUTION_CATEGORY_EXISTS(HashMap<String, Object> map);
    int INSERT_SOLUTION_CATEGORY(HashMap<String, Object> map);
    int UPDATE_SOLUTION_CATEGORY(HashMap<String, Object> map);
    int DELETE_SOLUTION_CATEGORY(HashMap<String, Object> map);
    int UPDATE_SOLUTION_CATEGORY_SORT(HashMap<String, Object> map);
    List<ResultMap> SELECT_SOLUTION_CONTENT_LIST(HashMap<String, Object> map);
    int INSERT_SOLUTION_CONTENT(HashMap<String, Object> map);
    int DELETE_SOLUTION_CONTENT(HashMap<String, Object> map);
    int UPDATE_SOLUTION_CONTENT_SORT(HashMap<String, Object> map);
    List<ResultMap> SELECT_SOLUTION_TEMPLATE_LIST(HashMap<String, Object> map);
    int SELECT_SOLUTION_TEMPLATE_EXISTS(HashMap<String, Object> map);
    ResultMap SELECT_SOLUTION_TEMPLATE(HashMap<String, Object> map);
    int INSERT_SOLUTION_TEMPLATE(HashMap<String, Object> map);
    int UPDATE_SOLUTION_TEMPLATE(HashMap<String, Object> map);
    int DELETE_SOLUTION_TEMPLATE(HashMap<String, Object> map);
}
