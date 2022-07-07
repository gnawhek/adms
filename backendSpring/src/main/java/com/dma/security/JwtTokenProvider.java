package com.dma.security;

import java.util.Base64;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;

import com.dma.domain.user.dto.User;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Component;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.SignatureException;
import io.jsonwebtoken.UnsupportedJwtException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Component
public class JwtTokenProvider { // JWT 토큰을 생성 및 검증 모듈

    @Value("${spring.jwt.secret:jwtsecret12#$}")
    private String secretKey;

    private long tokenValidMilisecond = 1000L * 60 * 60 * 24; // 24시간만 토큰 유효

    private final UserDetailsService userDetailsService;

    @PostConstruct
    protected void init() {
        secretKey = Base64.getEncoder().encodeToString(secretKey.getBytes());
    }

    // Jwt 토큰 생성
    public String createToken(String userPk, List<String> roles, String address) {
        Claims claims = Jwts.claims().setSubject(userPk);
        claims.put("roles", roles);
        claims.put("address", address);
        Date now = new Date();
        String token =  Jwts.builder()
                .setClaims(claims) // 데이터
                .setIssuedAt(now) // 토큰 발행일자
                .setExpiration(new Date(now.getTime() + tokenValidMilisecond)) // set Expire Time
                .signWith(SignatureAlgorithm.HS256, secretKey) // 암호화 알고리즘, secret값 세팅
                .compact();

        return token;
    }

    /**
     * 이름으로 Jwt Token을 생성한다.
     */
    public String generateToken(String name) {
        Date now = new Date();
        return Jwts.builder()
                .setId(name)
                .setIssuedAt(now) // 토큰 발행일자
                .setExpiration(new Date(now.getTime() + tokenValidMilisecond)) // 유효시간 설정
                .signWith(SignatureAlgorithm.HS256, secretKey) // 암호화 알고리즘, secret값 세팅
                .compact();
    }

    /**
     * Jwt Token을 복호화 하여 이름을 얻는다.
     */
    public String getUserNameFromJwt(String jwt) {
        return getClaims(jwt).getId();
    }

    public void removeToken(String token) {
        getClaims(token).setExpiration(new Date(0));
    }
    
    /**
     * Jwt Token을 복호화 하여 사용자 정보를 얻는다.
     */
    public User getUser(String token) {
        User user = null;
        try {
             user = (User) getAuthentication(token).getPrincipal();
            if (user.getIpAddress() == null) {
                user.setIpAddress(getAddress(token));
            }    
        } catch (Exception e) {
            log.error("getUser :{}", e.getMessage());
        }
        
        return user;
    }

    // Jwt 토큰으로 인증 정보를 조회
    public Authentication getAuthentication(String token) {
        String pk = this.getUserPk(token);
        log.info("getAuthentication > getUserPk: {}, token: {}", pk, token);

        UserDetails userDetails = userDetailsService.loadUserByUsername(pk);
        return new UsernamePasswordAuthenticationToken(userDetails, "", userDetails.getAuthorities());
    }

    // Jwt 토큰에서 회원 구별 정보 추출
    public String getUserPk(String token) {
        return getClaims(token).getSubject();
    }

    // Request의 Header에서 token 파싱 : "X-AUTH-TOKEN: jwt토큰"
    public String resolveToken(HttpServletRequest req) {
        return req.getHeader("X-AUTH-TOKEN");
    }

    // Jwt 토큰의 유효성 + 만료일자 확인
    public boolean validateToken(String jwtToken) {
        try {
            // Jws<Claims> claims = Jwts.parser().setSigningKey(secretKey).parseClaimsJws(jwtToken);
            Claims claims = this.getClaims(jwtToken);
            log.info("validateToken > claims.body: {}", claims);
            return !claims.getExpiration().before(new Date());
        } catch (Exception e) {
            log.error("validateToken: {}", e.getMessage());
            return false;
        }
    }

    private String getAddress(String jwtToken) {
        try {
            return (String) this.getClaims(jwtToken).get("address");
        } catch (Exception e) {
            return null;
        }
    }

    public Claims getClaims(String jwt) {
        return (Claims)getJwtClaims(jwt).getBody();
    }

    private Jws<Claims> getJwtClaims(String jwt) {
        try {
            return Jwts.parser().setSigningKey(secretKey).parseClaimsJws(jwt);
        } catch (SignatureException ex) {
            log.error("Invalid JWT signature :{}", ex.toString());
            throw ex;
        } catch (MalformedJwtException ex) {
            log.error("Invalid JWT token :{}", ex.toString());
            throw ex;
        } catch (ExpiredJwtException ex) {
            log.error("Expired JWT token :{}", ex.toString());
            throw ex;
        } catch (UnsupportedJwtException ex) {
            log.error("Unsupported JWT token :{}", ex.toString());
            throw ex;
        } catch (IllegalArgumentException ex) {
            log.error("JWT claims string is empty :{}", ex.toString());
            throw ex;
        }
    }

}
