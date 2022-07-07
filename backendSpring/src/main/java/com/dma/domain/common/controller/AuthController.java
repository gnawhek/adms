package com.dma.domain.common.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.dma.advice.exception.CSigninFailedException;
import com.dma.domain.common.dto.AppDto;
import com.dma.domain.user.dto.User;
import com.dma.domain.user.service.UserService;
import com.dma.property.GlobalConstants;
import com.dma.security.JwtTokenProvider;
import com.dma.service.ResponseService;
import com.dma.share.Data;
import com.dma.share.response.BaseResponse;
import com.dma.share.response.SingleResponse;
import com.dma.utils.Base64;
import com.dma.utils.JsonUtil;
import com.dma.utils.cipher.rsa.RSA;
import com.dma.utils.cipher.tea.TEA;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RestController
// @RequestMapping(value = "/v1/auth") // 버전에 상관없이 접근하려면 "/v?", swagger-ui 를 사용하려면 /v1 으로 변경하세요
public class AuthController extends BaseController {

    private final UserService userService;
    private final JwtTokenProvider jwtTokenProvider;
    private final ResponseService responseService;
    private final PasswordEncoder passwordEncoder;
    private final AppDto appDto;
    private final String tokenKey = "accessToken";

    public static HashMap<String, RSA.RSAKey> RsaMAP = new HashMap<>();

    @GetMapping(value = "/getkey")
    public Data getKey(HttpServletRequest request) throws Exception {
        return postKey(request);
    }

    @PostMapping(value = "/getkey")
    public Data postKey(HttpServletRequest request) throws Exception {
        //TODO 세션 확인 필요
        javax.servlet.http.HttpSession session = request.getSession();
        if (session.getAttribute(GlobalConstants.KEY.RSA_KEY) == null) {
            session.setAttribute(GlobalConstants.KEY.RSA_KEY, RSA.createRsa());
        }
        //RSA.RSAKey rsaKey = (RSA.RSAKey) session.getAttribute(GlobalConstants.KEY.RSA_KEY);

        RSA.RSAKey rsaKey = RSA.createRsa();
        AuthController.RsaMAP.put(rsaKey.getPublicKeyModulus(), rsaKey);
        Data data = new Data();
        data.set("m", rsaKey.getPublicKeyModulus());
        data.set("e", rsaKey.getPublicKeyExponent());
        return data;
    }

    @GetMapping(value = "/currentkey")
    public Data currentKey(HttpServletRequest request) throws Exception {
        javax.servlet.http.HttpSession session = request.getSession();
        RSA.RSAKey rsaKey = (RSA.RSAKey) session.getAttribute(GlobalConstants.KEY.RSA_KEY);
        Data data = new Data();
        if (rsaKey != null) {
            data.set("m", rsaKey.getPublicKeyModulus());
            data.set("e", rsaKey.getPublicKeyExponent());
        }
        return data;
    }

    @PostMapping("/loginform")
    public SingleResponse<Map<String, Object>> formSignin(HttpServletRequest request, @RequestParam HashMap<String, Object> body) throws Exception {
        return postSignin(request, body);
    }

    @PostMapping(value = "/signin")
    public SingleResponse<Map<String, Object>> postSignin(
            HttpServletRequest request,
            @RequestBody HashMap<String, Object> body)
            throws Exception {
        // RequestBody 에서 파라미터 추출
        // log.info("signin(): id={}, password={}", body.get("id"),
        HashMap encData = (HashMap)body.get("data");
        String address = getAddress(request);

        String encryptKey = (String)encData.get("key");
        String encryptValue = Base64.decodeString((String)encData.get("value"));
        String m = (String)encData.get("m");

        javax.servlet.http.HttpSession session = request.getSession();
        RSA.RSAKey rsaKeyTest = (RSA.RSAKey) session.getAttribute(GlobalConstants.KEY.RSA_KEY);

        RSA.RSAKey rsaKey = RsaMAP.get(m);

        /* TEA 암호화에 사용된 키를 구한다 */
        String teaKey = null;
        try {
            teaKey = RSA.decryptRsa(rsaKey, encryptKey);
        } catch (Exception e) {
            e.printStackTrace();
        }

        /* 암호화된 text를 TEA키를 이용하여 decrypt 한다. */
        TEA tea = new TEA(teaKey);
        String data = tea.decrypt(encryptValue);
        JsonObject json = (JsonObject)JsonParser.parseString(data);
        String id = json.get("id").getAsString();
        String password = json.get("password").getAsString();
        return signin(id, password, address);
    }

