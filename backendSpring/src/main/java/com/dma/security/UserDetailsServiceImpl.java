package com.dma.security;

import com.dma.domain.user.service.UserService;
import com.dma.utils.CommonUtil;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserDetailsServiceImpl implements UserDetailsService {

    private final UserService userService;
    
    @Override
    public UserDetails loadUserByUsername(String uid) throws UsernameNotFoundException {
        try {
            return userService.findUserByUid(uid);
        } catch (Exception e) {
            e.printStackTrace();
            throw new UsernameNotFoundException(CommonUtil.format("{} 인증 할 수 없는 ID입니다.", uid));
        }
    }

}
