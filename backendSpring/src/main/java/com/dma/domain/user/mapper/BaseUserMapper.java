package com.dma.domain.user.mapper;

import java.util.HashMap;
import java.util.List;

import com.dma.domain.user.dto.User;

public interface BaseUserMapper {
     // 인증된 사용자를 가져올 때만 사용하도록 한다. (서비스에서 캐시하기 때문에 DB와 결과가 다를 수 있음에 주의)
     public User SELECT_LOGIN(HashMap<String, Object> map) throws Exception;
     public int UPDATE_LAST_LOGIN(HashMap<String, Object> map) throws Exception;
//     public User findUserByUid(HashMap<String, Object> map) throws Exception;
     public List<User> selectUserList(HashMap<String, Object> map) throws Exception;
     public int insertUser(User user) throws Exception;
     public int upsertUser(User user) throws Exception;
     public int deleteUser(HashMap<String, Object> map) throws Exception;
}
