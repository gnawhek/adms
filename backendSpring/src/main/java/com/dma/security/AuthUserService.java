package com.dma.security;

import com.dma.domain.user.dto.User;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

/**
 * AuthenticationUserService
 */
@Service
public class AuthUserService {

    public Authentication getAuthentication() {
        return SecurityContextHolder.getContext().getAuthentication();
    }

    // SecurityContext에서 인증받은 회원의 정보를 얻어온다.
    public User getUser() {
        return (User) (getAuthentication() != null ? getAuthentication().getPrincipal() : new User());
    }

    public String getUserUid() {
        return getUser().getI_ID();
    }

    public String getUserName() {
        return getUser().getN_NAME();
    }
}
