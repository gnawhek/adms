package com.dma.domain.common.mapper.admin;

import com.dma.domain.common.mapper.BaseDataMapper;
import com.dma.share.ResultMap;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
//@formatter:off
public interface ProductMapper extends BaseDataMapper
//@formatter:on
{
    List<ResultMap> SELECT_PRODUCT_CATEGORY_LIST(HashMap<String, Object> map);
    int SELECT_PRODUCT_CATEGORY_EXISTS(HashMap<String, Object> map);
    int INSERT_PRODUCT_CATEGORY(HashMap<String, Object> map);
    int UPDATE_PRODUCT_CATEGORY(HashMap<String, Object> map);
    int DELETE_PRODUCT_CATEGORY(HashMap<String, Object> map);
    int UPDATE_PRODUCT_CATEGORY_SORT(HashMap<String, Object> map);
    List<ResultMap> SELECT_PRODUCT_GROUP_LIST(HashMap<String, Object> map);
    int SELECT_PRODUCT_GROUP_EXISTS(HashMap<String, Object> map);
    int INSERT_PRODUCT_GROUP(HashMap<String, Object> map);
    int UPDATE_PRODUCT_GROUP(HashMap<String, Object> map);
    int DELETE_PRODUCT_GROUP(HashMap<String, Object> map);
    int UPDATE_PRODUCT_GROUP_SORT(HashMap<String, Object> map);
    List<ResultMap> SELECT_PRODUCT_PRODUCT_LIST(HashMap<String, Object> map);
    int INSERT_PRODUCT_PRODUCT(HashMap<String, Object> map);
    int DELETE_PRODUCT_PRODUCT(HashMap<String, Object> map);
    int UPDATE_PRODUCT_PRODUCT_SORT(HashMap<String, Object> map);
    List<ResultMap> SELECT_PRODUCT_TEMPLATE_LIST(HashMap<String, Object> map);
    int SELECT_PRODUCT_TEMPLATE_EXISTS(HashMap<String, Object> map);
    ResultMap SELECT_PRODUCT_TEMPLATE(HashMap<String, Object> map);
    int INSERT_PRODUCT_TEMPLATE(HashMap<String, Object> map);
    int UPDATE_PRODUCT_TEMPLATE(HashMap<String, Object> map);
    int DELETE_PRODUCT_TEMPLATE(HashMap<String, Object> map);
}
