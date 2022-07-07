package com.dma.domain.user.service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.dma.advice.exception.CUserNotFoundException;
import com.dma.domain.common.dto.AppDto;
import com.dma.domain.user.dto.User;
import com.dma.domain.user.mapper.BaseUserMapper;
import com.dma.domain.user.mapper.UserMapper;
import com.dma.property.GlobalConstants;
import com.dma.property.GlobalConstants.CustomCacheKey;
import com.dma.share.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
@RequiredArgsConstructor
public class UserService {

    private final UserMapper userMapper;
    private final AppDto appDto;

    private BaseUserMapper getDatasource() {
        return userMapper;
    }

    public User getDefaultUser() {
        return User.builder()
                .I_ID("dev")
                .S_PW("dev")
                .N_NAME("dev").build();
    }

    public User loginFromDb(String uid, String password) throws Exception {
        User user = findUserByUid(uid);
        return user;
    }

    public int updateLoginDate(String uid) throws Exception {
        return getDatasource().UPDATE_LAST_LOGIN(new HashMap(){{
            put(GlobalConstants.Common.I_ID, uid);
        }});
    }

    @Cacheable(value = CustomCacheKey.USER, key = "#uid", unless = "#result == null")
    public User findUserByUid(String uid) throws Exception {
        if (appDto.getAuthUse() == false) {
            return getDefaultUser();
        }
        User user = getDatasource().SELECT_LOGIN(getUserParam(uid));
        return Optional.ofNullable(user).orElseThrow(CUserNotFoundException::new);
    }

    public User findUserByUidAndProvider(String uid, String provider) throws Exception {
        return findUserByUid(uid);
    }

    public void insertUser(User userData) throws Exception {
        getDatasource().insertUser((User) userData);
    }

    public void upsertUser(User userData) throws Exception {
        getDatasource().upsertUser((User) userData);
    }

    @CacheEvict(value = CustomCacheKey.USER, key = "#uid")
    public void deleteUserByUid(String uid) throws Exception {
        getDatasource().deleteUser(getUserParam(uid));
    }

    public List<User> selectUserList(HashMap<String, Object> map) throws Exception {
        return getDatasource().selectUserList(map);
    }

    public HashMap<String, Object> getUserParam(String uid) {
        Data param = new Data();
        param.set("I_ID", uid);
        return (HashMap<String, Object>) param.getMap();
    }
}