    @GetMapping(value = "/signin")
    @ApiOperation(value = "로그인_Get", notes = "로그인을 한다.")
    public SingleResponse<Map<String, Object>> getSignin(
            HttpServletRequest request,
            @ApiParam(value = "ID", defaultValue = "dimmby", required = false) @RequestParam String id,
            @ApiParam(value = "PASSWORD", defaultValue = "dimmby", required = false) @RequestParam String password)
            throws Exception {
        return signin(id, password, getAddress(request));
    }

    public SingleResponse<Map<String, Object>> signin(String id, String password, String address) throws Exception {
        User user = null;
        if (appDto.isDevProfile()) {
            log.debug(passwordEncoder.encode(password));
        }
        if (appDto.getAuthUse() == false) {
            user = userService.getDefaultUser();
        } else {
            user = userService.loginFromDb(id, password);
            if (!passwordEncoder.matches(password, user.getPassword())) {
                log.debug("Password is wrong: enc={}, dec={}", user.getPassword(), password);
                throw new CSigninFailedException();
            } else {
                log.debug("Password is match: enc={}, dec={}", user.getPassword(), password);
                userService.updateLoginDate(id);
            }
        }

        user.setS_PW(null);
        user.setIpAddress(address);

        // String token_origin = jwtTokenProvider.createToken(String.valueOf(user.getUid()), user.getRolesList(), address);
        // jwtTokenProvider.removeToken(token_origin);
        String token = jwtTokenProvider.createToken(String.valueOf(user.getI_ID()), user.getRolesList(), address);

        // User 정보와 토큰 정보를 반환
        HashMap<String, Object> mapUser = JsonUtil.convertObjectToMap(user);
        Data data = new Data(mapUser);
        data.set(tokenKey, token);

        return responseService.createSingleDataResponse(data);
    }

    public void save(String id, String password, String name) throws Exception {
        userService.insertUser(
                User.builder()
                        .I_ID(id)
                        .S_PW(passwordEncoder.encode(password))
                        .N_NAME(name).build());
    }

    @PostMapping(value = "/signout")
    public SingleResponse<Map<String, Object>> signout(
            @RequestHeader HashMap<String, Object> header) throws Exception {
        String token = (String) header.get("x-auth-token");
        jwtTokenProvider.removeToken(token);
        Data data = new Data();
        return responseService.createSingleDataResponse(data);
    }

    /*@PostMapping(value = "/signin/{provider}")
    public SingleResponse<String> signinByProvider(HttpServletRequest request,
                                                   @PathVariable String provider,
                                                   @RequestParam String accessToken) throws Exception {
        String address = getAddress(request);
        KakaoProfile profile = kakaoService.getKakaoProfile(accessToken);
        User user = userService.findUserByUidAndProvider(String.valueOf(profile.getId()), provider);
        user.setIpAddress(address);
        return responseService.createSingleResponse(
                jwtTokenProvider.createToken(String.valueOf(user.getI_ID()), user.getRolesList(), address));
    }*/

    @PostMapping(value = "/signup")
    public BaseResponse signup(
            @RequestParam String id,
            @RequestParam String password,
            @RequestParam String name) throws Exception {
        save(id, password, name);
        return responseService.createSuccessResponse();
    }

    /*@PostMapping(value = "/signup/{provider}")
    public BaseResponse signupProvider(
            @PathVariable String provider,
            @RequestParam String accessToken,
            @RequestParam String name) throws Exception {
        KakaoProfile profile = kakaoService.getKakaoProfile(accessToken);
        User user = userService.findUserByUidAndProvider(String.valueOf(profile.getId()), provider);
        log.info("signupProvider(): id={}, password={}", user.getI_ID(), user.getPassword());

        User inUser = (User) User.builder()
                .I_ID(String.valueOf(profile.getId()))
                .N_NAME(name).build();
        userService.insertUser(inUser);
        return responseService.createSuccessResponse();
    }*/

    private String getAddress(HttpServletRequest request) {
        String ipAddress = request.getHeader("X-Forwarded-For");
        if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("Proxy-Client-IP");
        }
        if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getRemoteAddr();
        }
        return ipAddress;
    }
}
