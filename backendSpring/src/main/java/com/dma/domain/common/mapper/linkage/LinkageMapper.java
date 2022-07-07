package com.dma.domain.common.mapper.linkage;

import com.dma.share.ResultMap;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
//@formatter:off
public interface LinkageMapper
//@formatter:on
{
    List<ResultMap> LINKAGE_SAMPLE(HashMap<String, Object> map);
}
