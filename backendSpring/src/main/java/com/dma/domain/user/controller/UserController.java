package com.dma.domain.user.controller;

import java.util.HashMap;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.dma.domain.common.controller.BaseController;
import com.dma.domain.user.dto.User;
import com.dma.domain.user.dto.UserToken;
import com.dma.domain.user.service.UserService;
import com.dma.security.AuthUserService;
import com.dma.service.ResponseService;
import com.dma.share.response.BaseResponse;
import com.dma.share.response.ListResponse;
import com.dma.share.response.SingleResponse;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
// @RequestMapping(value = "/v1/user")
public class UserController extends BaseController {

    private final UserService userService;
    private final ResponseService responseService; // 결과를 처리할 Service
    private final AuthUserService authUserService;

    @GetMapping(value = "/users")
    public ListResponse<User> findAllUser() throws Exception {
        // 결과데이터가 여러건인경우 getListResult를 이용해서 결과를 출력한다.
        return responseService.createListResponse(userService.selectUserList(new HashMap<String, Object>()));
    }

    @GetMapping(value = "/user")
    public SingleResponse<User> findUser() throws Exception {
        String uid = authUserService.getUserUid();
        // 결과데이터가 단일건인경우 getSingleResult를 이용해서 결과를 출력한다.
        return responseService.createSingleResponse(userService.findUserByUid(uid));
    }

    @PutMapping(value = "/user")
    public BaseResponse modify(
            @RequestParam String name) throws Exception {
        String uid = authUserService.getUserUid();
        User user = userService.findUserByUid(uid);
        user.setN_NAME(name);
        userService.insertUser(user);
        return responseService.createSuccessResponse();
    }

    @DeleteMapping(value = "/user/{uid}")
    public BaseResponse delete(@PathVariable String uid) throws Exception {
        userService.deleteUserByUid(uid);
        // 성공 결과 정보만 필요한경우 getSuccessResult()를 이용하여 결과를 출력한다.
        return responseService.createSuccessResponse();
    }

    @GetMapping("/token")
    @ResponseBody
    public SingleResponse<UserToken> getUserToken(@RequestHeader HashMap<String, Object> header) {
        String name = authUserService.getUserName();

        // case1. 로그인 인증 토큰으로 공유 할 경우, 사용자가 같을 경우 1개의 token 반환
        String token = (String) header.get("x-auth-token");

        // case2. 이름으로만 토큰 생성 할 경우, 접속 될 때 마다 새로운 token을 반환
        // String token = jwtTokenProvider.generateToken(name);

        UserToken userToken = UserToken.builder().name(name).token(token).build();
        return responseService.createSingleResponse(userToken);
    }
}

