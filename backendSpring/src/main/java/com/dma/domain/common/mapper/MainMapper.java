package com.dma.domain.common.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.dma.share.ResultMap;

@Mapper
//@formatter:off
public interface MainMapper extends BaseDataMapper
//@formatter:on
{
    List<ResultMap> SELECT_SEARCH_EXISTING_CUSTOMERS_LIST(HashMap<String, Object> map);
    ResultMap SELECT_LOGIN_ID(HashMap<String, Object> map);
    int USER_NEW_PW(HashMap<String, Object> map);
    ResultMap SELECT_FIND_LOGIN_ID(HashMap<String, Object> map);
    ResultMap SELECT_FIND_LOGIN_POOL(HashMap<String, Object> map);
    ResultMap SELECT_FIND_RECOMM_CODE(HashMap<String, Object> map);
    List<ResultMap> SELECT_PARTNER_LIST(HashMap<String, Object> map);
    List<ResultMap> SELECT_ALG_SEX_LIST(HashMap<String, Object> map);
    List<ResultMap> SELECT_PWI_AGE_LIST(HashMap<String, Object> map);
    List<ResultMap> SELECT_PWI_TYPE_LIST(HashMap<String, Object> map);
    List<ResultMap> SELECT_ALG_TS_TYPE_LIST(HashMap<String, Object> map);
    List<ResultMap> SELECT_ALG_RESULT_UI_LIST(HashMap<String, Object> map);
    List<ResultMap> SELECT_ZIP_STATE_LIST(HashMap<String, Object> map);
    List<ResultMap> SELECT_ZIP_CITY_LIST(HashMap<String, Object> map);
    int NewMemberRegister(HashMap<String, Object> map);

    List<ResultMap> SELECT_CATEGORY_LIST(HashMap<String, Object> map);
}
